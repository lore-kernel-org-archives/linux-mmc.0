Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EFEC11F66
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Jul 2021 23:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3348F61958
	for <linux-mmc@archiver.kernel.org>; Sun,  4 Jul 2021 23:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhGDXKd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 4 Jul 2021 19:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232183AbhGDXKE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 4 Jul 2021 19:10:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7055061953;
        Sun,  4 Jul 2021 23:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625440043;
        bh=nYZjtovbTvEXUjXwCxT6in8QL3EZuWYSvKmgcDiqPfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=osCYmzRYmmkydjxl69pzex2hmBqHTz7SKXF+gp6ocBtm+OD+lL/kz5F7erpVSmXIs
         50rSb1mmZCW2gWuTqGKQ2eTBaxFk0IJDo641NM36WBByMgdO+FLo3oXOnYv52+134k
         RvCKXQKbOrrgZ9wR5E49KbpTTtcJI9YgZSINliiV95X7qDNO7zeCdbuo77PBkBbTiE
         rgFj0vijWCSwm65AyOacCQ15LMWNA5KNgrEOmGhqJH5BKSHSiW3diR7kvmQluCP/9V
         7cIoAN9fHx//uLQe2lwQBtm3H3lS2EKYSix+mA+XBmHSoVW4twAyLeoZzdx3SjPFyl
         sVinzoYyksUpg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel test robot <lkp@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 49/80] mmc: sdhci-sprd: use sdhci_sprd_writew
Date:   Sun,  4 Jul 2021 19:05:45 -0400
Message-Id: <20210704230616.1489200-49-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210704230616.1489200-1-sashal@kernel.org>
References: <20210704230616.1489200-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit 961470820021e6f9d74db4837bd6831a1a30341b ]

The sdhci_sprd_writew() was defined by never used in sdhci_ops:

    drivers/mmc/host/sdhci-sprd.c:134:20: warning: unused function 'sdhci_sprd_writew'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20210601095403.236007-2-krzysztof.kozlowski@canonical.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-sprd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 5dc36efff47f..11e375579cfb 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -393,6 +393,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
+	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
 	.get_max_clock = sdhci_sprd_get_max_clock,
-- 
2.30.2

