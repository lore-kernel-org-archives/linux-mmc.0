From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch]: sdhci support emmc ddr50 mode [v4]
Date: Sun, 9 Jan 2011 06:50:12 -0500
Message-ID: <AANLkTi=EP1dJEEHa49N26s0Hfsq_fie69aqTtNAqbvzZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636c5b6a53e00f70499687438
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36955 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab1AILuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 06:50:14 -0500
Received: by fxm20 with SMTP id 20so18094734fxm.19
        for <linux-mmc@vger.kernel.org>; Sun, 09 Jan 2011 03:50:12 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

--001636c5b6a53e00f70499687438
Content-Type: text/plain; charset=ISO-8859-1

>From d65af1e0a51bd4cc6b7a55b48df2bc23ccb84f2d Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Sun, 9 Jan 2011 18:09:12 -0500
Subject: [PATCH] mmc: sdhci support emmc ddr50 mode

	1. spec sdhc 3.0 does not claim support 1.2v ddr mode
	2. Call back function set_uhs is added, since some controller count
on external pmic to provide io voltage

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/core/core.c  |   17 ++++++++++++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |    5 +++
 drivers/mmc/host/sdhci.c |   62 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |   14 +++++++++-
 include/linux/mmc/host.h |    2 +
 6 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8e89f3..964b44f 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -623,6 +623,23 @@ static inline void mmc_set_ios(struct mmc_host *host)
 	host->ops->set_ios(host, ios);
 }

+int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode)
+{
+	int ret = -EINVAL;
+
+	if (host->ops->set_uhs) {
+		ret = host->ops->set_uhs(host, uhs_mode);
+
+		/*
+		 * According to sdhc standard spec v3.0
+		 * 1.8v regulator should be stable withing 5ms
+		 */
+		mmc_delay(5);
+	}
+
+	return ret;
+}
+
 /*
  * Control chip select pin on a host.
  */
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 026c975..4b1ea7e 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
unsigned int width);
 void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 			   unsigned int ddr);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
+int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);

 static inline void mmc_delay(unsigned int ms)
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 86cac0d..4dac82f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -529,6 +529,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				ddr = MMC_1_2V_DDR_MODE;
 	}

+	if (ddr) {
+		if (mmc_set_uhs(host, ddr))
+			ddr = MMC_SDR_MODE;
+	}
+
 	/*
 	 * Activate wide bus and DDR (if supported).
 	 */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..906f85b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	host->cmd = NULL;
 }

+static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
+{
+	u16 con;
+
+	if (ddr == MMC_SDR_MODE)
+		return;
+
+	con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if (con & SDHCI_CTRL2_1_8V) {
+		con &= ~SDHCI_CTRL2_UHS_MASK;
+		if (ddr & MMC_1_8V_DDR_MODE)
+			con |= SDHCI_CTRL2_DDR50;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+	}
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div;
@@ -1180,6 +1196,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
struct mmc_ios *ios)
 	}

 	sdhci_set_clock(host, ios->clock);
+	sdhci_set_ddr(host, ios->ddr);

 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
@@ -1237,6 +1254,35 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }

+static int sdhci_set_uhs(struct mmc_host *mmc, unsigned int uhs_mode)
+{
+	struct sdhci_host *host;
+	unsigned long flags;
+	int ret = 0;
+
+	host = mmc_priv(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+	if (host->mmc->caps & MMC_CAP_1_8V_DDR) {
+		u16 con;
+
+		con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		con |= SDHCI_CTRL2_1_8V;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
+	} else
+		goto err;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	if (host->ops->set_uhs)
+		ret = host->ops->set_uhs(host, uhs_mode);
+
+	return ret;
+err:
+	spin_unlock_irqrestore(&host->lock, flags);
+	return  -EINVAL;
+}
+
 static int sdhci_get_ro(struct mmc_host *mmc)
 {
 	struct sdhci_host *host;
@@ -1287,6 +1333,7 @@ out:
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
+	.set_uhs	= sdhci_set_uhs,
 	.get_ro		= sdhci_get_ro,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
 };
@@ -1744,7 +1791,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	unsigned int caps, ocr_avail;
+	unsigned int caps, caps_h = 0, ocr_avail;
 	int ret;

 	WARN_ON(host == NULL);
@@ -1767,8 +1814,17 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->version);
 	}

-	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
-		sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
+		caps = host->caps;
+	else {
+		caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+		caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	}
+
+	if (caps & SDHCI_CAN_VDD_180) {
+		if (caps_h & SDHCI_CAN_SDR50)
+			mmc->caps |= (MMC_CAP_1_8V_DDR);
+	}

 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..f8e94b9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -145,7 +145,14 @@

 #define SDHCI_ACMD12_ERR	0x3C

-/* 3E-3F reserved */
+#define SDHCI_HOST_CONTROL2	0x3E
+#define  SDHCI_CTRL2_UHS_MASK	0x0007
+#define   SDHCI_CTRL2_SDR12	0x0000
+#define   SDHCI_CTRL2_SDR25	0x0001
+#define   SDHCI_CTRL2_SDR50	0x0002
+#define   SDHCI_CTRL2_SDR104	0x0003
+#define   SDHCI_CTRL2_DDR50	0x0004
+#define  SDHCI_CTRL2_1_8V	0x0008

 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -167,6 +174,9 @@
 #define  SDHCI_CAN_64BIT	0x10000000

 #define SDHCI_CAPABILITIES_1	0x44
+#define  SDHCI_CAN_SDR50	0x00000001
+#define  SDHCI_CAN_SDR104	0x00000002
+#define  SDHCI_CAN_DDR50	0x00000004

 #define SDHCI_MAX_CURRENT	0x48

@@ -222,6 +232,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	unsigned int    (*set_uhs)(struct sdhci_host *host,
+				unsigned int uhs_mode);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..07131b0 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -117,6 +117,8 @@ struct mmc_host_ops {

 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
+
+	int	(*set_uhs)(struct mmc_host *host, unsigned int uhs_mode);
 };

 struct mmc_card;
-- 
1.7.0.4

--001636c5b6a53e00f70499687438
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Disposition: attachment;
	filename="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_giqnld7s0

RnJvbSBkNjVhZjFlMGE1MWJkNGNjNmI3YTU1YjQ4ZGYyYmMyM2NjYjg0ZjJkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogU3VuLCA5IEphbiAyMDExIDE4OjA5OjEyIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0g
bW1jOiBzZGhjaSBzdXBwb3J0IGVtbWMgZGRyNTAgbW9kZQoKCTEuIHNwZWMgc2RoYyAzLjAgZG9l
cyBub3QgY2xhaW0gc3VwcG9ydCAxLjJ2IGRkciBtb2RlCgkyLiBDYWxsIGJhY2sgZnVuY3Rpb24g
c2V0X3VocyBpcyBhZGRlZCwgc2luY2Ugc29tZSBjb250cm9sbGVyIGNvdW50IG9uIGV4dGVybmFs
IHBtaWMgdG8gcHJvdmlkZSBpbyB2b2x0YWdlCgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8g
PHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9jb3JlL2NvcmUuYyAg
fCAgIDE3ICsrKysrKysrKysrKwogZHJpdmVycy9tbWMvY29yZS9jb3JlLmggIHwgICAgMSArCiBk
cml2ZXJzL21tYy9jb3JlL21tYy5jICAgfCAgICA1ICsrKwogZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5jIHwgICA2MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0K
IGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaCB8ICAgMTQgKysrKysrKysrLQogaW5jbHVkZS9saW51
eC9tbWMvaG9zdC5oIHwgICAgMiArCiA2IGZpbGVzIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgYi9k
cml2ZXJzL21tYy9jb3JlL2NvcmUuYwppbmRleCBhOGU4OWYzLi45NjRiNDRmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYwpA
QCAtNjIzLDYgKzYyMywyMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbW1jX3NldF9pb3Moc3RydWN0
IG1tY19ob3N0ICpob3N0KQogCWhvc3QtPm9wcy0+c2V0X2lvcyhob3N0LCBpb3MpOwogfQogCitp
bnQgbW1jX3NldF91aHMoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgdWhzX21v
ZGUpCit7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwlpZiAoaG9zdC0+b3BzLT5zZXRfdWhzKSB7
CisJCXJldCA9IGhvc3QtPm9wcy0+c2V0X3Vocyhob3N0LCB1aHNfbW9kZSk7CisKKwkJLyoKKwkJ
ICogQWNjb3JkaW5nIHRvIHNkaGMgc3RhbmRhcmQgc3BlYyB2My4wCisJCSAqIDEuOHYgcmVndWxh
dG9yIHNob3VsZCBiZSBzdGFibGUgd2l0aGluZyA1bXMKKwkJICovCisJCW1tY19kZWxheSg1KTsK
Kwl9CisKKwlyZXR1cm4gcmV0OworfQorCiAvKgogICogQ29udHJvbCBjaGlwIHNlbGVjdCBwaW4g
b24gYSBob3N0LgogICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuaCBiL2Ry
aXZlcnMvbW1jL2NvcmUvY29yZS5oCmluZGV4IDAyNmM5NzUuLjRiMWVhN2UgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5oCkBA
IC00MSw2ICs0MSw3IEBAIHZvaWQgbW1jX3NldF9idXNfd2lkdGgoc3RydWN0IG1tY19ob3N0ICpo
b3N0LCB1bnNpZ25lZCBpbnQgd2lkdGgpOwogdm9pZCBtbWNfc2V0X2J1c193aWR0aF9kZHIoc3Ry
dWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgd2lkdGgsCiAJCQkgICB1bnNpZ25lZCBp
bnQgZGRyKTsKIHUzMiBtbWNfc2VsZWN0X3ZvbHRhZ2Uoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1
MzIgb2NyKTsKK2ludCBtbWNfc2V0X3VocyhzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHVuc2lnbmVk
IGludCB1aHNfbW9kZSk7CiB2b2lkIG1tY19zZXRfdGltaW5nKHN0cnVjdCBtbWNfaG9zdCAqaG9z
dCwgdW5zaWduZWQgaW50IHRpbWluZyk7CiAKIHN0YXRpYyBpbmxpbmUgdm9pZCBtbWNfZGVsYXko
dW5zaWduZWQgaW50IG1zKQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9tbWMuYyBiL2Ry
aXZlcnMvbW1jL2NvcmUvbW1jLmMKaW5kZXggODZjYWMwZC4uNGRhYzgyZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tbWMvY29yZS9tbWMuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jCkBAIC01
MjksNiArNTI5LDExIEBAIHN0YXRpYyBpbnQgbW1jX2luaXRfY2FyZChzdHJ1Y3QgbW1jX2hvc3Qg
Kmhvc3QsIHUzMiBvY3IsCiAJCQkJZGRyID0gTU1DXzFfMlZfRERSX01PREU7CiAJfQogCisJaWYg
KGRkcikgeworCQlpZiAobW1jX3NldF91aHMoaG9zdCwgZGRyKSkKKwkJCWRkciA9IE1NQ19TRFJf
TU9ERTsKKwl9CisKIAkvKgogCSAqIEFjdGl2YXRlIHdpZGUgYnVzIGFuZCBERFIgKGlmIHN1cHBv
cnRlZCkuCiAJICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMgYi9kcml2
ZXJzL21tYy9ob3N0L3NkaGNpLmMKaW5kZXggZDVmZWJlNS4uOTA2Zjg1YiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpA
QCAtOTg2LDYgKzk4NiwyMiBAQCBzdGF0aWMgdm9pZCBzZGhjaV9maW5pc2hfY29tbWFuZChzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIAlob3N0LT5jbWQgPSBOVUxMOwogfQogCitzdGF0aWMgdm9p
ZCBzZGhjaV9zZXRfZGRyKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgZGRy
KQoreworCXUxNiBjb247CisKKwlpZiAoZGRyID09IE1NQ19TRFJfTU9ERSkKKwkJcmV0dXJuOwor
CisJY29uID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisJaWYgKGNv
biAmIFNESENJX0NUUkwyXzFfOFYpIHsKKwkJY29uICY9IH5TREhDSV9DVFJMMl9VSFNfTUFTSzsK
KwkJaWYgKGRkciAmIE1NQ18xXzhWX0REUl9NT0RFKQorCQkJY29uIHw9IFNESENJX0NUUkwyX0RE
UjUwOworCQlzZGhjaV93cml0ZXcoaG9zdCwgY29uLCBTREhDSV9IT1NUX0NPTlRST0wyKTsKKwl9
Cit9CisKIHN0YXRpYyB2b2lkIHNkaGNpX3NldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9z
dCwgdW5zaWduZWQgaW50IGNsb2NrKQogewogCWludCBkaXY7CkBAIC0xMTgwLDYgKzExOTYsNyBA
QCBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfaW9zKHN0cnVjdCBtbWNfaG9zdCAqbW1jLCBzdHJ1Y3Qg
bW1jX2lvcyAqaW9zKQogCX0KIAogCXNkaGNpX3NldF9jbG9jayhob3N0LCBpb3MtPmNsb2NrKTsK
KwlzZGhjaV9zZXRfZGRyKGhvc3QsIGlvcy0+ZGRyKTsKIAogCWlmIChpb3MtPnBvd2VyX21vZGUg
PT0gTU1DX1BPV0VSX09GRikKIAkJc2RoY2lfc2V0X3Bvd2VyKGhvc3QsIC0xKTsKQEAgLTEyMzcs
NiArMTI1NCwzNSBAQCBvdXQ6CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaG9zdC0+bG9jaywg
ZmxhZ3MpOwogfQogCitzdGF0aWMgaW50IHNkaGNpX3NldF91aHMoc3RydWN0IG1tY19ob3N0ICpt
bWMsIHVuc2lnbmVkIGludCB1aHNfbW9kZSkKK3sKKwlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdDsK
Kwl1bnNpZ25lZCBsb25nIGZsYWdzOworCWludCByZXQgPSAwOworCisJaG9zdCA9IG1tY19wcml2
KG1tYyk7CisKKwlzcGluX2xvY2tfaXJxc2F2ZSgmaG9zdC0+bG9jaywgZmxhZ3MpOworCWlmICho
b3N0LT5tbWMtPmNhcHMgJiBNTUNfQ0FQXzFfOFZfRERSKSB7CisJCXUxNiBjb247CisKKwkJY29u
ID0gc2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisJCWNvbiB8PSBTREhD
SV9DVFJMMl8xXzhWOworCQlzZGhjaV93cml0ZXcoaG9zdCwgY29uLCBTREhDSV9IT1NUX0NPTlRS
T0wyKTsKKwl9IGVsc2UKKwkJZ290byBlcnI7CisKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZo
b3N0LT5sb2NrLCBmbGFncyk7CisKKwlpZiAoaG9zdC0+b3BzLT5zZXRfdWhzKQorCQlyZXQgPSBo
b3N0LT5vcHMtPnNldF91aHMoaG9zdCwgdWhzX21vZGUpOworCisJcmV0dXJuIHJldDsKK2VycjoK
KwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZob3N0LT5sb2NrLCBmbGFncyk7CisJcmV0dXJuICAt
RUlOVkFMOworfQorCiBzdGF0aWMgaW50IHNkaGNpX2dldF9ybyhzdHJ1Y3QgbW1jX2hvc3QgKm1t
YykKIHsKIAlzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdDsKQEAgLTEyODcsNiArMTMzMyw3IEBAIG91
dDoKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2hvc3Rfb3BzIHNkaGNpX29wcyA9IHsKIAkucmVx
dWVzdAk9IHNkaGNpX3JlcXVlc3QsCiAJLnNldF9pb3MJPSBzZGhjaV9zZXRfaW9zLAorCS5zZXRf
dWhzCT0gc2RoY2lfc2V0X3VocywKIAkuZ2V0X3JvCQk9IHNkaGNpX2dldF9ybywKIAkuZW5hYmxl
X3NkaW9faXJxID0gc2RoY2lfZW5hYmxlX3NkaW9faXJxLAogfTsKQEAgLTE3NDQsNyArMTc5MSw3
IEBAIEVYUE9SVF9TWU1CT0xfR1BMKHNkaGNpX2FsbG9jX2hvc3QpOwogaW50IHNkaGNpX2FkZF9o
b3N0KHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0KQogewogCXN0cnVjdCBtbWNfaG9zdCAqbW1jOwot
CXVuc2lnbmVkIGludCBjYXBzLCBvY3JfYXZhaWw7CisJdW5zaWduZWQgaW50IGNhcHMsIGNhcHNf
aCA9IDAsIG9jcl9hdmFpbDsKIAlpbnQgcmV0OwogCiAJV0FSTl9PTihob3N0ID09IE5VTEwpOwpA
QCAtMTc2Nyw4ICsxODE0LDE3IEBAIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1Y3Qgc2RoY2lfaG9z
dCAqaG9zdCkKIAkJCWhvc3QtPnZlcnNpb24pOwogCX0KIAotCWNhcHMgPSAoaG9zdC0+cXVpcmtz
ICYgU0RIQ0lfUVVJUktfTUlTU0lOR19DQVBTKSA/IGhvc3QtPmNhcHMgOgotCQlzZGhjaV9yZWFk
bChob3N0LCBTREhDSV9DQVBBQklMSVRJRVMpOworCWlmIChob3N0LT5xdWlya3MgJiBTREhDSV9R
VUlSS19NSVNTSU5HX0NBUFMpCisJCWNhcHMgPSBob3N0LT5jYXBzOworCWVsc2UgeworCQljYXBz
ID0gc2RoY2lfcmVhZGwoaG9zdCwgU0RIQ0lfQ0FQQUJJTElUSUVTKTsKKwkJY2Fwc19oID0gc2Ro
Y2lfcmVhZGwoaG9zdCwgU0RIQ0lfQ0FQQUJJTElUSUVTXzEpOworCX0KKworCWlmIChjYXBzICYg
U0RIQ0lfQ0FOX1ZERF8xODApIHsKKwkJaWYgKGNhcHNfaCAmIFNESENJX0NBTl9TRFI1MCkKKwkJ
CW1tYy0+Y2FwcyB8PSAoTU1DX0NBUF8xXzhWX0REUik7CisJfQogCiAJaWYgKGhvc3QtPnF1aXJr
cyAmIFNESENJX1FVSVJLX0ZPUkNFX0RNQSkKIAkJaG9zdC0+ZmxhZ3MgfD0gU0RIQ0lfVVNFX1NE
TUE7CmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLmgKaW5kZXggNmUwOTY5ZS4uZjhlOTRiOSAxMDA2NDQKLS0tIGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS5oCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuaApAQCAtMTQ1LDcg
KzE0NSwxNCBAQAogCiAjZGVmaW5lIFNESENJX0FDTUQxMl9FUlIJMHgzQwogCi0vKiAzRS0zRiBy
ZXNlcnZlZCAqLworI2RlZmluZSBTREhDSV9IT1NUX0NPTlRST0wyCTB4M0UKKyNkZWZpbmUgIFNE
SENJX0NUUkwyX1VIU19NQVNLCTB4MDAwNworI2RlZmluZSAgIFNESENJX0NUUkwyX1NEUjEyCTB4
MDAwMAorI2RlZmluZSAgIFNESENJX0NUUkwyX1NEUjI1CTB4MDAwMQorI2RlZmluZSAgIFNESENJ
X0NUUkwyX1NEUjUwCTB4MDAwMgorI2RlZmluZSAgIFNESENJX0NUUkwyX1NEUjEwNAkweDAwMDMK
KyNkZWZpbmUgICBTREhDSV9DVFJMMl9ERFI1MAkweDAwMDQKKyNkZWZpbmUgIFNESENJX0NUUkwy
XzFfOFYJMHgwMDA4CiAKICNkZWZpbmUgU0RIQ0lfQ0FQQUJJTElUSUVTCTB4NDAKICNkZWZpbmUg
IFNESENJX1RJTUVPVVRfQ0xLX01BU0sJMHgwMDAwMDAzRgpAQCAtMTY3LDYgKzE3NCw5IEBACiAj
ZGVmaW5lICBTREhDSV9DQU5fNjRCSVQJMHgxMDAwMDAwMAogCiAjZGVmaW5lIFNESENJX0NBUEFC
SUxJVElFU18xCTB4NDQKKyNkZWZpbmUgIFNESENJX0NBTl9TRFI1MAkweDAwMDAwMDAxCisjZGVm
aW5lICBTREhDSV9DQU5fU0RSMTA0CTB4MDAwMDAwMDIKKyNkZWZpbmUgIFNESENJX0NBTl9ERFI1
MAkweDAwMDAwMDA0CiAKICNkZWZpbmUgU0RIQ0lfTUFYX0NVUlJFTlQJMHg0OAogCkBAIC0yMjIs
NiArMjMyLDggQEAgc3RydWN0IHNkaGNpX29wcyB7CiAJdm9pZCAoKnBsYXRmb3JtX3NlbmRfaW5p
dF83NF9jbG9ja3MpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAogCQkJCQkgICAgIHU4IHBvd2Vy
X21vZGUpOwogCXVuc2lnbmVkIGludCAgICAoKmdldF9ybykoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QpOworCXVuc2lnbmVkIGludCAgICAoKnNldF91aHMpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0
LAorCQkJCXVuc2lnbmVkIGludCB1aHNfbW9kZSk7CiB9OwogCiAjaWZkZWYgQ09ORklHX01NQ19T
REhDSV9JT19BQ0NFU1NPUlMKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaCBi
L2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaAppbmRleCBiY2I3OTNlLi4wNzEzMWIwIDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L21tYy9ob3N0LmgKKysrIGIvaW5jbHVkZS9saW51eC9tbWMvaG9z
dC5oCkBAIC0xMTcsNiArMTE3LDggQEAgc3RydWN0IG1tY19ob3N0X29wcyB7CiAKIAkvKiBvcHRp
b25hbCBjYWxsYmFjayBmb3IgSEMgcXVpcmtzICovCiAJdm9pZAkoKmluaXRfY2FyZCkoc3RydWN0
IG1tY19ob3N0ICpob3N0LCBzdHJ1Y3QgbW1jX2NhcmQgKmNhcmQpOworCisJaW50CSgqc2V0X3Vo
cykoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgdWhzX21vZGUpOwogfTsKIAog
c3RydWN0IG1tY19jYXJkOwotLSAKMS43LjAuNAoK
--001636c5b6a53e00f70499687438--
