From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 3/4] mmc: sunxi: Reset behavior fix
Date: Tue, 16 Dec 2014 10:57:10 +0100
Message-ID: <549001F6.5080202@redhat.com>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch> <20141216003756.15488.34861.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39666 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbaLPJ6c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 16 Dec 2014 04:58:32 -0500
In-Reply-To: <20141216003756.15488.34861.stgit@dizzy-6.o2s.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?RGF2aWQgTGFuemVuZMO2cmZlcg==?= <david.lanzendoerfer@o2s.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?B?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi,

On 16-12-14 01:37, David Lanzend=C3=B6rfer wrote:
> When there is only one DES available the DMA performs a FIFO reset an=
d waits until the reinitialization has been completed.
> Disabling the SDXC_IDMAC_DES0_DIC bit prevents the DMA from sending a=
n interrupt after it has finished this reinitialization.
>
> The flags SDXC_IDMAC_DES0_FD and SDXC_IDMAC_DES0_LD are both required=
 in order to use the controller with more than one DES.
>
> Signed-off-by: David Lanzend=C3=B6rfer <david.lanzendoerfer@o2s.ch>
> Reported-by: =E6=9D=8E=E6=83=B3 <lixiang@allwinnertech.com>
> ---
>   drivers/mmc/host/sunxi-mmc.c |   12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mm=
c.c
> index 50bd3d2..5331c88 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -310,7 +310,17 @@ static void sunxi_mmc_init_idma_des(struct sunxi=
_mmc_host *host,
>   	}
>
>   	pdes[0].config |=3D SDXC_IDMAC_DES0_FD;
> -	pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
> +
> +	/*
> +	 * When there is only one DES available the DMA performs a FIFO res=
et and waits
> +	 * until the reinitialization has been completed.
> +	 * Disabling the SDXC_IDMAC_DES0_DIC bit prevents the DMA from send=
ing an interrupt
> +	 * after it has finished this reinitialization.
> +	 */
> +	pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN;
> +	pdes[i - 1].config |=3D SDXC_IDMAC_DES0_FD;
> +	pdes[i - 1].config |=3D SDXC_IDMAC_DES0_LD;
> +	pdes[i - 1].config &=3D ~SDXC_IDMAC_DES0_DIC;
>
>   	/*
>   	 * Avoid the io-store starting the idmac hitting io-mem before the

This is wrong. For one you are starting with an assignment, so you coul=
d just as well
set all the flags you want with a single line / assignment. Besides tha=
t you're setting
the FD flag, which should only be set for the first descriptor of a tra=
nsfer, so for
multi descriptor transfers this is wrong.

Please see the patch which I send you which gets this right.

Regards,

Hans

