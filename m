From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 17:59:42 +0530
Message-ID: <CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:37911 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761738Ab2FVM3p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jun 2012 08:29:45 -0400
Received: by lbok6 with SMTP id k6so4088074lbo.4
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 05:29:42 -0700 (PDT)
In-Reply-To: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

On Fri, Jun 22, 2012 at 4:19 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> This patch reverts the commit dba3c29ea4a1d5d544.
>
> After bisecting, this commit dba3c29 is found to ruin micro-SD card d=
ata
> (writing incorrect file, or fs is corrupt after several times mount)
> on the beagle-xm revB, and reverting the commit will fix the problem.
>
> Also from TRM of OMAP3/OMAP4/DM37x, the below is mentioned about
> the Auto CMD12 Enable bit.
> =A0 =A0 =A0 =A0- SDIO does not support this feature.
> =A0 =A0 =A0 =A0- SD card only.
> Looks it is not suitable to always enable Auto CMD12 in host controll=
er
> driver.
>
> Considered that the commit is not mature enough, so ask to revert it
> first.
>

Hi Ming,
Rather than reverting the entire commit,
Can you try with the below change alone, so that AutoCMD12 can be easil=
y
enabled back when needed.

@@ -1859,7 +1859,6 @@ static int __devinit omap_hsmmc_probe(st
 	host->mapbase	=3D res->start + pdata->reg_offset;
 	host->base	=3D ioremap(host->mapbase, SZ_4K);
 	host->power_mode =3D MMC_POWER_OFF;
-	host->flags	=3D AUTO_CMD12;
 	host->next_data.cookie =3D 1;

 	platform_set_drvdata(pdev, host);

> Cc: Balaji T K <balajitk@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Buglink: https://lkml.org/lkml/2012/6/10/225
> Reported-by: Paolo Pisati <p.pisati@gmail.com>
> Reported-bisected-and-tested-by: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 15 +++------------
> =A01 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 9a7a60a..389a3ee 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -85,7 +85,6 @@
> =A0#define BRR_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 5)
> =A0#define DTO_ENABLE =A0 =A0 =A0 =A0 =A0 =A0 (1 << 20)
> =A0#define INIT_STREAM =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> -#define ACEN_ACMD12 =A0 =A0 =A0 =A0 =A0 =A0(1 << 2)
> =A0#define DP_SELECT =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 21)
> =A0#define DDIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 4)
> =A0#define DMA_EN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> @@ -117,7 +116,6 @@
> =A0#define OMAP_MMC_MAX_CLOCK =A0 =A0 52000000
> =A0#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0 =A0"omap_hsmmc"
>
> -#define AUTO_CMD12 =A0 =A0 =A0 =A0 =A0 =A0 (1 << 0) =A0 =A0 =A0 =A0/=
* Auto CMD12 support */
> =A0/*
> =A0* One controller can have multiple slots, like on some omap boards=
 using
> =A0* omap.c controller driver. Luckily this is not currently done on =
any known
> @@ -177,7 +175,6 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs_block=
ed;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_reg;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_in_pro=
gress;
> - =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0flags;
> =A0 =A0 =A0 =A0struct omap_hsmmc_next =A0next_data;
>
> =A0 =A0 =A0 =A0struct =A0omap_mmc_platform_data =A0*pdata;
> @@ -773,8 +770,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *=
host, struct mmc_command *cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmdtype =3D 0x3;
>
> =A0 =A0 =A0 =A0cmdreg =3D (cmd->opcode << 24) | (resptype << 16) | (c=
mdtype << 22);
> - =A0 =A0 =A0 if ((host->flags & AUTO_CMD12) && mmc_op_multi(cmd->opc=
ode))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdreg |=3D ACEN_ACMD12;
>
> =A0 =A0 =A0 =A0if (data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmdreg |=3D DP_SELECT | MSBS | BCE;
> @@ -847,14 +842,11 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *ho=
st, struct mmc_data *data)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->bytes_xfered =3D 0;
>
> - =A0 =A0 =A0 if (data->stop && ((!(host->flags & AUTO_CMD12)) || dat=
a->error)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_start_command(host, data->st=
op, NULL);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->stop)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->stop->resp[0] =3D=
 OMAP_HSMMC_READ(host->base,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RSP76);
> + =A0 =A0 =A0 if (!data->stop) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_request_done(host, data->mr=
q);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 omap_hsmmc_start_command(host, data->stop, NULL);
> =A0}
>
> =A0/*
> @@ -1859,7 +1851,6 @@ static int __devinit omap_hsmmc_probe(struct pl=
atform_device *pdev)
> =A0 =A0 =A0 =A0host->mapbase =A0 =3D res->start + pdata->reg_offset;
> =A0 =A0 =A0 =A0host->base =A0 =A0 =A0=3D ioremap(host->mapbase, SZ_4K=
);
> =A0 =A0 =A0 =A0host->power_mode =3D MMC_POWER_OFF;
> - =A0 =A0 =A0 host->flags =A0 =A0 =3D AUTO_CMD12;
> =A0 =A0 =A0 =A0host->next_data.cookie =3D 1;
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, host);
> --
> 1.7.9.5
>
