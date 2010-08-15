From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] MMC: fix the use of kunmap_atomic() in tmio_mmc.h
Date: Sun, 15 Aug 2010 09:56:08 +0800
Message-ID: <AANLkTikSsFzHihy+P2bmvEhsT4mdpVhMYz_BdA0gPkAw@mail.gmail.com>
References: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:35076 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab0HOB4a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 14 Aug 2010 21:56:30 -0400
Received: by wwf26 with SMTP id 26so2676777wwf.1
        for <linux-mmc@vger.kernel.org>; Sat, 14 Aug 2010 18:56:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <spyro@f2s.com>, Magnus Damm <damm@opensource.se>

On Sun, Aug 15, 2010 at 4:29 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

If I understand the kunmap_atomic() thing correctly, this looks good to=
 me.

Acked-by: Eric Miao <eric.y.miao@gmail.com>


> ---
> =C2=A0drivers/mmc/host/tmio_mmc.c | =C2=A0 =C2=A07 ++++---
> =C2=A0drivers/mmc/host/tmio_mmc.h | =C2=A0 =C2=A08 +++-----
> =C2=A02 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index ee7d0a5..69d98e3 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -164,6 +164,7 @@ tmio_mmc_start_command(struct tmio_mmc_host *host=
, struct mmc_command *cmd)
> =C2=A0static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_data *data =3D host->data;
> + =C2=A0 =C2=A0 =C2=A0 void *sg_virt;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned short *buf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int count;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> @@ -173,8 +174,8 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host=
 *host)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 buf =3D (unsigned short *)(tmio_mmc_kmap_atomi=
c(host, &flags) +
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host->sg_off);
> + =C2=A0 =C2=A0 =C2=A0 sg_virt =3D tmio_mmc_kmap_atomic(host->sg_ptr,=
 &flags);
> + =C2=A0 =C2=A0 =C2=A0 buf =3D (unsigned short *)(sg_virt + host->sg_=
off);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D host->sg_ptr->length - host->sg_=
off;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (count > data->blksz)
> @@ -191,7 +192,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host=
 *host)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->sg_off +=3D count;
>
> - =C2=A0 =C2=A0 =C2=A0 tmio_mmc_kunmap_atomic(host, &flags);
> + =C2=A0 =C2=A0 =C2=A0 tmio_mmc_kunmap_atomic(sg_virt, &flags);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->sg_off =3D=3D host->sg_ptr->leng=
th)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmio_mmc_next_=
sg(host);
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.=
h
> index 64f7d5d..446f9e9 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -177,19 +177,17 @@ static inline int tmio_mmc_next_sg(struct tmio_=
mmc_host *host)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return --host->sg_len;
> =C2=A0}
>
> -static inline char *tmio_mmc_kmap_atomic(struct tmio_mmc_host *host,
> +static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long *flags)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 struct scatterlist *sg =3D host->sg_ptr;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_save(*flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return kmap_atomic(sg_page(sg), KM_BIO_SRC=
_IRQ) + sg->offset;
> =C2=A0}
>
> -static inline void tmio_mmc_kunmap_atomic(struct tmio_mmc_host *host=
,
> +static inline void tmio_mmc_kunmap_atomic(void *virt,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long *flags)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 kunmap_atomic(sg_page(host->sg_ptr), KM_BIO_SR=
C_IRQ);
> + =C2=A0 =C2=A0 =C2=A0 kunmap_atomic(virt, KM_BIO_SRC_IRQ);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0local_irq_restore(*flags);
> =C2=A0}
>
> --
> 1.7.2
>
>
