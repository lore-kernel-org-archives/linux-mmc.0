Return-Path: <SRS0=9I0v=2H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE59C43603
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABDE221739
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Dec 2019 11:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfLQLzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Dec 2019 06:55:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:2032 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfLQLzS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Dec 2019 06:55:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 03:55:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,325,1571727600"; 
   d="scan'208";a="217761205"
Received: from cvg-ubt08.iil.intel.com ([143.185.152.138])
  by orsmga003.jf.intel.com with ESMTP; 17 Dec 2019 03:55:15 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@intel.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: tune multi-block read gap
Date:   Tue, 17 Dec 2019 13:55:02 +0200
Message-Id: <20191217115502.5590-1-vladimir.kondratiev@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Additional tuning required for multi-block read command.
Implement it accordingly to Cadence recommendation.

2 registers used: HRS37 and HRS38. To HRS37, SD interface mode programmed,
this selects HRS38 slot - there is separate slot for every SD interface
mode. HRS38 contains gap parameter,
it is selected by starting with gap=0 and sending multi-block read command.
gap incremented until multi-block read succeeds.

As of now, this tuning executed for HS200 only

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
---
 drivers/mmc/host/sdhci-cadence.c | 137 ++++++++++++++++++++++++++++++-
 1 file changed, 136 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index ae0ec27dd7cc..d0bed1932b6c 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -34,6 +34,23 @@
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400	0x5
 #define   SDHCI_CDNS_HRS06_MODE_MMC_HS400ES	0x6
 
+/* Read block gap */
+#define SDHCI_CDNS_HRS37		0x94	/* interface mode select */
+#define   SDHCI_CDNS_HRS37_MODE_DS		0x0
+#define   SDHCI_CDNS_HRS37_MODE_HS		0x1
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR12	0x8
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR25	0x9
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR50	0xa
+#define   SDHCI_CDNS_HRS37_MODE_UDS_SDR104	0xb
+#define   SDHCI_CDNS_HRS37_MODE_UDS_DDR50	0xc
+#define   SDHCI_CDNS_HRS37_MODE_MMC_LEGACY	0x20
+#define   SDHCI_CDNS_HRS37_MODE_MMC_SDR		0x21
+#define   SDHCI_CDNS_HRS37_MODE_MMC_DDR		0x22
+#define   SDHCI_CDNS_HRS37_MODE_MMC_HS200	0x23
+#define   SDHCI_CDNS_HRS37_MODE_MMC_HS400	0x24
+#define   SDHCI_CDNS_HRS37_MODE_MMC_HS400ES	0x25
+#define SDHCI_CDNS_HRS38		0x98	/* Read block gap coefficient */
+#define   SDHCI_CDNS_HRS38_BLKGAP_MAX		0xf
 /* SRS - Slot Register Set (SDHCI-compatible) */
 #define SDHCI_CDNS_SRS_BASE		0x200
 
@@ -272,6 +289,118 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	return 0;
 }
 
+/**
+ * mmc_send_mb_read() - send multi-block read command
+ * @host: MMC host
+ *
+ * Sends multi-block read command, CMD23/CMD18/CMD12, ignore read data
+ *
+ * Return: error code
+ */
+int mmc_send_mb_read(struct mmc_host *host)
+{
+	const int blksz = 512;
+	const int blocks = 32;
+	struct scatterlist sg;
+	struct mmc_command sbc = {
+		.opcode = MMC_SET_BLOCK_COUNT,
+		.arg = blocks,
+		.flags = MMC_RSP_R1 | MMC_CMD_AC,
+	};
+	struct mmc_command cmd = {
+		.opcode = MMC_READ_MULTIPLE_BLOCK,
+		.arg = 0,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC,
+	};
+	struct mmc_command stop = {
+		.opcode = MMC_STOP_TRANSMISSION,
+		.arg = 0,
+		.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC,
+	};
+	struct mmc_data data = {
+		.flags = MMC_DATA_READ,
+		.blksz = blksz,
+		.blocks = blocks,
+		.blk_addr = 0,
+		.timeout_ns =  800000000,	/* 800ms */
+		.timeout_clks = 1000,
+		.sg = &sg,
+		.sg_len = 1,
+	};
+	struct mmc_request mrq = {
+		.sbc = &sbc,
+		.cmd = &cmd,
+		.data = &data,
+		.stop = &stop,
+	};
+	int size = blksz * blocks, err = 0;
+	u8 *data_buf;
+
+	data_buf = kzalloc(size, GFP_KERNEL);
+	if (!data_buf)
+		return -ENOMEM;
+
+	sg_init_one(&sg, data_buf, size);
+
+	mmc_wait_for_req(host, &mrq);
+
+	if (cmd.error) {
+		err = cmd.error;
+		goto out;
+	}
+
+	if (data.error) {
+		err = data.error;
+		goto out;
+	}
+
+out:
+	kfree(data_buf);
+	return err;
+}
+
+/**
+ * sdhci_cdns_tune_blkgap() - tune multi-block read gap
+ * @mmc: MMC host
+ *
+ * Tune delay used in multi block read. To do so,
+ * try sending multi-block read command with incremented gap, unless
+ * it succeeds.
+ *
+ * Return: error code
+ */
+static int sdhci_cdns_tune_blkgap(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	void __iomem *hrs37_reg = priv->hrs_addr + SDHCI_CDNS_HRS37;
+	void __iomem *hrs38_reg = priv->hrs_addr + SDHCI_CDNS_HRS38;
+	bool tuned = false;
+	u8 gap;
+	u8 hrs37_mode;
+
+	switch (host->timing) {
+	case MMC_TIMING_MMC_HS200:
+		hrs37_mode = SDHCI_CDNS_HRS37_MODE_MMC_HS200;
+		break;
+	default:
+		return 0; /* no tuning in this mode */
+	}
+
+	writel(hrs37_mode, hrs37_reg);
+
+	for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
+		writel(gap, hrs38_reg);
+		tuned = !mmc_send_mb_read(mmc);
+		if (tuned)
+			break;
+	}
+	dev_dbg(mmc_dev(mmc), "read block gap tune %s, gap %d\n",
+		tuned ? "OK" : "failed", gap);
+	return tuned ? 0 : -EIO;
+}
+
 static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -279,6 +408,7 @@ static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int max_streak = 0;
 	int end_of_streak = 0;
 	int i;
+	int ret;
 
 	/*
 	 * This handler only implements the eMMC tuning that is specific to
@@ -308,7 +438,12 @@ static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		return -EIO;
 	}
 
-	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+	ret = sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
+
+	if (!ret)
+		ret = sdhci_cdns_tune_blkgap(mmc);
+
+	return ret;
 }
 
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
-- 
2.20.1

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

