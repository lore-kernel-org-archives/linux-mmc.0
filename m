From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] mmc: sunxi: Also set SDXC_LOW_POWER_ON
Date: Mon, 25 May 2015 09:02:37 +0200
Message-ID: <5562C90D.8070507@redhat.com>
References: <cover.1432491958.git.hramrach@gmail.com> <29e003a6fb8253b1e103f341405d4e8322e3edc2.1432491958.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52115 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbEYHCk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 25 May 2015 03:02:40 -0400
In-Reply-To: <29e003a6fb8253b1e103f341405d4e8322e3edc2.1432491958.git.hramrach@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>, linux-sunxi@googlegroups.com, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?windows-1252?Q?David?= =?windows-1252?Q?_Lanzend=F6rfer?= <david.lanzendoerfer@o2s.ch>, Chen-Yu Tsai <wens@csie.org>, Peter Griffin <peter.griffin@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi,

On 24-05-15 20:04, Michal Suchanek wrote:
> The function sunxi_mmc_oclk_onoff filters out the SDXC_LOW_POWER_ON flag
> but never sets it.
>
> Set SDXC_LOW_POWER_ON when oclk is disabled.

Nack, looking at the datasheet I do not thing this patch actually
does anything, according to the datasheet setting this bit to 1 results
in: "Turn off card clock when FSM in IDLE state", iow this does mmc clock
gating on idle automatically in hardware, since we completely disable the
clock on clock-off by clearing SDXC_CARD_CLOCK_ON setting this bit on
clock-off is a nop.

We could consider actually setting this to safe power when setting the clock
on, for doing that it would be good to look at the android code and see if
it ever sets this bit and if so when.

WRT CONFIG_MMC_CLKGATE we are probably better off using SDXC_LOW_POWER_ON
then that when it is enabled. So maybe we should set SDXC_LOW_POWER_ON
based on #ifdef WRT CONFIG_MMC_CLKGATE, and have some way to tell the
mmc core to not do clock gating on this host ?

Regards,

Hans



>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>   drivers/mmc/host/sunxi-mmc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 7cdeecd..e957888 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -603,6 +603,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>
>   	if (oclk_en)
>   		rval |= SDXC_CARD_CLOCK_ON;
> +	else
> +		rval |= SDXC_LOW_POWER_ON;
>
>   	start = jiffies;
>   	end = start + msecs_to_jiffies(750);
>
