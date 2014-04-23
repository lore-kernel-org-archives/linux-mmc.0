From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: Don't print data errors
Date: Wed, 23 Apr 2014 15:22:44 +0900
Message-ID: <000201cf5ebc$70213200$50639600$%jun@samsung.com>
References: <1398210681-22976-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1398210681-22976-1-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: yuvaraj.cd@samsung.com, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Sonny Rao' <sonnyrao@chromium.org>, linux-samsung-soc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, April 23, 2014, Doug Anderson wrote:
> Data errors are completely expected during tuning.  Printing them out
> is confusing people looking at the kernel logs.  They see things like:
> 
>  [    3.613296] dwmmc_exynos 12200000.dwmmc0: data error, status 0x00000088
> 
> ...and they think something is wrong with their hardware.
> 
> Remove the printouts.  We'll leave it up to a higher level to report
> about errors.
Yes, your saying makes sense.
But in normal I/O, actual error information such as status below is useful, isn't it?

Thanks,
Seungwon Jeon

> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index cced599..4c8d423 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1248,7 +1248,7 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
>  			data->error = -EIO;
>  		}
> 
> -		dev_err(host->dev, "data error, status 0x%08x\n", status);
> +		dev_dbg(host->dev, "data error, status 0x%08x\n", status);
> 
>  		/*
>  		 * After an error, there may be data lingering
> --
> 1.9.1.423.g4596e3a
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
