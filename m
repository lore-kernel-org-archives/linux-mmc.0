Return-Path: <SRS0=KkSK=AD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D095C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Jun 2020 08:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776B620738
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Jun 2020 08:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFVIa6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:30:58 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60708 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgFVIa6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Jun 2020 04:30:58 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 59573200901;
        Mon, 22 Jun 2020 10:30:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 306F520060E;
        Mon, 22 Jun 2020 10:30:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B779A4029E;
        Mon, 22 Jun 2020 16:30:46 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, pali@kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, fugang.duan@nxp.com,
        dianders@chromium.org, huyue2@yulong.com, mka@chromium.org
Subject: [PATCH] mmc: sdio: fix clock rate setting for SDR12/SDR25 mode
Date:   Mon, 22 Jun 2020 16:19:19 +0800
Message-Id: <1592813959-5914-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

In current code logic, when work in SDR12/SDR25 mode, the final clock
rate is incorrect, just the legancy 400KHz, because the
card->sw_caps.sd3_bus_mode do not has the flag SD_MODE_UHS_SDR12 or
SD_MODE_UHS_SDR25. Besides, SDIO_SPEED_SDR12 is actually value 0, and
every mode need to config the timing and clock rate, so remove the
‘if’ operator.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/core/sdio.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0e32ca7b9488..7b40553d3934 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -176,15 +176,18 @@ static int sdio_read_cccr(struct mmc_card *card, u32 ocr)
 			if (mmc_host_uhs(card->host)) {
 				if (data & SDIO_UHS_DDR50)
 					card->sw_caps.sd3_bus_mode
-						|= SD_MODE_UHS_DDR50;
+						|= SD_MODE_UHS_DDR50 | SD_MODE_UHS_SDR50
+							| SD_MODE_UHS_SDR25 | SD_MODE_UHS_SDR12;
 
 				if (data & SDIO_UHS_SDR50)
 					card->sw_caps.sd3_bus_mode
-						|= SD_MODE_UHS_SDR50;
+						|= SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR25
+							| SD_MODE_UHS_SDR12;
 
 				if (data & SDIO_UHS_SDR104)
 					card->sw_caps.sd3_bus_mode
-						|= SD_MODE_UHS_SDR104;
+						|= SD_MODE_UHS_SDR104 | SD_MODE_UHS_SDR50
+							| SD_MODE_UHS_SDR25 | SD_MODE_UHS_SDR12;
 			}
 
 			ret = mmc_io_rw_direct(card, 0, 0,
@@ -537,10 +540,8 @@ static int sdio_set_bus_speed_mode(struct mmc_card *card)
 	max_rate = min_not_zero(card->quirk_max_rate,
 				card->sw_caps.uhs_max_dtr);
 
-	if (bus_speed) {
-		mmc_set_timing(card->host, timing);
-		mmc_set_clock(card->host, max_rate);
-	}
+	mmc_set_timing(card->host, timing);
+	mmc_set_clock(card->host, max_rate);
 
 	return 0;
 }
-- 
2.17.1

