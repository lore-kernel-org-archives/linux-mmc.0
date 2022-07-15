Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6163C43334
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jul 2022 13:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiGRNVa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiGRNV3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2022 09:21:29 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234631FCF9;
        Mon, 18 Jul 2022 06:21:24 -0700 (PDT)
X-QQ-mid: bizesmtp66t1658150472tcpc2ud5
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:21:10 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: xqT8U4SkSphsl6ONspj/KF5kVQFD0rPk/8LI/98JCoIYgNVkJtJFEW9rNfW/7
        ohg/b+4RPLwJDO5R4Ok8UIA7ZtrGRbOpFleyKd/eJGHWv+KMbt1VxLmD84DIthT1B0fEfh6
        hiSeDpaRkECjyc5yx+LJcGhnkHbRIwu843R4xcEnsTJ7MFs+SCaMjVB6SRyU+B75ZorYaVF
        /lipVcKNsaHCcUjb8OuK1HWKoKP+BA+D2d7n4ENTdZchYKWTTqsJKrBZ/kKTCkuCozwYr06
        LQ2vGPl3vC+wdtDSOvR+ucoKQHxHcy7Ocrk2BSXnNzBko6P3dH5ID8DR7cdkrCrvaCDTB3g
        bvSTYRlDCYnMhRNgrLrkLj+akacpJmJ18VLQ2cbNov1N7c4y3hO7aEzEKSKkZwZr5FTs6E2
        KdbaFsSvXU/Gce/dtIpaSg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ulf.hansson@linaro.org
Cc:     adrian.hunter@intel.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] mmc: sdhci-bcm-kona: Fix comment typo
Date:   Fri, 15 Jul 2022 13:19:12 +0800
Message-Id: <20220715051912.31180-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The double `that' is duplicated in line 171, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index 61a12f2f7f03..6a93a54fe067 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -168,7 +168,7 @@ static void sdhci_bcm_kona_init_74_clocks(struct sdhci_host *host,
 	/*
 	 *  JEDEC and SD spec specify supplying 74 continuous clocks to
 	 * device after power up. With minimum bus (100KHz) that
-	 * that translates to 740us
+	 * translates to 740us
 	 */
 	if (power_mode != MMC_POWER_OFF)
 		udelay(740);
-- 
2.35.1

