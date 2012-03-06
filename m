From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: core: hs200 fixes
Date: Tue, 6 Mar 2012 18:37:31 +0530
Message-ID: <CAGxe1ZGxxLV8=w32Ka3aoTmwCkrK2yNNLj+W=mgqZG+epab56w@mail.gmail.com>
References: <1331036952-18211-1-git-send-email-subhashj@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1331036952-18211-1-git-send-email-subhashj@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On 6 March 2012 17:59, Subhash Jadavani <subhashj@codeaurora.org> wrote=
:
> This patch fixes following issues when HS200 is enabled:
>
> 1. If executing_tuning() host ops is called without mmc_host_clk_hold=
(),
> =A0 card clocks might get turned off (if MMC_CLK_GATING is enabled)
> =A0 while execute_tuning() is in progress. So this patch makes sure
> =A0 that execute_tuning() is called with mmc_host_clk_hold().
>
> 2. If host timing mode is set to HS200 mode, there should not be
> =A0 any communication with the card until execute_tuning() is complet=
ed.
> =A0 But there is a chance that CMD6 might be sent to enable set HPI_E=
N
> =A0 (of HPI_MGMT field in EXT_CSD) before execute_tuning() is called.
> =A0 So this patch moves this operation after execute_tuning() is comp=
leted.
>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 38 +++++++++++++++++++++-------------=
----
> =A01 files changed, 21 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index a480663..d36d2c4 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1030,22 +1030,6 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0* Enable HPI feature (if supported)
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (card->ext_csd.hpi) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_HPI_MGMT, 1, 0)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enablin=
g HPI failed\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(card->host));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =3D=
 1;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Compute bus speed.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0max_dtr =3D (unsigned int)-1;
> @@ -1094,9 +1078,12 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 4. execute tuning for HS200
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((host->caps2 & MMC_CAP2_HS200) &&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tuning=
)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->host->ops->execute_tuning=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_hold(card-=
>host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D card->host->op=
s->execute_tuning(card->host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_SE=
ND_TUNING_BLOCK_HS200);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_clk_release(ca=
rd->host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_warning("%s: tuning=
 execution failed\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m=
mc_hostname(card->host));
> @@ -1216,6 +1203,23 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* Enable HPI feature (if supported)
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (card->ext_csd.hpi) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_HPI_MGMT, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.generic_cmd6_time);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Enablin=
g HPI failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
mmc_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.hpi_en =3D=
 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * If cache size is higher than 0, this indicates
> =A0 =A0 =A0 =A0 * the existence of cache and it can be turned on.
> =A0 =A0 =A0 =A0 */

Reviewed-By: girish.shivananjappa@linaro.org

> --
> 1.7.1.1
>
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum.
