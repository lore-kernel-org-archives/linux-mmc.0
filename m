From: amit kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH V2] mmc: core: Add host capability check for power class
Date: Thu, 15 Dec 2011 11:33:46 +0530
Message-ID: <CADGdYn5MYLD4ReuBZuF7QCkJo34aDhGsDpDWX_S3DuKNk9J85Q@mail.gmail.com>
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

On Thu, Dec 15, 2011 at 9:28 AM, Girish K S
<girish.shivananjappa@linaro.org> wrote:
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
Hi girish,

These checks can be made like ,
if (pwrclass_val > MMC_MAX_CURRENT_800)
        pwrclass_val =3D MMC_MAX_CURRENT_800;
Applicable in all below conditional checks.

Thanks,
Amit D

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
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
