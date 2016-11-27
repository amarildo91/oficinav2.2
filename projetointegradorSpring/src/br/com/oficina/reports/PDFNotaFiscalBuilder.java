package br.com.oficina.reports;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.text.MaskFormatter;

import br.com.oficina.beans.Cidade;
import br.com.oficina.beans.ItemOrdemServico;
import br.com.oficina.beans.NotaFiscal;
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

public class PDFNotaFiscalBuilder extends AbstractITextPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc,
			PdfWriter writer, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		// instancia objetos
		NotaFiscal notaFiscal = (NotaFiscal)model.get("notaFiscal");				
		Pessoa cliente = notaFiscal.getOrdemServico().getPessoa();
		Cidade cidade = cliente.getEndereco().getCidade();
		
		// cabeçalho NF
		PdfPTable tableHeader = new PdfPTable(2);
		tableHeader.setWidthPercentage(100.0f);
		tableHeader.setWidths(new float[] {12.0f, 5.0f});
		tableHeader.setSpacingBefore(10);
		
		// fontes
		Font fontTitle = new Font();
		fontTitle.setFamily(FontFactory.TIMES_BOLD);
		fontTitle.setSize(12.0F);

		Font fontSub = new Font();
		fontSub.setFamily(FontFactory.TIMES_BOLD);
		fontSub.setSize(8.0F);
		
		Font fontText = new Font();
		fontText.setFamily(FontFactory.TIMES_BOLD);
		fontText.setSize(10.0F);
		
		// cell de cabeçalho
		PdfPCell c1 = new PdfPCell(new Phrase("ROBERTO CLERI SOUZA OLIVEIRA 96821906068", fontTitle));
		c1.setBorder(13);
		
		// nr nota fiscal
		Paragraph nrNota = new Paragraph("Nota Fiscal Nº "+notaFiscal.getId(), fontTitle);
		nrNota.setAlignment(Element.ALIGN_RIGHT);		
		PdfPCell c2 = new PdfPCell(new Phrase(nrNota));
		c2.setBorder(13);
		
		// subtitle
		PdfPCell c3 = new PdfPCell(new Phrase("FLORES DA CUNHA , 4001 - SUBSL - BORGHETTI, CARAZINHO, RS - CEP:99500000", fontSub));
		c3.setBorder(12);
		
		// dt emissao
		DateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");
		String date = formatter.format(notaFiscal.getDtEmissao());
		
		Paragraph dtEmissaoNF = new Paragraph("Dt. Emissão: "+ date, fontSub);
		dtEmissaoNF.setAlignment(Element.ALIGN_RIGHT);		
		PdfPCell c4 = new PdfPCell(new Phrase(dtEmissaoNF));
		c4.setBorder(12);
		
		// subtitle
		PdfPCell c5 = new PdfPCell(new Phrase("E-mail: robertocleri@hotmail.com  Fone/Fax:(54)99967-7726", fontSub));
		c5.setBorder(14);
		
		PdfPCell c6 = new PdfPCell(new Phrase("CNPJ: 18.367.515/0001-90", fontSub));
		c6.setBorder(14);
		
		// add celulas a table
		tableHeader.addCell(c1);
		tableHeader.addCell(c2);
		tableHeader.addCell(c3);
		tableHeader.addCell(c4);
		tableHeader.addCell(c5);
		tableHeader.addCell(c6);
		doc.add(tableHeader);
		
		// dados cliente - inicio
		Font fontSubTitle = new Font();
		fontSubTitle.setFamily(FontFactory.TIMES_BOLD);
		fontSubTitle.setSize(11.0F);
		doc.add(new Paragraph("TOMADOR DOS SERVIÇOS", fontSubTitle));
		
		PdfPTable tableClinte = new PdfPTable(2);
		tableClinte.setWidthPercentage(100.0f);
		tableClinte.setWidths(new float[] {4.0f, 4.0f});
		tableClinte.setSpacingBefore(10);
		
		tableClinte.addCell(new Phrase("Razão Social: " + cliente.getNome(), fontText));
		tableClinte.addCell(new Phrase("Contato: " + formatString(cliente.getTelefone(), "(##)#####-####"), fontText));
		tableClinte.addCell(new Phrase("Email: " + cliente.getEmail(), fontText));
		
		tableClinte.addCell(new Phrase("Cidade: " + cidade.getNome() + " - " + cidade.getUf().getSigla(), fontText));
		tableClinte.addCell(new Phrase("CPF/CNPJ: " + cliente.getCpfCnpj(), fontText));
		
		tableClinte.addCell(new Phrase("Endereço: " + cliente.getEndereco().getRua()+", "+cliente.getEndereco().getBairro(), fontText));
		tableClinte.addCell(new Phrase("CEP: " + cliente.getEndereco().getCep(), fontText));
		
		doc.add(tableClinte);
		// dados cliente - fim
		
		// observacao
		doc.add(new Paragraph("______________________________________________________________________________"));
		doc.add(new Paragraph("DADOS COMPLEMENTARES", fontSubTitle));
		doc.add(new Paragraph(notaFiscal.getOrdemServico().getObservacao(), fontText));		
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		// items de serviço
		doc.add(new Paragraph("DISCRIMINAÇÃO DOS SERVIÇOS", fontSubTitle));
		PdfPTable table = new PdfPTable(4);
		table.setWidthPercentage(100.0f);
		table.setWidths(new float[] {1.0f, 4.0f, 2.0f, 2.0f});
		table.setSpacingBefore(10);
		
		// define font for table header row
		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		font.setSize(10.0f);
		
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
		for (ItemOrdemServico item : notaFiscal.getOrdemServico().getItem()) {
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
		doc.add(new Paragraph("______________________________________________________________________________"));
		
		// valor da nf
		Paragraph pValorTotal = new Paragraph("VALOR TOTAL DE SERVIÇOS = "+(new DecimalFormat("#,###,##0.00")).format(notaFiscal.getVlTotal()), fontSubTitle);
		pValorTotal.setAlignment(Element.ALIGN_CENTER);
		pValorTotal.setSpacingAfter(9f);
		doc.add(pValorTotal);
		
		// impostos da NF - inicio
		PdfPTable tableDed = new PdfPTable(6);
		tableDed.setWidthPercentage(100.0f);
		tableDed.setWidths(new float[] {2.0f, 2.0f, 2.0f, 2.0f, 2.0f, 2.0f});
		tableDed.setSpacingBefore(10);
		
		tableDed.addCell(new Phrase("PIS (R$)", fontText));
		tableDed.addCell(new Phrase("COFINS(R$)", fontText));
		tableDed.addCell(new Phrase("INSS (R$)", fontText));
		tableDed.addCell(new Phrase("IR (R$)", fontText));
		tableDed.addCell(new Phrase("CSLL (R$)", fontText));
		tableDed.addCell(new Phrase("Outras Retenções (R$)", fontText));
		
		tableDed.addCell(new Phrase("0,00", fontText));
		tableDed.addCell(new Phrase("0,00", fontText));
		tableDed.addCell(new Phrase("0,00", fontText));
		tableDed.addCell(new Phrase("0,00", fontText));
		tableDed.addCell(new Phrase("0,00", fontText));
		tableDed.addCell(new Phrase("0,00", fontText));
				
		doc.add(tableDed);	
		
		PdfPTable tableImp = new PdfPTable(4);
		tableImp.setWidthPercentage(100.0f);
		tableImp.setWidths(new float[] {4.0f, 4.0f, 4.0f, 4.0f});
		tableImp.setSpacingBefore(10);
		
		tableImp.addCell(new Phrase("Deduções", fontText));
		tableImp.addCell(new Phrase("Desconto Incondicionado", fontText));
		tableImp.addCell(new Phrase("Base de Cálculo", fontText));
		tableImp.addCell(new Phrase("Alíquota %", fontText));
		
		tableImp.addCell(new Phrase("0,00", fontText));
		tableImp.addCell(new Phrase("0,00", fontText));
		tableImp.addCell(new Phrase(""+(new DecimalFormat("#,###,##0.00")).format(notaFiscal.getVlTotal()), fontText));
		tableImp.addCell(new Phrase("-", fontText));
		
		doc.add(tableImp);
		
		PdfPTable tableImp2 = new PdfPTable(5);
		tableImp2.setWidthPercentage(100.0f);
		tableImp2.setWidths(new float[] {4.0f, 2.0f, 4.0f, 4.0f, 4.0f});
		tableImp2.setSpacingBefore(10);
		
		tableImp2.addCell(new Phrase("ISS Prestador (R$)", fontText));
		tableImp2.addCell(new Phrase("ISS Tomador (R$)", fontText));
		tableImp2.addCell(new Phrase("Desconto Condicionado", fontText));
		tableImp2.addCell(new Phrase("Valor Total da Nota (R$)", fontText));
		tableImp2.addCell(new Phrase("Valor Liquido (R$)", fontText));
		
		tableImp2.addCell(new Phrase("-", fontText));
		tableImp2.addCell(new Phrase("0,00", fontText));
		tableImp2.addCell(new Phrase("0,00", fontText));
		tableImp2.addCell(new Phrase(""+(new DecimalFormat("#,###,##0.00")).format(notaFiscal.getVlTotal()), fontText));
		tableImp2.addCell(new Phrase(""+(new DecimalFormat("#,###,##0.00")).format(notaFiscal.getVlTotal()), fontText));
		
		doc.add(tableImp2);		
		doc.add(new Paragraph("**Tributação fixa", fontSub));
		// impostos da NF - fim		
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

