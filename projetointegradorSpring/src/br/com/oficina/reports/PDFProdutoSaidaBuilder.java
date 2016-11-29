package br.com.oficina.reports;

import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import br.com.oficina.beans.OrdemServico;

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

public class PDFProdutoSaidaBuilder extends AbstractITextPdfView{
	
	@SuppressWarnings({"unchecked"})
	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document doc,
			PdfWriter writer, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		List<OrdemServico> listOrdem = (List<OrdemServico>)model.get("ordemServico");
			
		Font fontTitle = new Font();
		fontTitle.setFamily(FontFactory.TIMES_BOLD);
		fontTitle.setSize(16.0F);
		doc.add(new Paragraph("ROBERTO CLERI SOUZA OLIVEIRA 96821906068", fontTitle));
		
		Font fontSub = new Font();
		fontSub.setFamily(FontFactory.TIMES_BOLD);
		fontSub.setSize(8.0F);
		doc.add(new Paragraph("FLORES DA CUNHA , 4001 - SUBSL - BORGHETTI, CARAZINHO, RS - CEP:99500000", fontSub));
		doc.add(new Paragraph("E-mail: robertocleri@hotmail.com  Fone/Fax:(54)99967-7726", fontSub));
		
		doc.add(new Paragraph("Relatório de saída de produtos", fontTitle));		
		
		PdfPTable table = new PdfPTable(5);
		table.setWidthPercentage(100.0f);
		table.setWidths(new float[] {2.0f, 5.0f, 3.0f, 3.0f, 3.0f});
		table.setSpacingBefore(10);
		
		Font font = FontFactory.getFont(FontFactory.HELVETICA);
		font.setSize(10.0f);
		
		PdfPCell cell = new PdfPCell();
		cell.setBackgroundColor(BaseColor.GRAY);
		cell.setPadding(5);
		cell.setBorder(1);
		
		cell.setPhrase(new Phrase("Id", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Descrição", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Ordem Serviço", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Qt.", font));
		table.addCell(cell);
		
		cell.setPhrase(new Phrase("Valor", font));
		table.addCell(cell);
		
		double vlFinal = 0.0;
		
		for (OrdemServico ordem : listOrdem){
			for (int i=0; i < ordem.getItem().size(); i++){
				for (int j=0; j < ordem.getItem().get(i).getListProduto().size(); j++){
					
					PdfPCell c1 = new PdfPCell();
					c1.setPadding(5);
					c1.setBorder(0);
					
					double vlTotal = ordem.getItem().get(i).getListProduto().get(j).getQuantidadeProduto() * ordem.getItem().get(i).getListProduto().get(j).getProduto().getValor();
					c1.setPhrase(new Phrase(""+ordem.getItem().get(i).getListProduto().get(j).getProduto().getId(), font));
					table.addCell(c1);					
					c1.setPhrase(new Phrase(""+ordem.getItem().get(i).getListProduto().get(j).getProduto().getDescricao(), font));
					table.addCell(c1);
					c1.setPhrase(new Phrase(""+ordem.getIdOrdemServico(), font));
					table.addCell(c1);
					c1.setPhrase(new Phrase(""+(new DecimalFormat("#,###,##0.00")).format(ordem.getItem().get(i).getListProduto().get(j).getQuantidadeProduto()), font));
					table.addCell(c1);
					
					Paragraph pVlTotal = new Paragraph(""+(new DecimalFormat("#,###,##0.00")).format(vlTotal), font);
					pVlTotal.setAlignment(Element.ALIGN_RIGHT);					
					c1.addElement(pVlTotal);
					table.addCell(c1);
					
					vlFinal += vlTotal;
				}
			}				
		}
		
		String noResult = "";
		if (listOrdem.size() > 0){
			PdfPCell c2 = new PdfPCell();
			c2.setPadding(5);
			c2.setBorder(0);			
			
			c2.setPhrase(new Phrase(""));
			table.addCell(c2);					
			c2.setPhrase(new Phrase(""));
			table.addCell(c2);
			c2.setPhrase(new Phrase(""));
			table.addCell(c2);
			c2.setBorder(1);
			c2.setPhrase(new Phrase("Total R$", font));
			table.addCell(c2);
			
			Paragraph pVlFinal = new Paragraph(""+(new DecimalFormat("#,###,##0.00")).format(vlFinal), font);
			pVlFinal.setAlignment(Element.ALIGN_RIGHT);					
			c2.addElement(pVlFinal);			
			table.addCell(c2);
		} else {
			noResult = "Não há saída deste produto.";
		}
		
		doc.add(table);
		doc.add(new Paragraph(noResult, font));
	}
	

}
