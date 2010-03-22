From: Fred LIU <a18596@motorola.com>
Subject: bug in drivers/mmc/core/core.c
Date: Mon, 22 Mar 2010 14:56:36 +0800
Message-ID: <edce52581003212356r4fd5cfd6hd0209345f21fc79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636284858f66a9d04825e33f0
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:49148 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab0CVH3S (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2010 03:29:18 -0400
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by mdgate1.mot.com (8.14.3/8.14.3) with SMTP id o2M6vE53029351
	for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2010 00:57:14 -0600 (MDT)
Received: from mail-qy0-f203.google.com (mail-qy0-f203.google.com [209.85.221.203])
	by mdgate1.mot.com (8.14.3/8.14.3) with ESMTP id o2M6jxQo026977
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 22 Mar 2010 00:57:14 -0600 (MDT)
Received: by mail-qy0-f203.google.com with SMTP id 41so50769qyk.21
        for <linux-mmc@vger.kernel.org>; Sun, 21 Mar 2010 23:56:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--001636284858f66a9d04825e33f0
Content-Type: text/plain; charset=ISO-8859-1

Hi, greetings,

I think below line has a bug in core.c.

According to SD specification, the maximum identification frequency is
400 KHz (physical_layer_2.0.pdf, page 123).
But the original code would set higher than 400 KHz if the f_min is
higher than 400 KHz. Conversely, if f_min is lower than 400 KHz, it is
always set as 400 KHz. This is wrong also.

========================================================

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3168ebd..0cf7e5c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -907,7 +907,7 @@ static void mmc_power_up(struct mmc_host *host)
 	 */
 	mmc_delay(10);

-	if (host->f_min > 400000) {
+	if (host->f_min < 400000) {
 		pr_warning("%s: Minimum clock frequency too high for "
 				"identification mode\n", mmc_hostname(host));
 		host->ios.clock = host->f_min;

===========================================================

Best regards,
Fred

--001636284858f66a9d04825e33f0
Content-Type: application/octet-stream;
	name="0001-mmc-Maximum-frequency-of-identification-mode-is-400-.patch"
Content-Disposition: attachment;
	filename="0001-mmc-Maximum-frequency-of-identification-mode-is-400-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g72x92f20

RnJvbSA2YzUzODI4MzY5NjQxZWQ3MzcwMjdjZTVkYWIwYTZiNTQ3Yjc5ODI0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogZnJlZCA8ZnJlZEBmcmVkLWRlc2t0b3AuKG5vbmUpPg0KRGF0
ZTogTW9uLCAyMiBNYXIgMjAxMCAxNDo1MzozNCArMDgwMA0KU3ViamVjdDogW1BBVENIXSBbbW1j
XSBNYXhpbXVtIGZyZXF1ZW5jeSBvZiBpZGVudGlmaWNhdGlvbiBtb2RlIGlzIDQwMCBLSHoNCg0K
LS0tDQogZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgfCAgICAyICstDQogMSBmaWxlcyBjaGFuZ2Vk
LCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9jb3JlL2NvcmUuYyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQppbmRleCAzMTY4ZWJk
Li4wY2Y3ZTVjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMNCisrKyBiL2Ry
aXZlcnMvbW1jL2NvcmUvY29yZS5jDQpAQCAtOTA3LDcgKzkwNyw3IEBAIHN0YXRpYyB2b2lkIG1t
Y19wb3dlcl91cChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpDQogCSAqLw0KIAltbWNfZGVsYXkoMTAp
Ow0KIA0KLQlpZiAoaG9zdC0+Zl9taW4gPiA0MDAwMDApIHsNCisJaWYgKGhvc3QtPmZfbWluIDwg
NDAwMDAwKSB7DQogCQlwcl93YXJuaW5nKCIlczogTWluaW11bSBjbG9jayBmcmVxdWVuY3kgdG9v
IGhpZ2ggZm9yICINCiAJCQkJImlkZW50aWZpY2F0aW9uIG1vZGVcbiIsIG1tY19ob3N0bmFtZSho
b3N0KSk7DQogCQlob3N0LT5pb3MuY2xvY2sgPSBob3N0LT5mX21pbjsNCi0tIA0KMS42LjMuMw0K
DQo=
--001636284858f66a9d04825e33f0--
