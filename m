Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4365DC4338F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234416328D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhHPNA4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:00:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58350 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhHPNA4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Aug 2021 09:00:56 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EAC4F2027C9;
        Mon, 16 Aug 2021 15:00:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8827A2027BE;
        Mon, 16 Aug 2021 15:00:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 03EEE183AD05;
        Mon, 16 Aug 2021 21:00:21 +0800 (+08)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com,
        linux-mmc@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the auto-tuning setting for sdio device
Date:   Mon, 16 Aug 2021 20:38:26 +0800
Message-Id: <1629117508-4886-4-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

USDHC contain auto tuning circuit, this circuit will work automatically after
the tuning procedurae, it can increase/decrease the delay cell according to
the outside environment change (like temperature).

Unfortunately, this auto tuning circuit can not handle the async sdio device
interrupt correctly. When sdio device use 4 data line, async sdio interrupt
will use DAT[1], if we enable auto tuning circuit check 4 data lines, include
the DAT[1], this circuit will detect this interrupt, take this as a data on
DAT[1], and adjust the delay cell wrongly.

This is the hardware design limitation, to avoid this, when sdio device enable
async interrupt, auto tuning circuit only check DAT[0] and CMD lines.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f18d169bc8ff..ab84c29777e5 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -226,6 +226,7 @@ struct esdhc_platform_data {
 	unsigned int tuning_step;       /* The delay cell steps in tuning procedure */
 	unsigned int tuning_start_tap;	/* The start delay cell point in tuning procedure */
 	unsigned int strobe_dll_delay_target;	/* The delay cell for strobe pad (read clock) */
+	bool sdio_async_interrupt_enabled;	/* sdio device enable the async interrupt */
 };
 
 struct esdhc_soc_data {
@@ -416,6 +417,8 @@ static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
 /* Enable the auto tuning circuit to check the CMD line and BUS line */
 static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
 	u32 buswidth, auto_tune_buswidth;
 
 	buswidth = USDHC_GET_BUSWIDTH(readl(host->ioaddr + SDHCI_HOST_CONTROL));
@@ -432,6 +435,18 @@ static inline void usdhc_auto_tuning_mode_sel(struct sdhci_host *host)
 		break;
 	}
 
+	/*
+	 * If sdio device use async interrupt, it will use DAT[1] to signal
+	 * the device's interrupt asynchronous when use 4 data lines.
+	 * Then hardware auto tuning circuit MUST NOT check the DAT[1] line,
+	 * otherwise auto tuning will be impacted by this async interrupt,
+	 * and change the delay cell incorrectly, which then cause data/cmd
+	 * errors.
+	 * This is the hardware auto tuning circuit limitation.
+	 */
+	if (imx_data->boarddata.sdio_async_interrupt_enabled)
+		auto_tune_buswidth = ESDHC_VEND_SPEC2_AUTO_TUNE_1BIT_EN;
+
 	esdhc_clrset_le(host, ESDHC_VEND_SPEC2_AUTO_TUNE_MODE_MASK,
 			auto_tune_buswidth | ESDHC_VEND_SPEC2_AUTO_TUNE_CMD_EN,
 			ESDHC_VEND_SPEC2);
@@ -1531,6 +1546,9 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 	if (of_property_read_u32(np, "fsl,delay-line", &boarddata->delay_line))
 		boarddata->delay_line = 0;
 
+	if (of_property_read_bool(np, "fsl,sdio-async-interrupt-enabled"))
+		boarddata->sdio_async_interrupt_enabled = true;
+
 	mmc_of_parse_voltage(host->mmc, &host->ocr_mask);
 
 	if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
-- 
2.17.1

