Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25407C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5A920776
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 10:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbgEZKcY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 06:32:24 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60882 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388412AbgEZKcY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 May 2020 06:32:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED5C4200320;
        Tue, 26 May 2020 12:32:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6CEFF200303;
        Tue, 26 May 2020 12:32:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1BD5C402BC;
        Tue, 26 May 2020 18:32:11 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, yangbo.lu@nxp.com
Subject: [PATCH 2/2] mmc: sdhci-esdhc-imx: disable the CMD CRC check for standard tuning
Date:   Tue, 26 May 2020 18:22:02 +0800
Message-Id: <1590488522-9292-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
References: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

In current code, we add 1ms dealy after each tuning command for standard
tuning method. Adding this 1ms dealy is because USDHC default check the
CMD CRC and DATA line. If detect the CMD CRC, USDHC standard tuning
IC logic do not wait for the tuning data sending out by the card, trigger
the buffer read ready interrupt immediately, and step to next cycle. So
when next time the new tuning command send out by USDHC, card may still
not send out the tuning data of the upper command，then some eMMC cards
may stuck, can't response to any command, block the whole tuning procedure.

If do not check the CMD CRC for tuning, then do not has this issue. USDHC
will wait for the tuning data of each tuning command and check them. If the
tuning data pass the check, it also means the CMD line also okay for tuning.

So this patch disable the CMD CRC check for tuning, save some time for the
whole tuning procedure.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 2cf7fa59270e..b0ddf3db440f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -91,6 +91,7 @@
 /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
 #define ESDHC_TUNING_START_TAP_DEFAULT	0x1
 #define ESDHC_TUNING_START_TAP_MASK	0x7f
+#define ESDHC_TUNING_CMD_CRC_CHECK_DISABLE	(1 << 7)
 #define ESDHC_TUNING_STEP_MASK		0x00070000
 #define ESDHC_TUNING_STEP_SHIFT		16
 
@@ -1316,6 +1317,18 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 				tmp |= imx_data->boarddata.tuning_step
 					<< ESDHC_TUNING_STEP_SHIFT;
 			}
+
+			/* Disable the CMD CRC check for tuning, if not, need to
+			 * add some delay after every tuning command, because
+			 * hardware standard tuning logic will directly go to next
+			 * step once it detect the CMD CRC error, will not wait for
+			 * the card side to finally send out the tuning data, trigger
+			 * the buffer read ready interrupt immediately. If usdhc send
+			 * the next tuning command some eMMC card will stuck, can't
+			 * response, block the tuning procedure or the first command
+			 * after the whole tuning procedure always can't get any response.
+			 */
+			 tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
 			writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
 		} else if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
 			/*
@@ -1661,8 +1674,6 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (err)
 		goto disable_ahb_clk;
 
-	host->tuning_delay = 1;
-
 	sdhci_esdhc_imx_hwinit(host);
 
 	err = sdhci_add_host(host);
-- 
2.17.1

