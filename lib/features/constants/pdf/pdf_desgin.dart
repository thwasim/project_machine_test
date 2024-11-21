import 'dart:io';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

class ReceiptPDF {
  Future<void> generatePDF() async {
    final pdf = pw.Document();

    final logoImage = await rootBundle.load('assets/png/logo.png');
    final logoBackImage = await rootBundle.load('assets/png/icon.png');
    final signatureImg = await rootBundle.load('assets/png/signature.png');
    final signatureImageBytes = signatureImg.buffer.asUint8List();
    final logoBytes = logoImage.buffer.asUint8List();
    final logoBackgroundBytes = logoBackImage.buffer.asUint8List();

    pdf.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          margin: const pw.EdgeInsets.all(24),
          buildBackground: (pw.Context context) {
            return pw.FullPage(
              ignoreMargins: false,
              child: pw.Image(
                pw.MemoryImage(logoBackgroundBytes),
                fit: pw.BoxFit.cover,
              ),
            );
          },
        ),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Image(
                    pw.MemoryImage(logoBytes),
                    height: 40,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('KUMARAKOM', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 5),
                      pw.Text('Cheepunkal P.O, Kumarakom, Kottayam, Kerala - 686563\nemail: unikorn@gmail.com\nMob: +91 9876543210 | +91 9876543211\nGST No: 32AAUCB0093R1ZW',
                          style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                    ],
                  ),
                ],
              ),
              pw.Divider(),
              pw.Text('Patient Details', style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF006837))),
              pw.SizedBox(height: 5),
              pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
                pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Row(children: [
                    pw.Text("Name:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF000000))),
                    pw.SizedBox(width: 66),
                    pw.Text("Salin T", style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text("Address:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF000000))),
                    pw.SizedBox(width: 55),
                    pw.Text("Nakkarakuzhi, Kozhikode", style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text("WhatsApp Number:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF000000))),
                    pw.SizedBox(width: 5),
                    pw.Text("+91 987654321", style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                  ]),
                ]),
                pw.SizedBox(width: 40),
                pw.Column(mainAxisAlignment: pw.MainAxisAlignment.start, crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                  pw.Row(children: [
                    pw.Text("Booked On:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF000000))),
                    pw.SizedBox(width: 50),
                    pw.Text("31/01/2024 / 12:12pm", style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text("Treatment Date:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF000000))),
                    pw.SizedBox(width: 30),
                    pw.Text("21/02/2024", style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                  ]),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text("Treatment Time:", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold, color: const PdfColor.fromInt(0xFF000000))),
                    pw.SizedBox(width: 28),
                    pw.Text("11:00 am", style: const pw.TextStyle(fontSize: 10, color: PdfColor.fromInt(0xFF726C6C))),
                  ]),
                ]),
              ]),
              pw.Divider(),
              pw.Table(
                children: [
                  pw.TableRow(
                    children: [
                      _buildTableCell('Treatment', bold: true),
                      _buildTableCell('Price', bold: true),
                      _buildTableCell('Male', bold: true),
                      _buildTableCell('Female', bold: true),
                      _buildTableCell('Total', bold: true),
                    ],
                  ),
                  _buildTableRow('Panchakarma', '\u{20B9} 230', '4', '4', '\u{20B9} 2,540'),
                  _buildTableRow('Njavara Kizhi Treatment', '\u{20B9} 230', '4', '4', '\u{20B9} 2,540'),
                  _buildTableRow('Panchakarma', '\u{20B9} 230', '4', '4', '\u{20B9} 2,540'),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    _buildAmountRow('Total Amount ', '\u{20B9} 7,620', fontSize: 14, bold: true),
                    pw.SizedBox(height: 5),
                    _buildAmountRow('Discount ', '\u{20B9} 500'),
                    pw.SizedBox(height: 5),
                    _buildAmountRow('Advance ', '\u{20B9} 1,200'),
                    pw.Divider(thickness: 1),
                    _buildAmountRow('Balance ', '\u{20B9} 5,920', fontSize: 14, bold: true),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.SizedBox(
                      width: 200,
                      child: pw.Text('Thank you for choosing us',
                          textAlign: pw.TextAlign.center, style: pw.TextStyle(fontSize: 14, color: const PdfColor.fromInt(0xFF006837), fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.SizedBox(height: 10),
                    pw.SizedBox(
                      width: 200,
                      child: pw.Text('Your health is our commitment, and we hope we have served you with your health journey.', textAlign: pw.TextAlign.left, style: const pw.TextStyle(fontSize: 10)),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Image(
                      pw.MemoryImage(signatureImageBytes),
                      width: 100,
                      fit: pw.BoxFit.contain,
                    ),
                  ],
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Booking amount is non-refundable, and its important to adhere to the allotted time for your treatment.',
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey),
              ),
            ],
          );
        },
      ),
    );

    try {
      final outputDir = await getTemporaryDirectory();
      final filePath = '${outputDir.path}/receipt.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());
      await OpenFilex.open(filePath);
    } catch (e) {
      log('Error generating PDF: $e');
    }
  }

  pw.Widget _buildTableCell(String text, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),
      child: pw.Text(
        text,
        style:
            pw.TextStyle(fontSize: bold ? 12 : 10, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal, color: bold ? const PdfColor.fromInt(0xFF006837) : const PdfColor.fromInt(0xFF726C6C)),
      ),
    );
  }

  pw.TableRow _buildTableRow(String treatment, String price, String male, String female, String total) {
    return pw.TableRow(
      children: [
        _buildTableCell(treatment),
        _buildTableCell(price),
        _buildTableCell(male),
        _buildTableCell(female),
        _buildTableCell(total),
      ],
    );
  }

  pw.Widget _buildAmountRow(String label, String amount, {bool bold = false, double fontSize = 12}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: fontSize, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
        pw.Text(amount, style: pw.TextStyle(fontSize: fontSize, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
      ],
    );
  }
}
