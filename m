From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/4] drivers/mmc/host/mxs-mmc.c: fix error return code
Date: Mon, 17 Sep 2012 12:09:28 +0200
Message-ID: <201209171209.28173.marex@denx.de>
References: <1347869728-2696-1-git-send-email-peter.senna@gmail.com> <1347869728-2696-4-git-send-email-peter.senna@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:51040 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872Ab2IQKJj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Sep 2012 06:09:39 -0400
In-Reply-To: <1347869728-2696-4-git-send-email-peter.senna@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Senna Tschudin <peter.senna@gmail.com>
Cc: cjb@laptop.org, shawn.guo@linaro.org, broonie@opensource.wolfsonmicro.com, vinod.koul@linux.intel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Dear Peter Senna Tschudin,

> From: Peter Senna Tschudin <peter.senna@gmail.com>

The patch description is a bit crap, but otherwise

Acked-by: Marek Vasut <marex@denx.de>

> Convert a nonnegative error return code to a negative one, as returned
> elsewhere in the function.
> 
> A simplified version of the semantic match that finds this problem is as
> follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> (
> if@p1 (\(ret < 0\|ret != 0\))
>  { ... return ret; }
> 
> ret@p1 = 0
> )
> ... when != ret = e1
>     when != &ret
> *if(...)
> {
>   ... when != ret = e2
>       when forall
>  return ret;
> }
> // </smpl>
> 
> Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
> ---
>  drivers/mmc/host/mxs-mmc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 80d1e6d..afd8fdd 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -674,6 +674,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	if (!ssp->dmach) {
>  		dev_err(mmc_dev(host->mmc),
>  			"%s: failed to request dma\n", __func__);
> +		ret = -ENODEV;
>  		goto out_clk_put;
>  	}

Best regards,
Marek Vasut
