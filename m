Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD63DC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7556E2222C
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgJNTpT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:45:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:38684 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727071AbgJNTpS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 14 Oct 2020 15:45:18 -0400
IronPort-SDR: eMrJCRk1W6QZ77Pv4I/vS2RUZZlgIVjqV2USH0JkAG7ztWHh5q3fKYt8VONT69g2w5B8OtdjK+
 7FqzinPx7DfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="146046956"
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="146046956"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 12:45:12 -0700
IronPort-SDR: hprZGBEUZftwTDrfJtuECyazvnCwR48TpuhQXEehRGPIsRu0V4xDkMYMUCUJi1ySG4p0d8fhYW
 MvppxDhwOQmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,375,1596524400"; 
   d="scan'208";a="314270085"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga003.jf.intel.com with ESMTP; 14 Oct 2020 12:45:09 -0700
Subject: Re: [PATCH] mmc: sdhci: Use Auto CMD Auto Select only when v4_mode is
 true
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, zhang.chunyan@linaro.org
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <20201013190851.715df9ad@xhacker.debian>
 <CAPDyKFo-Q-+wK1RjtTyoC42_M7UL-HteKwzLmWR-ctD6oKc=rA@mail.gmail.com>
 <87a39115-5843-a6a3-7564-e36ae1f16903@intel.com>
 <20201014183212.475a789d@xhacker.debian>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2c958ccd-e21f-c660-2259-e7051d95c205@intel.com>
Date:   Wed, 14 Oct 2020 22:44:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201014183212.475a789d@xhacker.debian>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Chunyan

On 14/10/20 1:32 pm, Jisheng Zhang wrote:
> Auto CMD Auto Select can only be used when v4_mode is enabled.

The SDHCI spec. doesn't seem to say that.  AFAICS it refers only to v4.1 not
v4 mode.

> 
> Fixes: 427b6514d095 ("mmc: sdhci: Add Auto CMD Auto Select support")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..5e0ec5df4074 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1386,7 +1386,8 @@ static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
>  	 * Select' is recommended rather than use of 'Auto CMD12
>  	 * Enable' or 'Auto CMD23 Enable'.
>  	 */
> -	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
> +	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
> +	    (use_cmd12 || use_cmd23)) {
>  		*mode |= SDHCI_TRNS_AUTO_SEL;
>  
>  		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 

