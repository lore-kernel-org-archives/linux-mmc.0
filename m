From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH V2 16/16] mmc: omap_hsmmc: add a hardware reset before initialization
Date: Fri, 6 May 2011 18:56:36 +0530
Message-ID: <BANLkTim3aZutT36j4TE9gnmpny9gN6=GUw@mail.gmail.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com> <1304673255-31634-17-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:37530 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754950Ab1EFN1R convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 May 2011 09:27:17 -0400
In-Reply-To: <1304673255-31634-17-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, May 6, 2011 at 14:44, Adrian Hunter <adrian.hunter@nokia.com> w=
rote:
> After a warm restart, an eMMC which cannot be powered off is
> in an unknown state, so reset it to be sure it will initialize.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 38 +++++++++++++++++++++++++++=
++++++++++-
> =A01 files changed, 37 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index e1c9017..70b8ef8 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -530,10 +530,25 @@ static int omap_hsmmc_gpio_init(struct omap_mmc=
_platform_data *pdata)
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].gpio_wp =3D -EINVAL;
>
> + =A0 =A0 =A0 if (gpio_is_valid(pdata->slots[0].gpio_hw_reset)) {

Not required as gpio_request takes care of it.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_request(pdata->slots[0].gp=
io_hw_reset,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
"mmc_hw_reset");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_wp;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D gpio_direction_output(pdata->sl=
ots[0].gpio_hw_reset, 1);

Use gpio_request_one instead.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_hw_reset;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].gpio_hw_reset =3D -EINV=
AL;
> +
> =A0 =A0 =A0 =A0return 0;
>
> +
> +err_free_hw_reset:
> + =A0 =A0 =A0 gpio_free(pdata->slots[0].gpio_hw_reset);
> =A0err_free_wp:
> - =A0 =A0 =A0 gpio_free(pdata->slots[0].gpio_wp);
> + =A0 =A0 =A0 if (gpio_is_valid(pdata->slots[0].gpio_wp))

Not required as gpio_free takes care of it.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->slots[0].gpio_wp);
> =A0err_free_cd:
> =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->slots[0].switch_pin))
> =A0err_free_sp:
> @@ -543,6 +558,8 @@ err_free_sp:
>
> =A0static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pd=
ata)
> =A0{
> + =A0 =A0 =A0 if (gpio_is_valid(pdata->slots[0].gpio_hw_reset))

ditto

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(pdata->slots[0].gpio_hw_reset=
);
> =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->slots[0].gpio_wp))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gpio_free(pdata->slots[0].gpio_wp);
> =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->slots[0].switch_pin))


<<snip>>
