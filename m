From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V6] mmc: core: Add host capability check for power class
Date: Wed, 14 Dec 2011 11:44:14 +0530
Message-ID: <CAGxe1ZH4V-KbiU6aaT+v=o7OYyickj-LOycLvOKSj6ngXPvwjw@mail.gmail.com>
References: <1323843295-25314-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1323843295-25314-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, subhashj@codeaurora.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Ignore this patch

On 14 December 2011 11:44, Girish K S <girish.shivananjappa@linaro.org>=
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
> Changes in v6:
> =A0 =A0 =A0 =A0Added the check whehter the host supports the max curr=
ent value
> =A0 =A0 =A0 =A0read from the extended csd register.
>
> Changes in v5:
> =A0 =A0 =A0 Replace break statement with appropriate return error val=
ue in
> =A0 =A0 =A0 drivers/mmc/core/mmc.c for unsupported voltage range.
>
> Changes in v4:
> =A0 =A0 =A0 updated with review comments.
>
> Changes in v3:
> =A0 =A0 =A0 updated with review comments made by chris ball. patch ge=
nerated
> =A0 =A0 =A0 by rebasing to chris balls mmc-next branch.
>
> Changes in v2:
> =A0 =A0 =A0 This patch version removes some checkpatch error
>
> Changes in v1:
> =A0 =A0 =A0 This version modifies the power_class_select function pro=
totype.
> =A0 =A0 =A0 During device enumeration, when the host tries to read th=
e extended
> =A0 =A0 =A0 csd register after switching to higher bus width, the rea=
d fails at
> =A0 =A0 =A0 higher bus width. So the power_class_select function is m=
odified to
> =A0 =A0 =A0 reuse the extended csd register values read with 1 bit bu=
s width.
>
> =A0drivers/mmc/core/mmc.c =A0 | =A0 27 +++++++++++++++++++++++++++
> =A0include/linux/mmc/card.h | =A0 =A04 ++++
> =A02 files changed, 31 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 006e932..30d1cbc 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -688,6 +688,33 @@ static int mmc_select_powerclass(struct mmc_card=
 *card,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrclass_val =3D (pwrclass_val & EXT_C=
SD_PWR_CL_4BIT_MASK) >>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_CS=
D_PWR_CL_4BIT_SHIFT;
>
> + =A0 =A0 =A0 if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrclass_val >=3D MMC_MAX_CURRENT_8=
00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_800;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURR=
ENT_600)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_600;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURR=
ENT_400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURR=
ENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_200;
> + =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_MAX_CURRENT_600) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrclass_val >=3D MMC_MAX_CURRENT_6=
00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_600;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURR=
ENT_400)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURR=
ENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_200;
> + =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_MAX_CURRENT_400) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrclass_val >=3D MMC_MAX_CURRENT_4=
00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_400;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (pwrclass_val >=3D MMC_MAX_CURR=
ENT_200)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_200;
> + =A0 =A0 =A0 } else if (card->host->caps & MMC_CAP_MAX_CURRENT_200) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pwrclass_val >=3D MMC_MAX_CURRENT_2=
00)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrclass_val =3D MMC_MA=
X_CURRENT_200;
> + =A0 =A0 =A0 } else
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
