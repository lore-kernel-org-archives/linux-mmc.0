From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2] MMC:mmc_spi: Recover from CRC error for SD read/write
	operation over SPI.
Date: Fri, 16 Jul 2010 18:51:40 +0800
Message-ID: <AANLkTimwi7IuKZySIkDjlgBi7NDkIaW79CHNbhliJ2UY@mail.gmail.com>
References: <1278921056.22437.1.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39380 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964971Ab0GPKvm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jul 2010 06:51:42 -0400
In-Reply-To: <1278921056.22437.1.camel@eight.analog.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-mmc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>

Any comments?


Sonic

On Mon, Jul 12, 2010 at 3:50 PM, sonic zhang <sonic.adi@gmail.com> wrot=
e:
> >From 94d1ea57ac2fbe37133e25e99ccb265250f0027d Mon Sep 17 00:00:00 20=
01
> From: Sonic Zhang <sonic.zhang@analog.com>
> Date: Fri, 9 Jul 2010 15:36:20 +0800
> Subject: [PATCH v2] MMC:mmc_spi: Recover from crc error for SD read/w=
rite operation over SPI.
>
> SPI bus is not reliable on all platforms when doing large data transf=
er.
> Current mmc spi driver fails SD read/write command immediately, if
> occasional CRC error is reported by SD device. This patch makes the
> operation recover from the CRC error by doing last SD command again.
> The retry count is set to 5 to ensure the driver pass any stress test=
=2E
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
> =A0drivers/mmc/host/mmc_spi.c | =A0 22 ++++++++++++++++++++++
> =A01 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index ad847a2..8192434 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1055,6 +1055,8 @@ static void mmc_spi_request(struct mmc_host *mm=
c, struct mmc_request *mrq)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_spi_host =A0 =A0 *host =3D mmc_priv(mmc);
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D=
 -EINVAL;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crc_retry =3D=
 5;
> + =A0 =A0 =A0 struct mmc_command =A0 =A0 =A0stop;
>
> =A0#ifdef DEBUG
> =A0 =A0 =A0 =A0/* MMC core and layered drivers *MUST* issue SPI-aware=
 commands */
> @@ -1084,10 +1086,30 @@ static void mmc_spi_request(struct mmc_host *=
mmc, struct mmc_request *mrq)
> =A0 =A0 =A0 =A0}
> =A0#endif
>
> +crc_recover:
> =A0 =A0 =A0 =A0/* issue command; then optionally data and stop */
> =A0 =A0 =A0 =A0status =3D mmc_spi_command_send(host, mrq, mrq->cmd, m=
rq->data !=3D NULL);
> =A0 =A0 =A0 =A0if (status =3D=3D 0 && mrq->data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_spi_data_do(host, mrq->cmd, mrq->d=
ata, mrq->data->blksz);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* SPI bus is not reliable when doing=
 large data transfer.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If occasional crc error is reporte=
d by SD device when do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* data read/write over SPI, it can b=
e recovered by doing
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* last SD command again. The retry c=
ount is set to 5 to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ensure the driver pass any stress =
test.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mrq->data->error =3D=3D -EILSEQ && =
crc_retry) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stop.opcode =3D MMC_STO=
P_TRANSMISSION;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stop.arg =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stop.flags =3D MMC_RSP_=
SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D mmc_spi_comm=
and_send(host, mrq, &stop, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 crc_retry--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mrq->data->error =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto crc_recover;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mrq->stop)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D mmc_spi_com=
mand_send(host, mrq, mrq->stop, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> --
> 1.6.0
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
