From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH v2] MMC: Standardize header file inclusion checks.
Date: Fri, 27 May 2011 12:57:34 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105271255001.9277@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:37809 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab1E0Q5l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 12:57:41 -0400
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com ([99.241.2.77] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1QQ0M0-000223-C6
	for linux-mmc@vger.kernel.org; Fri, 27 May 2011 12:57:40 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org


Standardize the checks for multiple MMC header file inclusion,
including adding comments to terminating #endif's, and fixing one
incorrect comment.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  not compile-checked since it's basically aesthetic.


diff --git a/include/linux/mmc/boot.h b/include/linux/mmc/boot.h
index 39d787c..23acc3b 100644
--- a/include/linux/mmc/boot.h
+++ b/include/linux/mmc/boot.h
@@ -1,7 +1,7 @@
-#ifndef MMC_BOOT_H
-#define MMC_BOOT_H
+#ifndef LINUX_MMC_BOOT_H
+#define LINUX_MMC_BOOT_H

 enum { MMC_PROGRESS_ENTER, MMC_PROGRESS_INIT,
        MMC_PROGRESS_LOAD, MMC_PROGRESS_DONE };

-#endif
+#endif /* LINUX_MMC_BOOT_H */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index c6927a4..7b4fd7b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -390,4 +390,4 @@ extern void mmc_unregister_driver(struct mmc_driver *);
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);

-#endif
+#endif /* LINUX_MMC_CARD_H */
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b6718e5..791f060 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -179,4 +179,4 @@ static inline void mmc_claim_host(struct mmc_host *host)

 extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);

-#endif
+#endif /* LINUX_MMC_CORE_H */
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index bdd7cee..55d9909 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -11,8 +11,8 @@
  * (at your option) any later version.
  */

-#ifndef _LINUX_MMC_DW_MMC_H_
-#define _LINUX_MMC_DW_MMC_H_
+#ifndef LINUX_MMC_DW_MMC_H
+#define LINUX_MMC_DW_MMC_H

 #define MAX_MCI_SLOTS	2

@@ -219,4 +219,4 @@ struct dw_mci_board {
 	struct block_settings *blk_settings;
 };

-#endif /* _LINUX_MMC_DW_MMC_H_ */
+#endif /* LINUX_MMC_DW_MMC_H */
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1ee4424..fc24b38 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -373,5 +373,4 @@ static inline int mmc_host_cmd23(struct mmc_host *host)
 {
 	return host->caps & MMC_CAP_CMD23;
 }
-#endif
-
+#endif /* LINUX_MMC_HOST_H */
diff --git a/include/linux/mmc/ioctl.h b/include/linux/mmc/ioctl.h
index 5baf298..8fa5bc5 100644
--- a/include/linux/mmc/ioctl.h
+++ b/include/linux/mmc/ioctl.h
@@ -51,4 +51,4 @@ struct mmc_ioc_cmd {
  * block device operations.
  */
 #define MMC_IOC_MAX_BYTES  (512L * 256)
-#endif  /* LINUX_MMC_IOCTL_H */
+#endif /* LINUX_MMC_IOCTL_H */
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index ac26a68..5bade06 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -21,8 +21,8 @@
  *          15 May 2002
  */

-#ifndef MMC_MMC_H
-#define MMC_MMC_H
+#ifndef LINUX_MMC_MMC_H
+#define LINUX_MMC_MMC_H

 /* Standard MMC commands (4.1)           type  argument     response */
    /* class 1 */
@@ -327,5 +327,4 @@ struct _mmc_csd {
 #define MMC_SWITCH_MODE_CLEAR_BITS	0x02	/* Clear bits which are 1 in value */
 #define MMC_SWITCH_MODE_WRITE_BYTE	0x03	/* Set target to value */

-#endif  /* MMC_MMC_PROTOCOL_H */
-
+#endif /* LINUX_MMC_MMC_H */
diff --git a/include/linux/mmc/pm.h b/include/linux/mmc/pm.h
index d37aac4..4a13920 100644
--- a/include/linux/mmc/pm.h
+++ b/include/linux/mmc/pm.h
@@ -27,4 +27,4 @@ typedef unsigned int mmc_pm_flag_t;
 #define MMC_PM_KEEP_POWER	(1 << 0)	/* preserve card power during suspend */
 #define MMC_PM_WAKE_SDIO_IRQ	(1 << 1)	/* wake up host system on SDIO IRQ assertion */

-#endif
+#endif /* LINUX_MMC_PM_H */
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 7d35d52..1ebcf9b 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -9,8 +9,8 @@
  * your option) any later version.
  */

-#ifndef MMC_SD_H
-#define MMC_SD_H
+#ifndef LINUX_MMC_SD_H
+#define LINUX_MMC_SD_H

 /* SD commands                           type  argument     response */
   /* class 0 */
@@ -91,5 +91,4 @@
 #define SD_SWITCH_ACCESS_DEF	0
 #define SD_SWITCH_ACCESS_HS	1

-#endif
-
+#endif /* LINUX_MMC_SD_H */
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
index 548d59d..f7d72a7 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -11,8 +11,8 @@
  * your option) any later version.
  */

-#ifndef _SDHCI_PLTFM_H
-#define _SDHCI_PLTFM_H
+#ifndef LINUX_MMC_SDHCI_PLTFM_H
+#define LINUX_MMC_SDHCI_PLTFM_H

 struct sdhci_ops;
 struct sdhci_host;
@@ -32,4 +32,4 @@ struct sdhci_pltfm_data {
 	void (*exit)(struct sdhci_host *host);
 };

-#endif /* _SDHCI_PLTFM_H */
+#endif /* LINUX_MMC_SDHCI_PLTFM_H */
diff --git a/include/linux/mmc/sdhci-spear.h b/include/linux/mmc/sdhci-spear.h
index 9188c97..5cdc96d 100644
--- a/include/linux/mmc/sdhci-spear.h
+++ b/include/linux/mmc/sdhci-spear.h
@@ -11,8 +11,8 @@
  * warranty of any kind, whether express or implied.
  */

-#ifndef MMC_SDHCI_SPEAR_H
-#define MMC_SDHCI_SPEAR_H
+#ifndef LINUX_MMC_SDHCI_SPEAR_H
+#define LINUX_MMC_SDHCI_SPEAR_H

 #include <linux/platform_device.h>
 /*
@@ -39,4 +39,4 @@ sdhci_set_plat_data(struct platform_device *pdev, struct sdhci_plat_data *data)
 	pdev->dev.platform_data = data;
 }

-#endif /* MMC_SDHCI_SPEAR_H */
+#endif /* LINUX_MMC_SDHCI_SPEAR_H */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 6a68c4e..5666f3a 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -8,8 +8,8 @@
  * the Free Software Foundation; either version 2 of the License, or (at
  * your option) any later version.
  */
-#ifndef __SDHCI_H
-#define __SDHCI_H
+#ifndef LINUX_MMC_SDHCI_H
+#define LINUX_MMC_SDHCI_H

 #include <linux/scatterlist.h>
 #include <linux/compiler.h>
@@ -162,4 +162,4 @@ struct sdhci_host {

 	unsigned long private[0] ____cacheline_aligned;
 };
-#endif /* __SDHCI_H */
+#endif /* LINUX_MMC_SDHCI_H */
diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
index 245cdac..2a2e990 100644
--- a/include/linux/mmc/sdio.h
+++ b/include/linux/mmc/sdio.h
@@ -9,8 +9,8 @@
  * your option) any later version.
  */

-#ifndef MMC_SDIO_H
-#define MMC_SDIO_H
+#ifndef LINUX_MMC_SDIO_H
+#define LINUX_MMC_SDIO_H

 /* SDIO commands                         type  argument     response */
 #define SD_IO_SEND_OP_COND          5 /* bcr  [23:0] OCR         R4  */
@@ -161,5 +161,4 @@

 #define SDIO_FBR_BLKSIZE	0x10	/* block size (2 bytes) */

-#endif
-
+#endif /* LINUX_MMC_SDIO_H */
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 31baaf8..50f0bc9 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -9,8 +9,8 @@
  * your option) any later version.
  */

-#ifndef MMC_SDIO_FUNC_H
-#define MMC_SDIO_FUNC_H
+#ifndef LINUX_MMC_SDIO_FUNC_H
+#define LINUX_MMC_SDIO_FUNC_H

 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
@@ -161,5 +161,4 @@ extern void sdio_f0_writeb(struct sdio_func *func, unsigned char b,
 extern mmc_pm_flag_t sdio_get_host_pm_caps(struct sdio_func *func);
 extern int sdio_set_host_pm_flags(struct sdio_func *func, mmc_pm_flag_t flags);

-#endif
-
+#endif /* LINUX_MMC_SDIO_FUNC_H */
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index a36ab3b..9f03fee 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -2,8 +2,8 @@
  * SDIO Classes, Interface Types, Manufacturer IDs, etc.
  */

-#ifndef MMC_SDIO_IDS_H
-#define MMC_SDIO_IDS_H
+#ifndef LINUX_MMC_SDIO_IDS_H
+#define LINUX_MMC_SDIO_IDS_H

 /*
  * Standard SDIO Function Interfaces
@@ -44,4 +44,4 @@
 #define SDIO_DEVICE_ID_SIANO_NOVA_A0		0x1100
 #define SDIO_DEVICE_ID_SIANO_STELLAR 		0x5347

-#endif
+#endif /* LINUX_MMC_SDIO_IDS_H */
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index 9eb9b4b..0222cd8 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -11,8 +11,8 @@
  *
  */

-#ifndef __SH_MMCIF_H__
-#define __SH_MMCIF_H__
+#ifndef LINUX_MMC_SH_MMCIF_H
+#define LINUX_MMC_SH_MMCIF_H

 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -220,4 +220,4 @@ static inline void sh_mmcif_boot_init(void __iomem *base)
 	sh_mmcif_boot_cmd(base, 0x03400040, 0x00010000);
 }

-#endif /* __SH_MMCIF_H__ */
+#endif /* LINUX_MMC_SH_MMCIF_H */
diff --git a/include/linux/mmc/sh_mobile_sdhi.h b/include/linux/mmc/sh_mobile_sdhi.h
index faf32b6..bd50b36 100644
--- a/include/linux/mmc/sh_mobile_sdhi.h
+++ b/include/linux/mmc/sh_mobile_sdhi.h
@@ -1,5 +1,5 @@
-#ifndef __SH_MOBILE_SDHI_H__
-#define __SH_MOBILE_SDHI_H__
+#ifndef LINUX_MMC_SH_MOBILE_SDHI_H
+#define LINUX_MMC_SH_MOBILE_SDHI_H

 #include <linux/types.h>

@@ -17,4 +17,4 @@ struct sh_mobile_sdhi_info {
 	int (*get_cd)(struct platform_device *pdev);
 };

-#endif /* __SH_MOBILE_SDHI_H__ */
+#endif /* LINUX_MMC_SH_MOBILE_SDHI_H */
diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
index 19490b9..551490f 100644
--- a/include/linux/mmc/tmio.h
+++ b/include/linux/mmc/tmio.h
@@ -12,8 +12,8 @@
  *
  * TC6393XB TC6391XB TC6387XB T7L66XB ASIC3
  */
-#ifndef _LINUX_MMC_TMIO_H_
-#define _LINUX_MMC_TMIO_H_
+#ifndef LINUX_MMC_TMIO_H
+#define LINUX_MMC_TMIO_H

 #define CTL_SD_CMD 0x00
 #define CTL_ARG_REG 0x04
@@ -60,4 +60,4 @@

 #define TMIO_BBS		512		/* Boot block size */

-#endif /* _LINUX_MMC_TMIO_H_ */
+#endif /* LINUX_MMC_TMIO_H */

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
