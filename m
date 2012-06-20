From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sh_mmcif: Support MMC_SLEEP_AWAKE command
Date: Wed, 20 Jun 2012 13:54:33 +0200
Message-ID: <CAPDyKFo_my_+xQOKYooNawtJ1b3Ncm2osNg9TMN8YpftXfr+Jg@mail.gmail.com>
References: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1339534569-27923-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org, Saugata Das <saugata.das@linaro.org>, Girish Shivananjappa <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Laurent,

Your issue seem more related to a mmc protocol problem. Likely caused
by a bad patch for eMMC 4.5 poweroff notify. The patch I refer to is:
"mmc: core: Fix PowerOff Notify suspend/resume"

You may try to revert this patch and see if the same problem occurs for=
 you.

We are trying to fix the issue inserted by the above commit in a patch =
named:
"MMC-4.5 Power OFF Notify Rework", please have a look if you have the t=
ime.

Kind regards
Ulf Hansson

On 12 June 2012 22:56, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> The MMC_SLEEP_AWAKE and SD_IO_SEND_OP_COND commands share the same
> opcode. SD_IO_SEND_OP_COND isn't supported by the SH MMCIF, but
> MMC_SLEEP_AWAKE is. Discriminate between the two commands using the
> command flags, and reject SD_IO_SEND_OP_COND only.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> =A0drivers/mmc/host/sh_mmcif.c | =A0 14 ++++----------
> =A01 files changed, 4 insertions(+), 10 deletions(-)
>
> Not supporting the MMC_SLEEP_AWAKE command makes system suspend fail =
if an MMC
> or eMMC device supporting sleep/wake is connected. The issue has been=
 first
> noticed on the Armadillo 800 EVA board.
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.=
c
> index 724b35e..e32da11 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -892,21 +892,15 @@ static void sh_mmcif_request(struct mmc_host *m=
mc, struct mmc_request *mrq)
>
> =A0 =A0 =A0 =A0switch (mrq->cmd->opcode) {
> =A0 =A0 =A0 =A0/* MMCIF does not support SD/SDIO command */
> - =A0 =A0 =A0 case SD_IO_SEND_OP_COND:
> + =A0 =A0 =A0 case MMC_SLEEP_AWAKE: /* =3D SD_IO_SEND_OP_COND (5) */
> + =A0 =A0 =A0 case MMC_SEND_EXT_CSD: /* =3D SD_SEND_IF_COND (8) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((mrq->cmd->flags & MMC_CMD_MASK) !=3D=
 MMC_CMD_BCR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0case MMC_APP_CMD:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->state =3D STATE_IDLE;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mrq->cmd->error =3D -ETIMEDOUT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_request_done(mmc, mrq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> - =A0 =A0 =A0 case MMC_SEND_EXT_CSD: /* =3D SD_SEND_IF_COND (8) */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mrq->data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* send_if_cond cmd (no=
t support) */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->state =3D STATE_I=
DLE;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->cmd->error =3D -ET=
IMEDOUT;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(mmc, m=
rq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> --
> Regards,
>
> Laurent Pinchart
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
