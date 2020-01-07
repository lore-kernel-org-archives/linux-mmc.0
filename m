Return-Path: <SRS0=8m0a=24=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9773CC33C99
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 09:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8C521744
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jan 2020 09:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="RI1VjAZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbgAGJri (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jan 2020 04:47:38 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:40353 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgAGJri (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 7 Jan 2020 04:47:38 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47sSGb5vpxz39;
        Tue,  7 Jan 2020 10:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578390456; bh=mQhGMrMqAWw47NECxXln208dkF/GHmMTdjSqLfREAeI=;
        h=Date:From:Subject:To:Cc:From;
        b=RI1VjAZW/5oEzniE4siJGYElmPhb/QAKViy2c/5A3PX8nhSyhy7A8+Sb2t0XGri1N
         9v5jifgL5K8Wt0RTqNsfbg8yZ72vpVMh0Mkb0lv8NVb2DE2QnGXH+0FmaOSmna2Fcx
         8JQDtdvAfZjqq32gexokiMkdQzk1/syjk3Ux6gc+tHzdAW23vIvodkVo7DIvfnQ95A
         tXLLGFJMZzuHbJd5TDroP0Rglg0d21lB51WrPzggSqM08QpqiiUWEdc3kca1aWloyI
         rIjssdpdfZegcd9adbJ6kv1yl2GutIHps2DUj3dyDRtbtHDD2PPoq9qfKJf5azJiX/
         aEPZ7iPtMQecA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Tue, 07 Jan 2020 10:47:34 +0100
Message-Id: <9aff1d859935e59edd81e4939e40d6c55e0b55f6.1578390388.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3] mmc: tegra: fix SDR50 tuning override
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>
Cc:     linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
broke SDR50 tuning override. Use correct NVQUIRK_ name.

Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
Cc: <stable@vger.kernel.org> # 4f6aa3264af4: mmc: tegra: Only advertise UHS modes if IO regulator is present
Cc: <stable@vger.kernel.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Tested-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
 v3: added Thierry's signs that were missing in v2
 v2: converted 'Depends-On' tag to proper 'Cc: stable' lines

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/mmc/host/sdhci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7bc950520fd9..403ac44a7378 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -386,7 +386,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_DDR50;
 		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR104)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDR104;
-		if (soc_data->nvquirks & SDHCI_MISC_CTRL_ENABLE_SDR50)
+		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDR50)
 			clk_ctrl |= SDHCI_CLOCK_CTRL_SDR50_TUNING_OVERRIDE;
 	}
 
-- 
2.20.1

