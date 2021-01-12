Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7045C433E6
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 10:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AF3F2310E
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jan 2021 10:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404974AbhALKYX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:24:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:22804 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730230AbhALKYX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 12 Jan 2021 05:24:23 -0500
IronPort-SDR: d7Ly89wBkFDEm7DyHg1v3mP7abA9Lkm4TiTqZlqDW0irwUcSWnnrBa2Dn4CMQeoW+H4OWVZN8V
 GE5DgoFBgVjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165100680"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="165100680"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 02:23:42 -0800
IronPort-SDR: cjILx6JghTB+Ny13NlPb2xrtXziGCVW1HRvKDRvCM6boccj4Osv75C9pPZqozQM5C66rXoTHiX
 gmsuciABpiew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="345168618"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.149]) ([10.237.72.149])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2021 02:23:40 -0800
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20210107221509.6597-1-alcooperx@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <fcb0cb27-a32a-fb13-68e4-fb4e6432723b@intel.com>
Date:   Tue, 12 Jan 2021 12:23:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20210107221509.6597-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/01/21 12:15 am, Al Cooper wrote:
> Commit e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> that added a shutdown callback to the diver, is causing "mmc timeout"
> errors on S5 suspend. The problem was that the "remove" was queuing
> additional MMC commands after the "shutdown" and these caused
> timeouts as the MMC queues were cleaned up for "remove". The
> shutdown callback will be changed to calling sdhci-pltfm_suspend
> which should get better power savings because the clocks will be
> shutdown.
> 
> Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index bbf3496f4495..f9780c65ebe9 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -314,11 +314,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>  
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> -	int ret;
> -
> -	ret = sdhci_pltfm_unregister(pdev);
> -	if (ret)
> -		dev_err(&pdev->dev, "failed to shutdown\n");
> +	sdhci_pltfm_suspend(&pdev->dev);
>  }
>  
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> 

