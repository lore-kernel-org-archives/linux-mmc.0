Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C064C34034
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15AB2176D
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 07:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgBRHMU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:12:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:61168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgBRHMU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 18 Feb 2020 02:12:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 23:12:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,455,1574150400"; 
   d="scan'208";a="268657151"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga002.fm.intel.com with ESMTP; 17 Feb 2020 23:12:15 -0800
Subject: Re: [PATCH V2] mmc: sdhci-msm: Don't enable PWRSAVE_DLL for certain
 sdhc hosts
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        ulf.hansson@linaro.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, cang@codeaurora.org,
        rampraka@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1581062518-11655-1-git-send-email-vbadigan@codeaurora.org>
 <1581077075-26011-1-git-send-email-vbadigan@codeaurora.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <64ca4304-faab-cc82-0c7b-24a7f504bbd7@intel.com>
Date:   Tue, 18 Feb 2020 09:11:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581077075-26011-1-git-send-email-vbadigan@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 7/02/20 2:04 pm, Veerabhadrarao Badiganti wrote:
> From: Ritesh Harjani <riteshh@codeaurora.org>
> 
> SDHC core with new 14lpp and later tech DLL should not enable
> PWRSAVE_DLL since such controller's internal gating cannot meet
> following MCLK requirement:
> When MCLK is gated OFF, it is not gated for less than 0.5us and MCLK
> must be switched on for at-least 1us before DATA starts coming.
> 
> Adding support for this requirement.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> --
> 
> Changes since V1:
>   Condition was not correct in V1, which is corrected in V2
> 
> --
> ---
>  drivers/mmc/host/sdhci-msm.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index c3a160c..aa5b610 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -977,9 +977,21 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
>  		goto out;
>  	}
>  
> -	config = readl_relaxed(host->ioaddr + msm_offset->core_vendor_spec3);
> -	config |= CORE_PWRSAVE_DLL;
> -	writel_relaxed(config, host->ioaddr + msm_offset->core_vendor_spec3);
> +	/*
> +	 * Set CORE_PWRSAVE_DLL bit in CORE_VENDOR_SPEC3.
> +	 * When MCLK is gated OFF, it is not gated for less than 0.5us
> +	 * and MCLK must be switched on for at-least 1us before DATA
> +	 * starts coming. Controllers with 14lpp and later tech DLL cannot
> +	 * guarantee above requirement. So PWRSAVE_DLL should not be
> +	 * turned on for host controllers using this DLL.
> +	 */
> +	if (!msm_host->use_14lpp_dll_reset) {
> +		config = readl_relaxed(host->ioaddr +
> +				msm_offset->core_vendor_spec3);
> +		config |= CORE_PWRSAVE_DLL;
> +		writel_relaxed(config, host->ioaddr +
> +				msm_offset->core_vendor_spec3);
> +	}
>  
>  	/*
>  	 * Drain writebuffer to ensure above DLL calibration
> 

