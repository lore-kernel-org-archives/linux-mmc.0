From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: [PATCH 2/2] sdhci-pxa add call back interface to share sdhci-pxa
Date: Fri, 3 Dec 2010 01:31:22 -0500
Message-ID: <AANLkTi=ECyTAPntMfp_F4Kp2A3UCntLxyWJcbpS3WFP3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf3054a52dd71d5804967baf31
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61085 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717Ab0LCGbX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Dec 2010 01:31:23 -0500
Received: by fxm20 with SMTP id 20so1902430fxm.19
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2010 22:31:22 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, niej0001@gmail.com, Philip Rakity <prakity@marvell.com>, Mark Brown <markb@marvell.com>, xywu@marvell.com, njun@marvell.com

--20cf3054a52dd71d5804967baf31
Content-Type: text/plain; charset=ISO-8859-1

>From fb5927afac7cbb44805093816bea51dde33da1e5 Mon Sep 17 00:00:00 2001
From: Zhangfei Gao <zhangfei.gao@marvell.com>
Date: Tue, 30 Nov 2010 05:43:29 -0500
Subject: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa

	Call back functions is added to support mmp2, pxa910, pxa168 and pxa955

Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
CC: RaymondWu <xywu@marvell.com>
CC: Jun Nie <njun@marvell.com>
CC: Philip Rakity <prakity@marvell.com>
---
 arch/arm/plat-pxa/include/plat/sdhci.h |   44 +++++++++++++++++
 drivers/mmc/host/sdhci-pxa.c           |   83 +++++++++++++++++++++-----------
 2 files changed, 98 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-pxa/include/plat/sdhci.h
b/arch/arm/plat-pxa/include/plat/sdhci.h
index 1ab332e..4ce3b05 100644
--- a/arch/arm/plat-pxa/include/plat/sdhci.h
+++ b/arch/arm/plat-pxa/include/plat/sdhci.h
@@ -13,9 +13,14 @@
 #ifndef __PLAT_PXA_SDHCI_H
 #define __PLAT_PXA_SDHCI_H

+#include <linux/mmc/sdhci.h>
+#include <linux/platform_device.h>
+
 /* pxa specific flag */
 /* Require clock free running */
 #define PXA_FLAG_DISABLE_CLOCK_GATING (1<<0)
+/* card alwayes wired to host, like on-chip emmc */
+#define PXA_FLAG_CARD_PERMANENT	(1<<1)

 /* Board design supports 8-bit data on SD/SDIO BUS */
 #define PXA_FLAG_SD_8_BIT_CAPABLE_SLOT (1<<2)
@@ -25,11 +30,50 @@
  * @max_speed: the maximum speed supported
  * @quirks: quirks of specific device
  * @flags: flags for platform requirement
+ * @clk_delay_cycles:
+ *	mmp2: each step is roughly 100ps, 5bits width
+ *	pxa910 & pxa168: each step is 1ns, 4bits width
+ * @clk_delay_enable: enable clk_delay or not, used on pxa910 & pxa168
+ * @clk_delay_sel: select clk_delay, used on pxa910 & pxa168
+ *	0: choose feedback clk
+ *	1: choose feedback clk + delay value
+ *	2: choose internal clk
+ * @ext_cd_gpio: gpio pin used for external CD line
+ * @ext_cd_gpio_invert: invert values for external CD gpio line
+ * @soc_set_timing: set timing for specific soc
+ * @ext_cd_init: Initialize external card detect subsystem
+ * @ext_cd_cleanup: Cleanup external card detect subsystem
+ * @soc_set_ops: overwrite host ops with soc specific ops
  */
+struct sdhci_pxa;
 struct sdhci_pxa_platdata {
 	unsigned int	max_speed;
 	unsigned int	quirks;
 	unsigned int	flags;
+	unsigned int	clk_delay_cycles;
+	unsigned int	clk_delay_sel;
+	unsigned int	ext_cd_gpio;
+	bool		ext_cd_gpio_invert;
+	bool		clk_delay_enable;
+
+	void (*soc_set_timing)(struct sdhci_host *host,
+			struct sdhci_pxa_platdata *pdata);
+	int (*ext_cd_init)(void (*notify_func)(struct platform_device *dev,
+						   int state), void *data);
+	int (*ext_cd_cleanup)(void (*notify_func)(struct platform_device *dev,
+						      int state), void *data);
+	void (*soc_set_ops)(struct sdhci_pxa *pxa);
+};
+
+struct sdhci_pxa {
+	struct sdhci_host		*host;
+	struct sdhci_pxa_platdata	*pdata;
+	struct clk			*clk;
+	struct resource			*res;
+	struct sdhci_ops		*ops;
+
+	u8	clk_enable;
+	u8	power_mode;
 };

 #endif /* __PLAT_PXA_SDHCI_H */
diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-pxa.c
index 5a61208..f79dccf 100644
--- a/drivers/mmc/host/sdhci-pxa.c
+++ b/drivers/mmc/host/sdhci-pxa.c
@@ -24,32 +24,22 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/err.h>
+#include <linux/slab.h>
 #include <plat/sdhci.h>
 #include "sdhci.h"

 #define DRIVER_NAME	"sdhci-pxa"

-#define SD_FIFO_PARAM		0x104
-#define DIS_PAD_SD_CLK_GATE	0x400
-
-struct sdhci_pxa {
-	struct sdhci_host		*host;
-	struct sdhci_pxa_platdata	*pdata;
-	struct clk			*clk;
-	struct resource			*res;
-
-	u8 clk_enable;
-};
-
 /*****************************************************************************\
  *                                                                           *
  * SDHCI core callbacks                                                      *
  *                                                                           *
 \*****************************************************************************/
+
 static void set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pxa *pxa = sdhci_priv(host);
-	u32 tmp = 0;
+	struct sdhci_pxa_platdata *pdata = pxa->pdata;

 	if (clock == 0) {
 		if (pxa->clk_enable) {
@@ -57,21 +47,31 @@ static void set_clock(struct sdhci_host *host,
unsigned int clock)
 			pxa->clk_enable = 0;
 		}
 	} else {
-		if (0 == pxa->clk_enable) {
-			if (pxa->pdata->flags & PXA_FLAG_DISABLE_CLOCK_GATING) {
-				tmp = readl(host->ioaddr + SD_FIFO_PARAM);
-				tmp |= DIS_PAD_SD_CLK_GATE;
-				writel(tmp, host->ioaddr + SD_FIFO_PARAM);
-			}
-			clk_enable(pxa->clk);
-			pxa->clk_enable = 1;
-		}
+		if (pdata && pdata->soc_set_timing)
+			pdata->soc_set_timing(host, pdata);
+		clk_enable(pxa->clk);
+		pxa->clk_enable = 1;
 	}
 }

-static struct sdhci_ops sdhci_pxa_ops = {
-	.set_clock = set_clock,
-};
+static void sdhci_pxa_notify_change(struct platform_device *dev, int state)
+{
+	struct sdhci_host *host = platform_get_drvdata(dev);
+	unsigned long flags;
+
+	if (host) {
+		spin_lock_irqsave(&host->lock, flags);
+		if (state) {
+			dev_dbg(&dev->dev, "card inserted.\n");
+			host->flags &= ~SDHCI_DEVICE_DEAD;
+		} else {
+			dev_dbg(&dev->dev, "card removed.\n");
+			host->flags |= SDHCI_DEVICE_DEAD;
+		}
+		tasklet_schedule(&host->card_tasklet);
+		spin_unlock_irqrestore(&host->lock, flags);
+	}
+}

 /*****************************************************************************\
  *                                                                           *
@@ -111,6 +111,12 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 	pxa->pdata = pdata;
 	pxa->clk_enable = 0;

+	pxa->ops = kzalloc(sizeof(struct sdhci_ops), GFP_KERNEL);
+	if (!pxa->ops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	pxa->clk = clk_get(dev, "PXA-SDHCLK");
 	if (IS_ERR(pxa->clk)) {
 		dev_err(dev, "failed to get io clock\n");
@@ -134,32 +140,46 @@ static int __devinit sdhci_pxa_probe(struct
platform_device *pdev)
 	}

 	host->hw_name = "MMC";
-	host->ops = &sdhci_pxa_ops;
 	host->irq = irq;
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA | SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;

-	if (pdata->quirks)
+	if (pdata && pdata->flags & PXA_FLAG_CARD_PERMANENT) {
+		/* on-chip device */
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+	}
+
+	if (pdata && pdata->quirks)
 		host->quirks |= pdata->quirks;

 	/* If slot design supports 8 bit data, indicate this to MMC. */
 	if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;

+	if (pdata && pdata->soc_set_ops)
+		pdata->soc_set_ops(pxa);
+
+	pxa->ops->set_clock = set_clock;
+	host->ops = pxa->ops;
+
 	ret = sdhci_add_host(host);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add host\n");
 		goto out;
 	}

-	if (pxa->pdata->max_speed)
-		host->mmc->f_max = pxa->pdata->max_speed;
+	if (pdata && pdata->max_speed)
+		host->mmc->f_max = pdata->max_speed;

+	if (pdata && pdata->ext_cd_init)
+		pdata->ext_cd_init(&sdhci_pxa_notify_change, pdata);
 	platform_set_drvdata(pdev, host);

 	return 0;
 out:
 	if (host) {
 		clk_put(pxa->clk);
+		kfree(pxa->ops);
 		if (host->ioaddr)
 			iounmap(host->ioaddr);
 		if (pxa->res)
@@ -173,18 +193,23 @@ out:

 static int __devexit sdhci_pxa_remove(struct platform_device *pdev)
 {
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pxa *pxa = sdhci_priv(host);
 	int dead = 0;
 	u32 scratch;

 	if (host) {
+		if (pdata && pdata->ext_cd_cleanup)
+			pdata->ext_cd_cleanup(&sdhci_pxa_notify_change, pdata);
+
 		scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
 		if (scratch == (u32)-1)
 			dead = 1;

 		sdhci_remove_host(host, dead);

+		kfree(pxa->ops);
 		if (host->ioaddr)
 			iounmap(host->ioaddr);
 		if (pxa->res)
-- 
1.7.0.4

--20cf3054a52dd71d5804967baf31
Content-Type: text/x-patch; charset=US-ASCII;
	name="0002-sdhci-pxa-add-call-back-interface-to-share-sdhci-pxa.patch"
Content-Disposition: attachment;
	filename="0002-sdhci-pxa-add-call-back-interface-to-share-sdhci-pxa.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gh8r8n6p0

RnJvbSBmYjU5MjdhZmFjN2NiYjQ0ODA1MDkzODE2YmVhNTFkZGUzM2RhMWU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVpLmdhb0BtYXJ2ZWxsLmNv
bT4KRGF0ZTogVHVlLCAzMCBOb3YgMjAxMCAwNTo0MzoyOSAtMDUwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8yXSBzZGhjaS1weGE6IGFkZCBjYWxsIGJhY2sgaW50ZXJmYWNlIHRvIHNoYXJlIHNkaGNpLXB4
YQoKCUNhbGwgYmFjayBmdW5jdGlvbnMgaXMgYWRkZWQgdG8gc3VwcG9ydCBtbXAyLCBweGE5MTAs
IHB4YTE2OCBhbmQgcHhhOTU1CgpTaWduZWQtb2ZmLWJ5OiBaaGFuZ2ZlaSBHYW8gPHpoYW5nZmVp
Lmdhb0BtYXJ2ZWxsLmNvbT4KQ0M6IFJheW1vbmRXdSA8eHl3dUBtYXJ2ZWxsLmNvbT4KQ0M6IEp1
biBOaWUgPG5qdW5AbWFydmVsbC5jb20+CkNDOiBQaGlsaXAgUmFraXR5IDxwcmFraXR5QG1hcnZl
bGwuY29tPgotLS0KIGFyY2gvYXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIHwgICA0
NCArKysrKysrKysrKysrKysrKwogZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYyAgICAgICAg
ICAgfCAgIDgzICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDk4IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL3BsYXQtcHhhL2luY2x1ZGUvcGxhdC9zZGhjaS5oIGIvYXJjaC9hcm0vcGxhdC1weGEvaW5j
bHVkZS9wbGF0L3NkaGNpLmgKaW5kZXggMWFiMzMyZS4uNGNlM2IwNSAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vcGxhdC1weGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKKysrIGIvYXJjaC9hcm0vcGxhdC1w
eGEvaW5jbHVkZS9wbGF0L3NkaGNpLmgKQEAgLTEzLDkgKzEzLDE0IEBACiAjaWZuZGVmIF9fUExB
VF9QWEFfU0RIQ0lfSAogI2RlZmluZSBfX1BMQVRfUFhBX1NESENJX0gKIAorI2luY2x1ZGUgPGxp
bnV4L21tYy9zZGhjaS5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorCiAv
KiBweGEgc3BlY2lmaWMgZmxhZyAqLwogLyogUmVxdWlyZSBjbG9jayBmcmVlIHJ1bm5pbmcgKi8K
ICNkZWZpbmUgUFhBX0ZMQUdfRElTQUJMRV9DTE9DS19HQVRJTkcgKDE8PDApCisvKiBjYXJkIGFs
d2F5ZXMgd2lyZWQgdG8gaG9zdCwgbGlrZSBvbi1jaGlwIGVtbWMgKi8KKyNkZWZpbmUgUFhBX0ZM
QUdfQ0FSRF9QRVJNQU5FTlQJKDE8PDEpCiAKIC8qIEJvYXJkIGRlc2lnbiBzdXBwb3J0cyA4LWJp
dCBkYXRhIG9uIFNEL1NESU8gQlVTICovCiAjZGVmaW5lIFBYQV9GTEFHX1NEXzhfQklUX0NBUEFC
TEVfU0xPVCAoMTw8MikKQEAgLTI1LDExICszMCw1MCBAQAogICogQG1heF9zcGVlZDogdGhlIG1h
eGltdW0gc3BlZWQgc3VwcG9ydGVkCiAgKiBAcXVpcmtzOiBxdWlya3Mgb2Ygc3BlY2lmaWMgZGV2
aWNlCiAgKiBAZmxhZ3M6IGZsYWdzIGZvciBwbGF0Zm9ybSByZXF1aXJlbWVudAorICogQGNsa19k
ZWxheV9jeWNsZXM6CisgKgltbXAyOiBlYWNoIHN0ZXAgaXMgcm91Z2hseSAxMDBwcywgNWJpdHMg
d2lkdGgKKyAqCXB4YTkxMCAmIHB4YTE2ODogZWFjaCBzdGVwIGlzIDFucywgNGJpdHMgd2lkdGgK
KyAqIEBjbGtfZGVsYXlfZW5hYmxlOiBlbmFibGUgY2xrX2RlbGF5IG9yIG5vdCwgdXNlZCBvbiBw
eGE5MTAgJiBweGExNjgKKyAqIEBjbGtfZGVsYXlfc2VsOiBzZWxlY3QgY2xrX2RlbGF5LCB1c2Vk
IG9uIHB4YTkxMCAmIHB4YTE2OAorICoJMDogY2hvb3NlIGZlZWRiYWNrIGNsaworICoJMTogY2hv
b3NlIGZlZWRiYWNrIGNsayArIGRlbGF5IHZhbHVlCisgKgkyOiBjaG9vc2UgaW50ZXJuYWwgY2xr
CisgKiBAZXh0X2NkX2dwaW86IGdwaW8gcGluIHVzZWQgZm9yIGV4dGVybmFsIENEIGxpbmUKKyAq
IEBleHRfY2RfZ3Bpb19pbnZlcnQ6IGludmVydCB2YWx1ZXMgZm9yIGV4dGVybmFsIENEIGdwaW8g
bGluZQorICogQHNvY19zZXRfdGltaW5nOiBzZXQgdGltaW5nIGZvciBzcGVjaWZpYyBzb2MKKyAq
IEBleHRfY2RfaW5pdDogSW5pdGlhbGl6ZSBleHRlcm5hbCBjYXJkIGRldGVjdCBzdWJzeXN0ZW0K
KyAqIEBleHRfY2RfY2xlYW51cDogQ2xlYW51cCBleHRlcm5hbCBjYXJkIGRldGVjdCBzdWJzeXN0
ZW0KKyAqIEBzb2Nfc2V0X29wczogb3ZlcndyaXRlIGhvc3Qgb3BzIHdpdGggc29jIHNwZWNpZmlj
IG9wcwogICovCitzdHJ1Y3Qgc2RoY2lfcHhhOwogc3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSB7
CiAJdW5zaWduZWQgaW50CW1heF9zcGVlZDsKIAl1bnNpZ25lZCBpbnQJcXVpcmtzOwogCXVuc2ln
bmVkIGludAlmbGFnczsKKwl1bnNpZ25lZCBpbnQJY2xrX2RlbGF5X2N5Y2xlczsKKwl1bnNpZ25l
ZCBpbnQJY2xrX2RlbGF5X3NlbDsKKwl1bnNpZ25lZCBpbnQJZXh0X2NkX2dwaW87CisJYm9vbAkJ
ZXh0X2NkX2dwaW9faW52ZXJ0OworCWJvb2wJCWNsa19kZWxheV9lbmFibGU7CisKKwl2b2lkICgq
c29jX3NldF90aW1pbmcpKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LAorCQkJc3RydWN0IHNkaGNp
X3B4YV9wbGF0ZGF0YSAqcGRhdGEpOworCWludCAoKmV4dF9jZF9pbml0KSh2b2lkICgqbm90aWZ5
X2Z1bmMpKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwKKwkJCQkJCSAgIGludCBzdGF0ZSks
IHZvaWQgKmRhdGEpOworCWludCAoKmV4dF9jZF9jbGVhbnVwKSh2b2lkICgqbm90aWZ5X2Z1bmMp
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKmRldiwKKwkJCQkJCSAgICAgIGludCBzdGF0ZSksIHZv
aWQgKmRhdGEpOworCXZvaWQgKCpzb2Nfc2V0X29wcykoc3RydWN0IHNkaGNpX3B4YSAqcHhhKTsK
K307CisKK3N0cnVjdCBzZGhjaV9weGEgeworCXN0cnVjdCBzZGhjaV9ob3N0CQkqaG9zdDsKKwlz
dHJ1Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhCSpwZGF0YTsKKwlzdHJ1Y3QgY2xrCQkJKmNsazsKKwlz
dHJ1Y3QgcmVzb3VyY2UJCQkqcmVzOworCXN0cnVjdCBzZGhjaV9vcHMJCSpvcHM7CisKKwl1OAlj
bGtfZW5hYmxlOworCXU4CXBvd2VyX21vZGU7CiB9OwogCiAjZW5kaWYgLyogX19QTEFUX1BYQV9T
REhDSV9IICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jIGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1weGEuYwppbmRleCA1YTYxMjA4Li5mNzlkY2NmIDEwMDY0NAot
LS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXB4YS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktcHhhLmMKQEAgLTI0LDMyICsyNCwyMiBAQAogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgog
I2luY2x1ZGUgPGxpbnV4L2lvLmg+CiAjaW5jbHVkZSA8bGludXgvZXJyLmg+CisjaW5jbHVkZSA8
bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPHBsYXQvc2RoY2kuaD4KICNpbmNsdWRlICJzZGhjaS5o
IgogCiAjZGVmaW5lIERSSVZFUl9OQU1FCSJzZGhjaS1weGEiCiAKLSNkZWZpbmUgU0RfRklGT19Q
QVJBTQkJMHgxMDQKLSNkZWZpbmUgRElTX1BBRF9TRF9DTEtfR0FURQkweDQwMAotCi1zdHJ1Y3Qg
c2RoY2lfcHhhIHsKLQlzdHJ1Y3Qgc2RoY2lfaG9zdAkJKmhvc3Q7Ci0Jc3RydWN0IHNkaGNpX3B4
YV9wbGF0ZGF0YQkqcGRhdGE7Ci0Jc3RydWN0IGNsawkJCSpjbGs7Ci0Jc3RydWN0IHJlc291cmNl
CQkJKnJlczsKLQotCXU4IGNsa19lbmFibGU7Ci19OwotCiAvKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKipc
CiAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICoKICAqIFNESENJIGNvcmUgY2FsbGJhY2tzICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKgogICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAqCiBcKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCisKIHN0YXRpYyB2b2lkIHNldF9j
bG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQgaW50IGNsb2NrKQogewogCXN0
cnVjdCBzZGhjaV9weGEgKnB4YSA9IHNkaGNpX3ByaXYoaG9zdCk7Ci0JdTMyIHRtcCA9IDA7CisJ
c3RydWN0IHNkaGNpX3B4YV9wbGF0ZGF0YSAqcGRhdGEgPSBweGEtPnBkYXRhOwogCiAJaWYgKGNs
b2NrID09IDApIHsKIAkJaWYgKHB4YS0+Y2xrX2VuYWJsZSkgewpAQCAtNTcsMjEgKzQ3LDMxIEBA
IHN0YXRpYyB2b2lkIHNldF9jbG9jayhzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCwgdW5zaWduZWQg
aW50IGNsb2NrKQogCQkJcHhhLT5jbGtfZW5hYmxlID0gMDsKIAkJfQogCX0gZWxzZSB7Ci0JCWlm
ICgwID09IHB4YS0+Y2xrX2VuYWJsZSkgewotCQkJaWYgKHB4YS0+cGRhdGEtPmZsYWdzICYgUFhB
X0ZMQUdfRElTQUJMRV9DTE9DS19HQVRJTkcpIHsKLQkJCQl0bXAgPSByZWFkbChob3N0LT5pb2Fk
ZHIgKyBTRF9GSUZPX1BBUkFNKTsKLQkJCQl0bXAgfD0gRElTX1BBRF9TRF9DTEtfR0FURTsKLQkJ
CQl3cml0ZWwodG1wLCBob3N0LT5pb2FkZHIgKyBTRF9GSUZPX1BBUkFNKTsKLQkJCX0KLQkJCWNs
a19lbmFibGUocHhhLT5jbGspOwotCQkJcHhhLT5jbGtfZW5hYmxlID0gMTsKLQkJfQorCQlpZiAo
cGRhdGEgJiYgcGRhdGEtPnNvY19zZXRfdGltaW5nKQorCQkJcGRhdGEtPnNvY19zZXRfdGltaW5n
KGhvc3QsIHBkYXRhKTsKKwkJY2xrX2VuYWJsZShweGEtPmNsayk7CisJCXB4YS0+Y2xrX2VuYWJs
ZSA9IDE7CiAJfQogfQogCi1zdGF0aWMgc3RydWN0IHNkaGNpX29wcyBzZGhjaV9weGFfb3BzID0g
ewotCS5zZXRfY2xvY2sgPSBzZXRfY2xvY2ssCi19Oworc3RhdGljIHZvaWQgc2RoY2lfcHhhX25v
dGlmeV9jaGFuZ2Uoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2LCBpbnQgc3RhdGUpCit7CisJ
c3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShkZXYpOworCXVu
c2lnbmVkIGxvbmcgZmxhZ3M7CisKKwlpZiAoaG9zdCkgeworCQlzcGluX2xvY2tfaXJxc2F2ZSgm
aG9zdC0+bG9jaywgZmxhZ3MpOworCQlpZiAoc3RhdGUpIHsKKwkJCWRldl9kYmcoJmRldi0+ZGV2
LCAiY2FyZCBpbnNlcnRlZC5cbiIpOworCQkJaG9zdC0+ZmxhZ3MgJj0gflNESENJX0RFVklDRV9E
RUFEOworCQl9IGVsc2UgeworCQkJZGV2X2RiZygmZGV2LT5kZXYsICJjYXJkIHJlbW92ZWQuXG4i
KTsKKwkJCWhvc3QtPmZsYWdzIHw9IFNESENJX0RFVklDRV9ERUFEOworCQl9CisJCXRhc2tsZXRf
c2NoZWR1bGUoJmhvc3QtPmNhcmRfdGFza2xldCk7CisJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
Jmhvc3QtPmxvY2ssIGZsYWdzKTsKKwl9Cit9CiAKIC8qKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKlwKICAq
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKgpAQCAtMTExLDYgKzExMSwxMiBAQCBzdGF0aWMgaW50IF9fZGV2
aW5pdCBzZGhjaV9weGFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAlweGEt
PnBkYXRhID0gcGRhdGE7CiAJcHhhLT5jbGtfZW5hYmxlID0gMDsKIAorCXB4YS0+b3BzID0ga3ph
bGxvYyhzaXplb2Yoc3RydWN0IHNkaGNpX29wcyksIEdGUF9LRVJORUwpOworCWlmICghcHhhLT5v
cHMpIHsKKwkJcmV0ID0gLUVOT01FTTsKKwkJZ290byBvdXQ7CisJfQorCiAJcHhhLT5jbGsgPSBj
bGtfZ2V0KGRldiwgIlBYQS1TREhDTEsiKTsKIAlpZiAoSVNfRVJSKHB4YS0+Y2xrKSkgewogCQlk
ZXZfZXJyKGRldiwgImZhaWxlZCB0byBnZXQgaW8gY2xvY2tcbiIpOwpAQCAtMTM0LDMyICsxNDAs
NDYgQEAgc3RhdGljIGludCBfX2RldmluaXQgc2RoY2lfcHhhX3Byb2JlKHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXYpCiAJfQogCiAJaG9zdC0+aHdfbmFtZSA9ICJNTUMiOwotCWhvc3QtPm9w
cyA9ICZzZGhjaV9weGFfb3BzOwogCWhvc3QtPmlycSA9IGlycTsKIAlob3N0LT5xdWlya3MgPSBT
REhDSV9RVUlSS19CUk9LRU5fQURNQSB8IFNESENJX1FVSVJLX0JST0tFTl9USU1FT1VUX1ZBTDsK
IAotCWlmIChwZGF0YS0+cXVpcmtzKQorCWlmIChwZGF0YSAmJiBwZGF0YS0+ZmxhZ3MgJiBQWEFf
RkxBR19DQVJEX1BFUk1BTkVOVCkgeworCQkvKiBvbi1jaGlwIGRldmljZSAqLworCQlob3N0LT5x
dWlya3MgfD0gU0RIQ0lfUVVJUktfQlJPS0VOX0NBUkRfREVURUNUSU9OOworCQlob3N0LT5tbWMt
PmNhcHMgfD0gTU1DX0NBUF9OT05SRU1PVkFCTEU7CisJfQorCisJaWYgKHBkYXRhICYmIHBkYXRh
LT5xdWlya3MpCiAJCWhvc3QtPnF1aXJrcyB8PSBwZGF0YS0+cXVpcmtzOwogCiAJLyogSWYgc2xv
dCBkZXNpZ24gc3VwcG9ydHMgOCBiaXQgZGF0YSwgaW5kaWNhdGUgdGhpcyB0byBNTUMuICovCiAJ
aWYgKHBkYXRhLT5mbGFncyAmIFBYQV9GTEFHX1NEXzhfQklUX0NBUEFCTEVfU0xPVCkKIAkJaG9z
dC0+bW1jLT5jYXBzIHw9IE1NQ19DQVBfOF9CSVRfREFUQTsKIAorCWlmIChwZGF0YSAmJiBwZGF0
YS0+c29jX3NldF9vcHMpCisJCXBkYXRhLT5zb2Nfc2V0X29wcyhweGEpOworCisJcHhhLT5vcHMt
PnNldF9jbG9jayA9IHNldF9jbG9jazsKKwlob3N0LT5vcHMgPSBweGEtPm9wczsKKwogCXJldCA9
IHNkaGNpX2FkZF9ob3N0KGhvc3QpOwogCWlmIChyZXQpIHsKIAkJZGV2X2VycigmcGRldi0+ZGV2
LCAiZmFpbGVkIHRvIGFkZCBob3N0XG4iKTsKIAkJZ290byBvdXQ7CiAJfQogCi0JaWYgKHB4YS0+
cGRhdGEtPm1heF9zcGVlZCkKLQkJaG9zdC0+bW1jLT5mX21heCA9IHB4YS0+cGRhdGEtPm1heF9z
cGVlZDsKKwlpZiAocGRhdGEgJiYgcGRhdGEtPm1heF9zcGVlZCkKKwkJaG9zdC0+bW1jLT5mX21h
eCA9IHBkYXRhLT5tYXhfc3BlZWQ7CiAKKwlpZiAocGRhdGEgJiYgcGRhdGEtPmV4dF9jZF9pbml0
KQorCQlwZGF0YS0+ZXh0X2NkX2luaXQoJnNkaGNpX3B4YV9ub3RpZnlfY2hhbmdlLCBwZGF0YSk7
CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgaG9zdCk7CiAKIAlyZXR1cm4gMDsKIG91dDoK
IAlpZiAoaG9zdCkgewogCQljbGtfcHV0KHB4YS0+Y2xrKTsKKwkJa2ZyZWUocHhhLT5vcHMpOwog
CQlpZiAoaG9zdC0+aW9hZGRyKQogCQkJaW91bm1hcChob3N0LT5pb2FkZHIpOwogCQlpZiAocHhh
LT5yZXMpCkBAIC0xNzMsMTggKzE5MywyMyBAQCBvdXQ6CiAKIHN0YXRpYyBpbnQgX19kZXZleGl0
IHNkaGNpX3B4YV9yZW1vdmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIHsKKwlzdHJ1
Y3Qgc2RoY2lfcHhhX3BsYXRkYXRhICpwZGF0YSA9IHBkZXYtPmRldi5wbGF0Zm9ybV9kYXRhOwog
CXN0cnVjdCBzZGhjaV9ob3N0ICpob3N0ID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEocGRldik7CiAJ
c3RydWN0IHNkaGNpX3B4YSAqcHhhID0gc2RoY2lfcHJpdihob3N0KTsKIAlpbnQgZGVhZCA9IDA7
CiAJdTMyIHNjcmF0Y2g7CiAKIAlpZiAoaG9zdCkgeworCQlpZiAocGRhdGEgJiYgcGRhdGEtPmV4
dF9jZF9jbGVhbnVwKQorCQkJcGRhdGEtPmV4dF9jZF9jbGVhbnVwKCZzZGhjaV9weGFfbm90aWZ5
X2NoYW5nZSwgcGRhdGEpOworCiAJCXNjcmF0Y2ggPSByZWFkbChob3N0LT5pb2FkZHIgKyBTREhD
SV9JTlRfU1RBVFVTKTsKIAkJaWYgKHNjcmF0Y2ggPT0gKHUzMiktMSkKIAkJCWRlYWQgPSAxOwog
CiAJCXNkaGNpX3JlbW92ZV9ob3N0KGhvc3QsIGRlYWQpOwogCisJCWtmcmVlKHB4YS0+b3BzKTsK
IAkJaWYgKGhvc3QtPmlvYWRkcikKIAkJCWlvdW5tYXAoaG9zdC0+aW9hZGRyKTsKIAkJaWYgKHB4
YS0+cmVzKQotLSAKMS43LjAuNAoK
--20cf3054a52dd71d5804967baf31--
