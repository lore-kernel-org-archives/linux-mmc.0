From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc:sdio:retry CMD52/53 when error happens
Date: Mon, 14 May 2012 17:27:24 +0530
Message-ID: <CANfBPZ_hgEks_dTBWomaj49xLiXaz-_x+rCAYjCgLQNa24WU=A@mail.gmail.com>
References: <1336984792-13956-1-git-send-email-yongd@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:37481 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755747Ab2ENL5r convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 May 2012 07:57:47 -0400
Received: by bkwj10 with SMTP id j10so4202885bkw.4
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 04:57:45 -0700 (PDT)
In-Reply-To: <1336984792-13956-1-git-send-email-yongd@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yongd <yongd@marvell.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, linux-kernel@vger.kernel.org

On Mon, May 14, 2012 at 2:09 PM, yongd <yongd@marvell.com> wrote:
> =A0Set sdio CMD52/53's retry time as MMC_CMD_RETRIES. As a result,
> sdio might benefit from core-internal CMD retry mechanism when
> some errors happen(CRC, etc).
>
> Signed-off-by: yongd <yongd@marvell.com>
> ---
> =A0drivers/mmc/core/sdio_ops.c | =A0 =A03 ++-
> =A01 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.=
c
> index d29e206..884c27e 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -86,7 +86,7 @@ static int mmc_io_rw_direct_host(struct mmc_host *h=
ost, int write, unsigned fn,
> =A0 =A0 =A0 =A0cmd.arg |=3D in;
> =A0 =A0 =A0 =A0cmd.flags =3D MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AC=
;
>
> - =A0 =A0 =A0 err =3D mmc_wait_for_cmd(host, &cmd, 0);
> + =A0 =A0 =A0 err =3D mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> @@ -147,6 +147,7 @@ int mmc_io_rw_extended(struct mmc_card *card, int=
 write, unsigned fn,
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd.arg |=3D 0x08000000 | blocks; =A0 =
=A0 =A0 =A0 /* block mode */
> =A0 =A0 =A0 =A0cmd.flags =3D MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_AD=
TC;
> + =A0 =A0 =A0 cmd.retries =3D MMC_CMD_RETRIES;
>
> =A0 =A0 =A0 =A0data.blksz =3D blksz;
> =A0 =A0 =A0 =A0/* Code in host drivers/fwk assumes that "blocks" alwa=
ys is >=3D1 */
> --

Looks right to me.
Reviewed-by: Venkatraman S <svenkatr@ti.com>
