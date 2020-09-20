Return-Path: <SRS0=NMQi=C5=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336EC43463
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Sep 2020 20:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DC30206E5
	for <linux-mmc@archiver.kernel.org>; Sun, 20 Sep 2020 20:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7zImAEJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgITUvF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Sep 2020 16:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITUvF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Sep 2020 16:51:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0CC061755;
        Sun, 20 Sep 2020 13:51:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so6156735pjg.1;
        Sun, 20 Sep 2020 13:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wi8H9WAjiHugl2gpiCPfjZRK1PiKYfl3iGGZE86uwDs=;
        b=F7zImAEJ0pHdPIS5ePTvn9Jsw0Th3IPFTU2PYIE0Cm49/YFzO6Jtnhvyi7RhDc0gtd
         4ndx2nCSbyzihT0DQMtR4ozNurlN6ebsMyx2ndVW6z2+0XElKnKkUK45CCK71EUaCkgB
         bQ08Ahdi+oI7ope+Ub2JAABKVEghg0ZiqIlXL5b6oCcaj5d40uDrasP+MJEQxa+vaMhg
         ywciD44fayAhRaAd31Bu6b8bEl1Q8EFHro9wcSCS6C1Jtd4EKbfKIv00y4bYlYzjQUT1
         XtLxlR5Ez+f3LSFAqevM0/E4nnnomGIcjYv47SOomxBd7HjBwaxixrQBiP1i4bbw17EG
         fm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wi8H9WAjiHugl2gpiCPfjZRK1PiKYfl3iGGZE86uwDs=;
        b=fQVtHs0BM3IAYNzw5p3ianIGHoMBOEgIFYTHo4aqNzGp8PgXydvFA01OlLOzxZAxPs
         6yIstWjt5reJ7ZTq8wLEoxydLnEJ6ap3Q0FDHDbMNdmodtCu3j8e3DmS6bdg2EJ22fc8
         pP7XGjetFCslAqzgEMYoParMVaeDWxo5Uh0PyE5gIa0dIKkb7lQ7NTVzGJyTVCE4/qol
         gvr+dQgnm0PVM6Pc48K56mTtt+Ohtkbh1MsPJJUGeeaC/CLPDLJijAcQwB4V2Xi5nIIA
         uWQEz03M2B0K4YlfFYETxggJT4+IZRL3tHYMYRixopCKbuD8yJsyqvEdWDBKY4efZdLr
         G/VA==
X-Gm-Message-State: AOAM533NGinasvR6jS8FjWFtVE1NiS4tvQhq6vO2l1kXIgqSF3+18bd4
        PaUKwpzt1Ztggi7OWqvEYL0=
X-Google-Smtp-Source: ABdhPJz14Z3oOfjUPAdEv8gp6U4y0JUONe0ir1MU7wAMj/bePRUyd4L55catL1t1Rs+oc/Q6cu9kaA==
X-Received: by 2002:a17:90a:9708:: with SMTP id x8mr22814262pjo.213.1600635064498;
        Sun, 20 Sep 2020 13:51:04 -0700 (PDT)
Received: from localhost.localdomain ([103.248.31.139])
        by smtp.googlemail.com with ESMTPSA id j1sm9561159pgp.93.2020.09.20.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 13:51:03 -0700 (PDT)
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     ulf.hansson@linaro.org
Cc:     gustavoars@kernel.org, mirq-linux@rere.qmqm.pl,
        ameynarkhede03@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: davinci: Drop pointer to mmc_host from mmc_davinci_host
Date:   Mon, 21 Sep 2020 02:19:08 +0530
Message-Id: <20200920204907.225287-1-ameynarkhede03@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The TI DaVinci MMC host driver uses a pointer to get from
the private mmc_davinci_host structure to generic mmc_host
structure. However mmc_host always immediately precedes
mmc_davinci_host in memory hence get the address of that
mmc_host structure using mmc_from_priv() which performs
subtraction(which is cheaper than a dereference) and drop
the unnecessary pointer.

Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 96 ++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index e50a08bce7ef..c607b6a27a03 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -168,7 +168,6 @@ MODULE_PARM_DESC(use_dma, "Whether to use DMA or not. Default = 1");
 struct mmc_davinci_host {
 	struct mmc_command *cmd;
 	struct mmc_data *data;
-	struct mmc_host *mmc;
 	struct clk *clk;
 	unsigned int mmc_input_clk;
 	void __iomem *base;
@@ -270,8 +269,9 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 {
 	u32 cmd_reg = 0;
 	u32 im_val;
+	struct mmc_host *mmc = mmc_from_priv(host);

-	dev_dbg(mmc_dev(host->mmc), "CMD%d, arg 0x%08x%s\n",
+	dev_dbg(mmc_dev(mmc), "CMD%d, arg 0x%08x%s\n",
 		cmd->opcode, cmd->arg,
 		({ char *s;
 		switch (mmc_resp_type(cmd)) {
@@ -312,7 +312,7 @@ static void mmc_davinci_start_command(struct mmc_davinci_host *host,
 		break;
 	default:
 		cmd_reg |= MMCCMD_RSPFMT_NONE;
-		dev_dbg(mmc_dev(host->mmc), "unknown resp_type %04x\n",
+		dev_dbg(mmc_dev(mmc), "unknown resp_type %04x\n",
 			mmc_resp_type(cmd));
 		break;
 	}
@@ -402,6 +402,7 @@ static int mmc_davinci_send_dma_request(struct mmc_davinci_host *host,
 {
 	struct dma_chan *chan;
 	struct dma_async_tx_descriptor *desc;
+	struct mmc_host *mmc = mmc_from_priv(host);
 	int ret = 0;

 	if (host->data_dir == DAVINCI_MMC_DATADIR_WRITE) {
@@ -421,7 +422,7 @@ static int mmc_davinci_send_dma_request(struct mmc_davinci_host *host,
 				DMA_MEM_TO_DEV,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(mmc),
 				"failed to allocate DMA TX descriptor");
 			ret = -1;
 			goto out;
@@ -443,7 +444,7 @@ static int mmc_davinci_send_dma_request(struct mmc_davinci_host *host,
 				DMA_DEV_TO_MEM,
 				DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 		if (!desc) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(mmc),
 				"failed to allocate DMA RX descriptor");
 			ret = -1;
 			goto out;
@@ -460,17 +461,18 @@ static int mmc_davinci_send_dma_request(struct mmc_davinci_host *host,
 static int mmc_davinci_start_dma_transfer(struct mmc_davinci_host *host,
 		struct mmc_data *data)
 {
+	struct mmc_host *mmc = mmc_from_priv(host);
 	int i;
 	int mask = rw_threshold - 1;
 	int ret = 0;

-	host->sg_len = dma_map_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+	host->sg_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
 				  mmc_get_dma_dir(data));

 	/* no individual DMA segment should need a partial FIFO */
 	for (i = 0; i < host->sg_len; i++) {
 		if (sg_dma_len(data->sg + i) & mask) {
-			dma_unmap_sg(mmc_dev(host->mmc),
+			dma_unmap_sg(mmc_dev(mmc),
 				     data->sg, data->sg_len,
 				     mmc_get_dma_dir(data));
 			return -1;
@@ -494,15 +496,17 @@ static void davinci_release_dma_channels(struct mmc_davinci_host *host)

 static int davinci_acquire_dma_channels(struct mmc_davinci_host *host)
 {
-	host->dma_tx = dma_request_chan(mmc_dev(host->mmc), "tx");
+	struct mmc_host *mmc = mmc_from_priv(host);
+
+	host->dma_tx = dma_request_chan(mmc_dev(mmc), "tx");
 	if (IS_ERR(host->dma_tx)) {
-		dev_err(mmc_dev(host->mmc), "Can't get dma_tx channel\n");
+		dev_err(mmc_dev(mmc), "Can't get dma_tx channel\n");
 		return PTR_ERR(host->dma_tx);
 	}

-	host->dma_rx = dma_request_chan(mmc_dev(host->mmc), "rx");
+	host->dma_rx = dma_request_chan(mmc_dev(mmc), "rx");
 	if (IS_ERR(host->dma_rx)) {
-		dev_err(mmc_dev(host->mmc), "Can't get dma_rx channel\n");
+		dev_err(mmc_dev(mmc), "Can't get dma_rx channel\n");
 		dma_release_channel(host->dma_tx);
 		return PTR_ERR(host->dma_rx);
 	}
@@ -518,6 +522,7 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 	int fifo_lev = (rw_threshold == 32) ? MMCFIFOCTL_FIFOLEV : 0;
 	int timeout;
 	struct mmc_data *data = req->data;
+	struct mmc_host *mmc = mmc_from_priv(mmc);

 	if (host->version == MMC_CTLR_VERSION_2)
 		fifo_lev = (rw_threshold == 64) ? MMCFIFOCTL_FIFOLEV : 0;
@@ -530,10 +535,10 @@ mmc_davinci_prepare_data(struct mmc_davinci_host *host, struct mmc_request *req)
 		return;
 	}

-	dev_dbg(mmc_dev(host->mmc), "%s, %d blocks of %d bytes\n",
+	dev_dbg(mmc_dev(mmc), "%s, %d blocks of %d bytes\n",
 		(data->flags & MMC_DATA_WRITE) ? "write" : "read",
 		data->blocks, data->blksz);
-	dev_dbg(mmc_dev(host->mmc), "  DTO %d cycles + %d ns\n",
+	dev_dbg(mmc_dev(mmc), "  DTO %d cycles + %d ns\n",
 		data->timeout_clks, data->timeout_ns);
 	timeout = data->timeout_clks +
 		(data->timeout_ns / host->ns_in_one_cycle);
@@ -598,7 +603,7 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
 		cpu_relax();
 	}
 	if (mmcst1 & MMCST1_BUSY) {
-		dev_err(mmc_dev(host->mmc), "still BUSY? bad ... \n");
+		dev_err(mmc_dev(mmc), "still BUSY? bad ...\n");
 		req->cmd->error = -ETIMEDOUT;
 		mmc_request_done(mmc, req);
 		return;
@@ -688,8 +693,9 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	struct mmc_davinci_host *host = mmc_priv(mmc);
 	struct platform_device *pdev = to_platform_device(mmc->parent);
 	struct davinci_mmc_config *config = pdev->dev.platform_data;
+	struct mmc_host *mmc = mmc_from_priv(host);

-	dev_dbg(mmc_dev(host->mmc),
+	dev_dbg(mmc_dev(mmc),
 		"clock %dHz busmode %d powermode %d Vdd %04x\n",
 		ios->clock, ios->bus_mode, ios->power_mode,
 		ios->vdd);
@@ -707,13 +713,13 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)

 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_8:
-		dev_dbg(mmc_dev(host->mmc), "Enabling 8 bit mode\n");
+		dev_dbg(mmc_dev(mmc), "Enabling 8 bit mode\n");
 		writel((readl(host->base + DAVINCI_MMCCTL) &
 			~MMCCTL_WIDTH_4_BIT) | MMCCTL_WIDTH_8_BIT,
 			host->base + DAVINCI_MMCCTL);
 		break;
 	case MMC_BUS_WIDTH_4:
-		dev_dbg(mmc_dev(host->mmc), "Enabling 4 bit mode\n");
+		dev_dbg(mmc_dev(mmc), "Enabling 4 bit mode\n");
 		if (host->version == MMC_CTLR_VERSION_2)
 			writel((readl(host->base + DAVINCI_MMCCTL) &
 				~MMCCTL_WIDTH_8_BIT) | MMCCTL_WIDTH_4_BIT,
@@ -724,7 +730,7 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->base + DAVINCI_MMCCTL);
 		break;
 	case MMC_BUS_WIDTH_1:
-		dev_dbg(mmc_dev(host->mmc), "Enabling 1 bit mode\n");
+		dev_dbg(mmc_dev(mmc), "Enabling 1 bit mode\n");
 		if (host->version == MMC_CTLR_VERSION_2)
 			writel(readl(host->base + DAVINCI_MMCCTL) &
 				~(MMCCTL_WIDTH_8_BIT | MMCCTL_WIDTH_4_BIT),
@@ -756,7 +762,7 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			cpu_relax();
 		}
 		if (lose)
-			dev_warn(mmc_dev(host->mmc), "powerup timeout\n");
+			dev_warn(mmc_dev(mmc), "powerup timeout\n");
 	}

 	/* FIXME on power OFF, reset things ... */
@@ -765,9 +771,10 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static void
 mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
 {
-	host->data = NULL;
+	struct mmc_host *mmc = mmc_from_priv(host);

-	if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
+	host->data = NULL;
+	if (mmc->caps & MMC_CAP_SDIO_IRQ) {
 		/*
 		 * SDIO Interrupt Detection work-around as suggested by
 		 * Davinci Errata (TMS320DM355 Silicon Revision 1.1 Errata
@@ -776,21 +783,21 @@ mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
 		if (host->sdio_int && !(readl(host->base + DAVINCI_SDIOST0) &
 					SDIOST0_DAT1_HI)) {
 			writel(SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
-			mmc_signal_sdio_irq(host->mmc);
+			mmc_signal_sdio_irq(mmc);
 		}
 	}

 	if (host->do_dma) {
 		davinci_abort_dma(host);

-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 		host->do_dma = false;
 	}
 	host->data_dir = DAVINCI_MMC_DATADIR_NONE;

 	if (!data->stop || (host->cmd && host->cmd->error)) {
-		mmc_request_done(host->mmc, data->mrq);
+		mmc_request_done(mmc, data->mrq);
 		writel(0, host->base + DAVINCI_MMCIM);
 		host->active_request = false;
 	} else
@@ -818,7 +825,7 @@ static void mmc_davinci_cmd_done(struct mmc_davinci_host *host,
 	if (host->data == NULL || cmd->error) {
 		if (cmd->error == -ETIMEDOUT)
 			cmd->mrq->cmd->retries = 0;
-		mmc_request_done(host->mmc, cmd->mrq);
+		mmc_request_done(mmc_from_priv(host), cmd->mrq);
 		writel(0, host->base + DAVINCI_MMCIM);
 		host->active_request = false;
 	}
@@ -849,14 +856,15 @@ davinci_abort_data(struct mmc_davinci_host *host, struct mmc_data *data)
 static irqreturn_t mmc_davinci_sdio_irq(int irq, void *dev_id)
 {
 	struct mmc_davinci_host *host = dev_id;
+	struct mmc_host *mmc = mmc_from_priv(host);
 	unsigned int status;

 	status = readl(host->base + DAVINCI_SDIOIST);
 	if (status & SDIOIST_IOINT) {
-		dev_dbg(mmc_dev(host->mmc),
+		dev_dbg(mmc_dev(mmc),
 			"SDIO interrupt status %x\n", status);
 		writel(status | SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
-		mmc_signal_sdio_irq(host->mmc);
+		mmc_signal_sdio_irq(mmc);
 	}
 	return IRQ_HANDLED;
 }
@@ -867,11 +875,12 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 	unsigned int status, qstatus;
 	int end_command = 0;
 	int end_transfer = 0;
+	struct mmc_host *mmc = mmc_from_priv(host);
 	struct mmc_data *data = host->data;

 	if (host->cmd == NULL && host->data == NULL) {
 		status = readl(host->base + DAVINCI_MMCST0);
-		dev_dbg(mmc_dev(host->mmc),
+		dev_dbg(mmc_dev(mmc),
 			"Spurious interrupt 0x%04x\n", status);
 		/* Disable the interrupt from mmcsd */
 		writel(0, host->base + DAVINCI_MMCIM);
@@ -929,7 +938,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 			end_transfer = 1;
 			data->bytes_xfered = data->blocks * data->blksz;
 		} else {
-			dev_err(mmc_dev(host->mmc),
+			dev_err(mmc_dev(mmc),
 					"DATDNE with no host->data\n");
 		}
 	}
@@ -939,7 +948,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 		data->error = -ETIMEDOUT;
 		end_transfer = 1;

-		dev_dbg(mmc_dev(host->mmc),
+		dev_dbg(mmc_dev(mmc),
 			"read data timeout, status %x\n",
 			qstatus);

@@ -963,7 +972,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 			if (temp == 0x9f)
 				data->error = -ETIMEDOUT;
 		}
-		dev_dbg(mmc_dev(host->mmc), "data %s %s error\n",
+		dev_dbg(mmc_dev(mmc), "data %s %s error\n",
 			(qstatus & MMCST0_CRCWR) ? "write" : "read",
 			(data->error == -ETIMEDOUT) ? "timeout" : "CRC");

@@ -973,7 +982,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 	if (qstatus & MMCST0_TOUTRS) {
 		/* Command timeout */
 		if (host->cmd) {
-			dev_dbg(mmc_dev(host->mmc),
+			dev_dbg(mmc_dev(mmc),
 				"CMD%d timeout, status %x\n",
 				host->cmd->opcode, qstatus);
 			host->cmd->error = -ETIMEDOUT;
@@ -987,7 +996,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)

 	if (qstatus & MMCST0_CRCRS) {
 		/* Command CRC error */
-		dev_dbg(mmc_dev(host->mmc), "Command CRC error\n");
+		dev_dbg(mmc_dev(mmc), "Command CRC error\n");
 		if (host->cmd) {
 			host->cmd->error = -EILSEQ;
 			end_command = 1;
@@ -1035,7 +1044,7 @@ static void mmc_davinci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	if (enable) {
 		if (!(readl(host->base + DAVINCI_SDIOST0) & SDIOST0_DAT1_HI)) {
 			writel(SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
-			mmc_signal_sdio_irq(host->mmc);
+			mmc_signal_sdio_irq(mmc_from_priv(host));
 		} else {
 			host->sdio_int = true;
 			writel(readl(host->base + DAVINCI_SDIOIEN) |
@@ -1068,7 +1077,7 @@ static int mmc_davinci_cpufreq_transition(struct notifier_block *nb,
 	unsigned long flags;

 	host = container_of(nb, struct mmc_davinci_host, freq_transition);
-	mmc = host->mmc;
+	mmc = mmc_from_priv(host);
 	mmc_pclk = clk_get_rate(host->clk);

 	if (val == CPUFREQ_POSTCHANGE) {
@@ -1215,7 +1224,6 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		return -ENOMEM;

 	host = mmc_priv(mmc);
-	host->mmc = mmc;	/* Important */

 	host->mem_res = mem;
 	host->base = devm_ioremap(&pdev->dev, mem->start, mem_size);
@@ -1293,10 +1301,10 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	mmc->max_blk_count	= 65535; /* NBLK is 16 bits */
 	mmc->max_req_size	= mmc->max_blk_size * mmc->max_blk_count;

-	dev_dbg(mmc_dev(host->mmc), "max_segs=%d\n", mmc->max_segs);
-	dev_dbg(mmc_dev(host->mmc), "max_blk_size=%d\n", mmc->max_blk_size);
-	dev_dbg(mmc_dev(host->mmc), "max_req_size=%d\n", mmc->max_req_size);
-	dev_dbg(mmc_dev(host->mmc), "max_seg_size=%d\n", mmc->max_seg_size);
+	dev_dbg(mmc_dev(mmc_from_priv(host)), "max_segs=%d\n", mmc->max_segs);
+	dev_dbg(mmc_dev(mmc_from_priv(host)), "max_blk_size=%d\n", mmc->max_blk_size);
+	dev_dbg(mmc_dev(mmc_from_priv(host)), "max_req_size=%d\n", mmc->max_req_size);
+	dev_dbg(mmc_dev(mmc_from_priv(host)), "max_seg_size=%d\n", mmc->max_seg_size);

 	platform_set_drvdata(pdev, host);

@@ -1325,7 +1333,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)

 	rename_region(mem, mmc_hostname(mmc));

-	dev_info(mmc_dev(host->mmc), "Using %s, %d-bit mode\n",
+	dev_info(mmc_dev(mmc_from_priv(host)), "Using %s, %d-bit mode\n",
 		host->use_dma ? "DMA" : "PIO",
 		(mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1);

@@ -1351,12 +1359,13 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
 {
 	struct mmc_davinci_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = mmc_from_priv(host);

-	mmc_remove_host(host->mmc);
+	mmc_remove_host(mmc);
 	mmc_davinci_cpufreq_deregister(host);
 	davinci_release_dma_channels(host);
 	clk_disable_unprepare(host->clk);
-	mmc_free_host(host->mmc);
+	mmc_free_host(mmc);

 	return 0;
 }
@@ -1410,4 +1419,3 @@ MODULE_AUTHOR("Texas Instruments India");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MMC/SD driver for Davinci MMC controller");
 MODULE_ALIAS("platform:davinci_mmc");
-
--
2.28.0

I'm a beginer contributor so please let me know
if there are any mistakes.
