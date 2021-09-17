Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F0C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71186610C9
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 12:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhIQMtd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 08:49:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50466 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235476AbhIQMtd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 08:49:33 -0400
X-UUID: 193ec61471eb4c33a9a2b45cf6c693a8-20210917
X-UUID: 193ec61471eb4c33a9a2b45cf6c693a8-20210917
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 862515583; Fri, 17 Sep 2021 20:48:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 20:48:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Sep 2021 20:48:04 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yue Hu <huyue2@yulong.com>, Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RESEND v4 2/3] mmc: core: add tuning support for HS400 mode
Date:   Fri, 17 Sep 2021 20:48:02 +0800
Message-ID: <20210917124803.22871-3-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210917124803.22871-1-wenbin.mei@mediatek.com>
References: <20210917124803.22871-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This adds the execute_hs400_tuning callback function for HS400 tuning
operations and move the declaration of mmc_get_ext_csd() to
include/linux/mmc/host.h.

If execute_hs400_tuning is not implemented then they are not called.
That means there should be no affect for existing drivers as none implemt
these ops.

Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
---
 drivers/mmc/core/mmc.c     | 8 ++++++++
 drivers/mmc/core/mmc_ops.h | 1 -
 include/linux/mmc/host.h   | 4 ++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 838726b68ff3..0aa72acd8612 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1222,6 +1222,14 @@ static int mmc_select_hs400(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
 	mmc_set_bus_speed(card);
 
+	if (host->ops->execute_hs400_tuning) {
+		mmc_retune_disable(host);
+		err = host->ops->execute_hs400_tuning(host, card);
+		mmc_retune_enable(host);
+		if (err)
+			goto out_err;
+	}
+
 	if (host->ops->hs400_complete)
 		host->ops->hs400_complete(host);
 
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index ae25ffc2e870..e5e94567a9a9 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -38,7 +38,6 @@ int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_bus_test(struct mmc_card *card, u8 bus_width);
 int mmc_can_ext_csd(struct mmc_card *card);
-int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 			  unsigned int timeout_ms);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ff1a251bb0bc..072650aeb2a7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -162,6 +162,9 @@ struct mmc_host_ops {
 	/* Prepare HS400 target operating frequency depending host driver */
 	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios *ios);
 
+	/* Execute HS400 tuning depending host driver */
+	int	(*execute_hs400_tuning)(struct mmc_host *host, struct mmc_card *card);
+
 	/* Prepare switch to DDR during the HS400 init sequence */
 	int	(*hs400_prepare_ddr)(struct mmc_host *host);
 
@@ -633,5 +636,6 @@ static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *data)
 
 int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
 int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
+int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 
 #endif /* LINUX_MMC_HOST_H */
-- 
2.25.1

