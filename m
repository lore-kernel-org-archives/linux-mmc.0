Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D7C432C3
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 02:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FF92256F
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Dec 2020 02:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgLWC3P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Dec 2020 21:29:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730639AbgLWCZx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Dec 2020 21:25:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70AA622A83;
        Wed, 23 Dec 2020 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690338;
        bh=ElZFJenPwKmFJZjW+9jfyQVKLCCfNn+lzwvk7yJZRsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XbGilQAjuaV3TpK9yVIQxeEmcdkQx33RfBNucwYtHrwHLJ/cewq/pMzDaFbE2erEx
         R1IAmNzvosvv0RJkidKbnWmR/jLdw9qs/Qr5GSAYlbW0v2Tsmo7p4HWsYEXn8rCwLf
         466EURCizYTpnWpRP8qnes1jVUdLlj4Qb43YqXx7chJfy2rdFpsTcUuHvwNm7vKr4x
         /BGKBnW5DcL8vReAgNtZL9QiXsf5xrie5U4DvusJc7G1YbuDLP7OEM4Dq9B1d8Ix2y
         p05Ou1Th9GywdV32MGoO7WLM7EHiiXq294ont3QcttvjEd2UwIqHK9EM/c4CIzQ1QQ
         oE2phFH0EC3Qw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 17/38] mmc: tmio: do not print real IOMEM pointer
Date:   Tue, 22 Dec 2020 21:24:55 -0500
Message-Id: <20201223022516.2794471-17-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223022516.2794471-1-sashal@kernel.org>
References: <20201223022516.2794471-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

[ Upstream commit ade8e9d3fb9232ddfb87a4bc641b35b988d9757b ]

Printing kernel pointers is discouraged because they might leak kernel
memory layout.  This fixes smatch warning:

    drivers/mmc/host/tmio_mmc.c:177 tmio_mmc_probe() warn: argument 3 to %08lx specifier is cast from pointer

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20201116164252.44078-1-krzk@kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/tmio_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e897e7fc3b14c..052093db7d159 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -109,8 +109,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto host_remove;
 
-	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, irq);
+	pr_info("%s at 0x%p irq %d\n", mmc_hostname(host->mmc), host->ctl, irq);
 
 	return 0;
 
-- 
2.27.0

