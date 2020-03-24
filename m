Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF30C54EEB
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2C20719
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mecw7Z1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgCXSIN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:08:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40417 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgCXSIN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:08:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so19601536ljj.7
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64ZAMpUJ5rH31akevtnc9j967RGejqJSPQFQwpUtFu8=;
        b=mecw7Z1kjIP1pClqvR9MdTgWcQ4OaV74xHWC0Mpa+3eX/nDK6mi+qJwmLGJ39LQsrp
         4fN1MCFaVMeu876vvPiEaQkHZQCGi0dnrT5ggddwnWOOtnmL16DPFVx3V27O54l7eHzy
         Aan2G5o2A2VOZNXuEcynlZEzGCxmmPG5Sk1c8BtH+y5B2eeFYXIld1eo2CfBY4WcLlJx
         UB0w6Th7Wdb5Jlj5bU+LWfkFToxGdyKvwslPt10i/9wbeluAUxc4JbWi0xhOI6QiWZqC
         liBkw1MCsonHMstDrYRF0lvEblTdJ9YCt7k8mXTWhi6fYuO8s7B4bvM/s+lL1yNezVD5
         IGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64ZAMpUJ5rH31akevtnc9j967RGejqJSPQFQwpUtFu8=;
        b=da47VPVKuHpuViiJFdwpzNjYJOsiiuzGfPZE882a5y4zehurbXJryuryex5EgawwmN
         VZK1CuUKvKWa98I6k17/HOOQ6lG6Ipb789cLQqMKLus31hP+3jQUskRry1XKYSjDfdQW
         NMqpFpeHRcFSHKA+/Ngfjpev3aRw++pAz5KrJroEcGjQEgV80rQixrTwPoRoCm4zFpvc
         akM6PSNQ/c+3fVdPk1GtHBJ6K8P/O1g3NHeTI7GpMH+Rtt7sLVNzhNRzNk0TeFjPNmDh
         5YfvdxgMzBcbfI6KQCUbn1pbKRzxaw/+bbJthTOAVKppiKJVvyLBsWxvz/z0LtBY0+d9
         NHfA==
X-Gm-Message-State: ANhLgQ2SIBnsidiaZXdyFH+3W3p5/MI3XycoVpPd8p41WjEF0Ov+Z3Cq
        Gtnc+iQRSI5zgrYy0/eEtxHixg==
X-Google-Smtp-Source: ADFU+vv12iDbrBNzBpnLat9A0w/VW62S5gPjD4IeUjL69XsldV1NErLUIRHTg4INORpQsC718BcKsg==
X-Received: by 2002:a2e:a0d3:: with SMTP id f19mr17698199ljm.117.1585073290826;
        Tue, 24 Mar 2020 11:08:10 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id s10sm11029858ljp.87.2020.03.24.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:08:10 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 4.19.113 4/5] mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
Date:   Tue, 24 Mar 2020 19:07:59 +0100
Message-Id: <20200324180800.28953-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200324180800.28953-1-ulf.hansson@linaro.org>
References: <20200324180800.28953-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[ Upstream commit 055e04830d4544c57f2a5192a26c9e25915c29c0 ]

It has turned out that the sdhci-omap controller requires the R1B response,
for commands that has this response associated with them. So, converting
from an R1B to an R1 response for a CMD6 for example, leads to problems
with the HW busy detection support.

Fix this by informing the mmc core about the requirement, via setting the
host cap, MMC_CAP_NEED_RSP_BUSY.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Faiz Abbas <faiz_abbas@ti.com>
Cc: <stable@vger.kernel.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index e9793d8e83a0..05ade7a2dd24 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1147,6 +1147,9 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
+	/* R1B responses is required to properly manage HW busy detection. */
+	mmc->caps |= MMC_CAP_NEED_RSP_BUSY;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.20.1

