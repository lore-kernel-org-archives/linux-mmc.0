Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B27C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Oct 2021 10:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B2561077
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Oct 2021 10:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbhJMKC5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Oct 2021 06:02:57 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:48084
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239184AbhJMKC5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2021 06:02:57 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DB13C3F22D;
        Wed, 13 Oct 2021 10:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634119253;
        bh=53e+MWtjbQBfgbBFwQcxGcPAOvJ+WyNsyNnEXHebVSM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=sNLQoW4VhRCZ+zF1eaPQQxOL57SP/mBikjrcvf056hdAdjIKO1LSt1/eIeooj1z6D
         M/8Flmw9R2ogDzx8K+cmH2QZnxOlkUKtA4+NFxanXi5llTBQcyx0sOukmh1sOHCdi1
         EyccrKqeqR1zyB0R+fVDHOPRereNUJJ1l3KYWGX+H7mJ/gENxcuSdSTLlqAKXu867O
         63tIUFm8j7hoCuantWdVuFGx/6EBooyg3808Z1Qp31BIPdmDJjIz67Wll1EFW5oEEm
         fCJhyRqdTsYO4D0TtrbtvfrJ2VjtE5xyNMVCZd5X3WwTEQzX/LIJeWXCZjLW1kNYut
         GqPtkO/dNbk0w==
From:   Colin King <colin.king@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, linux-mmc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mmc: moxart: Fix null pointer dereference on pointer host
Date:   Wed, 13 Oct 2021 11:00:52 +0100
Message-Id: <20211013100052.125461-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several error return paths that dereference the null pointer
host because the pointer has not yet been set to a valid value.
Fix this by adding a new out_mmc label and exiting via this label
to avoid the host clean up and hence the null pointer dereference.

Addresses-Coverity: ("Explicit null dereference")
Fixes: 8105c2abbf36 ("mmc: moxart: Fix reference count leaks in moxart_probe")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/moxart-mmc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 7b9fcef490de..16d1c7a43d33 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -566,37 +566,37 @@ static int moxart_probe(struct platform_device *pdev)
 	if (!mmc) {
 		dev_err(dev, "mmc_alloc_host failed\n");
 		ret = -ENOMEM;
-		goto out;
+		goto out_mmc;
 	}
 
 	ret = of_address_to_resource(node, 0, &res_mmc);
 	if (ret) {
 		dev_err(dev, "of_address_to_resource failed\n");
-		goto out;
+		goto out_mmc;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
 		dev_err(dev, "irq_of_parse_and_map failed\n");
 		ret = -EINVAL;
-		goto out;
+		goto out_mmc;
 	}
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-		goto out;
+		goto out_mmc;
 	}
 
 	reg_mmc = devm_ioremap_resource(dev, &res_mmc);
 	if (IS_ERR(reg_mmc)) {
 		ret = PTR_ERR(reg_mmc);
-		goto out;
+		goto out_mmc;
 	}
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-		goto out;
+		goto out_mmc;
 
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
@@ -687,6 +687,7 @@ static int moxart_probe(struct platform_device *pdev)
 		dma_release_channel(host->dma_chan_tx);
 	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
 		dma_release_channel(host->dma_chan_rx);
+out_mmc:
 	if (mmc)
 		mmc_free_host(mmc);
 	return ret;
-- 
2.32.0

