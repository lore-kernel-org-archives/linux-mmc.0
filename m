Return-Path: <SRS0=8+sB=DW=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE43C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 10:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC33522249
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Oct 2020 10:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389159AbgJOKPE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Oct 2020 06:15:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:43378 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389157AbgJOKPD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 15 Oct 2020 06:15:03 -0400
IronPort-SDR: 2T8RAQbGZBmXnt/ZW47y4KaqB/ik75X7A8IXkx3p5apbgbfdIsOxua9j0X28k0t+DLACYgycKI
 vH8SomUgalgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="146171328"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="146171328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:15:02 -0700
IronPort-SDR: gIuTaUcZ5rGI0I8YaE4W4zyUUuTOiIJRuZffASIFJo5w36K4Jt3rbEa3FHFT8C1I7HNT7xYBAP
 SKGtlf91RMWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="330749617"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga002.jf.intel.com with ESMTP; 15 Oct 2020 03:15:01 -0700
Subject: Re: [PATCH v2] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode
 is true
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201015174115.4cf2c19a@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <6f54fd08-8285-a50f-9e18-e4d854f7d559@intel.com>
Date:   Thu, 15 Oct 2020 13:14:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201015174115.4cf2c19a@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/10/20 12:41 pm, Jisheng Zhang wrote:
> sdhci-of-dwcmshc meets an eMMC read performance regression with below
> command after commit 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto
> Select support"):
> 
> dd if=/dev/mmcblk0 of=/dev/null bs=8192 count=100000
> 
> Before the commit, the above command gives 120MB/s
> After the commit, the above command gives 51.3 MB/s
> 
> So it looks like sdhci-of-dwcmshc expects Version 4 Mode for Auto
> CMD Auto Select. Fix the performance degradation by ensuring v4_mode
> is true to use Auto CMD Auto Select.
> 
> Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Since v1:
>   - add the performance degradation on sdhci-of-dwcmshc explanation in
>     commit msg
>   - add a comment in the code explaining we require Version 4 Mode because some
>     controllers(e.g sdhci-of-dwcmshc) expect it that way.
> 
>  drivers/mmc/host/sdhci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..3561ae8a481a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1384,9 +1384,11 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>  	/*
>  	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
>  	 * Select' is recommended rather than use of 'Auto CMD12
> -	 * Enable' or 'Auto CMD23 Enable'.
> +	 * Enable' or 'Auto CMD23 Enable'. We require Version 4 Mode
> +	 * here because some controllers (e.g sdhci-of-dwmshc) expect it.
>  	 */
> -	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +	    (use_cmd12 || use_cmd23)) {
>  		*mode |= SDHCI_TRNS_AUTO_SEL;
>  
>  		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 

