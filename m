From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v7 1/4] mmc: omap_hsmmc: Enable SDIO IRQ.
Date: Fri, 28 Feb 2014 22:34:44 +0530
Message-ID: <5310C1AC.5060301@ti.com>
References: <1393331866-28307-1-git-send-email-afenkart@gmail.com> <1393331866-28307-2-git-send-email-afenkart@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1393331866-28307-2-git-send-email-afenkart@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 25 February 2014 06:07 PM, Andreas Fenkart wrote:
> For now, only support SDIO interrupt if we are booted with
> DT. This is because some platforms need special quirks. And
> we don't want to add new legacy mux platform init code
> callbacks any longer as we are moving to DT based booting
> anyways.
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index a5a38cc..bd3bb0c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c

<snip>

> @@ -1705,7 +1757,18 @@ static void omap_hsmmc_debugfs(struct mmc_host *mmc)
>   #endif
>
>   #ifdef CONFIG_OF
> -static u16 omap4_reg_offset = 0x100;
> +struct of_data {
> +	u16 offset;
> +	int flags;
> +};
> +
Hi Andreas,

struct of_data declaration needs to be moved out of #ifdef CONFIG_OF
for !CONFIG_OF build.

I tried testing this patch series on am335x, I see throughput in the
range of KBs. Will give another try with Tony's version.

Thanks and Regards,
Balaji T K

> +static struct of_data omap4_data = {
> +	.offset	= 0x100,
> +};
> +static struct of_data am33xx_data = {
> +	.offset	= 0x100,
> +	.flags	= OMAP_HSMMC_SWAKEUP_MISSING,
> +};
>
>   static const struct of_device_id omap_mmc_of_match[] = {
>   	{
