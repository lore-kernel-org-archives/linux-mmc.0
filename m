From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Fri, 23 Dec 2011 21:10:26 +0530
Message-ID: <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:59969 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752901Ab1LWPk2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Dec 2011 10:40:28 -0500
In-Reply-To: <1323868927-3738-1-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrote:
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 101cd31..8215ef9 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0if (mmc_slot(host).vcc_aux_disable_is_sleep)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_slot(host).no_off =3D 1;
>
> - =A0 =A0 =A0 mmc->f_min =A0 =A0 =A0=3D OMAP_MMC_MIN_CLOCK;
> - =A0 =A0 =A0 mmc->f_max =A0 =A0 =A0=3D OMAP_MMC_MAX_CLOCK;
> + =A0 =A0 =A0 mmc->f_min =3D OMAP_MMC_MIN_CLOCK;

Stray change for f_min ?
