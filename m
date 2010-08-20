From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch 1/1] sdhci-base-clock-freqency-change-in-spec-3.0
Date: Fri, 20 Aug 2010 02:22:56 -0400
Message-ID: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001485e98b2263fc88048e3b54cc
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47162 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab0HTGW5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 02:22:57 -0400
Received: by iwn5 with SMTP id 5so470701iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2010 23:22:57 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

--001485e98b2263fc88048e3b54cc
Content-Type: text/plain; charset=ISO-8859-1

>From 6b82bd3c0fe55b7060b8d96801e5e2c4fecc79b7 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zgao6@marvell.com>
Date: Fri, 20 Aug 2010 14:02:36 -0400
Subject: [PATCH] sdhci: base clock freqency change in spec 3.0

	sdhc spec 3.0:       Capabilities Register bits[15-08] is Base Clock Freqency
	sdhc spec 1.0 & 2.0: Capabilities Register bits[13-08] is Base Clock Freqency

Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.c |    8 ++++++--
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 7855121..458e5d4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1778,8 +1778,12 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
 	}

-	host->max_clk =
-		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	if (host->version >= SDHCI_SPEC_300)
+		host->max_clk =
+			(caps & SDHCI_CLOCK_V3_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	else
+		host->max_clk =
+			(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
 	host->max_clk *= 1000000;
 	if (host->max_clk == 0 || host->quirks &
 			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 036cfae..8f71f56 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -140,6 +140,7 @@
 #define  SDHCI_TIMEOUT_CLK_SHIFT 0
 #define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
 #define  SDHCI_CLOCK_BASE_MASK	0x00003F00
+#define  SDHCI_CLOCK_V3_BASE_MASK	0x0000FF00
 #define  SDHCI_CLOCK_BASE_SHIFT	8
 #define  SDHCI_MAX_BLOCK_MASK	0x00030000
 #define  SDHCI_MAX_BLOCK_SHIFT  16
-- 
1.7.0.4

--001485e98b2263fc88048e3b54cc
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-sdhci-base-clock-freqency-change-in-spec-3.0.patch"
Content-Disposition: attachment;
	filename="0001-sdhci-base-clock-freqency-change-in-spec-3.0.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gd3d7gmo0

RnJvbSA2YjgyYmQzYzBmZTU1YjcwNjBiOGQ5NjgwMWU1ZTJjNGZlY2M3OWI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpnYW82QG1hcnZlbGwuY29tPgpEYXRl
OiBGcmksIDIwIEF1ZyAyMDEwIDE0OjAyOjM2IC0wNDAwClN1YmplY3Q6IFtQQVRDSF0gc2RoY2k6
IGJhc2UgY2xvY2sgZnJlcWVuY3kgY2hhbmdlIGluIHNwZWMgMy4wCgoJc2RoYyBzcGVjIDMuMDog
ICAgICAgQ2FwYWJpbGl0aWVzIFJlZ2lzdGVyIGJpdHNbMTUtMDhdIGlzIEJhc2UgQ2xvY2sgRnJl
cWVuY3kKCXNkaGMgc3BlYyAxLjAgJiAyLjA6IENhcGFiaWxpdGllcyBSZWdpc3RlciBiaXRzWzEz
LTA4XSBpcyBCYXNlIENsb2NrIEZyZXFlbmN5CgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8g
PHpnYW82QG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyB8ICAgIDgg
KysrKysrLS0KIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCB8ICAgIDEgKwogMiBmaWxlcyBjaGFu
Z2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmluZGV4IDc4NTUx
MjEuLjQ1OGU1ZDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYworKysgYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTE3NzgsOCArMTc3OCwxMiBAQCBpbnQgc2RoY2lf
YWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJCW1tY19kZXYoaG9zdC0+bW1jKS0+
ZG1hX21hc2sgPSAmaG9zdC0+ZG1hX21hc2s7CiAJfQogCi0JaG9zdC0+bWF4X2NsayA9Ci0JCShj
YXBzICYgU0RIQ0lfQ0xPQ0tfQkFTRV9NQVNLKSA+PiBTREhDSV9DTE9DS19CQVNFX1NISUZUOwor
CWlmIChob3N0LT52ZXJzaW9uID49IFNESENJX1NQRUNfMzAwKQorCQlob3N0LT5tYXhfY2xrID0K
KwkJCShjYXBzICYgU0RIQ0lfQ0xPQ0tfVjNfQkFTRV9NQVNLKSA+PiBTREhDSV9DTE9DS19CQVNF
X1NISUZUOworCWVsc2UKKwkJaG9zdC0+bWF4X2NsayA9CisJCQkoY2FwcyAmIFNESENJX0NMT0NL
X0JBU0VfTUFTSykgPj4gU0RIQ0lfQ0xPQ0tfQkFTRV9TSElGVDsKIAlob3N0LT5tYXhfY2xrICo9
IDEwMDAwMDA7CiAJaWYgKGhvc3QtPm1heF9jbGsgPT0gMCB8fCBob3N0LT5xdWlya3MgJgogCQkJ
U0RIQ0lfUVVJUktfQ0FQX0NMT0NLX0JBU0VfQlJPS0VOKSB7CmRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKaW5kZXggMDM2Y2Zh
ZS4uOGY3MWY1NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oCisrKyBiL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtMTQwLDYgKzE0MCw3IEBACiAjZGVmaW5lICBTREhD
SV9USU1FT1VUX0NMS19TSElGVCAwCiAjZGVmaW5lICBTREhDSV9USU1FT1VUX0NMS19VTklUCTB4
MDAwMDAwODAKICNkZWZpbmUgIFNESENJX0NMT0NLX0JBU0VfTUFTSwkweDAwMDAzRjAwCisjZGVm
aW5lICBTREhDSV9DTE9DS19WM19CQVNFX01BU0sJMHgwMDAwRkYwMAogI2RlZmluZSAgU0RIQ0lf
Q0xPQ0tfQkFTRV9TSElGVAk4CiAjZGVmaW5lICBTREhDSV9NQVhfQkxPQ0tfTUFTSwkweDAwMDMw
MDAwCiAjZGVmaW5lICBTREhDSV9NQVhfQkxPQ0tfU0hJRlQgIDE2Ci0tIAoxLjcuMC40Cgo=
--001485e98b2263fc88048e3b54cc--
