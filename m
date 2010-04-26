From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: mmc: sdhci.h compile error
Date: Mon, 26 Apr 2010 15:46:31 +0800
Message-ID: <g2g309424b61004260046hc2773535o2885383daf414b4b@mail.gmail.com>
References: <m2w309424b61004210443x612468b3n3caabe87e9717165@mail.gmail.com>
	 <87zl0rb20u.fsf@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:45593 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601Ab0DZHqd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 03:46:33 -0400
Received: by qyk9 with SMTP id 9so16935329qyk.1
        for <linux-mmc@vger.kernel.org>; Mon, 26 Apr 2010 00:46:32 -0700 (PDT)
In-Reply-To: <87zl0rb20u.fsf@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>

Hi, Matt

We also rename the function name to pass compile.
Besides, here is typo error drivers/mmc/host/sdhci.h, though it is not
a big deal.

Thanks

=46rom 1fbcb05dbab2e5e5de72060f0481a279fa3eda18 Mon Sep 17 00:00:00 200=
1
=46rom: Zhangfei Gao <zgao6@marvell.com>
Date: Thu, 22 Apr 2010 11:25:17 +0800
Subject: [PATCH] mmc: SDHCI_INT_DATA_MASK typo error


Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
---
 drivers/mmc/host/sdhci.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 842f46f..9ba4268 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -127,7 +127,7 @@
 #define  SDHCI_INT_DATA_MASK	(SDHCI_INT_DATA_END | SDHCI_INT_DMA_END |=
 \
 		SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL | \
 		SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_DATA_CRC | \
-		SDHCI_INT_DATA_END_BIT | SDHCI_ADMA_ERROR)
+		SDHCI_INT_DATA_END_BIT | SDHCI_INT_ADMA_ERROR)
 #define SDHCI_INT_ALL_MASK	((unsigned int)-1)

 #define SDHCI_ACMD12_ERR	0x3C
--=20
1.6.0.4



On Mon, Apr 26, 2010 at 6:28 AM, Matt Fleming <matt@console-pimps.org> =
wrote:
> On Wed, 21 Apr 2010 19:43:32 +0800, zhangfei gao <zhangfei.gao@gmail.=
com> wrote:
>>
>> There is compile error when we enable CONFIG_MMC_SDHCI_IO_ACCESSORS,
>> and include header file #include "sdhci.h"
>> error: macro "writel" passed 3 arguments, but takes just 2
>>
>
> Interesting...
>
> It was Anton Vorontsov that added this code; presumably the code has
> never been compiled for an ARM board (or any other architecture that
> #define's their I/O accessors in asm/io.h).
>
>> The writel is treated as macro and it is already defined in ARM.
>> The workaround is modify the name of ops writel.
>>
>
> It would be better if all architectures declared their I/O accessors =
as
> static inline, but I'm not volunteering to touch all those headers ;-=
)
> Renaming the SDHCI ops is definitely the easiest option. Anton, do yo=
u
> have a problem with the attached patch to rename the SDHCI accessor
> functions?
>
>> Is there anybody also see such issue, and my platform is ARM.
>
> I'm curious to know why you need to set MMC_SDHCI_IO_ACCESSORS. Does
> your board have weird I/O memory access requirements? This option is
> pretty specialized.
>

The reason is HOST_VERSION is bits [08:15] of offset 0xFE, so we have
to shifp >> 16 for SDHCI_HOST_VERSION

> --
>
> From d9c3a1666ea7597c21a68e44f3b5a2de0a6932b6 Mon Sep 17 00:00:00 200=
1
> Message-Id: <d9c3a1666ea7597c21a68e44f3b5a2de0a6932b6.1272234369.git.=
matt@console-pimps.org>
> From: Matt Fleming <matt@console-pimps.org>
> Date: Sun, 25 Apr 2010 23:14:34 +0100
> Subject: [PATCH] sdhci: Rename SDHCI I/O accessor functions
>
> Unfortunately some architectures #define their read{b,w,l} and
> write{b,w,l} I/O accessors which makes the SDHCI I/O accessor functio=
ns
> of the same names subject to preprocessing. This leads to the followi=
ng
> compiler error,
>
> In file included from drivers/mmc/host/sdhci.c:26:
> drivers/mmc/host/sdhci.h:318:35: error: macro "writel" passed 3 argum=
ents, but takes just 2
>
> Rename the SDHCI I/O functions so that CONFIG_MMC_SDHCI_IO_ACCESSORS =
can
> be enabled for architectures that implement their read{b,w,l} and
> write{b,w,l} functions with macros.
>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
> =A0drivers/mmc/host/sdhci-of-esdhc.c | =A0 12 ++++++------
> =A0drivers/mmc/host/sdhci-of-hlwd.c =A0| =A0 12 ++++++------
> =A0drivers/mmc/host/sdhci.h =A0 =A0 =A0 =A0 =A0| =A0 36 +++++++++++++=
+++++------------------
> =A03 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdh=
ci-of-esdhc.c
> index d5b11a1..c8623de 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -129,12 +129,12 @@ struct sdhci_of_data sdhci_esdhc =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_QUIRK_RESTORE_IRQS_AFTER_RES=
ET |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_QUIRK_NO_CARD_NO_RESET,
> =A0 =A0 =A0 =A0.ops =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .readl =3D sdhci_be32bs_readl,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .readw =3D esdhc_readw,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .readb =3D sdhci_be32bs_readb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .writel =3D sdhci_be32bs_writel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .writew =3D esdhc_writew,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .writeb =3D esdhc_writeb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .read_l =3D sdhci_be32bs_readl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .read_w =3D esdhc_readw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .read_b =3D sdhci_be32bs_readb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .write_l =3D sdhci_be32bs_writel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .write_w =3D esdhc_writew,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .write_b =3D esdhc_writeb,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.set_clock =3D esdhc_set_clock,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable_dma =3D esdhc_enable_dma,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.get_max_clock =3D esdhc_get_max_clock=
,
> diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhc=
i-of-hlwd.c
> index 35117f3..68ddb75 100644
> --- a/drivers/mmc/host/sdhci-of-hlwd.c
> +++ b/drivers/mmc/host/sdhci-of-hlwd.c
> @@ -55,11 +55,11 @@ struct sdhci_of_data sdhci_hlwd =3D {
> =A0 =A0 =A0 =A0.quirks =3D SDHCI_QUIRK_32BIT_DMA_ADDR |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_QUIRK_32BIT_DMA_SIZE,
> =A0 =A0 =A0 =A0.ops =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .readl =3D sdhci_be32bs_readl,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .readw =3D sdhci_be32bs_readw,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .readb =3D sdhci_be32bs_readb,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .writel =3D sdhci_hlwd_writel,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .writew =3D sdhci_hlwd_writew,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .writeb =3D sdhci_hlwd_writeb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .read_l =3D sdhci_be32bs_readl,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .read_w =3D sdhci_be32bs_readw,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .read_b =3D sdhci_be32bs_readb,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .write_l =3D sdhci_hlwd_writel,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .write_w =3D sdhci_hlwd_writew,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .write_b =3D sdhci_hlwd_writeb,
> =A0 =A0 =A0 =A0},
> =A0};
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 842f46f..68de5cf 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -294,12 +294,12 @@ struct sdhci_host {
>
> =A0struct sdhci_ops {
> =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> - =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 (*readl)(struct sdhci_host =
*host, int reg);
> - =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 (*readw)(struct sdhci_host =
*host, int reg);
> - =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*readb)(struct sdhci_hos=
t *host, int reg);
> - =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*writel)(struct sdhci_host=
 *host, u32 val, int reg);
> - =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*writew)(struct sdhci_host=
 *host, u16 val, int reg);
> - =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*writeb)(struct sdhci_host=
 *host, u8 val, int reg);
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 (*read_l)(struct sdhci_host=
 *host, int reg);
> + =A0 =A0 =A0 u16 =A0 =A0 =A0 =A0 =A0 =A0 (*read_w)(struct sdhci_host=
 *host, int reg);
> + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*read_b)(struct sdhci_ho=
st *host, int reg);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*write_l)(struct sdhci_hos=
t *host, u32 val, int reg);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*write_w)(struct sdhci_hos=
t *host, u16 val, int reg);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*write_b)(struct sdhci_hos=
t *host, u8 val, int reg);
> =A0#endif
>
> =A0 =A0 =A0 =A0void =A0 =A0(*set_clock)(struct sdhci_host *host, unsi=
gned int clock);
> @@ -314,48 +314,48 @@ struct sdhci_ops {
>
> =A0static inline void sdhci_writel(struct sdhci_host *host, u32 val, =
int reg)
> =A0{
> - =A0 =A0 =A0 if (unlikely(host->ops->writel))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->writel(host, val, reg);
> + =A0 =A0 =A0 if (unlikely(host->ops->write_l))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->write_l(host, val, reg);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writel(val, host->ioaddr + reg);
> =A0}
>
> =A0static inline void sdhci_writew(struct sdhci_host *host, u16 val, =
int reg)
> =A0{
> - =A0 =A0 =A0 if (unlikely(host->ops->writew))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->writew(host, val, reg);
> + =A0 =A0 =A0 if (unlikely(host->ops->write_w))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->write_w(host, val, reg);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writew(val, host->ioaddr + reg);
> =A0}
>
> =A0static inline void sdhci_writeb(struct sdhci_host *host, u8 val, i=
nt reg)
> =A0{
> - =A0 =A0 =A0 if (unlikely(host->ops->writeb))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->writeb(host, val, reg);
> + =A0 =A0 =A0 if (unlikely(host->ops->write_b))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->write_b(host, val, reg);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0writeb(val, host->ioaddr + reg);
> =A0}
>
> =A0static inline u32 sdhci_readl(struct sdhci_host *host, int reg)
> =A0{
> - =A0 =A0 =A0 if (unlikely(host->ops->readl))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->readl(host, reg);
> + =A0 =A0 =A0 if (unlikely(host->ops->read_l))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->read_l(host, reg);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return readl(host->ioaddr + reg);
> =A0}
>
> =A0static inline u16 sdhci_readw(struct sdhci_host *host, int reg)
> =A0{
> - =A0 =A0 =A0 if (unlikely(host->ops->readw))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->readw(host, reg);
> + =A0 =A0 =A0 if (unlikely(host->ops->read_w))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->read_w(host, reg);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return readw(host->ioaddr + reg);
> =A0}
>
> =A0static inline u8 sdhci_readb(struct sdhci_host *host, int reg)
> =A0{
> - =A0 =A0 =A0 if (unlikely(host->ops->readb))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->readb(host, reg);
> + =A0 =A0 =A0 if (unlikely(host->ops->read_b))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return host->ops->read_b(host, reg);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return readb(host->ioaddr + reg);
> =A0}
> --
> 1.6.4.rc0
>
>
