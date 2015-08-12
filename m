From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [linux-sunxi] [PATCH v3 1/3] mmc: sunxi: fix timeout in
 sunxi_mmc_oclk_onoff
Date: Wed, 12 Aug 2015 16:49:10 +0200
Message-ID: <55CB5CE6.1000303@redhat.com>
References: <cover.1439381423.git.hramrach@gmail.com>
 <7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com>
 <bdcb7ce26f359b7fedbd8559eb275c324bfb52bb.1439386047.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37660 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753492AbbHLOtO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 12 Aug 2015 10:49:14 -0400
In-Reply-To: <bdcb7ce26f359b7fedbd8559eb275c324bfb52bb.1439386047.git.hramrach@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>, linux-sunxi@googlegroups.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?David_Lanzend=c3=b6rfer?= <david.lanzendoerfer@o2s.ch>, Chen-Yu Tsai <wens@csie.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 08/12/2015 03:29 PM, Michal Suchanek wrote:
> The 250ms timeout is too short.
>
> On my system enabling the oclk takes under 50ms and disabling slightly
> over 100ms when idle. Under load disabling the clock can take over
> 350ms.
>
> This does not make mmc clock gating look like good option to have on
> sunxi but the system should not crash with mmc clock gating enabled
> nonetheless.
>
> This patch sets the timeout to 750ms.
>
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
>
> ---
> v3
>   - remove debug message

Thanks, this one looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Ulf, can you apply this one please?

Thanks & Regards,

Hans


> v2
>   - fix formatting
> ---
>   drivers/mmc/host/sunxi-mmc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index 4d3e1ff..a7b7a67 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
>
>   static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>   {
> -	unsigned long expire = jiffies + msecs_to_jiffies(250);
> +	unsigned long expire = jiffies + msecs_to_jiffies(750);
>   	u32 rval;
>
>   	rval = mmc_readl(host, REG_CLKCR);
>
