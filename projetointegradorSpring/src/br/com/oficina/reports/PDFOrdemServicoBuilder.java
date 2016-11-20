package br.com.oficina.reports;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.MaskFormatter;

import br.com.oficina.beans.Cidade;
import br.com.oficina.beans.ItemOrdemServico;
import br.com.oficina.beans.OrdemServico;
import br.com.oficina.beans.Pessoa;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFOrdemServicoBuilder extends AbstractITextPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc,
			PdfWriter writer, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		OrdemServico ordem = (OrdemServico)model.get("ordemServico");				
		Pessoa cliente = ordem.getPessoa();
		Cidade cidade = cliente.getEndereco().getCidade();
		
		Font fontTitle = new Font();
		fontTitle.setFamily(FontFactory.TIMES_BOLD);
		fontTitle.setSize(22.0F);
		doc.add(new Paragraph("Oficina RC - Serralheria", fontTitle));
		
		Font fontSub = new Font();
		fontSub.setFamily(FontFactory.TIMES_BOLD);
		fontSub.setSize(8.0F);
		doc.add(new Paragraph("Av. Flores da Cunha, 1677 - Borghetti - Carazinho - RS", fontSub));
		doc.add(new Paragraph("E-mail: robertocleri@hotmail.com  Contato:(54)99996-6226", fontSub));
		
		doc.add(new Paragraph("ORDEM DE SERVIÇO Nº "+ordem.getIdOrdemServico(), fontTitle));
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		Font fontSubTitle = new Font();
		fontSubTitle.setFamily(FontFactory.TIMES_BOLD);
		fontSubTitle.setSize(14.0F);
		doc.add(new Paragraph("Cliente", fontSubTitle));
		
		Font fontText = new Font();
		fontText.setFamily(FontFactory.TIMES_BOLD);
		fontText.setSize(11.0F);
		
		PdfPTable tableClinte = new PdfPTable(2);
		tableClinte.setWidthPercentage(100.0f);
		tableClinte.setWidths(new float[] {4.0f, 4.0f});
		tableClinte.setSpacingBefore(10);
		
		tableClinte.addCell(new Phrase("Cliente: " + cliente.getNome(), fontText));
		tableClinte.addCell(new Phrase("Contato: " + formatString(cliente.getTelefone(), "(##)#####-####"), fontText));
		
		tableClinte.addCell(new Phrase("Cidade: " + cidade.getNome() + " - " + cidade.getUf().getSigla(), fontText));
		tableClinte.addCell(new Phrase("CPF: " + cliente.getCpf(), fontText));
		
		tableClinte.addCell(new Phrase("Endereço: " + cliente.getEndereco().getRua(), fontText));
		tableClinte.addCell(new Phrase("CEP: " + cliente.getEndereco().getCep(), fontText));
		
		doc.add(tableClinte);
		
		
		doc.add(new Paragraph("Descrição", fontSubTitle));
		doc.add(new Paragraph(ordem.getObservacao(), fontText));
		
		
		
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		PdfPTable table = new PdfPTable(4);
		table.setWidthPercentage(100.0f);
		table.setWidths(new float[] {1.0f, 4.0f, 2.0f, 2.0f});
		table.setSpacingBefore(10);
		
		// define font for table header row
		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		
		// define table header cell
		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(BaseColor.GRAY);
		cell.setPadding(5);
		
		// write table header 
		cell.setPhrase(new Phrase("Qt.", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Descrição", font));
		table.addCell(cell);

		cell.setPhrase(new Phrase("Valor Unitário", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Valor", font));
		table.addCell(cell);		
		
		// write table row data
		for (ItemOrdemServico item : ordem.getItem()) {
			PdfPCell cellVlItem = new PdfPCell();			
			Paragraph pVlItem = new Paragraph(new DecimalFormat("#,###,##0.00").format(item.getValorItem()), fontText);
			pVlItem.setAlignment(Element.ALIGN_RIGHT);			
			cellVlItem.addElement(pVlItem);
			
			table.addCell(new Phrase("  1", fontText));
			table.addCell(new Phrase(item.getDescricao(), fontText));
			table.addCell(cellVlItem);
			table.addCell(cellVlItem);
		}
		
		doc.add(table);
		
		Paragraph pValorTotal = new Paragraph("TOTAL: R$ "+(new DecimalFormat("#,###,##0.00")).format(ordem.getValorTotal()), fontSubTitle);
		pValorTotal.setAlignment(Element.ALIGN_RIGHT);
		pValorTotal.setSpacingAfter(9f);
		doc.add(pValorTotal);
		
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		doc.add(new Paragraph("Concordo com os lançamentos descritos referentes a Ordem de Serviço.", fontSub));
		doc.add(new Paragraph("Oficina RC - Serralheria.", fontSub));
		
		Paragraph pNrOrdem = new Paragraph("Nº "+ordem.getIdOrdemServico(), fontSubTitle);
		pNrOrdem.setAlignment(Element.ALIGN_RIGHT);
		doc.add(pNrOrdem);
		
		Phrase pData = new Phrase(30, "Data: ______/_____/______                            "+
				"                        Assintaura: _________________________", fontText);
		doc.add(new Paragraph(pData));
		doc.add(new Paragraph("______________________________________________________________________________"));

		doc.newPage();
		
		// 2ª via ordem serviço
		doc.add(new Paragraph("Oficina RC - Serralheria", fontTitle));
		doc.add(new Paragraph("Av. Flores da Cunha, 1677 - Borghetti - Carazinho - RS", fontSub));
		doc.add(new Paragraph("E-mail: robertocleri@hotmail.com  Contato:(54)99996-6226", fontSub));
		
		doc.add(new Paragraph("ORDEM DE SERVIÇO Nº "+ordem.getIdOrdemServico(), fontTitle));
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		doc.add(new Paragraph("Cliente", fontSubTitle));	
		doc.add(tableClinte);		
		
		doc.add(new Paragraph("Descrição", fontSubTitle));
		doc.add(new Paragraph(ordem.getObservacao(), fontText));
		
		doc.add(new Paragraph("______________________________________________________________________________"));
				
		doc.add(table);
		
		doc.add(pValorTotal);
		
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		doc.add(new Paragraph("Concordo com os lançamentos descritos referentes a Ordem de Serviço.", fontSub));
		doc.add(new Paragraph("Oficina RC - Serralheria.", fontSub));
		doc.add(pNrOrdem);
		doc.add(new Paragraph(pData));
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		
	}
	
	public static String formatString(String value, String pattern) {
        MaskFormatter mf;
        try {
            mf = new MaskFormatter(pattern);
            mf.setValueContainsLiteralCharacters(false);
            return mf.valueToString(value);
        } catch (ParseException ex) {
            return value;
        }
    }
}
