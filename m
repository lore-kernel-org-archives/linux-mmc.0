Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE38BC5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 08:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9621C208C3
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 08:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgKYIIs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Nov 2020 03:08:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:55243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbgKYIIr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 25 Nov 2020 03:08:47 -0500
IronPort-SDR: UDQY2SUrIK9J24AtSW1A+1oBANrW4p6Hb1cnM7e1FjZ8KAQFbjBGufUlpPc+uh/QNYBnU3yAHl
 DuanINuZQWGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="236223224"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="236223224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 00:08:46 -0800
IronPort-SDR: d89wyNIp/4sQKU38ifwFZ5XXb+cpLwQcHD9SOaPhNOn3QIZ8cYwwijxxMXdIOweNsRxHSYri+e
 13UJofcaabdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="362239500"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 25 Nov 2020 00:08:45 -0800
Subject: Re: [PATCH] mmc: sdhci: Use more concise device_property_read_u64
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ulf.hansson@linaro.org
References: <20201125033630.603863-1-jeremy.linton@arm.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <2f28f4c7-6f00-33ee-ac38-211c6fb07702@intel.com>
Date:   Wed, 25 Nov 2020 10:08:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201125033630.603863-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 25/11/20 5:36 am, Jeremy Linton wrote:
> Since we only need a single u64 the _array form is
> unnecessarily. Use device_property_read_u64 instead.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thank you :-)

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index feba64fbde16..ad4ae88a7f74 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>  	if (host->v4_mode)
>  		sdhci_do_enable_v4_mode(host);
>  
> -	device_property_read_u64_array(mmc_dev(host->mmc),
> -				       "sdhci-caps-mask", &dt_caps_mask, 1);
> -	device_property_read_u64_array(mmc_dev(host->mmc),
> -				       "sdhci-caps", &dt_caps, 1);
> +	device_property_read_u64(mmc_dev(host->mmc),
> +				 "sdhci-caps-mask", &dt_caps_mask);
> +	device_property_read_u64(mmc_dev(host->mmc),
> +				 "sdhci-caps", &dt_caps);
>  
>  	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>  	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
> 

