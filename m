Return-Path: <SRS0=M0wQ=4O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C28C4BA2D
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C47024653
	for <linux-mmc@archiver.kernel.org>; Wed, 26 Feb 2020 22:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="lnt9fUCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgBZW2j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:28:39 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.202]:11957 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727740AbgBZW2i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Feb 2020 17:28:38 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 562C6A503D
        for <linux-mmc@vger.kernel.org>; Wed, 26 Feb 2020 16:28:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 75ATjUI348vkB75ATjPNGk; Wed, 26 Feb 2020 16:28:37 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PtyODivJUtDP9MgCyxcSsityaCmUVDZg/RBEFKBCll0=; b=lnt9fUCwwhD2j8AXOE+QPdVwS0
        rf4kr3sau6HQ7AUq/27TIk4qcQyE7uPX51BjsM7bdgZn0DDb7sjspoANUu7XYfS+eSDzlYragd+6G
        KRq+/zSzjZCqbisZbLoPR/NKuLg3xt394GWv4TWUJHsgpSSgBLRsGYhzw1Atwc5SfsVkD4OSdDDVc
        h4L2TbMYUH5hNB0Db/QqV7G9l+zjZIH3rrl2hDQMnERqZVHiNmkzm5NmiFlipNLh0PzYnOwK9RI48
        6JhzsfVg1/DExj501hZsfpO4WGdrrLEw4fvMn1zKk30UjJkuGdAQqaFGA4sjNXVUWxJ618dF6SpCV
        OyWMwCyQ==;
Received: from [201.162.161.208] (port=50608 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j75AP-001MIy-8J; Wed, 26 Feb 2020 16:28:35 -0600
Date:   Wed, 26 Feb 2020 16:31:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: Replace zero-length array with flexible-array member
Message-ID: <20200226223125.GA20630@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.161.208
X-Source-L: No
X-Exim-ID: 1j75AP-001MIy-8J
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.161.208]:50608
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 28
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-acpi.c    | 2 +-
 drivers/mmc/host/sdhci-cadence.c | 2 +-
 drivers/mmc/host/sdhci-pci.h     | 2 +-
 drivers/mmc/host/sdhci-pltfm.h   | 2 +-
 drivers/mmc/host/sdhci.h         | 2 +-
 drivers/mmc/host/vub300.c        | 2 +-
 include/linux/mmc/host.h         | 2 +-
 include/linux/mmc/sdio_func.h    | 2 +-
 include/uapi/linux/mmc/ioctl.h   | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 9651dca6863e..ea0e4fda3a9e 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -72,7 +72,7 @@ struct sdhci_acpi_host {
 	const struct sdhci_acpi_slot	*slot;
 	struct platform_device		*pdev;
 	bool				use_runtime_pm;
-	unsigned long			private[0] ____cacheline_aligned;
+	unsigned long			private[] ____cacheline_aligned;
 };
 
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 5827d3751b81..9af3fe48d62f 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -67,7 +67,7 @@ struct sdhci_cdns_priv {
 	void __iomem *hrs_addr;
 	bool enhanced_strobe;
 	unsigned int nr_phy_params;
-	struct sdhci_cdns_phy_param phy_params[0];
+	struct sdhci_cdns_phy_param phy_params[];
 };
 
 struct sdhci_cdns_phy_cfg {
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 981bbbe63aff..42ccd123b046 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -163,7 +163,7 @@ struct sdhci_pci_slot {
 	bool			cd_override_level;
 
 	void (*hw_reset)(struct sdhci_host *host);
-	unsigned long		private[0] ____cacheline_aligned;
+	unsigned long		private[] ____cacheline_aligned;
 };
 
 struct sdhci_pci_chip {
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 2af445b8c325..6301b81cf573 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -25,7 +25,7 @@ struct sdhci_pltfm_host {
 	unsigned int clock;
 	u16 xfer_mode_shadow;
 
-	unsigned long private[0] ____cacheline_aligned;
+	unsigned long private[] ____cacheline_aligned;
 };
 
 #ifdef CONFIG_MMC_SDHCI_BIG_ENDIAN_32BIT_BYTE_SWAPPER
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cac2d97782e6..249635692112 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -614,7 +614,7 @@ struct sdhci_host {
 
 	u64			data_timeout;
 
-	unsigned long private[0] ____cacheline_aligned;
+	unsigned long private[] ____cacheline_aligned;
 };
 
 struct sdhci_ops {
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 6ced1b7f642f..a5a90d133f1f 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -95,7 +95,7 @@ struct sd_response_header {
 	u8 port_number;
 	u8 command_type;
 	u8 command_index;
-	u8 command_response[0];
+	u8 command_response[];
 } __packed;
 
 struct sd_status_header {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 562ed06881b0..2629329ab9f2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -465,7 +465,7 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
-	unsigned long		private[0] ____cacheline_aligned;
+	unsigned long		private[] ____cacheline_aligned;
 };
 
 struct device_node;
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 5a177f7a83c3..fa2aaab5e57a 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -25,7 +25,7 @@ struct sdio_func_tuple {
 	struct sdio_func_tuple *next;
 	unsigned char code;
 	unsigned char size;
-	unsigned char data[0];
+	unsigned char data[];
 };
 
 /*
diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
index 00c08120f3ba..98e29e7f54ac 100644
--- a/include/uapi/linux/mmc/ioctl.h
+++ b/include/uapi/linux/mmc/ioctl.h
@@ -57,7 +57,7 @@ struct mmc_ioc_cmd {
  */
 struct mmc_ioc_multi_cmd {
 	__u64 num_of_cmds;
-	struct mmc_ioc_cmd cmds[0];
+	struct mmc_ioc_cmd cmds[];
 };
 
 #define MMC_IOC_CMD _IOWR(MMC_BLOCK_MAJOR, 0, struct mmc_ioc_cmd)
-- 
2.25.0

