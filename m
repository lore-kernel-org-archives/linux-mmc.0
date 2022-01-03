Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4006C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Jan 2022 08:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbiACIaj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Jan 2022 03:30:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:19557 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232071AbiACIai (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Jan 2022 03:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641198638; x=1672734638;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=MbFeihPsVRfpT3QKYZRaAoYZgfjIlElj1+7sWdPR7lQ=;
  b=VAqp9zk38Q+tqHfxRMTtR8M4lfdbiVlBM9vEEiYxH665pX6uNrsKKhpG
   1lu5t++eRrHhTMfFfeu1ixcNfFlNzs1hUGz+StTroZulIcLzxJI69EqDr
   y+LKQPnq2uh2JLFTRigs5PhE6ZueLb6lGugPlr4Us1K49JdhZQoNe+av0
   35lUdRaGL6WK6odS82l9S+JnUGWiVW79zxkjV7v/n7QTMGUjivC3QUXWI
   vRgZy/WXQUdjVQpV2fe4PyFNfPil7lA0xrba+MHh4DrJCbtUuLzrWqYW7
   17EfumwrtmCPXGuluXCopsg+sLasE0IsgQETNVzG0nnsBjVyJJ5sosmoS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10215"; a="305386036"
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="305386036"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 00:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,257,1635231600"; 
   d="scan'208";a="525483629"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.92]) ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 03 Jan 2022 00:30:33 -0800
Subject: Re: [PATCH RFC 10/13] mmc: sdhci-spear: fix deferred probing
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-11-s.shtylyov@omp.ru>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b62c6cf2-7336-86a6-2007-8dc84209f0a7@intel.com>
Date:   Mon, 3 Jan 2022 10:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211223171202.8224-11-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/12/2021 19:11, Sergey Shtylyov wrote:
> The driver overrides the error codes and IRQ0 returned by platform_get_irq()
> to -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the error
> codes upstream. IRQ0 is no longer returned by platform_get_irq(), so we now
> can safely ignore it...
> 
> Fixes: 682798a596a6 ("mmc: sdhci-spear: Handle return value of platform_get_irq")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-spear.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index d463e2fd5b1a..c79035727b20 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -65,8 +65,8 @@ static int sdhci_probe(struct platform_device *pdev)
>  	host->hw_name = "sdhci";
>  	host->ops = &sdhci_pltfm_ops;
>  	host->irq = platform_get_irq(pdev, 0);
> -	if (host->irq <= 0) {
> -		ret = -EINVAL;
> +	if (host->irq < 0) {
> +		ret = host->irq;
>  		goto err_host;
>  	}
>  	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
> 

