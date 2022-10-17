Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB61C43219
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Oct 2022 23:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiJQX4Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Oct 2022 19:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJQX4V (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2022 19:56:21 -0400
Received: from smtpcmd0641.aruba.it (smtpcmd0641.aruba.it [62.149.156.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CECB57E000
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2022 16:56:06 -0700 (PDT)
Received: from localhost.localdomain ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kZxkoIDsHJpY4kZxkoMdsm; Tue, 18 Oct 2022 01:56:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666050965; bh=Cs2BTahNhYGQT+BUpkMV4KQNAvoojZ2DWm+w744j3f8=;
        h=From:To:Subject:Date:MIME-Version;
        b=E0p9tmO5b6etadFD6I/aB+KXEqn6DN2lKdtYWIkOgoR4RciOD/qXWIOGDfBvaII0N
         bM3LQre3JlAxuaYHc/YtYaAm40x0Qzzef5xQLivjRUB1DAtOxOw9wUugbmf3zdUeYf
         XFb1ICudEnnlrZFbiauKi83fvM1r8OCWVcpEqhvdDE9CDo0THm+D/RpDOQxxCf298a
         stX9ZoIJ0zqsoUPhdrSk0N5ZyZRtipGuEvIB0nMwQ9Q1Cn9RAIqugtgxRlaBKvP3Fi
         kq6iVRUVXkrizCu41mPR/A+Cag7IZ1Geh+G5pziNCIQyD4upxesNVk+0aHTEC04eqN
         /6xDyE7gk4HmA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH 1/5] clk: imx: imxrt1050: fix IMXRT1050_CLK_LCDIF_APB offsets
Date:   Tue, 18 Oct 2022 01:55:58 +0200
Message-Id: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPrn7ntQdoekybvwfhFyO67CFnqXTpbenwSu5crc4XKZ5ExrFtLgKub6vuPX7iwmOxEApIB8wqcmul4VKipnrJ27OwlZeUrE7KmNoEviAUNFWy5I+1jK
 Er10ZCTFieqmKEHNcDB6Ng7qMSpyAFxg7ipKt/VcvJolwBx6RX8S+M39hOOc/VOvYWnecqGjNzK/kVcPY7JZifJTtYIWPnYAARwEY58+xTp/XQvKvyTSFB1Z
 C6UfaD7j4D19FwrNcGCHX8XhVIyVugL4O+RAAdaMEbh0+fJZoac2gSx1NlaWbiZ0GahmGCYIP4Ef8QqEsEFQjxYu/YKQCY+GHHY5/pq4+U1hGkFOaVRTtlTO
 76N/gnGQVpL9VPF1n4+10sQCFizSAjUPk//MMKeog7rVul0qYBwEpbOcjfEdXAqD7GKRmoQlasBn9eNPFXU4SDIgx2ED23AbFRi7yN7afF1dJDEWDsehoKq6
 5hm0KOOkD4snEZOezBo0yu/wvojYXOX7oST69pEwuYUGzCrQgBGb2mMAqzvcrQzCVF/Va8oAv3VfNQWwQvrhCOBmx1SGBgA6grB4179aeZWCL8gwLON7c5MZ
 TY0=
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
 drivers/clk/imx/clk-imxrt1050.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imxrt1050.c b/drivers/clk/imx/clk-imxrt1050.c
index 9539d35588ee..26108e9f7e67 100644
--- a/drivers/clk/imx/clk-imxrt1050.c
+++ b/drivers/clk/imx/clk-imxrt1050.c
@@ -140,7 +140,7 @@ static int imxrt1050_clocks_probe(struct platform_device *pdev)
 	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
 	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
 	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
-	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
+	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x70, 28);
 	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
 	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
 	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
-- 
2.34.1

