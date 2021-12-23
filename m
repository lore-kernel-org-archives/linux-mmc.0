Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D4BC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Dec 2021 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbhLWRcm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:32:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60376 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbhLWRch (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2021 12:32:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83A361EE9
        for <linux-mmc@vger.kernel.org>; Thu, 23 Dec 2021 17:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA693C36AE9;
        Thu, 23 Dec 2021 17:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640280756;
        bh=QMOb2xFvtVi3U3ng5z2XUO40wX+8YRmINn5LHBGfPRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eB+TAFQXRb35uiMLk4gHFZQrgfvvC75DGzbf6d5HDDktQUeYrN1d7NDG+PR/x8YAD
         3xz/7Avzo7RrlzIce5mOwzr7JJOVs807qprBS4c+gkNvt7bMvu5iwY8fpMRHGDugel
         q40duFZTm3Zep+RxpwaE9zyD57m8ggsTPzUF/WK7amE2xmahpOEW/WY7EWuavF2dWq
         48Kk6ScQrutbnmXDPnmPGv0iP3zVuJ7AC5iM1JQbe9d05CW0pSYbKOPXrOdp5Ak/Ou
         v1wystuDt6yZlp844LQRnALZ2C1iMkflldqRLn7d5oooDXmxgWgdradeI0P2+bCR/J
         u1ZbZkxM8898A==
Date:   Thu, 23 Dec 2021 23:02:30 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 07/13] mmc: owl: fix deferred probing
Message-ID: <20211223173230.GB5159@thinkpad>
References: <20211223171202.8224-1-s.shtylyov@omp.ru>
 <20211223171202.8224-8-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223171202.8224-8-s.shtylyov@omp.ru>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 23, 2021 at 08:11:56PM +0300, Sergey Shtylyov wrote:
> The driver overrides the error codes returned by platform_get_irq() to
> -EINVAL, so if it returns -EPROBE_DEFER, the driver will fail the probe
> permanently instead of the deferred probing. Switch to propagating the
> error codes upstream.
> 
> Fixes: ff65ffe46d28 ("mmc: Add Actions Semi Owl SoCs SD/MMC driver")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mmc/host/owl-mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
> index 3dc143b03939..679b8b0b310e 100644
> --- a/drivers/mmc/host/owl-mmc.c
> +++ b/drivers/mmc/host/owl-mmc.c
> @@ -638,7 +638,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
>  
>  	owl_host->irq = platform_get_irq(pdev, 0);
>  	if (owl_host->irq < 0) {
> -		ret = -EINVAL;
> +		ret = owl_host->irq;
>  		goto err_release_channel;
>  	}
>  
> -- 
> 2.26.3
> 
