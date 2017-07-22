From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 038/102] mmc: dw_mmc: explicitly request exclusive reset
 control
Date: Sat, 22 Jul 2017 21:13:52 +0800
Message-ID: <dac26040-0480-6331-5971-8c09c9848b7f@rock-chips.com>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
 <20170719152646.25903-39-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:34056 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbdGVNO2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jul 2017 09:14:28 -0400
In-Reply-To: <20170719152646.25903-39-p.zabel@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On 2017/7/19 23:25, Philipp Zabel wrote:
> Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
> reset lines") started to transition the reset control request API calls
> to explicitly state whether the driver needs exclusive or shared reset
> control behavior. Convert all drivers requesting exclusive resets to the
> explicit API call so the temporary transition helpers can be removed.
>
> No functional changes.
>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a9dfb26972f21..7c1e2dbc76776 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2950,7 +2950,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  		return ERR_PTR(-ENOMEM);
>
>  	/* find reset controller when exist */
> -	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
> +	pdata->rstc = devm_reset_control_get_optional_exclusive(dev, "reset");
>  	if (IS_ERR(pdata->rstc)) {
>  		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
>  			return ERR_PTR(-EPROBE_DEFER);
>


-- 
Best Regards
Shawn Lin

