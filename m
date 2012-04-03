From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v1 1/1] mmc: core: fix power class selection
Date: Tue, 3 Apr 2012 20:54:41 +0530
Message-ID: <CAKLKtzew2g7bXR3Xdz448cs8O_jQHp0ybG1r1VBUTXcoh2BDwA@mail.gmail.com>
References: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:43104 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab2DCPYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Apr 2012 11:24:42 -0400
Received: by ghrr11 with SMTP id r11so1831608ghr.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 Apr 2012 08:24:41 -0700 (PDT)
In-Reply-To: <1333436158-4762-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, girish.shivananjappa@linaro.org

On 3 April 2012 12:25, Subhash Jadavani <subhashj@codeaurora.org> wrote=
:
> mmc_select_powerclass() function returns error if eMMC
> VDD level supported by host is between 2.7v to 3.2v.
>
> According to eMMC specification, valid voltage for high
> voltage cards is 2.7v to 3.6v. This patch ensures that
> 2.7v to 3.6v VDD range is treated as valid range.
>
> Also, failure to set the power class shouldn't be treated
> as fatal error because even if setting the power class
> fails, card can still work in default power class.
> If mmc_select_powerclass() returns error, just print
> the warning message and go ahead with rest of the card
> initialization.
>

Have you checked why mmc_select_powerclass returned error ? Today, in
the mmc_select_powerclass, it is just setting the value of power
class, which the eMMC expects. So, it should not fail.

Another point is that, today mmc_select_powerclass is assuming that
host can support the maximum possible power classes and it does not
check host controllers capability in driving higher current (mA). But
I think in future we need to add this check for host controller
ability and return error from mmc_select_powerclass so that
mmc_init_card can choose the next speed mode. From that perspective,
the approach to ignore the error return from mmc_select_powerclass
looks wrong.


> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 30 +++++++++++++++++-------------
> =A01 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 02914d6..54df5ad 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -695,6 +695,11 @@ static int mmc_select_powerclass(struct mmc_card=
 *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (host->ios.clock <=3D 20000000=
0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0index =3D EXT_CSD_PWR_=
CL_200_195;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 case MMC_VDD_27_28:
> + =A0 =A0 =A0 case MMC_VDD_28_29:
> + =A0 =A0 =A0 case MMC_VDD_29_30:
> + =A0 =A0 =A0 case MMC_VDD_30_31:
> + =A0 =A0 =A0 case MMC_VDD_31_32:
> =A0 =A0 =A0 =A0case MMC_VDD_32_33:
> =A0 =A0 =A0 =A0case MMC_VDD_33_34:
> =A0 =A0 =A0 =A0case MMC_VDD_34_35:
> @@ -1111,11 +1116,10 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd_bits =3D (bus_width =3D=3D MMC=
_BUS_WIDTH_8) ?
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_BUS_WIDTH_8 : EXT_CSD_BUS_WIDTH_4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_powerclass(card, ex=
t_csd_bits, ext_csd);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: power class=
 selection to bus width %d failed\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hos=
tname(card->host), 1 << bus_width);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: power c=
lass selection to bus width %d"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
" failed\n", mmc_hostname(card->host),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
1 << bus_width);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> @@ -1147,10 +1151,10 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_pow=
erclass(card, ext_csd_bits[idx][0],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"%s: power class selection to "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"bus width %d failed\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01 << bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn=
ing("%s: power class selection to "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
> @@ -1178,10 +1182,10 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_select_pow=
erclass(card, ext_csd_bits[idx][1],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"%s: power class selection to "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0"bus width %d ddr %d failed\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A01 << bus_width, ddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn=
ing("%s: power class selection to "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0"bus width %d ddr %d failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0mmc_hostname(card->host),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A01 << bus_width, ddr);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_BUS_WIDTH,
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
