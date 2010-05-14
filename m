From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] sdio: add new function for RAW (Read after Write)
	operation
Date: Fri, 14 May 2010 14:04:17 +0300
Message-ID: <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
References: <1272403088-4727-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:34731 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0ENLES convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 May 2010 07:04:18 -0400
Received: by ywh36 with SMTP id 36so1114483ywh.4
        for <linux-mmc@vger.kernel.org>; Fri, 14 May 2010 04:04:18 -0700 (PDT)
In-Reply-To: <1272403088-4727-1-git-send-email-notasas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kalle Valo <kalle.valo@iki.fi>
Cc: Andrew Morton <akpm@linux-foundation.org>, Grazvydas Ignotas <notasas@gmail.com>, linux-mmc@vger.kernel.org

Hi Kalle,

On Wed, Apr 28, 2010 at 12:18 AM, Grazvydas Ignotas <notasas@gmail.com>=
 wrote:
> SDIO specification allows RAW (Read after Write) operation using
> IO_RW_DIRECT command (CMD52) by setting the RAW bit. This operation i=
s
> similar to ordinary read/write commands, except that both write and r=
ead
> are performed using single command/response pair. The Linux SDIO laye=
r
> already supports this internaly, only external function is missing fo=
r
> drivers to make use, which is added by this patch.
>
> This type of command is required to implement proper power save mode
> support in wl1251 wifi driver.

As wl1251 maintainer, can you confirm this is needed for wl1251 driver
to function in SDIO mode? Perhaps this could help convince Andrew to
merge this patch. Without this the chip is having problems leaving ELP
mode. Android has similar patch for G1 in it's tree for the same
reason:

http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dcommitdiff;h=3D=
74a47786f6ecbe6c1cf9fb15efe6a968451deb52

>
> Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> ---
> =A0drivers/mmc/core/sdio_io.c =A0 =A0| =A0 31 +++++++++++++++++++++++=
++++++++
> =A0include/linux/mmc/sdio_func.h | =A0 =A03 +++
> =A02 files changed, 34 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index ff27c8c..3f681be 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -406,6 +406,37 @@ void sdio_writeb(struct sdio_func *func, u8 b, u=
nsigned int addr, int *err_ret)
> =A0EXPORT_SYMBOL_GPL(sdio_writeb);
>
> =A0/**
> + * =A0 =A0 sdio_writeb_readb - write and read a byte from SDIO funct=
ion
> + * =A0 =A0 @func: SDIO function to access
> + * =A0 =A0 @b: byte to write
> + * =A0 =A0 @addr: address to write to
> + * =A0 =A0 @err_ret: optional status value from transfer
> + *
> + * =A0 =A0 Performs a RAW (Read after Write) operation as defined by=
 SDIO spec -
> + * =A0 =A0 single byte is written to address space of a given SDIO f=
unction and
> + * =A0 =A0 response is read back from the same address, both using s=
ingle request.
> + * =A0 =A0 If there is a problem with the operation, 0xff is returne=
d and
> + * =A0 =A0 @err_ret will contain the error code.
> + */
> +u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
> + =A0 =A0 =A0 unsigned int addr, int *err_ret)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 u8 val;
> +
> + =A0 =A0 =A0 BUG_ON(!func);
> +
> + =A0 =A0 =A0 ret =3D mmc_io_rw_direct(func->card, 1, func->num, addr=
, b, &val);
> + =A0 =A0 =A0 if (err_ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *err_ret =3D ret;
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D 0xff;
> +
> + =A0 =A0 =A0 return val;
> +}
> +EXPORT_SYMBOL_GPL(sdio_writeb_readb);
> +
> +/**
> =A0* =A0 =A0 sdio_memcpy_fromio - read a chunk of memory from a SDIO =
function
> =A0* =A0 =A0 @func: SDIO function to access
> =A0* =A0 =A0 @dst: buffer to store the data
> diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_f=
unc.h
> index c6c0cce..8974b19 100644
> --- a/include/linux/mmc/sdio_func.h
> +++ b/include/linux/mmc/sdio_func.h
> @@ -145,6 +145,9 @@ extern void sdio_writew(struct sdio_func *func, u=
16 b,
> =A0extern void sdio_writel(struct sdio_func *func, u32 b,
> =A0 =A0 =A0 =A0unsigned int addr, int *err_ret);
>
> +extern u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
> + =A0 =A0 =A0 unsigned int addr, int *err_ret);
> +
> =A0extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int a=
ddr,
> =A0 =A0 =A0 =A0void *src, int count);
> =A0extern int sdio_writesb(struct sdio_func *func, unsigned int addr,
> --
> 1.6.3.3
>
>
