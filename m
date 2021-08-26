Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62267C4320A
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 06:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44745610CB
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Aug 2021 06:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhHZGgt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Aug 2021 02:36:49 -0400
Received: from foss.arm.com ([217.140.110.172]:39666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234415AbhHZGgt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Aug 2021 02:36:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3543FD6E;
        Wed, 25 Aug 2021 23:36:02 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 354913F766;
        Wed, 25 Aug 2021 23:36:01 -0700 (PDT)
Subject: Re: [PATCH V2 05/10] mmc: sdhci-iproc: Set
 SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
 <1628334401-6577-6-git-send-email-stefan.wahren@i2se.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <3e8bfa67-e3fe-bcfd-1941-90cae7ed0176@arm.com>
Date:   Thu, 26 Aug 2021 01:36:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1628334401-6577-6-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,


On 8/7/21 6:06 AM, Stefan Wahren wrote:
> From: Nicolas Saenz Julienne <nsaenz@kernel.org>
> 
> The controller doesn't seem to pick-up on clock changes, so set the
> SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN flag to query the clock frequency
> directly from the clock.
> 
> Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>   drivers/mmc/host/sdhci-iproc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 032bf85..e7565c6 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -295,7 +295,8 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
>   };
>   
>   static const struct sdhci_pltfm_data sdhci_bcm2711_pltfm_data = {
> -	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +	.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 |
> +		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>   	.ops = &sdhci_iproc_bcm2711_ops,
>   };

I just noticed that this got merged to rc7, and it breaks the ACPI based 
rpi's because it causes the 100Mhz max clock to be overridden to the 
return from sdhci_iproc_get_max_clock() which is 0 because there isn't a 
OF/DT based clock device.


