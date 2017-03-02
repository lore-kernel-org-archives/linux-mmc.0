From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: Fix access to HS400-ES devices
Date: Thu, 2 Mar 2017 09:12:52 +0800
Message-ID: <8b22ae13-f197-4642-53b7-d5fcc63c082f@rock-chips.com>
References: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1488406307-8952-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Anssi Hannula <anssi.hannula@bitwise.fi>, Douglas Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On 2017/3/2 6:11, Guenter Roeck wrote:
> HS400-ES devices fail to initialize with the following error messages.
>
> mmc1: power class selection to bus width 8 ddr 0 failed
> mmc1: error -110 whilst initialising MMC card
>
> This was seen on Samsung Chromebook Plus. Code analysis points to
> commit 3d4ef329757c ("mmc: core: fix multi-bit bus width without
> high-speed mode"), which attempts to set the bus width for all but
> HS200 devices unconditionally. However, for HS400-ES, the bus width
> is already selected.
>

Thanks Guenter for catching this early!

Well, I wasn't cc'ed for that patch and it was queued for just one day
without fully reviewed. And Doug pointed out the key point here, so,

Reviewed-by: Shawn Lin <shawn.lin@rock-chip.com>

btw, I think kernelci need some rk3399 platforms with hs400es
and CQ engine support for future test. I will try to find a way
to help kernelci to get some boards if possible..


> Cc: Anssi Hannula <anssi.hannula@bitwise.fi>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Fixes: 3d4ef329757c ("mmc: core: fix multi-bit bus width ...")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/mmc/core/mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7fd722868875..b502601df228 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1730,7 +1730,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>  		err = mmc_select_hs400(card);
>  		if (err)
>  			goto free_card;
> -	} else {
> +	} else if (!mmc_card_hs400es(card)) {
>  		/* Select the desired bus width optionally */
>  		err = mmc_select_bus_width(card);
>  		if (err > 0 && mmc_card_hs(card)) {
>


-- 
Best Regards
Shawn Lin
