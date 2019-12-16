Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD7DC43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2498324655
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 21:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EOVQisom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfLPVrH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:47:07 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40127 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfLPVrH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 16:47:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so5380029lfo.7
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2019 13:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pehE/XEmXt42PybxGxL2f+rlsOLyO398u74/V0rOiW4=;
        b=EOVQisomRAUu+oZLPs5McKH6ilhwQq2o8YRZmKXFJBaLb4Y3skAyftJbYMKViqh6QP
         rggm0up7vOnPSsSo+0BwHzkZZnYquzJRx/UMI9NwSmPHi6ySd9VUDqU7E5Vfqf/Fv5ib
         QdlEq1MInZLjubywE98voikOCZwjQByjB5tPzwARKayMfzao2jWLCj3L1xB4LIZzVWq3
         ZoRmJSRBnvEOISiq2ASxY2v8s9ULtKGLdSzWxL9Sq8lCYfz9V8ZowZEdGGkAMw4RnBXX
         WTyhGkqCrRQGliAWjsMAeJ2QR7t+JqA1oU/prmuPg2sJrorgoO/FzsUgUoNFBFwjdNtd
         j+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pehE/XEmXt42PybxGxL2f+rlsOLyO398u74/V0rOiW4=;
        b=EH7KZOtvQHzYEGN8VIXy9cb/d310lYaU62E5mWEaAjNw1X9KLlVljB87XFSZ+3V6Ef
         2QqcqOjE7YiG/dX5oxuM1/5Se3vWs0JmyjFM7RVcS1kGhuNsX2ueYJSY8aFVCMvK5+sf
         IF2HNuq+KRI6pJelRHCcr21VSTsS8Zb+kAe576rF0IRXHPIMscBtKRnaoo8VD0R/xEKz
         Ot2+jVkMkbY67a5hgsxm7MfW8Qqbh9cnXhAxdDbQV9d6SQm3bO4LLxhH6QK0GDddMTRJ
         ckFoiwPhT+39P7V+WyIeiAD7+ulKkcLsfV3Y4BI/W16pFUhhJb7DPrGkAFOAEA4k+axu
         c9pg==
X-Gm-Message-State: APjAAAW8Ls9qVDGtFh/8+gCghxhiUZ6S7Px9k6n0TN9HnUjmuNZzvml9
        dDzGCq0oxBVFmv8Hj1JZan3CpsFpQ0z4Jg==
X-Google-Smtp-Source: APXvYqyCgltgGwMKcY26OnerPwq7rUlBFmT+KiEh8baChcZJnQKndsSXXWpOELueeanq2O3fDyBYwQ==
X-Received: by 2002:a05:6512:4c6:: with SMTP id w6mr728960lfq.157.1576532824014;
        Mon, 16 Dec 2019 13:47:04 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-21cd225c.014-348-6c756e10.bbcust.telenor.se. [92.34.205.33])
        by smtp.gmail.com with ESMTPSA id c20sm11358867ljj.55.2019.12.16.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 13:47:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Brian Masney <masneyb@onstation.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5] mmc: mmci: Support odd block sizes for ux500v2 and qcom variant
Date:   Mon, 16 Dec 2019 22:46:59 +0100
Message-Id: <20191216214659.29778-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

For the ux500v2 variant of the PL18x block, odd block sizes
are supported. This is necessary to support some SDIO
transfers. This also affects the QCOM MMCI variant and the
ST micro variant.

For Ux500 an additional quirk only allowing DMA on blocks
that are a power of two is needed. This might be a bug in
the DMA engine (DMA40) or the MMCI or in the interconnect,
but the most likely is the MMCI, as transfers of these
sizes work fine for other devices using the same DMA
engine. DMA works fine also with SDIO as long as the
blocksize is a power of 2.

This patch has proven necessary for enabling SDIO for WLAN on
PostmarketOS-based Ux500 platforms.

What we managed to test in practice is Broadcom WiFi over
SDIO on the Ux500 based Samsung GT-I8190 and GT-S7710.
This WiFi chip, BCM4334 works fine after the patch.

Before this patch:

brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4334-sdio
	  for chip BCM4334/3
mmci-pl18x 80118000.sdi1_per2: unsupported block size (60 bytes)
brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
brcmfmac: brcmf_sdio_download_code_file: error -22 on writing
	  434236 membytes at 0x00000000
brcmfmac: brcmf_sdio_download_firmware: dongle image file download
	  failed

After this patch:

brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4334/3 wl0:
	  Nov 21 2012 00:21:28 version 6.10.58.813 (B2) FWID 01-0

Bringing up networks, discovering networks with "iw dev wlan0 scan"
and connecting works fine from this point.

This patch is inspired by Ulf Hansson's patch
http://www.spinics.net/lists/linux-mmc/msg12160.html

As the DMA engines on these platforms may now get block sizes
they were not used to before, make sure to also respect if
the DMA engine says "no" to a transfer.

Make a drive-by fix for datactrl_blocksz, misspelled.

Cc: Ludovic Barre <ludovic.barre@st.com>
Cc: Brian Masney <masneyb@onstation.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Niklas Cassel <niklas.cassel@linaro.org>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v4->v5:
- Rename variant members as Ulf want them.
ChangeLog v3->v4:
- Rewrite the patch to accept odd packages but only
  let power of two packages pass on to the DMA.
- Drop the patches disallowing DMA not divisible by 4:
  this doesn't work. Instead just push the whole
  power of two criteria down to the DMA submission
  phase.
- Drop the patch handling odd sglist offsets and
  passing of page boundaries in SG buffers when
  using PIO: it just doesn't happen in practice, we
  don't know why, but likely because all packets are
  small.
ChangeLog v2->v3:
- Repost with the inclusion of other patches.
ChangeLog v1->v2:
- Specify odd blocksize field to 1 bit (:1)
- Specify that STMMC supports odd block sizes
- Collect Stephan's test tag
---
 drivers/mmc/host/mmci.c | 34 ++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |  8 +++++++-
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index c37e70dbe250..5afe9145f957 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -168,6 +168,8 @@ static struct variant_data variant_ux500 = {
 	.cmdreg_srsp		= MCI_CPSM_RESPONSE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
+	.only_pow_2_dma		= true,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -201,6 +203,8 @@ static struct variant_data variant_ux500v2 = {
 	.datactrl_mask_ddrmode	= MCI_DPSM_ST_DDRMODE,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
+	.only_pow_2_dma		= true,
 	.datactrl_mask_sdio	= MCI_DPSM_ST_SDIOEN,
 	.st_sdio		= true,
 	.st_clkdiv		= true,
@@ -260,6 +264,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datacnt_useless	= true,
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
+	.datactrl_odd_blocksz	= true,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
 	.init			= sdmmc_variant_init,
 };
@@ -279,6 +284,7 @@ static struct variant_data variant_qcom = {
 	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
 	.datalength_bits	= 24,
 	.datactrl_blocksz	= 11,
+	.datactrl_odd_blocksz	= true,
 	.pwrreg_powerup		= MCI_PWR_UP,
 	.f_max			= 208000000,
 	.explicit_mclk_control	= true,
@@ -447,10 +453,11 @@ void mmci_dma_setup(struct mmci_host *host)
 static int mmci_validate_data(struct mmci_host *host,
 			      struct mmc_data *data)
 {
+	struct variant_data *variant = host->variant;
+
 	if (!data)
 		return 0;
-
-	if (!is_power_of_2(data->blksz)) {
+	if (!is_power_of_2(data->blksz) && !variant->datactrl_odd_blocksz) {
 		dev_err(mmc_dev(host->mmc),
 			"unsupported block size (%d bytes)\n", data->blksz);
 		return -EINVAL;
@@ -515,7 +522,9 @@ int mmci_dma_start(struct mmci_host *host, unsigned int datactrl)
 		 "Submit MMCI DMA job, sglen %d blksz %04x blks %04x flags %08x\n",
 		 data->sg_len, data->blksz, data->blocks, data->flags);
 
-	host->ops->dma_start(host, &datactrl);
+	ret = host->ops->dma_start(host, &datactrl);
+	if (ret)
+		return ret;
 
 	/* Trigger the DMA transfer */
 	mmci_write_datactrlreg(host, datactrl);
@@ -822,6 +831,18 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 	if (data->blksz * data->blocks <= variant->fifosize)
 		return -EINVAL;
 
+	/*
+	 * This is necessary to get SDIO working on the Ux500. We do not yet
+	 * know if this is a bug in:
+	 * - The Ux500 DMA controller (DMA40)
+	 * - The MMCI DMA interface on the Ux500
+	 * some power of two blocks (such as 64 bytes) are sent regularly
+	 * during SDIO traffic and those work fine so for these we enable DMA
+	 * transfers.
+	 */
+	if (host->variant->only_pow_2_dma && !is_power_of_2(data->blksz))
+		return -EINVAL;
+
 	device = chan->device;
 	nr_sg = dma_map_sg(device->dev, data->sg, data->sg_len,
 			   mmc_get_dma_dir(data));
@@ -872,9 +893,14 @@ int mmci_dmae_prep_data(struct mmci_host *host,
 int mmci_dmae_start(struct mmci_host *host, unsigned int *datactrl)
 {
 	struct mmci_dmae_priv *dmae = host->dma_priv;
+	int ret;
 
 	host->dma_in_progress = true;
-	dmaengine_submit(dmae->desc_current);
+	ret = dma_submit_error(dmaengine_submit(dmae->desc_current));
+	if (ret < 0) {
+		host->dma_in_progress = false;
+		return ret;
+	}
 	dma_async_issue_pending(dmae->cur);
 
 	*datactrl |= MCI_DPSM_DMAENABLE;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 833236ecb31e..89ab73343cf3 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -278,7 +278,11 @@ struct mmci_host;
  * @stm32_clkdiv: true if using a STM32-specific clock divider algorithm
  * @datactrl_mask_ddrmode: ddr mode mask in datactrl register.
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
- * @datactrl_blksz: block size in power of two
+ * @datactrl_blocksz: block size in power of two
+ * @datactrl_any_blocksz: true if block any block sizes are accepted by
+ *		  hardware, such as with some SDIO traffic that send
+ *		  odd packets.
+ * @dma_power_of_2: DMA only works with blocks that are a power of 2.
  * @datactrl_first: true if data must be setup before send command
  * @datacnt_useless: true if you could not use datacnt register to read
  *		     remaining data
@@ -323,6 +327,8 @@ struct variant_data {
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
+	u8			datactrl_any_blocksz:1;
+	u8			dma_power_of_2:1;
 	u8			datactrl_first:1;
 	u8			datacnt_useless:1;
 	u8			st_sdio:1;
-- 
2.21.0

