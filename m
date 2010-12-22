From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 23/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:11:35 -0800
Message-ID: <92E97B42-FC3E-4ECA-ABCD-214F0DB7182C@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_92E97B42FC3E4ECAABCD214F0DB7182Cmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54080 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752551Ab0LVHOI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:14:08 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_92E97B42FC3E4ECAABCD214F0DB7182Cmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable




>From e7c195e52dacf3a1d976cdd2da07309f35746af2 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Tue, 21 Dec 2010 21:14:34 -0800
Subject: [PATCH] mach-mmp: brownstone -- change SD/MMC clk_delay to max for=
 eMMC

clk_delay 31 needed to support Dual Data Rate eMMC

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.=
c
index e4e458c..52fc9c5 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -157,7 +157,7 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1=
 =3D {
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 =3D {
 	.adjust_clocks	=3D 1,
 	.clk_select	=3D 1,
-	.clk_delay	=3D 15,
+	.clk_delay	=3D 31,
 	.flags		=3D PXA_FLAG_CARD_PERMANENT |
 				PXA_FLAG_SD_8_BIT_CAPABLE_SLOT,
 };
--=20
1.6.0.4

--_002_92E97B42FC3E4ECAABCD214F0DB7182Cmarvellcom_
Content-Type: application/octet-stream;
	name="0023-mach-mmp-brownstone-change-SD-MMC-clk_delay-to-m.patch"
Content-Description: 0023-mach-mmp-brownstone-change-SD-MMC-clk_delay-to-m.patch
Content-Disposition: attachment;
	filename="0023-mach-mmp-brownstone-change-SD-MMC-clk_delay-to-m.patch";
	size=926; creation-date="Tue, 21 Dec 2010 23:11:35 GMT";
	modification-date="Tue, 21 Dec 2010 23:11:35 GMT"
Content-Transfer-Encoding: base64

RnJvbSBlN2MxOTVlNTJkYWNmM2ExZDk3NmNkZDJkYTA3MzA5ZjM1NzQ2YWYyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBUdWUsIDIxIERlYyAyMDEwIDIxOjE0OjM0IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gbWFj
aC1tbXA6IGJyb3duc3RvbmUgLS0gY2hhbmdlIFNEL01NQyBjbGtfZGVsYXkgdG8gbWF4IGZvciBl
TU1DCgpjbGtfZGVsYXkgMzEgbmVlZGVkIHRvIHN1cHBvcnQgRHVhbCBEYXRhIFJhdGUgZU1NQwoK
U2lnbmVkLW9mZi1ieTogUGhpbGlwIFJha2l0eSA8cHJha2l0eUBtYXJ2ZWxsLmNvbT4KLS0tCiBh
cmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25lLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQs
IDEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9t
YWNoLW1tcC9icm93bnN0b25lLmMgYi9hcmNoL2FybS9tYWNoLW1tcC9icm93bnN0b25lLmMKaW5k
ZXggZTRlNDU4Yy4uNTJmYzljNSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvYnJvd25z
dG9uZS5jCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL2Jyb3duc3RvbmUuYwpAQCAtMTU3LDcgKzE1
Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhIG1tcDJfc2RoX3BsYXRkYXRh
X21tYzEgPSB7CiBzdGF0aWMgc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSBtbXAyX3NkaF9wbGF0
ZGF0YV9tbWMyID0gewogCS5hZGp1c3RfY2xvY2tzCT0gMSwKIAkuY2xrX3NlbGVjdAk9IDEsCi0J
LmNsa19kZWxheQk9IDE1LAorCS5jbGtfZGVsYXkJPSAzMSwKIAkuZmxhZ3MJCT0gUFhBX0ZMQUdf
Q0FSRF9QRVJNQU5FTlQgfAogCQkJCVBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCwKIH07
Ci0tIAoxLjYuMC40Cgo=

--_002_92E97B42FC3E4ECAABCD214F0DB7182Cmarvellcom_--
