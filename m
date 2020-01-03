Return-Path: <SRS0=sWu+=2Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3175C3276C
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Jan 2020 00:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6E321D56
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Jan 2020 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgACAoE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 2 Jan 2020 19:44:04 -0500
Received: from lucky1.263xmail.com ([211.157.147.132]:43348 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACAoE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Jan 2020 19:44:04 -0500
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Jan 2020 19:44:02 EST
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 47AD286504;
        Fri,  3 Jan 2020 08:36:56 +0800 (CST)
X-MAIL-GRAY: 1
X-MAIL-DELIVERY: 0
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.37] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24155T140478920242944S1578011815672162_;
        Fri, 03 Jan 2020 08:36:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4c9a2c64a65767a833e6315775956551>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: adrian.hunter@intel.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Cc:     shawn.lin@rock-chips.com, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Subject: Re: [RFT PATCH 3/3] mmc: sdhci-of-arasan: Fix Command Queuing enable
 handling
To:     Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20191230092343.30692-1-faiz_abbas@ti.com>
 <20191230092343.30692-4-faiz_abbas@ti.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <5a7f96e5-58f0-083e-612f-7f5867d8eb66@rock-chips.com>
Date:   Fri, 3 Jan 2020 08:36:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191230092343.30692-4-faiz_abbas@ti.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2019/12/30 17:23, Faiz Abbas wrote:
> There is a need to dump data from the buffer before enabling command
> queuing because of leftover data from tuning. Reset the data lines to
> fix this at the source.
> 

It seems to work for my platform by porting it to 4.19 LTS.

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>   drivers/mmc/host/sdhci-of-arasan.c | 21 ++++-----------------
>   1 file changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e49b44b4d82e..1495ae72b902 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -376,22 +376,8 @@ static void sdhci_arasan_dumpregs(struct mmc_host *mmc)
>   	sdhci_dumpregs(mmc_priv(mmc));
>   }
>   
> -static void sdhci_arasan_cqe_enable(struct mmc_host *mmc)
> -{
> -	struct sdhci_host *host = mmc_priv(mmc);
> -	u32 reg;
> -
> -	reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -	while (reg & SDHCI_DATA_AVAILABLE) {
> -		sdhci_readl(host, SDHCI_BUFFER);
> -		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
> -	}
> -
> -	sdhci_cqe_enable(mmc);
> -}
> -
>   static const struct cqhci_host_ops sdhci_arasan_cqhci_ops = {
> -	.enable         = sdhci_arasan_cqe_enable,
> +	.enable         = sdhci_cqe_enable,
>   	.disable        = sdhci_cqe_disable,
>   	.dumpregs       = sdhci_arasan_dumpregs,
>   };
> @@ -410,8 +396,9 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
>   static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>   	.ops = &sdhci_arasan_cqe_ops,
>   	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN	|
> +		   SDHCI_QUIRK2_RESET_DATA_POST_TUNING	|
> +		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>   };
>   
>   static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
> 


