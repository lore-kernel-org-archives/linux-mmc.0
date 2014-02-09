From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: [PATCH v4 4/7] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Sun, 9 Feb 2014 06:37:59 -0800 (PST)
Message-ID: <dac5ec28-3a6d-428f-8ab6-c8f2bb53168f@googlegroups.com>
References: <20140207212709.24624.58619.stgit@dizzy-6.o2s.ch>
 <20140207213316.24624.28705.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_168_16967048.1391956679334"
Return-path: <linux-sunxi+bncBDJLTBEBXENBBSFF32LQKGQEFARAM4Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140207213316.24624.28705.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Emilio_L=C3=B3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

------=_Part_168_16967048.1391956679334
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=C3=9Chel kenal p=C3=A4eval, R, 07.02.2014 kell 22:33, kirjutas David Lanze=
nd=C3=B6rfer:
> This is based on the driver Allwinner ships in their Android kernel=20
sources.
>=20
> Initial porting to upstream kernels done by David Lanzend=C3=B6rfer, addi=
tional
> fixes and cleanups by Hans de Goede.
>=20
> It uses dma in bus-master mode using a built-in designware idmac=20
controller,
> which is identical to the one found in the mmc-dw hosts.
> The rest of the host is not identical to mmc-dw.
>=20
> Signed-off-by: David Lanzend=C3=B6rfer=20
<david.lanzendoerfer-Z7Kmv9EsliU-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> Signed-off-by: Hans de Goede=20
<hdegoede-H+wXaHxf7aLQT0dZR+AlfA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> ---
>  drivers/mmc/host/Kconfig     |    7=20
>  drivers/mmc/host/Makefile    |    2=20
>  drivers/mmc/host/sunxi-mci.c |  871=20
++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sunxi-mci.h |  239 ++++++++++++
>  4 files changed, 1119 insertions(+)
>  create mode 100644 drivers/mmc/host/sunxi-mci.c
>  create mode 100644 drivers/mmc/host/sunxi-mci.h
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 1384f67..7caf266 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -689,3 +689,10 @@ config MMC_REALTEK_PCI
>      help
>        Say Y here to include driver code to support SD/MMC card interface
>        of Realtek PCI-E card reader
> +
> +config MMC_SUNXI
> +    tristate "Allwinner sunxi SD/MMC Host Controller support"
> +    depends on ARCH_SUNXI
> +    help
> +      This selects support for the SD/MMC Host Controller on
> +      Allwinner sunxi SoCs.
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 3483b6b..6c9cbd3 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -54,6 +54,8 @@ obj-$(CONFIG_MMC_WMT)        +=3D wmt-sdmmc.o
> =20
>  obj-$(CONFIG_MMC_REALTEK_PCI)    +=3D rtsx_pci_sdmmc.o
> =20
> +obj-$(CONFIG_MMC_SUNXI)        +=3D sunxi-mci.o
> +
>  obj-$(CONFIG_MMC_SDHCI_PLTFM)        +=3D sdhci-pltfm.o
>  obj-$(CONFIG_MMC_SDHCI_CNS3XXX)        +=3D sdhci-cns3xxx.o
>  obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)    +=3D sdhci-esdhc-imx.o
> diff --git a/drivers/mmc/host/sunxi-mci.c b/drivers/mmc/host/sunxi-mci.c
> new file mode 100644
> index 0000000..8b47c99
> --- /dev/null
> +++ b/drivers/mmc/host/sunxi-mci.c
> @@ -0,0 +1,871 @@
> +/*

[...]

> +
> +static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *smc_host)
> +{
> +    struct mmc_command *cmd =3D smc_host->mrq->cmd;
> +    struct mmc_data *data =3D smc_host->mrq->data;
> +
> +    /* For some cmds timeout is normal with sd/mmc cards */
> +    if ((smc_host->int_sum & SDXC_IntErrBit) =3D=3D SDXC_RespTimeout &&
> +            (cmd->opcode =3D=3D 5 || cmd->opcode =3D=3D 52))
Aren't these the ones defined in linux/mmc/sdio.h:
5  - SD_IO_SEND_OP_COND
52 - SD_IO_RW_DIRECT

> +        return;
> +
> +    dev_err(mmc_dev(smc_host->mmc),
> +        "smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n",
> +        smc_host->mmc->index, cmd->opcode,
> +        data ? (data->flags & MMC_DATA_WRITE ? " WR" : " RD") : "",
> +        smc_host->int_sum & SDXC_RespErr     ? " RE"     : "",
> +        smc_host->int_sum & SDXC_RespCRCErr  ? " RCE"    : "",
> +        smc_host->int_sum & SDXC_DataCRCErr  ? " DCE"    : "",
> +        smc_host->int_sum & SDXC_RespTimeout ? " RTO"    : "",
> +        smc_host->int_sum & SDXC_DataTimeout ? " DTO"    : "",
> +        smc_host->int_sum & SDXC_FIFORunErr  ? " FE"     : "",
> +        smc_host->int_sum & SDXC_HardWLocked ? " HL"     : "",
> +        smc_host->int_sum & SDXC_StartBitErr ? " SBE"    : "",
> +        smc_host->int_sum & SDXC_EndBitErr   ? " EBE"    : ""
> +        );
> +}
[...]
> +static void sunxi_mmc_set_clk_dly(struct sunxi_mmc_host *smc_host,
> +                  u32 oclk_dly, u32 sclk_dly)
> +{
> +    unsigned long iflags;
> +    struct clk_hw *hw =3D __clk_get_hw(smc_host->clk_mod);
> +
> +    spin_lock_irqsave(&smc_host->lock, iflags);
> +    clk_sunxi_mmc_phase_control(hw, sclk_dly, oclk_dly);
> +    spin_unlock_irqrestore(&smc_host->lock, iflags);
> +}
> +
> +struct sunxi_mmc_clk_dly mmc_clk_dly[MMC_CLK_MOD_NUM] =3D {
> +    { MMC_CLK_400K, 0, 7 },
> +    { MMC_CLK_25M, 0, 5 },
> +    { MMC_CLK_50M, 3, 5 },
> +    { MMC_CLK_50MDDR, 2, 4 },
> +    { MMC_CLK_50MDDR_8BIT, 2, 4 },
> +    { MMC_CLK_100M, 1, 4 },
> +    { MMC_CLK_200M, 1, 4 },

>From the looks of it, it should be static const, but apparently this was
raising a warning when David did it.. Hints anyone?

> +};
> +
> +static void sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *smc_host,
> +                   unsigned int rate)
> +{
> +    u32 newrate;
> +    u32 src_clk;
> +    u32 oclk_dly;
> +    u32 sclk_dly;
> +    u32 temp;
> +    struct sunxi_mmc_clk_dly *dly =3D NULL;
> +
> +    newrate =3D clk_round_rate(smc_host->clk_mod, rate);
> +    if (smc_host->clk_mod_rate =3D=3D newrate) {
> +        dev_dbg(mmc_dev(smc_host->mmc), "clk already %d, rounded %d\n",
> +            rate, newrate);
> +        return;
> +    }
> +
> +    dev_dbg(mmc_dev(smc_host->mmc), "setting clk to %d, rounded %d\n",
> +        rate, newrate);
> +
> +    /* setting clock rate */
> +    clk_disable(smc_host->clk_mod);
> +    clk_set_rate(smc_host->clk_mod, newrate);
> +    clk_enable(smc_host->clk_mod);
> +    smc_host->clk_mod_rate =3D newrate =3D clk_get_rate(smc_host->clk_mo=
d);
> +    dev_dbg(mmc_dev(smc_host->mmc), "clk is now %d\n", newrate);
> +
> +    sunxi_mmc_oclk_onoff(smc_host, 0);
> +    /* clear internal divider */
> +    temp =3D mci_readl(smc_host, REG_CLKCR);
> +    temp &=3D ~0xff;
> +    mci_writel(smc_host, REG_CLKCR, temp);
> +
> +    /* determine delays */
> +    if (rate <=3D 400000) {
> +        dly =3D &mmc_clk_dly[MMC_CLK_400K];
> +    } else if (rate <=3D 25000000) {
> +        dly =3D &mmc_clk_dly[MMC_CLK_25M];
> +    } else if (rate <=3D 50000000) {
> +        if (smc_host->ddr) {
> +            if (smc_host->bus_width =3D=3D 8)
> +                dly =3D &mmc_clk_dly[MMC_CLK_50MDDR_8BIT];
> +            else
> +                dly =3D &mmc_clk_dly[MMC_CLK_50MDDR];
> +        } else {
> +            dly =3D &mmc_clk_dly[MMC_CLK_50M];
> +        }
> +    } else if (rate <=3D 104000000) {
> +        dly =3D &mmc_clk_dly[MMC_CLK_100M];
> +    } else if (rate <=3D 208000000) {
> +        dly =3D &mmc_clk_dly[MMC_CLK_200M];
> +    } else {
> +        dly =3D &mmc_clk_dly[MMC_CLK_50M];
> +    }
> +
> +    oclk_dly =3D dly->oclk_dly;
> +    sclk_dly =3D dly->sclk_dly;
> +
> +    src_clk =3D clk_get_rate(clk_get_parent(smc_host->clk_mod));
> +
> +    if (src_clk >=3D 300000000 && src_clk <=3D 400000000) {
> +        if (oclk_dly)
> +            oclk_dly--;
> +        if (sclk_dly)
> +            sclk_dly--;
> +    }
> +
> +    sunxi_mmc_set_clk_dly(smc_host, oclk_dly, sclk_dly);
> +    sunxi_mmc_oclk_onoff(smc_host, 1);
> +
> +    /* oclk_onoff sets various irq status bits, clear these */
> +    mci_writel(smc_host, REG_RINTR,
> +           mci_readl(smc_host, REG_RINTR) & ~SDXC_SDIOInt);
> +}
> +

[...]

> diff --git a/drivers/mmc/host/sunxi-mci.h b/drivers/mmc/host/sunxi-mci.h
> new file mode 100644
> index 0000000..4f3c2d9
> --- /dev/null
> +++ b/drivers/mmc/host/sunxi-mci.h
> @@ -0,0 +1,239 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2014-2015 Aaron Maoye=20
<leafy.myeh-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>
> + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> + * (C) Copyright 2014-2015 David Lanzend=C3=B6rfer=20
<david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> + * (C) Copyright 2014-2015 Hans de Goede=20
<hdegoede-H+wXaHxf7aLQT0dZR+AlfA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org>

Had to take a look at the calendar...

> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef __SUNXI_MCI_H__
> +#define __SUNXI_MCI_H__
> +

[...]

> +
> +struct sunxi_idma_des {
> +    u32    config;
> +#define SDXC_IDMAC_DES0_DIC    BIT(1)  /* disable interrupt on=20
completion */
> +#define SDXC_IDMAC_DES0_LD    BIT(2)  /* last descriptor */
> +#define SDXC_IDMAC_DES0_FD    BIT(3)  /* first descriptor */
> +#define SDXC_IDMAC_DES0_CH    BIT(4)  /* chain mode */
> +#define SDXC_IDMAC_DES0_ER    BIT(5)  /* end of ring */
> +#define SDXC_IDMAC_DES0_CES    BIT(30) /* card error summary */
> +#define SDXC_IDMAC_DES0_OWN    BIT(31) /* 1-idma owns it, 0-host owns it=
=20
*/

This #define placement inside the struct looks really weird.

> +
> +    /*
> +     * If the idma-des-size-bits of property is ie 13, bufsize bits are:
> +     *  Bits  0-12: buf1 size
> +     *  Bits 13-25: buf2 size
> +     *  Bits 26-31: not used
> +     * Since we only ever set buf1 size, we can simply store it directly=
.
> +     */
> +    u32    buf_size;
> +    u32    buf_addr_ptr1;
> +    u32    buf_addr_ptr2;
> +};
> +
[...]
> +
> +#define MMC_CLK_400K            0
> +#define MMC_CLK_25M             1
> +#define MMC_CLK_50M             2
> +#define MMC_CLK_50MDDR          3
> +#define MMC_CLK_50MDDR_8BIT     4
> +#define MMC_CLK_100M            5
> +#define MMC_CLK_200M            6
> +#define MMC_CLK_MOD_NUM         7
> +
> +struct sunxi_mmc_clk_dly {
> +    u32 mode;
> +    u32 oclk_dly;
> +    u32 sclk_dly;

Do these members have to be u32? They all seem to be smaller than 10.


--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.

------=_Part_168_16967048.1391956679334
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C3=9Chel kenal p=C3=A4eval, R, 07.02.2014 kell 22:33, kir=
jutas David Lanzend=C3=B6rfer:<br>&gt; This is based on the driver Allwinne=
r ships in their Android kernel sources.<br>&gt; <br>&gt; Initial porting t=
o upstream kernels done by David Lanzend=C3=B6rfer, additional<br>&gt; fixe=
s and cleanups by Hans de Goede.<br>&gt; <br>&gt; It uses dma in bus-master=
 mode using a built-in designware idmac controller,<br>&gt; which is identi=
cal to the one found in the mmc-dw hosts.<br>&gt; The rest of the host is n=
ot identical to mmc-dw.<br>&gt; <br>&gt; Signed-off-by: David Lanzend=C3=B6=
rfer &lt;david.lanzendoerfer-Z7Kmv9EsliU-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org&gt;<br>&gt; Signe=
d-off-by: Hans de Goede &lt;hdegoede-H+wXaHxf7aLQT0dZR+AlfA-XMD5yJDbdMTcBkidbGgD4Q@public.gmane.org=
g&gt;<br>&gt; ---<br>&gt;&nbsp; drivers/mmc/host/Kconfig&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp;&nbsp;&nbsp; 7 <br>&gt;&nbsp; drivers/mmc/host/Makefile&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 2 <br>&gt;&nbsp; drivers/mmc/host/sunxi-mci=
.c |&nbsp; 871 ++++++++++++++++++++++++++++++++++++++++++<br>&gt;&nbsp; dri=
vers/mmc/host/sunxi-mci.h |&nbsp; 239 ++++++++++++<br>&gt;&nbsp; 4 files ch=
anged, 1119 insertions(+)<br>&gt;&nbsp; create mode 100644 drivers/mmc/host=
/sunxi-mci.c<br>&gt;&nbsp; create mode 100644 drivers/mmc/host/sunxi-mci.h<=
br>&gt; <br>&gt; diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/K=
config<br>&gt; index 1384f67..7caf266 100644<br>&gt; --- a/drivers/mmc/host=
/Kconfig<br>&gt; +++ b/drivers/mmc/host/Kconfig<br>&gt; @@ -689,3 +689,10 @=
@ config MMC_REALTEK_PCI<br>&gt;&nbsp; &nbsp;&nbsp;&nbsp; help<br>&gt;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp; Say Y here to include driver code to support SD=
/MMC card interface<br>&gt;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; of Realtek PCI-=
E card reader<br>&gt; +<br>&gt; +config MMC_SUNXI<br>&gt; +&nbsp;&nbsp;&nbs=
p; tristate "Allwinner sunxi SD/MMC Host Controller support"<br>&gt; +&nbsp=
;&nbsp;&nbsp; depends on ARCH_SUNXI<br>&gt; +&nbsp;&nbsp;&nbsp; help<br>&gt=
; +&nbsp;&nbsp;&nbsp; &nbsp; This selects support for the SD/MMC Host Contr=
oller on<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp; Allwinner sunxi SoCs.<br>&gt; d=
iff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile<br>&gt; i=
ndex 3483b6b..6c9cbd3 100644<br>&gt; --- a/drivers/mmc/host/Makefile<br>&gt=
; +++ b/drivers/mmc/host/Makefile<br>&gt; @@ -54,6 +54,8 @@ obj-$(CONFIG_MM=
C_WMT)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; +=3D wmt-sdmmc.o<br>&gt;&nbsp; =
<br>&gt;&nbsp; obj-$(CONFIG_MMC_REALTEK_PCI)&nbsp;&nbsp;&nbsp; +=3D rtsx_pc=
i_sdmmc.o<br>&gt;&nbsp; <br>&gt; +obj-$(CONFIG_MMC_SUNXI)&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; +=3D sunxi-mci.o<br>&gt; +<br>&gt;&nbsp; obj-$(CONFIG_M=
MC_SDHCI_PLTFM)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; +=3D sdhci-pltfm.o<br>=
&gt;&nbsp; obj-$(CONFIG_MMC_SDHCI_CNS3XXX)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; +=3D sdhci-cns3xxx.o<br>&gt;&nbsp; obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)&n=
bsp;&nbsp;&nbsp; +=3D sdhci-esdhc-imx.o<br>&gt; diff --git a/drivers/mmc/ho=
st/sunxi-mci.c b/drivers/mmc/host/sunxi-mci.c<br>&gt; new file mode 100644<=
br>&gt; index 0000000..8b47c99<br>&gt; --- /dev/null<br>&gt; +++ b/drivers/=
mmc/host/sunxi-mci.c<br>&gt; @@ -0,0 +1,871 @@<br>&gt; +/*<br><br>[...]<br>=
<br>&gt; +<br>&gt; +static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_hos=
t *smc_host)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct mmc_command *cmd=
 =3D smc_host-&gt;mrq-&gt;cmd;<br>&gt; +&nbsp;&nbsp;&nbsp; struct mmc_data =
*data =3D smc_host-&gt;mrq-&gt;data;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; =
/* For some cmds timeout is normal with sd/mmc cards */<br>&gt; +&nbsp;&nbs=
p;&nbsp; if ((smc_host-&gt;int_sum &amp; SDXC_IntErrBit) =3D=3D SDXC_RespTi=
meout &amp;&amp;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; (cmd-&gt;opcode =3D=3D 5 || cmd-&gt;opcode =3D=3D 52))<br>Aren't th=
ese the ones defined in linux/mmc/sdio.h:<br>5&nbsp; - SD_IO_SEND_OP_COND<b=
r>52 - SD_IO_RW_DIRECT<br><br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; r=
eturn;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; dev_err(mmc_dev(smc_host-&gt;m=
mc),<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "smc %d err, cmd %d,%s%=
s%s%s%s%s%s%s%s%s !!\n",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc=
_host-&gt;mmc-&gt;index, cmd-&gt;opcode,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; data ? (data-&gt;flags &amp; MMC_DATA_WRITE ? " WR" : " RD") :=
 "",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_host-&gt;int_sum &a=
mp; SDXC_RespErr&nbsp;&nbsp;&nbsp;&nbsp; ? " RE"&nbsp;&nbsp;&nbsp;&nbsp; : =
"",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_host-&gt;int_sum &am=
p; SDXC_RespCRCErr&nbsp; ? " RCE"&nbsp;&nbsp;&nbsp; : "",<br>&gt; +&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_host-&gt;int_sum &amp; SDXC_DataCRCErr&nb=
sp; ? " DCE"&nbsp;&nbsp;&nbsp; : "",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; smc_host-&gt;int_sum &amp; SDXC_RespTimeout ? " RTO"&nbsp;&nbsp;&n=
bsp; : "",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_host-&gt;int_=
sum &amp; SDXC_DataTimeout ? " DTO"&nbsp;&nbsp;&nbsp; : "",<br>&gt; +&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_host-&gt;int_sum &amp; SDXC_FIFORunErr&=
nbsp; ? " FE"&nbsp;&nbsp;&nbsp;&nbsp; : "",<br>&gt; +&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; smc_host-&gt;int_sum &amp; SDXC_HardWLocked ? " HL"&nbsp;&n=
bsp;&nbsp;&nbsp; : "",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_h=
ost-&gt;int_sum &amp; SDXC_StartBitErr ? " SBE"&nbsp;&nbsp;&nbsp; : "",<br>=
&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; smc_host-&gt;int_sum &amp; SDXC=
_EndBitErr&nbsp;&nbsp; ? " EBE"&nbsp;&nbsp;&nbsp; : ""<br>&gt; +&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; );<br>&gt; +}<br>[...]<br>&gt; +static void sunx=
i_mmc_set_clk_dly(struct sunxi_mmc_host *smc_host,<br>&gt; +&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; u32 ocl=
k_dly, u32 sclk_dly)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; unsigned long i=
flags;<br>&gt; +&nbsp;&nbsp;&nbsp; struct clk_hw *hw =3D __clk_get_hw(smc_h=
ost-&gt;clk_mod);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&=
amp;smc_host-&gt;lock, iflags);<br>&gt; +&nbsp;&nbsp;&nbsp; clk_sunxi_mmc_p=
hase_control(hw, sclk_dly, oclk_dly);<br>&gt; +&nbsp;&nbsp;&nbsp; spin_unlo=
ck_irqrestore(&amp;smc_host-&gt;lock, iflags);<br>&gt; +}<br>&gt; +<br>&gt;=
 +struct sunxi_mmc_clk_dly mmc_clk_dly[MMC_CLK_MOD_NUM] =3D {<br>&gt; +&nbs=
p;&nbsp;&nbsp; { MMC_CLK_400K, 0, 7 },<br>&gt; +&nbsp;&nbsp;&nbsp; { MMC_CL=
K_25M, 0, 5 },<br>&gt; +&nbsp;&nbsp;&nbsp; { MMC_CLK_50M, 3, 5 },<br>&gt; +=
&nbsp;&nbsp;&nbsp; { MMC_CLK_50MDDR, 2, 4 },<br>&gt; +&nbsp;&nbsp;&nbsp; { =
MMC_CLK_50MDDR_8BIT, 2, 4 },<br>&gt; +&nbsp;&nbsp;&nbsp; { MMC_CLK_100M, 1,=
 4 },<br>&gt; +&nbsp;&nbsp;&nbsp; { MMC_CLK_200M, 1, 4 },<br><br>From the l=
ooks of it, it should be static const, but apparently this was<br>raising a=
 warning when David did it.. Hints anyone?<br><br>&gt; +};<br>&gt; +<br>&gt=
; +static void sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *smc_host,<br>&=
gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp; unsigned int rate)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp=
; u32 newrate;<br>&gt; +&nbsp;&nbsp;&nbsp; u32 src_clk;<br>&gt; +&nbsp;&nbs=
p;&nbsp; u32 oclk_dly;<br>&gt; +&nbsp;&nbsp;&nbsp; u32 sclk_dly;<br>&gt; +&=
nbsp;&nbsp;&nbsp; u32 temp;<br>&gt; +&nbsp;&nbsp;&nbsp; struct sunxi_mmc_cl=
k_dly *dly =3D NULL;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; newrate =3D clk_=
round_rate(smc_host-&gt;clk_mod, rate);<br>&gt; +&nbsp;&nbsp;&nbsp; if (smc=
_host-&gt;clk_mod_rate =3D=3D newrate) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; dev_dbg(mmc_dev(smc_host-&gt;mmc), "clk already %d, rounded %d=
\n",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rate=
, newrate);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return;<br>&gt; =
+&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; dev_dbg(mmc_dev=
(smc_host-&gt;mmc), "setting clk to %d, rounded %d\n",<br>&gt; +&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; rate, newrate);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&=
nbsp; /* setting clock rate */<br>&gt; +&nbsp;&nbsp;&nbsp; clk_disable(smc_=
host-&gt;clk_mod);<br>&gt; +&nbsp;&nbsp;&nbsp; clk_set_rate(smc_host-&gt;cl=
k_mod, newrate);<br>&gt; +&nbsp;&nbsp;&nbsp; clk_enable(smc_host-&gt;clk_mo=
d);<br>&gt; +&nbsp;&nbsp;&nbsp; smc_host-&gt;clk_mod_rate =3D newrate =3D c=
lk_get_rate(smc_host-&gt;clk_mod);<br>&gt; +&nbsp;&nbsp;&nbsp; dev_dbg(mmc_=
dev(smc_host-&gt;mmc), "clk is now %d\n", newrate);<br>&gt; +<br>&gt; +&nbs=
p;&nbsp;&nbsp; sunxi_mmc_oclk_onoff(smc_host, 0);<br>&gt; +&nbsp;&nbsp;&nbs=
p; /* clear internal divider */<br>&gt; +&nbsp;&nbsp;&nbsp; temp =3D mci_re=
adl(smc_host, REG_CLKCR);<br>&gt; +&nbsp;&nbsp;&nbsp; temp &amp;=3D ~0xff;<=
br>&gt; +&nbsp;&nbsp;&nbsp; mci_writel(smc_host, REG_CLKCR, temp);<br>&gt; =
+<br>&gt; +&nbsp;&nbsp;&nbsp; /* determine delays */<br>&gt; +&nbsp;&nbsp;&=
nbsp; if (rate &lt;=3D 400000) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; dly =3D &amp;mmc_clk_dly[MMC_CLK_400K];<br>&gt; +&nbsp;&nbsp;&nbsp; } =
else if (rate &lt;=3D 25000000) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; dly =3D &amp;mmc_clk_dly[MMC_CLK_25M];<br>&gt; +&nbsp;&nbsp;&nbsp; } =
else if (rate &lt;=3D 50000000) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; if (smc_host-&gt;ddr) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; if (smc_host-&gt;bus_width =3D=3D 8)<br>&gt; +&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dly =3D=
 &amp;mmc_clk_dly[MMC_CLK_50MDDR_8BIT];<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; else<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dly =3D &amp;mmc_clk_dly[MMC_=
CLK_50MDDR];<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; } else {<br>&gt=
; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dly =3D &amp;mm=
c_clk_dly[MMC_CLK_50M];<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br=
>&gt; +&nbsp;&nbsp;&nbsp; } else if (rate &lt;=3D 104000000) {<br>&gt; +&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dly =3D &amp;mmc_clk_dly[MMC_CLK_100M];<=
br>&gt; +&nbsp;&nbsp;&nbsp; } else if (rate &lt;=3D 208000000) {<br>&gt; +&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dly =3D &amp;mmc_clk_dly[MMC_CLK_200M]=
;<br>&gt; +&nbsp;&nbsp;&nbsp; } else {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; dly =3D &amp;mmc_clk_dly[MMC_CLK_50M];<br>&gt; +&nbsp;&nbsp;&nbs=
p; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; oclk_dly =3D dly-&gt;oclk_dly;<b=
r>&gt; +&nbsp;&nbsp;&nbsp; sclk_dly =3D dly-&gt;sclk_dly;<br>&gt; +<br>&gt;=
 +&nbsp;&nbsp;&nbsp; src_clk =3D clk_get_rate(clk_get_parent(smc_host-&gt;c=
lk_mod));<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; if (src_clk &gt;=3D 3000000=
00 &amp;&amp; src_clk &lt;=3D 400000000) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; if (oclk_dly)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; oclk_dly--;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; if (sclk_dly)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; sclk_dly--;<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp=
;&nbsp;&nbsp; sunxi_mmc_set_clk_dly(smc_host, oclk_dly, sclk_dly);<br>&gt; =
+&nbsp;&nbsp;&nbsp; sunxi_mmc_oclk_onoff(smc_host, 1);<br>&gt; +<br>&gt; +&=
nbsp;&nbsp;&nbsp; /* oclk_onoff sets various irq status bits, clear these *=
/<br>&gt; +&nbsp;&nbsp;&nbsp; mci_writel(smc_host, REG_RINTR,<br>&gt; +&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; mci_readl(smc_host, REG_RINT=
R) &amp; ~SDXC_SDIOInt);<br>&gt; +}<br>&gt; +<br><br>[...]<br><br>&gt; diff=
 --git a/drivers/mmc/host/sunxi-mci.h b/drivers/mmc/host/sunxi-mci.h<br>&gt=
; new file mode 100644<br>&gt; index 0000000..4f3c2d9<br>&gt; --- /dev/null=
<br>&gt; +++ b/drivers/mmc/host/sunxi-mci.h<br>&gt; @@ -0,0 +1,239 @@<br>&g=
t; +/*<br>&gt; + * Driver for sunxi SD/MMC host controllers<br>&gt; + * (C)=
 Copyright 2014-2015 Reuuimlla Technology Co., Ltd.<br>&gt; + * (C) Copyrig=
ht 2014-2015 Aaron Maoye &lt;leafy.myeh-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@pu=
blic.gmane.org&gt;<br>&gt; + * (C) Copyright 2014-2015 O2S GmbH &lt;www.o2s=
.ch&gt;<br>&gt; + * (C) Copyright 2014-2015 David Lanzend=C3=B6rfer &lt;dav=
id.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org&gt;<br>&gt; + * (C) Copyright 2014-2015 Hans de Goe=
de &lt;hdegoede-H+wXaHxf7aLQT0dZR+AlfA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org&gt;<br><br>Had to t=
ake a look at the calendar...<br><br>&gt; + *<br>&gt; + * This program is f=
ree software; you can redistribute it and/or<br>&gt; + * modify it under th=
e terms of the GNU General Public License as<br>&gt; + * published by the F=
ree Software Foundation; either version 2 of<br>&gt; + * the License, or (a=
t your option) any later version.<br>&gt; + */<br>&gt; +<br>&gt; +#ifndef _=
_SUNXI_MCI_H__<br>&gt; +#define __SUNXI_MCI_H__<br>&gt; +<br><br>[...]<br><=
br>&gt; +<br>&gt; +struct sunxi_idma_des {<br>&gt; +&nbsp;&nbsp;&nbsp; u32&=
nbsp;&nbsp;&nbsp; config;<br>&gt; +#define SDXC_IDMAC_DES0_DIC&nbsp;&nbsp;&=
nbsp; BIT(1)&nbsp; /* disable interrupt on completion */<br>&gt; +#define S=
DXC_IDMAC_DES0_LD&nbsp;&nbsp;&nbsp; BIT(2)&nbsp; /* last descriptor */<br>&=
gt; +#define SDXC_IDMAC_DES0_FD&nbsp;&nbsp;&nbsp; BIT(3)&nbsp; /* first des=
criptor */<br>&gt; +#define SDXC_IDMAC_DES0_CH&nbsp;&nbsp;&nbsp; BIT(4)&nbs=
p; /* chain mode */<br>&gt; +#define SDXC_IDMAC_DES0_ER&nbsp;&nbsp;&nbsp; B=
IT(5)&nbsp; /* end of ring */<br>&gt; +#define SDXC_IDMAC_DES0_CES&nbsp;&nb=
sp;&nbsp; BIT(30) /* card error summary */<br>&gt; +#define SDXC_IDMAC_DES0=
_OWN&nbsp;&nbsp;&nbsp; BIT(31) /* 1-idma owns it, 0-host owns it */<br><br>=
This #define placement inside the struct looks really weird.<br><br>&gt; +<=
br>&gt; +&nbsp;&nbsp;&nbsp; /*<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;* If the i=
dma-des-size-bits of property is ie 13, bufsize bits are:<br>&gt; +&nbsp;&n=
bsp;&nbsp; &nbsp;*&nbsp; Bits&nbsp; 0-12: buf1 size<br>&gt; +&nbsp;&nbsp;&n=
bsp; &nbsp;*&nbsp; Bits 13-25: buf2 size<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;=
*&nbsp; Bits 26-31: not used<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;* Since we o=
nly ever set buf1 size, we can simply store it directly.<br>&gt; +&nbsp;&nb=
sp;&nbsp; &nbsp;*/<br>&gt; +&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; buf_si=
ze;<br>&gt; +&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; buf_addr_ptr1;<br>&gt=
; +&nbsp;&nbsp;&nbsp; u32&nbsp;&nbsp;&nbsp; buf_addr_ptr2;<br>&gt; +};<br>&=
gt; +<br>[...]<br>&gt; +<br>&gt; +#define MMC_CLK_400K&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<br>&gt; +#define MMC_CLK_25=
M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1=
<br>&gt; +#define MMC_CLK_50M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>&gt; +#define MMC_CLK_50MDDR&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3<br>&gt; +#define MMC_CLK_50MDDR_8=
BIT&nbsp;&nbsp;&nbsp;&nbsp; 4<br>&gt; +#define MMC_CLK_100M&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5<br>&gt; +#define MMC_C=
LK_200M&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6=
<br>&gt; +#define MMC_CLK_MOD_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; 7<br>&gt; +<br>&gt; +struct sunxi_mmc_clk_dly {<br>&gt; +&nbsp;&nbsp=
;&nbsp; u32 mode;<br>&gt; +&nbsp;&nbsp;&nbsp; u32 oclk_dly;<br>&gt; +&nbsp;=
&nbsp;&nbsp; u32 sclk_dly;<br><br>Do these members have to be u32? They all=
 seem to be smaller than 10.<br><br><br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups &=
quot;linux-sunxi&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
For more options, visit <a href=3D"https://groups.google.com/groups/opt_out=
">https://groups.google.com/groups/opt_out</a>.<br />

------=_Part_168_16967048.1391956679334--
