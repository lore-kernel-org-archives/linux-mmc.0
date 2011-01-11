From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [patch]: sdhci support emmc ddr50 mode [v5]
Date: Mon, 10 Jan 2011 21:56:42 -0500
Message-ID: <AANLkTikJcVpgX7TPr4LTz44HzePKFk-Y1_9QsyUrFk-O@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016368e29f7f963ac0499893b6d
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57736 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753708Ab1AKC4o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jan 2011 21:56:44 -0500
Received: by fxm20 with SMTP id 20so19521980fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jan 2011 18:56:42 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>

--0016368e29f7f963ac0499893b6d
Content-Type: text/plain; charset=ISO-8859-1

Update typo

>From 93873d40ea72b1ccd97c3629ffe555080ac4d0e4 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Sun, 9 Jan 2011 18:09:12 -0500
Subject: [PATCH] mmc: sdhci support emmc ddr50 mode

	1. Spec sdhc 3.0 does not claim support 1.2v ddr mode, so sdhci.c
return error and SDR mode is been reused.
	2. Call back function set_uhs is added, since some controller count
on external pmic to provide io voltage
	3. mmc_set_uhs is added to make host switch io voltage according to uhs_mode
	4. Verified on mmp2 and toshiba emmc

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
---
 drivers/mmc/core/core.c  |   18 +++++++++++++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/mmc.c   |    9 ++++++
 drivers/mmc/host/sdhci.c |   64 +++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h |   16 ++++++++++-
 include/linux/mmc/host.h |    2 +
 6 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index a8e89f3..1f1f185 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -623,6 +623,24 @@ static inline void mmc_set_ios(struct mmc_host *host)
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
+		if (!ret)
+			mmc_delay(5);
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
index 86cac0d..657c5ef 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -529,6 +529,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				ddr = MMC_1_2V_DDR_MODE;
 	}

+	if (ddr) {
+		if (mmc_set_uhs(host, ddr)) {
+			printk(KERN_WARNING "%s: DDR mode not accepted by host "
+				"and reuse MMC_SDR_MODE.\n",
+				mmc_hostname(host));
+			ddr = MMC_SDR_MODE;
+		}
+	}
+
 	/*
 	 * Activate wide bus and DDR (if supported).
 	 */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d5febe5..decc50f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -80,7 +80,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 		sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
 	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
 		sdhci_readl(host, SDHCI_CAPABILITIES),
-		sdhci_readl(host, SDHCI_CAPABILITIES_1));
+		sdhci_readl(host, SDHCI_CAPABILITIES_H));
 	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
 		sdhci_readw(host, SDHCI_COMMAND),
 		sdhci_readl(host, SDHCI_MAX_CURRENT));
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
+	if (uhs_mode & MMC_1_8V_DDR_MODE) {
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
+		caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
+	}
+
+	if (caps & SDHCI_CAN_VDD_180) {
+		if (caps_h & SDHCI_CAN_DDR50)
+			mmc->caps |= (MMC_CAP_1_8V_DDR);
+	}

 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6e0969e..6be28a9 100644
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
@@ -166,7 +173,10 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000

-#define SDHCI_CAPABILITIES_1	0x44
+#define SDHCI_CAPABILITIES_H	0x44
+#define  SDHCI_CAN_SDR50	0x00000001
+#define  SDHCI_CAN_SDR104	0x00000002
+#define  SDHCI_CAN_DDR50	0x00000004

 #define SDHCI_MAX_CURRENT	0x48

@@ -222,6 +232,8 @@ struct sdhci_ops {
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
 	unsigned int    (*get_ro)(struct sdhci_host *host);
+	int		(*set_uhs)(struct sdhci_host *host,
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

--0016368e29f7f963ac0499893b6d
Content-Type: text/x-patch; charset=US-ASCII;
	name="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Disposition: attachment;
	filename="0001-mmc-sdhci-support-emmc-ddr50-mode.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gisz89880

RnJvbSA5Mzg3M2Q0MGVhNzJiMWNjZDk3YzM2MjlmZmU1NTUwODBhYzRkMGU0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogU3VuLCA5IEphbiAyMDExIDE4OjA5OjEyIC0wNTAwClN1YmplY3Q6IFtQQVRDSF0g
bW1jOiBzZGhjaSBzdXBwb3J0IGVtbWMgZGRyNTAgbW9kZQoKCTEuIFNwZWMgc2RoYyAzLjAgZG9l
cyBub3QgY2xhaW0gc3VwcG9ydCAxLjJ2IGRkciBtb2RlLCBzbyBzZGhjaS5jIHJldHVybiBlcnJv
ciBhbmQgU0RSIG1vZGUgaXMgYmVlbiByZXVzZWQuCgkyLiBDYWxsIGJhY2sgZnVuY3Rpb24gc2V0
X3VocyBpcyBhZGRlZCwgc2luY2Ugc29tZSBjb250cm9sbGVyIGNvdW50IG9uIGV4dGVybmFsIHBt
aWMgdG8gcHJvdmlkZSBpbyB2b2x0YWdlCgkzLiBtbWNfc2V0X3VocyBpcyBhZGRlZCB0byBtYWtl
IGhvc3Qgc3dpdGNoIGlvIHZvbHRhZ2UgYWNjb3JkaW5nIHRvIHVoc19tb2RlCgk0LiBWZXJpZmll
ZCBvbiBtbXAyIGFuZCB0b3NoaWJhIGVtbWMKClNpZ25lZC1vZmYtYnk6IFpoYW5nZmVpIEdhbyA8
emhhbmdmZWkuZ2FvQG1hcnZlbGwuY29tPgotLS0KIGRyaXZlcnMvbW1jL2NvcmUvY29yZS5jICB8
ICAgMTggKysrKysrKysrKysrKwogZHJpdmVycy9tbWMvY29yZS9jb3JlLmggIHwgICAgMSArCiBk
cml2ZXJzL21tYy9jb3JlL21tYy5jICAgfCAgICA5ICsrKysrKwogZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaS5jIHwgICA2NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLmggfCAgIDE2ICsrKysrKysrKystCiBpbmNsdWRl
L2xpbnV4L21tYy9ob3N0LmggfCAgICAyICsKIDYgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9jb3Jl
LmMgYi9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYwppbmRleCBhOGU4OWYzLi4xZjFmMTg1IDEwMDY0
NAotLS0gYS9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYworKysgYi9kcml2ZXJzL21tYy9jb3JlL2Nv
cmUuYwpAQCAtNjIzLDYgKzYyMywyNCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbW1jX3NldF9pb3Mo
c3RydWN0IG1tY19ob3N0ICpob3N0KQogCWhvc3QtPm9wcy0+c2V0X2lvcyhob3N0LCBpb3MpOwog
fQogCitpbnQgbW1jX3NldF91aHMoc3RydWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQg
dWhzX21vZGUpCit7CisJaW50IHJldCA9IC1FSU5WQUw7CisKKwlpZiAoaG9zdC0+b3BzLT5zZXRf
dWhzKSB7CisJCXJldCA9IGhvc3QtPm9wcy0+c2V0X3Vocyhob3N0LCB1aHNfbW9kZSk7CisKKwkJ
LyoKKwkJICogQWNjb3JkaW5nIHRvIHNkaGMgc3RhbmRhcmQgc3BlYyB2My4wCisJCSAqIDEuOHYg
cmVndWxhdG9yIHNob3VsZCBiZSBzdGFibGUgd2l0aGluZyA1bXMKKwkJICovCisJCWlmICghcmV0
KQorCQkJbW1jX2RlbGF5KDUpOworCX0KKworCXJldHVybiByZXQ7Cit9CisKIC8qCiAgKiBDb250
cm9sIGNoaXAgc2VsZWN0IHBpbiBvbiBhIGhvc3QuCiAgKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2NvcmUvY29yZS5oIGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmgKaW5kZXggMDI2Yzk3NS4u
NGIxZWE3ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvY29yZS9jb3JlLmgKKysrIGIvZHJpdmVy
cy9tbWMvY29yZS9jb3JlLmgKQEAgLTQxLDYgKzQxLDcgQEAgdm9pZCBtbWNfc2V0X2J1c193aWR0
aChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCB3aWR0aCk7CiB2b2lkIG1tY19z
ZXRfYnVzX3dpZHRoX2RkcihzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCB3aWR0
aCwKIAkJCSAgIHVuc2lnbmVkIGludCBkZHIpOwogdTMyIG1tY19zZWxlY3Rfdm9sdGFnZShzdHJ1
Y3QgbW1jX2hvc3QgKmhvc3QsIHUzMiBvY3IpOworaW50IG1tY19zZXRfdWhzKHN0cnVjdCBtbWNf
aG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IHVoc19tb2RlKTsKIHZvaWQgbW1jX3NldF90aW1pbmco
c3RydWN0IG1tY19ob3N0ICpob3N0LCB1bnNpZ25lZCBpbnQgdGltaW5nKTsKIAogc3RhdGljIGlu
bGluZSB2b2lkIG1tY19kZWxheSh1bnNpZ25lZCBpbnQgbXMpCmRpZmYgLS1naXQgYS9kcml2ZXJz
L21tYy9jb3JlL21tYy5jIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYwppbmRleCA4NmNhYzBkLi42
NTdjNWVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL21tYy9jb3JlL21tYy5jCisrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvbW1jLmMKQEAgLTUyOSw2ICs1MjksMTUgQEAgc3RhdGljIGludCBtbWNfaW5pdF9j
YXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwgdTMyIG9jciwKIAkJCQlkZHIgPSBNTUNfMV8yVl9E
RFJfTU9ERTsKIAl9CiAKKwlpZiAoZGRyKSB7CisJCWlmIChtbWNfc2V0X3Vocyhob3N0LCBkZHIp
KSB7CisJCQlwcmludGsoS0VSTl9XQVJOSU5HICIlczogRERSIG1vZGUgbm90IGFjY2VwdGVkIGJ5
IGhvc3QgIgorCQkJCSJhbmQgcmV1c2UgTU1DX1NEUl9NT0RFLlxuIiwKKwkJCQltbWNfaG9zdG5h
bWUoaG9zdCkpOworCQkJZGRyID0gTU1DX1NEUl9NT0RFOworCQl9CisJfQorCiAJLyoKIAkgKiBB
Y3RpdmF0ZSB3aWRlIGJ1cyBhbmQgRERSIChpZiBzdXBwb3J0ZWQpLgogCSAqLwpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5jCmlu
ZGV4IGQ1ZmViZTUuLmRlY2M1MGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ku
YworKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmMKQEAgLTgwLDcgKzgwLDcgQEAgc3RhdGlj
IHZvaWQgc2RoY2lfZHVtcHJlZ3Moc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCiAJCXNkaGNpX3Jl
YWR3KGhvc3QsIFNESENJX1NMT1RfSU5UX1NUQVRVUykpOwogCXByaW50ayhLRVJOX0RFQlVHIERS
SVZFUl9OQU1FICI6IENhcHM6ICAgICAweCUwOHggfCBDYXBzXzE6ICAgMHglMDh4XG4iLAogCQlz
ZGhjaV9yZWFkbChob3N0LCBTREhDSV9DQVBBQklMSVRJRVMpLAotCQlzZGhjaV9yZWFkbChob3N0
LCBTREhDSV9DQVBBQklMSVRJRVNfMSkpOworCQlzZGhjaV9yZWFkbChob3N0LCBTREhDSV9DQVBB
QklMSVRJRVNfSCkpOwogCXByaW50ayhLRVJOX0RFQlVHIERSSVZFUl9OQU1FICI6IENtZDogICAg
ICAweCUwOHggfCBNYXggY3VycjogMHglMDh4XG4iLAogCQlzZGhjaV9yZWFkdyhob3N0LCBTREhD
SV9DT01NQU5EKSwKIAkJc2RoY2lfcmVhZGwoaG9zdCwgU0RIQ0lfTUFYX0NVUlJFTlQpKTsKQEAg
LTk4Niw2ICs5ODYsMjIgQEAgc3RhdGljIHZvaWQgc2RoY2lfZmluaXNoX2NvbW1hbmQoc3RydWN0
IHNkaGNpX2hvc3QgKmhvc3QpCiAJaG9zdC0+Y21kID0gTlVMTDsKIH0KIAorc3RhdGljIHZvaWQg
c2RoY2lfc2V0X2RkcihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGRkcikK
K3sKKwl1MTYgY29uOworCisJaWYgKGRkciA9PSBNTUNfU0RSX01PREUpCisJCXJldHVybjsKKwor
CWNvbiA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0hPU1RfQ09OVFJPTDIpOworCWlmIChjb24g
JiBTREhDSV9DVFJMMl8xXzhWKSB7CisJCWNvbiAmPSB+U0RIQ0lfQ1RSTDJfVUhTX01BU0s7CisJ
CWlmIChkZHIgJiBNTUNfMV84Vl9ERFJfTU9ERSkKKwkJCWNvbiB8PSBTREhDSV9DVFJMMl9ERFI1
MDsKKwkJc2RoY2lfd3JpdGV3KGhvc3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisJfQor
fQorCiBzdGF0aWMgdm9pZCBzZGhjaV9zZXRfY2xvY2soc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Qs
IHVuc2lnbmVkIGludCBjbG9jaykKIHsKIAlpbnQgZGl2OwpAQCAtMTE4MCw2ICsxMTk2LDcgQEAg
c3RhdGljIHZvaWQgc2RoY2lfc2V0X2lvcyhzdHJ1Y3QgbW1jX2hvc3QgKm1tYywgc3RydWN0IG1t
Y19pb3MgKmlvcykKIAl9CiAKIAlzZGhjaV9zZXRfY2xvY2soaG9zdCwgaW9zLT5jbG9jayk7CisJ
c2RoY2lfc2V0X2Rkcihob3N0LCBpb3MtPmRkcik7CiAKIAlpZiAoaW9zLT5wb3dlcl9tb2RlID09
IE1NQ19QT1dFUl9PRkYpCiAJCXNkaGNpX3NldF9wb3dlcihob3N0LCAtMSk7CkBAIC0xMjM3LDYg
KzEyNTQsMzUgQEAgb3V0OgogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmhvc3QtPmxvY2ssIGZs
YWdzKTsKIH0KIAorc3RhdGljIGludCBzZGhjaV9zZXRfdWhzKHN0cnVjdCBtbWNfaG9zdCAqbW1j
LCB1bnNpZ25lZCBpbnQgdWhzX21vZGUpCit7CisJc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Q7CisJ
dW5zaWduZWQgbG9uZyBmbGFnczsKKwlpbnQgcmV0ID0gMDsKKworCWhvc3QgPSBtbWNfcHJpdiht
bWMpOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJmhvc3QtPmxvY2ssIGZsYWdzKTsKKwlpZiAodWhz
X21vZGUgJiBNTUNfMV84Vl9ERFJfTU9ERSkgeworCQl1MTYgY29uOworCisJCWNvbiA9IHNkaGNp
X3JlYWR3KGhvc3QsIFNESENJX0hPU1RfQ09OVFJPTDIpOworCQljb24gfD0gU0RIQ0lfQ1RSTDJf
MV84VjsKKwkJc2RoY2lfd3JpdGV3KGhvc3QsIGNvbiwgU0RIQ0lfSE9TVF9DT05UUk9MMik7CisJ
fSBlbHNlCisJCWdvdG8gZXJyOworCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmaG9zdC0+bG9j
aywgZmxhZ3MpOworCisJaWYgKGhvc3QtPm9wcy0+c2V0X3VocykKKwkJcmV0ID0gaG9zdC0+b3Bz
LT5zZXRfdWhzKGhvc3QsIHVoc19tb2RlKTsKKworCXJldHVybiByZXQ7CitlcnI6CisJc3Bpbl91
bmxvY2tfaXJxcmVzdG9yZSgmaG9zdC0+bG9jaywgZmxhZ3MpOworCXJldHVybiAgLUVJTlZBTDsK
K30KKwogc3RhdGljIGludCBzZGhjaV9nZXRfcm8oc3RydWN0IG1tY19ob3N0ICptbWMpCiB7CiAJ
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3Q7CkBAIC0xMjg3LDYgKzEzMzMsNyBAQCBvdXQ6CiBzdGF0
aWMgY29uc3Qgc3RydWN0IG1tY19ob3N0X29wcyBzZGhjaV9vcHMgPSB7CiAJLnJlcXVlc3QJPSBz
ZGhjaV9yZXF1ZXN0LAogCS5zZXRfaW9zCT0gc2RoY2lfc2V0X2lvcywKKwkuc2V0X3Vocwk9IHNk
aGNpX3NldF91aHMsCiAJLmdldF9ybwkJPSBzZGhjaV9nZXRfcm8sCiAJLmVuYWJsZV9zZGlvX2ly
cSA9IHNkaGNpX2VuYWJsZV9zZGlvX2lycSwKIH07CkBAIC0xNzQ0LDcgKzE3OTEsNyBAQCBFWFBP
UlRfU1lNQk9MX0dQTChzZGhjaV9hbGxvY19ob3N0KTsKIGludCBzZGhjaV9hZGRfaG9zdChzdHJ1
Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIHsKIAlzdHJ1Y3QgbW1jX2hvc3QgKm1tYzsKLQl1bnNpZ25l
ZCBpbnQgY2Fwcywgb2NyX2F2YWlsOworCXVuc2lnbmVkIGludCBjYXBzLCBjYXBzX2ggPSAwLCBv
Y3JfYXZhaWw7CiAJaW50IHJldDsKIAogCVdBUk5fT04oaG9zdCA9PSBOVUxMKTsKQEAgLTE3Njcs
OCArMTgxNCwxNyBAQCBpbnQgc2RoY2lfYWRkX2hvc3Qoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Qp
CiAJCQlob3N0LT52ZXJzaW9uKTsKIAl9CiAKLQljYXBzID0gKGhvc3QtPnF1aXJrcyAmIFNESENJ
X1FVSVJLX01JU1NJTkdfQ0FQUykgPyBob3N0LT5jYXBzIDoKLQkJc2RoY2lfcmVhZGwoaG9zdCwg
U0RIQ0lfQ0FQQUJJTElUSUVTKTsKKwlpZiAoaG9zdC0+cXVpcmtzICYgU0RIQ0lfUVVJUktfTUlT
U0lOR19DQVBTKQorCQljYXBzID0gaG9zdC0+Y2FwczsKKwllbHNlIHsKKwkJY2FwcyA9IHNkaGNp
X3JlYWRsKGhvc3QsIFNESENJX0NBUEFCSUxJVElFUyk7CisJCWNhcHNfaCA9IHNkaGNpX3JlYWRs
KGhvc3QsIFNESENJX0NBUEFCSUxJVElFU19IKTsKKwl9CisKKwlpZiAoY2FwcyAmIFNESENJX0NB
Tl9WRERfMTgwKSB7CisJCWlmIChjYXBzX2ggJiBTREhDSV9DQU5fRERSNTApCisJCQltbWMtPmNh
cHMgfD0gKE1NQ19DQVBfMV84Vl9ERFIpOworCX0KIAogCWlmIChob3N0LT5xdWlya3MgJiBTREhD
SV9RVUlSS19GT1JDRV9ETUEpCiAJCWhvc3QtPmZsYWdzIHw9IFNESENJX1VTRV9TRE1BOwpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS5oIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS5oCmluZGV4IDZlMDk2OWUuLjZiZTI4YTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2kuaAorKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLmgKQEAgLTE0NSw3ICsxNDUsMTQg
QEAKIAogI2RlZmluZSBTREhDSV9BQ01EMTJfRVJSCTB4M0MKIAotLyogM0UtM0YgcmVzZXJ2ZWQg
Ki8KKyNkZWZpbmUgU0RIQ0lfSE9TVF9DT05UUk9MMgkweDNFCisjZGVmaW5lICBTREhDSV9DVFJM
Ml9VSFNfTUFTSwkweDAwMDcKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIxMgkweDAwMDAKKyNk
ZWZpbmUgICBTREhDSV9DVFJMMl9TRFIyNQkweDAwMDEKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9T
RFI1MAkweDAwMDIKKyNkZWZpbmUgICBTREhDSV9DVFJMMl9TRFIxMDQJMHgwMDAzCisjZGVmaW5l
ICAgU0RIQ0lfQ1RSTDJfRERSNTAJMHgwMDA0CisjZGVmaW5lICBTREhDSV9DVFJMMl8xXzhWCTB4
MDAwOAogCiAjZGVmaW5lIFNESENJX0NBUEFCSUxJVElFUwkweDQwCiAjZGVmaW5lICBTREhDSV9U
SU1FT1VUX0NMS19NQVNLCTB4MDAwMDAwM0YKQEAgLTE2Niw3ICsxNzMsMTAgQEAKICNkZWZpbmUg
IFNESENJX0NBTl9WRERfMTgwCTB4MDQwMDAwMDAKICNkZWZpbmUgIFNESENJX0NBTl82NEJJVAkw
eDEwMDAwMDAwCiAKLSNkZWZpbmUgU0RIQ0lfQ0FQQUJJTElUSUVTXzEJMHg0NAorI2RlZmluZSBT
REhDSV9DQVBBQklMSVRJRVNfSAkweDQ0CisjZGVmaW5lICBTREhDSV9DQU5fU0RSNTAJMHgwMDAw
MDAwMQorI2RlZmluZSAgU0RIQ0lfQ0FOX1NEUjEwNAkweDAwMDAwMDAyCisjZGVmaW5lICBTREhD
SV9DQU5fRERSNTAJMHgwMDAwMDAwNAogCiAjZGVmaW5lIFNESENJX01BWF9DVVJSRU5UCTB4NDgK
IApAQCAtMjIyLDYgKzIzMiw4IEBAIHN0cnVjdCBzZGhjaV9vcHMgewogCXZvaWQgKCpwbGF0Zm9y
bV9zZW5kX2luaXRfNzRfY2xvY2tzKShzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwKIAkJCQkJICAg
ICB1OCBwb3dlcl9tb2RlKTsKIAl1bnNpZ25lZCBpbnQgICAgKCpnZXRfcm8pKHN0cnVjdCBzZGhj
aV9ob3N0ICpob3N0KTsKKwlpbnQJCSgqc2V0X3Vocykoc3RydWN0IHNkaGNpX2hvc3QgKmhvc3Qs
CisJCQkJdW5zaWduZWQgaW50IHVoc19tb2RlKTsKIH07CiAKICNpZmRlZiBDT05GSUdfTU1DX1NE
SENJX0lPX0FDQ0VTU09SUwpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvaG9zdC5oIGIv
aW5jbHVkZS9saW51eC9tbWMvaG9zdC5oCmluZGV4IGJjYjc5M2UuLjA3MTMxYjAgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvbW1jL2hvc3QuaAorKysgYi9pbmNsdWRlL2xpbnV4L21tYy9ob3N0
LmgKQEAgLTExNyw2ICsxMTcsOCBAQCBzdHJ1Y3QgbW1jX2hvc3Rfb3BzIHsKIAogCS8qIG9wdGlv
bmFsIGNhbGxiYWNrIGZvciBIQyBxdWlya3MgKi8KIAl2b2lkCSgqaW5pdF9jYXJkKShzdHJ1Y3Qg
bW1jX2hvc3QgKmhvc3QsIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCk7CisKKwlpbnQJKCpzZXRfdWhz
KShzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIHVuc2lnbmVkIGludCB1aHNfbW9kZSk7CiB9OwogCiBz
dHJ1Y3QgbW1jX2NhcmQ7Ci0tIAoxLjcuMC40Cgo=
--0016368e29f7f963ac0499893b6d--
