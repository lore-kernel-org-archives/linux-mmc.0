From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] Mmc: host - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 13:12:58 +0100
Message-ID: <7439833a-e8cd-54b5-a020-4a16ac2d75a8@denx.de>
References: <CGME20170130044838epcas1p43a1c58ae970b39909cfb67b2aa619a88@epcas1p4.samsung.com>
 <1485751698-29036-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:54306 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751701AbdA3MOF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2017 07:14:05 -0500
In-Reply-To: <1485751698-29036-1-git-send-email-shailendra.v@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shailendra Verma <shailendra.v@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fabio Estevam <fabio.estevam@nxp.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>

On 01/30/2017 05:48 AM, Shailendra Verma wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.
> 
> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
> ---
>  drivers/mmc/host/mxs-mmc.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 44ecebd..d12a5b7 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -581,6 +581,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  	struct regulator *reg_vmmc;
>  	struct mxs_ssp *ssp;
>  
> +	if (!of_id) {
> +		dev_err(&pdev->dev, "Error: No device match found\n");
> +		return -ENODEV;
> +	}

The probe won't be called if OF match doesn't happen in the first place,
so this check is redundant, no ?

>  	irq_err = platform_get_irq(pdev, 0);
>  	if (irq_err < 0)
>  		return irq_err;
> 


-- 
Best regards,
Marek Vasut
