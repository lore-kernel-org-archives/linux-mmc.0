From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: core: skip card initialization if power class
 selection fails
Date: Wed, 11 Apr 2012 17:37:25 +0530
Message-ID: <CAGxe1ZF0R0=6YKqCPNSaT_dekwg-J9WVSePpb5WDTThyCv6sPQ@mail.gmail.com>
References: <1334144122-20647-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:40882 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab2DKMH0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Apr 2012 08:07:26 -0400
Received: by qafi31 with SMTP id i31so4422178qaf.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Apr 2012 05:07:25 -0700 (PDT)
In-Reply-To: <1334144122-20647-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

On 11 April 2012 17:05, Subhash Jadavani <subhashj@codeaurora.org> wrot=
e:
> With current implementation of power class selection,
> mmc_select_powerclass() should never fail. So treat any error
> returned by this function as serious enough to skip the card
> initialization.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 26 +++++++++++++++-----------
> =A01 files changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f34afbd..5f9d98e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -722,6 +722,18 @@ static int mmc_select_powerclass(struct mmc_card=
 *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card-=
>ext_csd.generic_cmd6_time);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int width =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ddr =3D (bus_width <=3D EXT_CSD_BUS=
_WIDTH_8) ? 0 : 1;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((bus_width =3D=3D EXT_CSD_BUS_WIDTH=
_8) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (bus_width =3D=3D EXT_CSD_DDR_B=
US_WIDTH_8))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 width =3D 8;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power class selection to bu=
s width %d ddr %d"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" failed\n", mmc_hostnam=
e(card->host), width, ddr);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> @@ -1115,9 +1127,7 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_powerclass(card, ex=
t_csd_bits, ext_csd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: power c=
lass selection to bus width %d"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
" failed\n", mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
1 << bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> @@ -1149,10 +1159,7 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_pow=
erclass(card, ext_csd_bits[idx][0],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn=
ing("%s: power class selection to "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d failed\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
> @@ -1180,10 +1187,7 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_pow=
erclass(card, ext_csd_bits[idx][1],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn=
ing("%s: power class selection to "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d ddr %d failed\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width, ddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto er=
r;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,

Looks Good
Acked By: Girish K S <girish.shivananjappa@linaro.org>

> --
> 1.7.1.1
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
