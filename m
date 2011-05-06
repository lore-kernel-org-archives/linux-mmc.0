From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 02/15] mmc: sd: query function modes for uhs cards
Date: Fri, 6 May 2011 06:37:11 -0400
Message-ID: <BANLkTimk98UutTHrw61-7e+kS86hZU0pQA@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-3-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58831 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1EFKhP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:37:15 -0400
Received: by vxi39 with SMTP id 39so3290086vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:37:15 -0700 (PDT)
In-Reply-To: <1304578151-1775-3-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:48 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> SD cards which conform to Physical Layer Spec v3.01 can support
> additional Bus Speed Modes, Driver Strength, and Current Limit
> other than the default values. We use CMD6 mode 0 to read these
> additional card functions. The values read here will be used
> during UHS-I initialization steps.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/core/sd.c =A0 =A0| =A0 69 ++++++++++++++++++++++++++++=
++++++++++++-----
> =A0include/linux/mmc/card.h | =A0 =A04 ++
> =A02 files changed, 65 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index b0cd285..d4410c9 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -189,6 +189,9 @@ static int mmc_decode_scr(struct mmc_card *card)
>
> =A0 =A0 =A0 =A0scr->sda_vsn =3D UNSTUFF_BITS(resp, 56, 4);
> =A0 =A0 =A0 =A0scr->bus_widths =3D UNSTUFF_BITS(resp, 48, 4);
> + =A0 =A0 =A0 if (scr->sda_vsn =3D=3D SCR_SPEC_VER_2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check if Physical Layer Spec v3.0 is=
 supported*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr->sda_spec3 =3D UNSTUFF_BITS(resp, 4=
7, 1);
>
> =A0 =A0 =A0 =A0if (UNSTUFF_BITS(resp, 55, 1))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->erased_byte =3D 0xFF;
> @@ -278,25 +281,75 @@ static int mmc_read_switch(struct mmc_card *car=
d)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* Find out the supported Bus Speed Modes. */
> =A0 =A0 =A0 =A0err =3D mmc_sd_switch(card, 0, 0, 1, status);
> =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If the host or the card can't do the=
 switch,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fail more gracefully. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the host or the card can't do t=
he switch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fail more gracefully.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((err !=3D -EINVAL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& (err !=3D -ENOSYS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& (err !=3D -EFAULT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (err !=3D -ENOSYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (err !=3D -EFAULT))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: problem readin=
g switch "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "capabilities, performa=
nce might suffer.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: problem readin=
g Bus Speed modes.\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(card->hos=
t));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (status[13] & 0x02)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.hs_max_dtr =3D 50000000;
> + =A0 =A0 =A0 if (card->scr.sda_spec3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.sd3_bus_mode =3D status[1=
3];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find out Driver Strengths supported =
by the card */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_switch(card, 0, 2, 1, st=
atus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the host or the=
 card can't do the switch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fail more graceful=
ly.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((err !=3D -EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (err !=3D -ENOSYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (err !=3D -EFAULT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ou=
t;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: problem reading "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Driver=
 Strength.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.sd3_drv_type =3D status[9=
];
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Find out Current Limits supported by=
 the card */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_sd_switch(card, 0, 3, 1, st=
atus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the host or the=
 card can't do the switch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* fail more graceful=
ly.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((err !=3D -EINVAL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (err !=3D -ENOSYS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (err !=3D -EFAULT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ou=
t;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: problem reading "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Curren=
t Limit.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.sd3_curr_limit =3D status=
[7];
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status[13] & 0x02)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->sw_caps.hs_max_dt=
r =3D 50000000;
> + =A0 =A0 =A0 }
>
> =A0out:
> =A0 =A0 =A0 =A0kfree(status);
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 72a9868..56f4d92 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -67,6 +67,7 @@ struct mmc_ext_csd {
>
> =A0struct sd_scr {
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 sda_vsn;
> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 sda_spec3;
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 bus_widths;
> =A0#define SD_SCR_BUS_WIDTH_1 =A0 =A0 (1<<0)
> =A0#define SD_SCR_BUS_WIDTH_4 =A0 =A0 (1<<2)
> @@ -80,6 +81,9 @@ struct sd_ssr {
>
> =A0struct sd_switch_caps {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0hs_max_dtr;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_bus_mode;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_drv_type;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0sd3_curr_limit;
> =A0};
>
> =A0struct sdio_cccr {
> --
> 1.7.1
>
>
