Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC32C32771
	for <linux-mmc@archiver.kernel.org>; Mon, 26 Sep 2022 19:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiIZT03 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 26 Sep 2022 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiIZT01 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Sep 2022 15:26:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958C5A146;
        Mon, 26 Sep 2022 12:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664220386; x=1695756386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AZVPuZo3Qc/Eaz29CT/RaRCe8emvF7DALAGUFRZb1JM=;
  b=TcwD/ukEO5BCSK38tnrE5sWSUfY0Dm1TTjE67LXKuOOc5xmPtufYXx9Z
   wxVjyrTAbE6H6wFb/kfkgeUN/Z/jjh5XFjuwIqRKsTRDEzyjbp9ttQ6pF
   z8AI/W5sybEerB+/CC6kzSxPTZ3TSoJ6z6T5F6CdF8S5EvOC2+FtRrsyb
   nhA6An0S4iRvg4RiDpi4GjZSXSFPCgIm3JTM0Xzlyz6POHIBeTNrehcfP
   nJteSMFrSu4vIQ+Bd+Cxqz+16TbLcUBn6pDMfR2ulg3ukqw/sFWQO7sDs
   5ApmGkMM+nIMhz1XVX9MdiLmYN4MQIOP91GBMjJ/pmyNcabvWqFWlGZTf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="327474590"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="327474590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:26:26 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="796457561"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="796457561"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.59.121])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 12:26:22 -0700
Message-ID: <91f09a39-57fa-06a9-6e9e-b3e768d9e26a@intel.com>
Date:   Mon, 26 Sep 2022 22:26:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/4] mmc: sdhci-tegra: Issue CMD and DAT resets
 together
Content-Language: en-US
To:     Prathamesh Shete <pshete@nvidia.com>, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     anrao@nvidia.com, smangipudi@nvidia.com, kyarlagadda@nvidia.com
References: <20220926094906.14537-1-pshete@nvidia.com>
 <20220926094906.14537-3-pshete@nvidia.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20220926094906.14537-3-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 26/09/22 12:49, Prathamesh Shete wrote:
> In case of error condition to avoid system crash
> Tegra SDMMC controller requires CMD and DAT resets
> issued together. SDHCI controller FSM goes into
> bad state due to rapid SD card hot-plug event.
> Issuing reset on the CMD FSM before DATA FSM results
> in kernel panic, hence add support to issue CMD and
> DAT resets together.
> This is applicable to Tegra186 and later chips.
> 
> Signed-off-by: Aniruddha TVS Rao <anrao@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c |  3 ++-
>  drivers/mmc/host/sdhci.c       | 20 +++++++++++++++-----
>  drivers/mmc/host/sdhci.h       |  2 ++
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 4d32b5bfc424..58449e010a9b 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1532,7 +1532,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
>  		  SDHCI_QUIRK_NO_HISPD_BIT |
>  		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>  		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> -	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +		   SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER,
>  	.ops  = &tegra186_sdhci_ops,
>  };
>  
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7689ffec5ad1..2f4a0e84fee8 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3060,12 +3060,22 @@ static bool sdhci_request_done(struct sdhci_host *host)
>  			host->ops->set_clock(host, host->clock);
>  
>  		/*
> -		 * Spec says we should do both at the same time, but Ricoh
> -		 * controllers do not like that.
> +		 * While the specification says we should do both at the
> +		 * same time, Ricoh controllers (and potentially others) do not
> +		 * like that. On the other hand, some controllers (such as those
> +		 * found on Tegra186 and later) rely on both being reset at the
> +		 * same time. Use a quirk for the latter category since most
> +		 * controllers seem to work fine with DAT and CMD getting reset
> +		 * at the same time.
>  		 */
> -		sdhci_do_reset(host, SDHCI_RESET_CMD);
> -		sdhci_do_reset(host, SDHCI_RESET_DATA);
> -
> +		if (host->quirks2 &
> +			SDHCI_QUIRK2_ISSUE_CMD_DAT_RESET_TOGETHER) {
> +			sdhci_do_reset(host, SDHCI_RESET_CMD |
> +					SDHCI_RESET_DATA);
> +		} else {
> +			sdhci_do_reset(host, SDHCI_RESET_CMD);
> +			sdhci_do_reset(host, SDHCI_RESET_DATA);
> +		}

There is a bit a tidy up of SDHCI resets here:

https://lore.kernel.org/linux-mmc/20220926192022.85660-1-adrian.hunter@intel.com/

Would you mind implementing the quirk on top of that patch set.
The quirk should go somewhere in the new sdhci_reset_for_reason()
function, which should make it's use more consistent.
