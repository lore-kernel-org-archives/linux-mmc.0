From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH V2] mmc: core: Add host capability check for power class
Date: Thu, 15 Dec 2011 15:34:31 +0530
Message-ID: <CAKLKtzc4HDmqStQhn_J6GZxdZ0vE_vb7=+xq+oEHqp6QxYDxsg@mail.gmail.com>
References: <1323921517-31241-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1323921517-31241-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, subhashj@codeaurora.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On 15 December 2011 09:28, Girish K S <girish.shivananjappa@linaro.org>=
 wrote:
> This patch adds a check whether the host supports maximum current val=
ue
> obtained from the device's extended csd register for a selected inter=
face
> voltage and frequency.
>
> cc: Chris Ball <cjb@laptop.org>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
> ---
> Changes in v2:
> =A0 =A0 =A0 =A0deleted a unnecessary if else condition identified by =
subhash J
> Changes in v1:
> =A0 =A0 =A0 reduced the number of comparisons as per Hein's suggestio=
n
>
> =A0drivers/mmc/core/mmc.c =A0 | =A0 19 +++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A04 ++++
> =A02 files changed, 23 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 006e932..b9ef777 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -688,6 +688,25 @@ static int mmc_select_powerclass(struct mmc_card=
 *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrclass_val =3D (pwrclass_val & EXT_C=
SD_PWR_CL_4BIT_MASK) >>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_PWR_CL_4BIT_SHIFT;
>
> + =A0 =A0 =A0 if (pwrclass_val >=3D MMC_MAX_CURRENT_800)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_800;
> + =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURRENT_600)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_600;
> + =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURRENT_400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_400;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_200;
> +
> + =A0 =A0 =A0 if ((pwrclass_val =3D=3D MMC_MAX_CURRENT_800) &&
> + =A0 =A0 =A0 =A0 =A0 !(card->host->caps & MMC_CAP_MAX_CURRENT_800))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_600;
> + =A0 =A0 =A0 if ((pwrclass_val =3D=3D MMC_MAX_CURRENT_600) &&
> + =A0 =A0 =A0 =A0 =A0 !(card->host->caps & MMC_CAP_MAX_CURRENT_600))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_400;
> + =A0 =A0 =A0 if ((pwrclass_val =3D=3D MMC_MAX_CURRENT_400) &&
> + =A0 =A0 =A0 =A0 =A0 !(card->host->caps & MMC_CAP_MAX_CURRENT_400))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MAX_CURRENT_200;
> +
> =A0 =A0 =A0 =A0/* If the power class is different from the default va=
lue */
> =A0 =A0 =A0 =A0if (pwrclass_val > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,

It is not allowed to set the POWER_CLASS with any value other than
what is mentioned in the PWR_CL_ff_vvv or PWR_CL_DDR_ff_vvv  for the
corresponding frequency, voltage. That is, if PWR_CL_200_195 is 14 and
we want to operate at HS200 then the only value allowed for
POWER_CLASS is 14. So, we need to check the PWR_CL numbers and choose
the operating mode (HS200/DDR50/..) based on the platform capability
to support the current consumption and set the corresponding
POWER_CLASS value.

Please refer to section 6.6.5 of the 4.5 spec.


> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 9478a6b..c5e031a 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -195,6 +195,10 @@ struct mmc_part {
> =A0#define MMC_BLK_DATA_AREA_GP =A0 (1<<2)
> =A0};
>
> +#define MMC_MAX_CURRENT_200 =A0 =A0(0)
> +#define MMC_MAX_CURRENT_400 =A0 =A0(7)
> +#define MMC_MAX_CURRENT_600 =A0 =A0(11)
> +#define MMC_MAX_CURRENT_800 =A0 =A0(13)
> =A0/*
> =A0* MMC device
> =A0*/
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
