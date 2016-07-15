From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove the unnecessary IS_ERR() checking for
 ciu/biu clock
Date: Fri, 15 Jul 2016 10:07:44 +0800
Message-ID: <b0aa3a82-2d2b-270d-22a5-1d6573c95c57@rock-chips.com>
References: <1468547648-4458-1-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:60584 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbcGOCIB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2016 22:08:01 -0400
In-Reply-To: <1468547648-4458-1-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

=D4=DA 2016/7/15 9:54, Jaehoon Chung =D0=B4=B5=C0:
> If ciu/biu clock are NULL, clk_disable_unprepare should be just
> returned. In clk_disable_unprepare(), already checked whether clk is
> error or NULL.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

That's a good catch.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>  drivers/mmc/host/dw_mmc.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2dfdc58..9fab5ed 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3184,12 +3184,10 @@ err_dmaunmap:
>  		host->dma_ops->exit(host);
>
>  err_clk_ciu:
> -	if (!IS_ERR(host->ciu_clk))
> -		clk_disable_unprepare(host->ciu_clk);
> +	clk_disable_unprepare(host->ciu_clk);
>
>  err_clk_biu:
> -	if (!IS_ERR(host->biu_clk))
> -		clk_disable_unprepare(host->biu_clk);
> +	clk_disable_unprepare(host->biu_clk);
>
>  	return ret;
>  }
> @@ -3215,11 +3213,8 @@ void dw_mci_remove(struct dw_mci *host)
>  	if (host->use_dma && host->dma_ops->exit)
>  		host->dma_ops->exit(host);
>
> -	if (!IS_ERR(host->ciu_clk))
> -		clk_disable_unprepare(host->ciu_clk);
> -
> -	if (!IS_ERR(host->biu_clk))
> -		clk_disable_unprepare(host->biu_clk);
> +	clk_disable_unprepare(host->ciu_clk);
> +	clk_disable_unprepare(host->biu_clk);
>  }
>  EXPORT_SYMBOL(dw_mci_remove);
>
>


--=20
Best Regards
Shawn Lin

