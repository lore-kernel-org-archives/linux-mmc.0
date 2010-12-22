From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 20/23]  Alternative mmc structure to support pxa168, pxa910,
 mmp2 family SD
Date: Tue, 21 Dec 2010 23:10:59 -0800
Message-ID: <744F5B54-A687-4BF0-9F41-A7DE470CB48B@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_744F5B54A6874BF09F41A7DE470CB48Bmarvellcom_"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:50085 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752601Ab0LVHNe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 02:13:34 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Mark Brown <markb@marvell.com>

--_002_744F5B54A6874BF09F41A7DE470CB48Bmarvellcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>From 590eb2cc052330b7a4f68fb2df6255d65e249e1d Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Mon, 20 Dec 2010 21:47:37 -0800
Subject: [PATCH] sdhci: support hardware clock gating in the SD layer

Define callback (platform_hw_clk_gate) that is called when H/W clock gating
is defined. The adaptation layer is responsible for enabling hw clock
gating by:

a) setting mmc->caps |=3D MMC_CAP_HW_CLOCK_GATING to enable h/w gating
b) defining the callback.

Signed-off-by: Philip Rakity <prakity@marvell.com>
Signed-off-by: Mark F. Brown <markb@marvell.com>
Tested-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |    6 ++++++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff9d5f0..dcfbe83 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1203,6 +1203,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, stru=
ct mmc_ios *ios)
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
=20
+#ifdef CONFIG_MMC_CLKGATE
+	if ((mmc->caps & MMC_CAP_HW_CLOCK_GATING)
+		&& host->ops->platform_hw_clk_gate)
+			host->ops->platform_hw_clk_gate(host);
+#endif
+
 	/*
 	 * If your platform has 8-bit width support but is not a v3 controller,
 	 * or if it requires special setup code, you should implement that in
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 84292e0..cbd63e2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -241,6 +241,7 @@ struct sdhci_ops {
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
 	void	(*platform_specific_delay)(struct sdhci_host *host);
+	void	(*platform_hw_clk_gate)(struct sdhci_host *host);
 };
=20
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--=20
1.6.0.4

--_002_744F5B54A6874BF09F41A7DE470CB48Bmarvellcom_
Content-Type: application/octet-stream;
	name="0020-sdhci-support-hardware-clock-gating-in-the-SD-layer.patch"
Content-Description: 0020-sdhci-support-hardware-clock-gating-in-the-SD-layer.patch
Content-Disposition: attachment;
	filename="0020-sdhci-support-hardware-clock-gating-in-the-SD-layer.patch";
	size=1927; creation-date="Tue, 21 Dec 2010 23:11:00 GMT";
	modification-date="Tue, 21 Dec 2010 23:11:00 GMT"
Content-Transfer-Encoding: base64

RnJvbSA1OTBlYjJjYzA1MjMzMGI3YTRmNjhmYjJkZjYyNTVkNjVlMjQ5ZTFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgpE
YXRlOiBNb24sIDIwIERlYyAyMDEwIDIxOjQ3OjM3IC0wODAwClN1YmplY3Q6IFtQQVRDSF0gc2Ro
Y2k6IHN1cHBvcnQgaGFyZHdhcmUgY2xvY2sgZ2F0aW5nIGluIHRoZSBTRCBsYXllcgoKRGVmaW5l
IGNhbGxiYWNrIChwbGF0Zm9ybV9od19jbGtfZ2F0ZSkgdGhhdCBpcyBjYWxsZWQgd2hlbiBIL1cg
Y2xvY2sgZ2F0aW5nCmlzIGRlZmluZWQuIFRoZSBhZGFwdGF0aW9uIGxheWVyIGlzIHJlc3BvbnNp
YmxlIGZvciBlbmFibGluZyBodyBjbG9jawpnYXRpbmcgYnk6CgphKSBzZXR0aW5nIG1tYy0+Y2Fw
cyB8PSBNTUNfQ0FQX0hXX0NMT0NLX0dBVElORyB0byBlbmFibGUgaC93IGdhdGluZwpiKSBkZWZp
bmluZyB0aGUgY2FsbGJhY2suCgpTaWduZWQtb2ZmLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5
QG1hcnZlbGwuY29tPgpTaWduZWQtb2ZmLWJ5OiBNYXJrIEYuIEJyb3duIDxtYXJrYkBtYXJ2ZWxs
LmNvbT4KVGVzdGVkLWJ5OiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZlbGwuY29tPgotLS0K
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8ICAgIDYgKysrKysrCiBkcml2ZXJzL21tYy9ob3N0
L3NkaGNpLmggfCAgICAxICsKIDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2kuYwppbmRleCBmZjlkNWYwLi5kY2ZiZTgzIDEwMDY0NAotLS0gYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCkBA
IC0xMjAzLDYgKzEyMDMsMTIgQEAgc3RhdGljIHZvaWQgc2RoY2lfc2V0X2lvcyhzdHJ1Y3QgbW1j
X2hvc3QgKm1tYywgc3RydWN0IG1tY19pb3MgKmlvcykKIAlpZiAoaG9zdC0+b3BzLT5wbGF0Zm9y
bV9zZW5kX2luaXRfNzRfY2xvY2tzKQogCQlob3N0LT5vcHMtPnBsYXRmb3JtX3NlbmRfaW5pdF83
NF9jbG9ja3MoaG9zdCwgaW9zLT5wb3dlcl9tb2RlKTsKIAorI2lmZGVmIENPTkZJR19NTUNfQ0xL
R0FURQorCWlmICgobW1jLT5jYXBzICYgTU1DX0NBUF9IV19DTE9DS19HQVRJTkcpCisJCSYmIGhv
c3QtPm9wcy0+cGxhdGZvcm1faHdfY2xrX2dhdGUpCisJCQlob3N0LT5vcHMtPnBsYXRmb3JtX2h3
X2Nsa19nYXRlKGhvc3QpOworI2VuZGlmCisKIAkvKgogCSAqIElmIHlvdXIgcGxhdGZvcm0gaGFz
IDgtYml0IHdpZHRoIHN1cHBvcnQgYnV0IGlzIG5vdCBhIHYzIGNvbnRyb2xsZXIsCiAJICogb3Ig
aWYgaXQgcmVxdWlyZXMgc3BlY2lhbCBzZXR1cCBjb2RlLCB5b3Ugc2hvdWxkIGltcGxlbWVudCB0
aGF0IGluCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21t
Yy9ob3N0L3NkaGNpLmgKaW5kZXggODQyOTJlMC4uY2JkNjNlMiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS5oCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtMjQx
LDYgKzI0MSw3IEBAIHN0cnVjdCBzZGhjaV9vcHMgewogCXZvaWQJKCpwbGF0Zm9ybV9yZXNldF9l
eGl0KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzayk7CiAJdW5zaWduZWQgaW50CSgq
Z2V0X2ZfbWF4X2Nsb2NrKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CiAJdm9pZAkoKnBsYXRm
b3JtX3NwZWNpZmljX2RlbGF5KShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CisJdm9pZAkoKnBs
YXRmb3JtX2h3X2Nsa19nYXRlKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCk7CiB9OwogCiAjaWZk
ZWYgQ09ORklHX01NQ19TREhDSV9JT19BQ0NFU1NPUlMKLS0gCjEuNi4wLjQKCg==

--_002_744F5B54A6874BF09F41A7DE470CB48Bmarvellcom_--
