Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57572C2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351A821835
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 13:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgATNe3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:34:29 -0500
Received: from foss.arm.com ([217.140.110.172]:60384 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgATNe3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 08:34:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5643430E;
        Mon, 20 Jan 2020 05:34:29 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4F73F52E;
        Mon, 20 Jan 2020 05:34:27 -0800 (PST)
Subject: Re: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
To:     "Y.b. Lu" <yangbo.lu@nxp.com>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <50fe98f2-9ee6-c0fb-d246-e3d6b4b2cec5@arm.com>
Date:   Mon, 20 Jan 2020 13:34:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 20/01/2020 10:09 am, Y.b. Lu wrote:
> Hi Russell,
> 
> Recently I got eSDHC ADMA issue on PowerPC T2080 platform. After checking, the issue is related to this patch.
> This patch was to make eSDHC DMA SNOOP bit set per dma-coherent. That resolved issue on LX2160A ARM64 platform.
> However on T2080, we are facing similar issue again. It didn't have dma-coherent in dts.
> Adding dma-coherent in dts, or reverting the patch could resolve the problem.

Arguably updating the DTS would be the most accurate option, since it 
would be describing the hardware more correctly, however if there are 
reasons for that not being sufficient (e.g. DTBs baked into firmware, or 
worries of confusing some other DT consumer) then something like the 
below seems reasonable (albeit a little crude) IMO.

Robin.

----->8-----
 From fafad319893b4168fcccc5445543caf876a0be2d Mon Sep 17 00:00:00 2001
Message-Id: 
<fafad319893b4168fcccc5445543caf876a0be2d.1579526755.git.robin.murphy@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Date: Mon, 20 Jan 2020 13:11:59 +0000
Subject: [PATCH] mmc: sdhci-of-esdhc: Restore coherency for PPC platforms

Historically, not all PPC platforms have supported per-device coherency,
and some may rely on platform-level assumptions rather than explicitly
specifying the "dma-coherent" propert in their DT. Although the eSDHC
driver needs to tie in to per-device coherency to work correctly on
arm/arm64 platforms, this has apparently caused problems for PPC, so
restore the previous behaviour there with a special case.

Fixes: 121bd08b029e ("mmc: sdhci-of-esdhc: set DMA snooping based on DMA 
coherence")
Reported-by: Yangbo Lu <yangbo.lu@nxp.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/mmc/host/sdhci-of-esdhc.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c 
b/drivers/mmc/host/sdhci-of-esdhc.c
index 500f70a6ee42..a2599368b2bd 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -527,7 +527,8 @@ static int esdhc_of_enable_dma(struct sdhci_host *host)

  	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);

-	if (of_dma_is_coherent(dev->of_node))
+	/* Historically, PPC has always assumed coherency here */
+	if (IS_ENABLED(CONFIG_PPC) || of_dma_is_coherent(dev->of_node))
  		value |= ESDHC_DMA_SNOOP;
  	else
  		value &= ~ESDHC_DMA_SNOOP;
-- 
2.23.0.dirty
