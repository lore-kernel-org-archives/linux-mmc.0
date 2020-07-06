Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD2C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E06220702
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 16:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgGFQag (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:30:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgGFQag (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 12:30:36 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jsU0l-0000aN-UO; Mon, 06 Jul 2020 16:30:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc-exynos: remove redundant initialization of variable 'found'
Date:   Mon,  6 Jul 2020 17:30:31 +0100
Message-Id: <20200706163031.503431-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable 'found' is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/dw_mmc-exynos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 5e3d95b63676..99b900008a03 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -472,7 +472,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
 	struct dw_mci_exynos_priv_data *priv = host->priv;
 	struct mmc_host *mmc = slot->mmc;
 	u8 start_smpl, smpl, candiates = 0;
-	s8 found = -1;
+	s8 found;
 	int ret = 0;
 
 	start_smpl = dw_mci_exynos_get_clksmpl(host);
-- 
2.27.0

