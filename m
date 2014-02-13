From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v5 4/8] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Thu, 13 Feb 2014 15:24:07 +0800
Message-ID: <CAGb2v659FWc3qKDorJaMAZKf1KWmdbL4BU6ia+-GeKs=F+6opQ@mail.gmail.com>
References: <20140211190543.4568.83517.stgit@dizzy-6.o2s.ch> <20140211193358.4568.45603.stgit@dizzy-6.o2s.ch>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCMILY6JWQBBBLHG6GLQKGQESGXC2RI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20140211193358.4568.45603.stgit-GPtPHOohwllnsqa/0SyWJQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 12, 2014 at 3:33 AM, David Lanzend=F6rfer
<david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org> wrote:
> This is based on the driver Allwinner ships in their Android kernel sourc=
es.
>
> Initial porting to upstream kernels done by David Lanzend=F6rfer, additio=
nal
> fixes and cleanups by Hans de Goede.
>
> It uses dma in bus-master mode using a built-in designware idmac controll=
er,
> which is identical to the one found in the mmc-dw hosts.
> The rest of the host is not identical to mmc-dw.
>
> Signed-off-by: David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/mmc/host/Kconfig     |    7
>  drivers/mmc/host/Makefile    |    2
>  drivers/mmc/host/sunxi-mmc.c |  872 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/host/sunxi-mmc.h |  239 ++++++++++++
>  4 files changed, 1120 insertions(+)
>  create mode 100644 drivers/mmc/host/sunxi-mmc.c
>  create mode 100644 drivers/mmc/host/sunxi-mmc.h
>
[..]
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> new file mode 100644
> index 0000000..5fc4634
> --- /dev/null
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -0,0 +1,872 @@
> +/*
> + * Driver for sunxi SD/MMC host controllers
> + * (C) Copyright 2014-2015 Reuuimlla Technology Co., Ltd.
> + * (C) Copyright 2014-2015 Aaron Maoye <leafy.myeh-jFKXxz0WcGyYHARAtoI1EgC/G2K4zDHf@public.gmane.org>
> + * (C) Copyright 2014-2015 O2S GmbH <www.o2s.ch>
> + * (C) Copyright 2014-2015 David Lanzend=F6rfer <david.lanzendoerfer@o2s=
.ch>
> + * (C) Copyright 2014-2015 Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +
> +#include <linux/clk.h>
> +#include <linux/clk-private.h>
> +#include <linux/clk/sunxi.h>
> +
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include <linux/scatterlist.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/of_address.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_platform.h>
> +
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/sdio.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/slot-gpio.h>
> +
> +#include "sunxi-mmc.h"
> +
> +static int sunxi_mmc_init_host(struct mmc_host *mmc)
> +{
> +       u32 rval;
> +       struct sunxi_mmc_host *smc_host =3D mmc_priv(mmc);
> +       int ret;
> +
> +       ret =3D  clk_prepare_enable(smc_host->clk_ahb);
> +       if (ret) {
> +               dev_err(mmc_dev(smc_host->mmc), "AHB clk err %d\n", ret);
> +               return ret;
> +       }
> +       ret =3D  clk_prepare_enable(smc_host->clk_mod);
> +       if (ret) {
> +               dev_err(mmc_dev(smc_host->mmc), "MOD clk err %d\n", ret);
> +               clk_disable_unprepare(smc_host->clk_ahb);
> +               return ret;
> +       }
> +
> +       /* reset controller */
> +       rval =3D mci_readl(smc_host, REG_GCTRL) | SDXC_HARDWARE_RESET;
> +       mci_writel(smc_host, REG_GCTRL, rval);
> +
> +       mci_writel(smc_host, REG_FTRGL, 0x20070008);
> +       mci_writel(smc_host, REG_TMOUT, 0xffffffff);
> +       mci_writel(smc_host, REG_IMASK, smc_host->sdio_imask);
> +       mci_writel(smc_host, REG_RINTR, 0xffffffff);
> +       mci_writel(smc_host, REG_DBGC, 0xdeb);
> +       mci_writel(smc_host, REG_FUNS, 0xceaa0000);
> +       mci_writel(smc_host, REG_DLBA, smc_host->sg_dma);
> +       rval =3D mci_readl(smc_host, REG_GCTRL)|SDXC_INTERRUPT_ENABLE_BIT=
;
> +       rval &=3D ~SDXC_ACCESS_DONE_DIRECT;
> +       mci_writel(smc_host, REG_GCTRL, rval);
> +
> +       return 0;
> +}
> +
> +static void sunxi_mmc_exit_host(struct sunxi_mmc_host *smc_host)
> +{
> +       mci_writel(smc_host, REG_GCTRL, SDXC_HARDWARE_RESET);
> +       clk_disable_unprepare(smc_host->clk_ahb);
> +       clk_disable_unprepare(smc_host->clk_mod);
> +}
> +
> +/* /\* UHS-I Operation Modes */
> +/*  * DS               25MHz   12.5MB/s        3.3V */
> +/*  * HS               50MHz   25MB/s          3.3V */
> +/*  * SDR12    25MHz   12.5MB/s        1.8V */
> +/*  * SDR25    50MHz   25MB/s          1.8V */
> +/*  * SDR50    100MHz  50MB/s          1.8V */
> +/*  * SDR104   208MHz  104MB/s         1.8V */
> +/*  * DDR50    50MHz   50MB/s          1.8V */
> +/*  * MMC Operation Modes */
> +/*  * DS               26MHz   26MB/s          3/1.8/1.2V */
> +/*  * HS               52MHz   52MB/s          3/1.8/1.2V */
> +/*  * HSDDR    52MHz   104MB/s         3/1.8/1.2V */
> +/*  * HS200    200MHz  200MB/s         1.8/1.2V */
> +/*  * */
> +/*  * Spec. Timing */
> +/*  * SD3.0 */
> +/*  * Fcclk    Tcclk   Fsclk   Tsclk   Tis     Tih     odly  RTis     RT=
ih */
> +/*  * 400K     2.5us   24M     41ns    5ns     5ns     1     2209ns   41=
ns */
> +/*  * 25M      40ns    600M    1.67ns  5ns     5ns     3     14.99ns  5.=
01ns */
> +/*  * 50M      20ns    600M    1.67ns  6ns     2ns     3     14.99ns  5.=
01ns */
> +/*  * 50MDDR   20ns    600M    1.67ns  6ns     0.8ns   2     6.67ns   3.=
33ns */
> +/*  * 104M     9.6ns   600M    1.67ns  3ns     0.8ns   1     7.93ns   1.=
67ns */
> +/*  * 208M     4.8ns   600M    1.67ns  1.4ns   0.8ns   1     3.33ns   1.=
67ns */
> +
> +/*  * 25M      40ns    300M    3.33ns  5ns     5ns     2     13.34ns   6=
.66ns */
> +/*  * 50M      20ns    300M    3.33ns  6ns     2ns     2     13.34ns   6=
.66ns */
> +/*  * 50MDDR   20ns    300M    3.33ns  6ns     0.8ns   1     6.67ns    3=
.33ns */
> +/*  * 104M     9.6ns   300M    3.33ns  3ns     0.8ns   0     7.93ns    1=
.67ns */
> +/*  * 208M     4.8ns   300M    3.33ns  1.4ns   0.8ns   0     3.13ns    1=
.67ns */
> +
> +/*  * eMMC4.5 */
> +/*  * 400K     2.5us   24M     41ns    3ns     3ns     1     2209ns    4=
1ns */
> +/*  * 25M      40ns    600M    1.67ns  3ns     3ns     3     14.99ns   5=
.01ns */
> +/*  * 50M      20ns    600M    1.67ns  3ns     3ns     3     14.99ns   5=
.01ns */
> +/*  * 50MDDR   20ns    600M    1.67ns  2.5ns   2.5ns   2     6.67ns    3=
.33ns */
> +/*  * 200M     5ns     600M    1.67ns  1.4ns   0.8ns   1     3.33ns    1=
.67ns */
> +/*  *\/ */
> +
> +static void sunxi_mmc_init_idma_des(struct sunxi_mmc_host *host,
> +                                   struct mmc_data *data)
> +{
> +       struct sunxi_idma_des *pdes =3D (struct sunxi_idma_des *)host->sg=
_cpu;
> +       struct sunxi_idma_des *pdes_pa =3D (struct sunxi_idma_des *)host-=
>sg_dma;
> +       int i, max_len =3D (1 << host->idma_des_size_bits);
> +
> +       for (i =3D 0; i < data->sg_len; i++) {
> +               pdes[i].config =3D SDXC_IDMAC_DES0_CH | SDXC_IDMAC_DES0_O=
WN |
> +                                SDXC_IDMAC_DES0_DIC;
> +
> +               if (data->sg[i].length =3D=3D max_len)
> +                       pdes[i].buf_size =3D 0; /* 0 =3D=3D max_len */
> +               else
> +                       pdes[i].buf_size =3D data->sg[i].length;
> +
> +               pdes[i].buf_addr_ptr1 =3D sg_dma_address(&data->sg[i]);
> +               pdes[i].buf_addr_ptr2 =3D (u32)&pdes_pa[i + 1];
> +       }
> +
> +       pdes[0].config |=3D SDXC_IDMAC_DES0_FD;
> +       pdes[i - 1].config =3D SDXC_IDMAC_DES0_OWN | SDXC_IDMAC_DES0_LD;
> +
> +       wmb(); /* Ensure idma_des hit main mem before we start the idmac =
*/
> +}
> +
> +static enum dma_data_direction sunxi_mmc_get_dma_dir(struct mmc_data *da=
ta)
> +{
> +       if (data->flags & MMC_DATA_WRITE)
> +               return DMA_TO_DEVICE;
> +       else
> +               return DMA_FROM_DEVICE;
> +}
> +
> +static int sunxi_mmc_prepare_dma(struct sunxi_mmc_host *smc_host,
> +                                struct mmc_data *data)
> +{
> +       u32 dma_len;
> +       u32 i;
> +       u32 temp;
> +       struct scatterlist *sg;
> +
> +       dma_len =3D dma_map_sg(mmc_dev(smc_host->mmc), data->sg, data->sg=
_len,
> +                            sunxi_mmc_get_dma_dir(data));
> +       if (dma_len =3D=3D 0) {
> +               dev_err(mmc_dev(smc_host->mmc), "dma_map_sg failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       for_each_sg(data->sg, sg, data->sg_len, i) {
> +               if (sg->offset & 3 || sg->length & 3) {
> +                       dev_err(mmc_dev(smc_host->mmc),
> +                               "unaligned scatterlist: os %x length %d\n=
",
> +                               sg->offset, sg->length);
> +                       return -EINVAL;
> +               }
> +       }
> +
> +       sunxi_mmc_init_idma_des(smc_host, data);
> +
> +       temp =3D mci_readl(smc_host, REG_GCTRL);
> +       temp |=3D SDXC_DMA_ENABLE_BIT;
> +       mci_writel(smc_host, REG_GCTRL, temp);
> +       temp |=3D SDXC_DMA_RESET;
> +       mci_writel(smc_host, REG_GCTRL, temp);
> +       mci_writel(smc_host, REG_DMAC, SDXC_IDMAC_SOFT_RESET);
> +
> +       if (!(data->flags & MMC_DATA_WRITE))
> +               mci_writel(smc_host, REG_IDIE, SDXC_IDMAC_RECEIVE_INTERRU=
PT);
> +
> +       mci_writel(smc_host, REG_DMAC, SDXC_IDMAC_FIX_BURST | SDXC_IDMAC_=
IDMA_ON);
> +
> +       return 0;
> +}
> +
> +static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
> +                                      struct mmc_request *req)
> +{
> +       u32 cmd_val =3D SDXC_START | SDXC_RESPONSE_EXPIRE | SDXC_STOP_ABO=
RT_CMD
> +                       | SDXC_CHECK_RESPONSE_CRC | MMC_STOP_TRANSMISSION=
;
> +       u32 ri =3D 0;
> +       unsigned long expire =3D jiffies + msecs_to_jiffies(1000);
> +
> +       mci_writel(host, REG_CARG, 0);
> +       mci_writel(host, REG_CMDR, cmd_val);
> +
> +       do {
> +               ri =3D mci_readl(host, REG_RINTR);
> +       } while (!(ri & (SDXC_COMMAND_DONE | SDXC_INTERRUPT_ERROR_BIT)) &=
&
> +                time_before(jiffies, expire));
> +
> +       if (ri & SDXC_INTERRUPT_ERROR_BIT) {
> +               dev_err(mmc_dev(host->mmc), "send stop command failed\n")=
;
> +               if (req->stop)
> +                       req->stop->resp[0] =3D -ETIMEDOUT;
> +       } else {
> +               if (req->stop)
> +                       req->stop->resp[0] =3D mci_readl(host, REG_RESP0)=
;
> +       }
> +
> +       mci_writel(host, REG_RINTR, 0xffff);
> +}
> +
> +static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *smc_host)
> +{
> +       struct mmc_command *cmd =3D smc_host->mrq->cmd;
> +       struct mmc_data *data =3D smc_host->mrq->data;
> +
> +       /* For some cmds timeout is normal with sd/mmc cards */
> +       if ((smc_host->int_sum & SDXC_INTERRUPT_ERROR_BIT) =3D=3D SDXC_RE=
SPONSE_TIMEOUT &&
> +                       (cmd->opcode =3D=3D SD_IO_SEND_OP_COND || cmd->op=
code =3D=3D SD_IO_RW_DIRECT))
> +               return;
> +
> +       dev_err(mmc_dev(smc_host->mmc),
> +               "smc %d err, cmd %d,%s%s%s%s%s%s%s%s%s%s !!\n",
> +               smc_host->mmc->index, cmd->opcode,
> +               data ? (data->flags & MMC_DATA_WRITE ? " WR" : " RD") : "=
",
> +               smc_host->int_sum & SDXC_RESPONSE_ERROR     ? " RE"     :=
 "",
> +               smc_host->int_sum & SDXC_RESPONSE_CRC_ERROR  ? " RCE"    =
: "",
> +               smc_host->int_sum & SDXC_DATA_CRC_ERROR  ? " DCE"    : ""=
,
> +               smc_host->int_sum & SDXC_RESPONSE_TIMEOUT ? " RTO"    : "=
",
> +               smc_host->int_sum & SDXC_DATA_TIMEOUT ? " DTO"    : "",
> +               smc_host->int_sum & SDXC_FIFO_RUN_ERROR  ? " FE"     : ""=
,
> +               smc_host->int_sum & SDXC_HARD_WARE_LOCKED ? " HL"     : "=
",
> +               smc_host->int_sum & SDXC_START_BIT_ERROR ? " SBE"    : ""=
,
> +               smc_host->int_sum & SDXC_END_BIT_ERROR   ? " EBE"    : ""
> +               );
> +}
> +
> +static void sunxi_mmc_finalize_request(struct sunxi_mmc_host *host)
> +{
> +       struct mmc_request *mrq;
> +       unsigned long iflags;
> +
> +       spin_lock_irqsave(&host->lock, iflags);
> +
> +       mrq =3D host->mrq;
> +       if (!mrq) {
> +               spin_unlock_irqrestore(&host->lock, iflags);
> +               dev_err(mmc_dev(host->mmc), "no request to finalize\n");
> +               return;
> +       }
> +
> +       if (host->int_sum & SDXC_INTERRUPT_ERROR_BIT) {
> +               sunxi_mmc_dump_errinfo(host);
> +               mrq->cmd->error =3D -ETIMEDOUT;
> +               if (mrq->data)
> +                       mrq->data->error =3D -ETIMEDOUT;
> +               if (mrq->stop)
> +                       mrq->stop->error =3D -ETIMEDOUT;
> +       } else {
> +               if (mrq->cmd->flags & MMC_RSP_136) {
> +                       mrq->cmd->resp[0] =3D mci_readl(host, REG_RESP3);
> +                       mrq->cmd->resp[1] =3D mci_readl(host, REG_RESP2);
> +                       mrq->cmd->resp[2] =3D mci_readl(host, REG_RESP1);
> +                       mrq->cmd->resp[3] =3D mci_readl(host, REG_RESP0);
> +               } else {
> +                       mrq->cmd->resp[0] =3D mci_readl(host, REG_RESP0);
> +               }
> +               if (mrq->data)
> +                       mrq->data->bytes_xfered =3D
> +                               mrq->data->blocks * mrq->data->blksz;
> +       }
> +
> +       if (mrq->data) {
> +               struct mmc_data *data =3D mrq->data;
> +               u32 temp;
> +
> +               mci_writel(host, REG_IDST, 0x337);
> +               mci_writel(host, REG_DMAC, 0);
> +               temp =3D mci_readl(host, REG_GCTRL);
> +               mci_writel(host, REG_GCTRL, temp|SDXC_DMA_RESET);
> +               temp &=3D ~SDXC_DMA_ENABLE_BIT;
> +               mci_writel(host, REG_GCTRL, temp);
> +               temp |=3D SDXC_FIFO_RESET;
> +               mci_writel(host, REG_GCTRL, temp);
> +               dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
> +                                    sunxi_mmc_get_dma_dir(data));
> +       }
> +
> +       mci_writel(host, REG_RINTR, 0xffff);
> +
> +       dev_dbg(mmc_dev(host->mmc), "req done, resp %08x %08x %08x %08x\n=
",
> +               mrq->cmd->resp[0], mrq->cmd->resp[1],
> +               mrq->cmd->resp[2], mrq->cmd->resp[3]);
> +
> +       host->mrq =3D NULL;
> +       host->int_sum =3D 0;
> +       host->wait_dma =3D 0;
> +
> +       spin_unlock_irqrestore(&host->lock, iflags);
> +
> +       if (mrq->data && mrq->data->error) {
> +               dev_err(mmc_dev(host->mmc),
> +                       "data error, sending stop command\n");
> +               sunxi_mmc_send_manual_stop(host, mrq);
> +       }
> +
> +       mmc_request_done(host->mmc, mrq);
> +}
> +
> +static irqreturn_t sunxi_mmc_irq(int irq, void *dev_id)
> +{
> +       struct sunxi_mmc_host *host =3D dev_id;
> +       u32 finalize =3D 0;
> +       u32 sdio_int =3D 0;
> +       u32 msk_int;
> +       u32 idma_int;
> +
> +       spin_lock(&host->lock);
> +
> +       idma_int  =3D mci_readl(host, REG_IDST);
> +       msk_int   =3D mci_readl(host, REG_MISTA);
> +
> +       dev_dbg(mmc_dev(host->mmc), "irq: rq %p mi %08x idi %08x\n",
> +               host->mrq, msk_int, idma_int);
> +
> +       if (host->mrq) {
> +               if (idma_int & SDXC_IDMAC_RECEIVE_INTERRUPT)
> +                       host->wait_dma =3D 0;
> +
> +               host->int_sum |=3D msk_int;
> +
> +               /* Wait for COMMAND_DONE on RESPONSE_TIMEOUT before finis=
hing the req */
> +               if ((host->int_sum & SDXC_RESPONSE_TIMEOUT) &&
> +                               !(host->int_sum & SDXC_COMMAND_DONE))
> +                       mci_writel(host, REG_IMASK,
> +                                  host->sdio_imask | SDXC_COMMAND_DONE);
> +               else if (host->int_sum & SDXC_INTERRUPT_ERROR_BIT)
> +                       finalize =3D 1; /* Don't wait for dma on error */
> +               else if (host->int_sum & SDXC_INTERRUPT_DONE_BIT && !host=
->wait_dma)
> +                       finalize =3D 1; /* Done */
> +
> +               if (finalize) {
> +                       mci_writel(host, REG_IMASK, host->sdio_imask);
> +                       mci_writel(host, REG_IDIE, 0);
> +               }
> +       }
> +
> +       if (msk_int & SDXC_SDIO_INTERRUPT)
> +               sdio_int =3D 1;
> +
> +       mci_writel(host, REG_RINTR, msk_int);
> +       mci_writel(host, REG_IDST, idma_int);
> +
> +       spin_unlock(&host->lock);
> +
> +       if (finalize)
> +               tasklet_schedule(&host->tasklet);
> +
> +       if (sdio_int)
> +               mmc_signal_sdio_irq(host->mmc);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static void sunxi_mmc_tasklet(unsigned long data)
> +{
> +       struct sunxi_mmc_host *smc_host =3D (struct sunxi_mmc_host *) dat=
a;
> +       sunxi_mmc_finalize_request(smc_host);
> +}
> +
> +static void sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_e=
n)
> +{
> +       unsigned long expire =3D jiffies + msecs_to_jiffies(2000);
> +       u32 rval;
> +
> +       rval =3D mci_readl(host, REG_CLKCR);
> +       rval &=3D ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON);
> +
> +       if (oclk_en)
> +               rval |=3D SDXC_CARD_CLOCK_ON;
> +
> +       if (!host->io_flag)
> +               rval |=3D SDXC_LOW_POWER_ON;
> +
> +       mci_writel(host, REG_CLKCR, rval);
> +
> +       rval =3D SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
> +       if (host->voltage_switching)
> +               rval |=3D SDXC_VOLTAGE_SWITCH;
> +       mci_writel(host, REG_CMDR, rval);
> +
> +       do {
> +               rval =3D mci_readl(host, REG_CMDR);
> +       } while (time_before(jiffies, expire) && (rval & SDXC_START));
> +
> +       if (rval & SDXC_START) {
> +               dev_err(mmc_dev(host->mmc), "fatal err update clk timeout=
\n");
> +               host->ferror =3D 1;
> +       }
> +}
> +
> +static void sunxi_mmc_set_clk_dly(struct sunxi_mmc_host *smc_host,
> +                                 u32 oclk_dly, u32 sclk_dly)
> +{
> +       unsigned long iflags;
> +       struct clk_hw *hw =3D __clk_get_hw(smc_host->clk_mod);
> +
> +       spin_lock_irqsave(&smc_host->lock, iflags);
> +       clk_sunxi_mmc_phase_control(hw, sclk_dly, oclk_dly);
> +       spin_unlock_irqrestore(&smc_host->lock, iflags);
> +}
> +
> +struct sunxi_mmc_clk_dly mmc_clk_dly[MMC_CLK_MOD_NUM] =3D {
> +       { MMC_CLK_400K, 0, 7 },
> +       { MMC_CLK_25M, 0, 5 },
> +       { MMC_CLK_50M, 3, 5 },
> +       { MMC_CLK_50MDDR, 2, 4 },
> +       { MMC_CLK_50MDDR_8BIT, 2, 4 },
> +       { MMC_CLK_100M, 1, 4 },
> +       { MMC_CLK_200M, 1, 4 },
> +};
> +
> +static void sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *smc_host,
> +                                  unsigned int rate)
> +{
> +       u32 newrate;
> +       u32 src_clk;
> +       u32 oclk_dly;
> +       u32 sclk_dly;
> +       u32 temp;
> +       struct sunxi_mmc_clk_dly *dly =3D NULL;
> +
> +       newrate =3D clk_round_rate(smc_host->clk_mod, rate);
> +       if (smc_host->clk_mod_rate =3D=3D newrate) {
> +               dev_dbg(mmc_dev(smc_host->mmc), "clk already %d, rounded =
%d\n",
> +                       rate, newrate);
> +               return;
> +       }
> +
> +       dev_dbg(mmc_dev(smc_host->mmc), "setting clk to %d, rounded %d\n"=
,
> +               rate, newrate);
> +
> +       /* setting clock rate */
> +       clk_disable(smc_host->clk_mod);
> +       clk_set_rate(smc_host->clk_mod, newrate);
> +       clk_enable(smc_host->clk_mod);
> +       smc_host->clk_mod_rate =3D newrate =3D clk_get_rate(smc_host->clk=
_mod);
> +       dev_dbg(mmc_dev(smc_host->mmc), "clk is now %d\n", newrate);
> +
> +       sunxi_mmc_oclk_onoff(smc_host, 0);
> +       /* clear internal divider */
> +       temp =3D mci_readl(smc_host, REG_CLKCR);
> +       temp &=3D ~0xff;
> +       mci_writel(smc_host, REG_CLKCR, temp);
> +
> +       /* determine delays */
> +       if (rate <=3D 400000) {
> +               dly =3D &mmc_clk_dly[MMC_CLK_400K];
> +       } else if (rate <=3D 25000000) {
> +               dly =3D &mmc_clk_dly[MMC_CLK_25M];
> +       } else if (rate <=3D 50000000) {
> +               if (smc_host->ddr) {
> +                       if (smc_host->bus_width =3D=3D 8)
> +                               dly =3D &mmc_clk_dly[MMC_CLK_50MDDR_8BIT]=
;
> +                       else
> +                               dly =3D &mmc_clk_dly[MMC_CLK_50MDDR];
> +               } else {
> +                       dly =3D &mmc_clk_dly[MMC_CLK_50M];
> +               }
> +       } else if (rate <=3D 104000000) {
> +               dly =3D &mmc_clk_dly[MMC_CLK_100M];
> +       } else if (rate <=3D 208000000) {
> +               dly =3D &mmc_clk_dly[MMC_CLK_200M];
> +       } else {
> +               dly =3D &mmc_clk_dly[MMC_CLK_50M];
> +       }
> +
> +       oclk_dly =3D dly->oclk_dly;
> +       sclk_dly =3D dly->sclk_dly;
> +
> +       src_clk =3D clk_get_rate(clk_get_parent(smc_host->clk_mod));
> +
> +       if (src_clk >=3D 300000000 && src_clk <=3D 400000000) {
> +               if (oclk_dly)
> +                       oclk_dly--;
> +               if (sclk_dly)
> +                       sclk_dly--;
> +       }
> +
> +       sunxi_mmc_set_clk_dly(smc_host, oclk_dly, sclk_dly);
> +       sunxi_mmc_oclk_onoff(smc_host, 1);
> +
> +       /* oclk_onoff sets various irq status bits, clear these */
> +       mci_writel(smc_host, REG_RINTR,
> +                  mci_readl(smc_host, REG_RINTR) & ~SDXC_SDIO_INTERRUPT)=
;
> +}
> +
> +static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +       u32 temp;
> +       s32 err;
> +
> +       /* Set the power state */
> +       switch (ios->power_mode) {
> +       case MMC_POWER_ON:
> +               break;
> +
> +       case MMC_POWER_UP:
> +               if (!IS_ERR(host->vmmc)) {
> +                       mmc_regulator_set_ocr(host->mmc, host->vmmc, ios-=
>vdd);
> +                       udelay(200);
> +               }
> +
> +               err =3D sunxi_mmc_init_host(mmc);
> +               if (err) {
> +                       host->ferror =3D 1;
> +                       return;
> +               }
> +               enable_irq(host->irq);
> +
> +               dev_dbg(mmc_dev(host->mmc), "power on!\n");
> +               host->ferror =3D 0;
> +               break;
> +
> +       case MMC_POWER_OFF:
> +               dev_dbg(mmc_dev(host->mmc), "power off!\n");
> +               disable_irq(host->irq);
> +               sunxi_mmc_exit_host(host);
> +               if (!IS_ERR(host->vmmc))
> +                       mmc_regulator_set_ocr(host->mmc, host->vmmc, 0);
> +               host->ferror =3D 0;
> +               break;
> +       }
> +
> +       /* set bus width */
> +       switch (ios->bus_width) {
> +       case MMC_BUS_WIDTH_1:
> +               mci_writel(host, REG_WIDTH, SDXC_WIDTH1);
> +               host->bus_width =3D 1;
> +               break;
> +       case MMC_BUS_WIDTH_4:
> +               mci_writel(host, REG_WIDTH, SDXC_WIDTH4);
> +               host->bus_width =3D 4;
> +               break;
> +       case MMC_BUS_WIDTH_8:
> +               mci_writel(host, REG_WIDTH, SDXC_WIDTH8);
> +               host->bus_width =3D 8;
> +               break;
> +       }
> +
> +       /* set ddr mode */
> +       temp =3D mci_readl(host, REG_GCTRL);
> +       if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50) {
> +               temp |=3D SDXC_DDR_MODE;
> +               host->ddr =3D 1;
> +       } else {
> +               temp &=3D ~SDXC_DDR_MODE;
> +               host->ddr =3D 0;
> +       }
> +       mci_writel(host, REG_GCTRL, temp);
> +
> +       /* set up clock */
> +       if (ios->clock && ios->power_mode) {
> +               dev_dbg(mmc_dev(host->mmc), "ios->clock: %d\n", ios->cloc=
k);
> +               sunxi_mmc_clk_set_rate(host, ios->clock);
> +               usleep_range(50000, 55000);
> +       }
> +}
> +
> +static void sunxi_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       struct sunxi_mmc_host *smc_host =3D mmc_priv(mmc);
> +       unsigned long flags;
> +       u32 imask;
> +
> +       spin_lock_irqsave(&smc_host->lock, flags);
> +       imask =3D mci_readl(smc_host, REG_IMASK);
> +       if (enable) {
> +               smc_host->sdio_imask =3D SDXC_SDIO_INTERRUPT;
> +               imask |=3D SDXC_SDIO_INTERRUPT;
> +       } else {
> +               smc_host->sdio_imask =3D 0;
> +               imask &=3D ~SDXC_SDIO_INTERRUPT;
> +       }
> +       mci_writel(smc_host, REG_IMASK, imask);
> +       spin_unlock_irqrestore(&smc_host->lock, flags);
> +}
> +
> +static void sunxi_mmc_hw_reset(struct mmc_host *mmc)
> +{
> +       struct sunxi_mmc_host *smc_host =3D mmc_priv(mmc);
> +       mci_writel(smc_host, REG_HWRST, 0);
> +       udelay(10);
> +       mci_writel(smc_host, REG_HWRST, 1);
> +       udelay(300);
> +}
> +
> +static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *=
mrq)
> +{
> +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +       struct mmc_command *cmd =3D mrq->cmd;
> +       struct mmc_data *data =3D mrq->data;
> +       unsigned long iflags;
> +       u32 imask =3D SDXC_INTERRUPT_ERROR_BIT;
> +       u32 cmd_val =3D SDXC_START | (cmd->opcode & 0x3f);
> +       u32 byte_cnt =3D 0;
> +       int ret;
> +
> +       if (!mmc_gpio_get_cd(mmc) || host->ferror) {
> +               dev_dbg(mmc_dev(host->mmc), "no medium present\n");
> +               mrq->cmd->error =3D -ENOMEDIUM;
> +               mmc_request_done(mmc, mrq);
> +               return;
> +       }
> +
> +       if (data) {
> +               byte_cnt =3D data->blksz * data->blocks;
> +               mci_writel(host, REG_BLKSZ, data->blksz);
> +               mci_writel(host, REG_BCNTR, byte_cnt);
> +               ret =3D sunxi_mmc_prepare_dma(host, data);
> +               if (ret < 0) {
> +                       dev_err(mmc_dev(host->mmc), "prepare DMA failed\n=
");
> +                       cmd->error =3D ret;
> +                       cmd->data->error =3D ret;
> +                       mmc_request_done(host->mmc, mrq);
> +                       return;
> +               }
> +       }
> +
> +       if (cmd->opcode =3D=3D MMC_GO_IDLE_STATE) {
> +               cmd_val |=3D SDXC_SEND_INIT_SEQUENCE;
> +               imask |=3D SDXC_COMMAND_DONE;
> +       }
> +
> +       if (cmd->opcode =3D=3D SD_SWITCH_VOLTAGE) {
> +               cmd_val |=3D SDXC_VOLTAGE_SWITCH;
> +               imask |=3D SDXC_VOLTAGE_CHANGE_DONE;
> +               host->voltage_switching =3D 1;
> +               sunxi_mmc_oclk_onoff(host, 1);
> +       }
> +
> +       if (cmd->flags & MMC_RSP_PRESENT) {
> +               cmd_val |=3D SDXC_RESPONSE_EXPIRE;
> +               if (cmd->flags & MMC_RSP_136)
> +                       cmd_val |=3D SDXC_LONG_RESPONSE;
> +               if (cmd->flags & MMC_RSP_CRC)
> +                       cmd_val |=3D SDXC_CHECK_RESPONSE_CRC;
> +
> +               if ((cmd->flags & MMC_CMD_MASK) =3D=3D MMC_CMD_ADTC) {
> +                       cmd_val |=3D SDXC_DATA_EXPIRE | SDXC_WAIT_PRE_OVE=
R;
> +                       if (cmd->data->flags & MMC_DATA_STREAM) {
> +                               imask |=3D SDXC_AUTO_COMMAND_DONE;
> +                               cmd_val |=3D SDXC_SEQUENCE_MODE | SDXC_SE=
ND_AUTO_STOP;
> +                       }
> +                       if (cmd->data->stop) {
> +                               imask |=3D SDXC_AUTO_COMMAND_DONE;
> +                               cmd_val |=3D SDXC_SEND_AUTO_STOP;
> +                       } else
> +                               imask |=3D SDXC_DATA_OVER;
> +
> +                       if (cmd->data->flags & MMC_DATA_WRITE)
> +                               cmd_val |=3D SDXC_WRITE;
> +                       else
> +                               host->wait_dma =3D 1;
> +               } else
> +                       imask |=3D SDXC_COMMAND_DONE;
> +       } else
> +               imask |=3D SDXC_COMMAND_DONE;
> +
> +       dev_dbg(mmc_dev(host->mmc), "cmd %d(%08x) arg %x ie 0x%08x len %d=
\n",
> +               cmd_val & 0x3f, cmd_val, cmd->arg, imask,
> +               mrq->data ? mrq->data->blksz * mrq->data->blocks : 0);
> +
> +       spin_lock_irqsave(&host->lock, iflags);
> +       host->mrq =3D mrq;
> +       mci_writel(host, REG_IMASK, host->sdio_imask | imask);
> +       spin_unlock_irqrestore(&host->lock, iflags);
> +
> +       mci_writel(host, REG_CARG, cmd->arg);
> +       mci_writel(host, REG_CMDR, cmd_val);
> +}
> +
> +static const struct of_device_id sunxi_mmc_of_match[] =3D {
> +       { .compatible =3D "allwinner,sun4i-a10-mmc", },
> +       { .compatible =3D "allwinner,sun5i-a13-mmc", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
> +
> +static struct mmc_host_ops sunxi_mmc_ops =3D {
> +       .request         =3D sunxi_mmc_request,
> +       .set_ios         =3D sunxi_mmc_set_ios,
> +       .get_ro          =3D mmc_gpio_get_ro,
> +       .get_cd          =3D mmc_gpio_get_cd,
> +       .enable_sdio_irq =3D sunxi_mmc_enable_sdio_irq,
> +       .hw_reset        =3D sunxi_mmc_hw_reset,
> +};
> +
> +static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
> +                                     struct platform_device *pdev)
> +{
> +       struct device_node *np =3D pdev->dev.of_node;
> +       int ret;
> +
> +       if (of_device_is_compatible(np, "allwinner,sun4i-a10-mmc"))
> +               host->idma_des_size_bits =3D 13;
> +       else
> +               host->idma_des_size_bits =3D 16;
> +
> +       host->vmmc =3D devm_regulator_get_optional(&pdev->dev, "vmmc");
> +       if (IS_ERR(host->vmmc) && PTR_ERR(host->vmmc) =3D=3D -EPROBE_DEFE=
R)
> +               return -EPROBE_DEFER;
> +
> +       host->reg_base =3D devm_ioremap_resource(&pdev->dev,
> +                             platform_get_resource(pdev, IORESOURCE_MEM,=
 0));
> +       if (IS_ERR(host->reg_base))
> +               return PTR_ERR(host->reg_base);
> +
> +       host->clk_ahb =3D devm_clk_get(&pdev->dev, "ahb");
> +       if (IS_ERR(host->clk_ahb)) {
> +               dev_err(&pdev->dev, "Could not get ahb clock\n");
> +               return PTR_ERR(host->clk_ahb);
> +       }
> +
> +       host->clk_mod =3D devm_clk_get(&pdev->dev, "mod");
> +       if (IS_ERR(host->clk_mod)) {
> +               dev_err(&pdev->dev, "Could not get mod clock\n");
> +               return PTR_ERR(host->clk_mod);
> +       }
> +
> +       /* Make sure the controller is in a sane state before enabling ir=
qs */
> +       ret =3D sunxi_mmc_init_host(host->mmc);
> +       if (ret)
> +               return ret;
> +
> +       host->irq =3D platform_get_irq(pdev, 0);
> +       ret =3D devm_request_irq(&pdev->dev, host->irq, sunxi_mmc_irq, 0,
> +                              "sunxi-mci", host);
> +       if (ret =3D=3D 0)
> +               disable_irq(host->irq);
> +
> +       /* And put it back in reset */
> +       sunxi_mmc_exit_host(host);
> +
> +       return ret;
> +}
> +
> +static int sunxi_mmc_probe(struct platform_device *pdev)
> +{
> +       struct sunxi_mmc_host *host;
> +       struct mmc_host *mmc;
> +       int ret;
> +
> +       mmc =3D mmc_alloc_host(sizeof(struct sunxi_mmc_host), &pdev->dev)=
;
> +       if (!mmc) {
> +               dev_err(&pdev->dev, "mmc alloc host failed\n");
> +               return -ENOMEM;
> +       }
> +
> +       ret =3D mmc_of_parse(mmc);
> +       if (ret)
> +               goto error_free_host;
> +
> +       host =3D mmc_priv(mmc);
> +       host->mmc =3D mmc;
> +       spin_lock_init(&host->lock);
> +       tasklet_init(&host->tasklet, sunxi_mmc_tasklet, (unsigned long)ho=
st);
> +
> +       ret =3D sunxi_mmc_resource_request(host, pdev);
> +       if (ret)
> +               goto error_free_host;
> +
> +       host->sg_cpu =3D dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
> +                                         &host->sg_dma, GFP_KERNEL);
> +       if (!host->sg_cpu) {
> +               dev_err(&pdev->dev, "Failed to allocate DMA descriptor me=
m\n");
> +               ret =3D -ENOMEM;
> +               goto error_free_host;
> +       }
> +
> +       mmc->ops                =3D &sunxi_mmc_ops;
> +       mmc->max_blk_count      =3D 8192;
> +       mmc->max_blk_size       =3D 4096;
> +       mmc->max_segs           =3D PAGE_SIZE / sizeof(struct sunxi_idma_=
des);
> +       mmc->max_seg_size       =3D (1 << host->idma_des_size_bits);
> +       mmc->max_req_size       =3D mmc->max_seg_size * mmc->max_segs;
> +       /* 400kHz ~ 50MHz */
> +       mmc->f_min              =3D   400000;
> +       mmc->f_max              =3D 50000000;
> +       /* available voltages */
> +       if (!IS_ERR(host->vmmc))
> +               mmc->ocr_avail =3D mmc_regulator_get_ocrmask(host->vmmc);
> +       else
> +               mmc->ocr_avail =3D MMC_VDD_32_33 | MMC_VDD_33_34;
> +
> +       mmc->caps =3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> +               MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 | MMC_CAP_UHS_SDR50=
 |
> +               MMC_CAP_UHS_DDR50 | MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL=
 |

I think you can drop MMC_CAP_NEEDS_POLL, now that you're using mmc core GPI=
O
functions, which use GPIO irqs when possible, and sets MMC_CAP_NEEDS_POLL i=
f
that fails.


Cheers
ChenYu

> +               MMC_CAP_DRIVER_TYPE_A;
> +
> +       if (host->bus_width =3D=3D 4)
> +               mmc->caps |=3D MMC_CAP_4_BIT_DATA;
> +
> +       mmc->caps2 =3D MMC_CAP2_NO_PRESCAN_POWERUP;
> +
> +       ret =3D mmc_add_host(mmc);
> +
> +       if (ret)
> +               goto error_free_dma;
> +
> +       dev_info(&pdev->dev, "base:0x%p irq:%u\n", host->reg_base, host->=
irq);
> +       platform_set_drvdata(pdev, mmc);
> +       return 0;
> +
> +error_free_dma:
> +       dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_d=
ma);
> +error_free_host:
> +       mmc_free_host(mmc);
> +       return ret;
> +}
> +
> +static int sunxi_mmc_remove(struct platform_device *pdev)
> +{
> +       struct mmc_host *mmc =3D platform_get_drvdata(pdev);
> +       struct sunxi_mmc_host *host =3D mmc_priv(mmc);
> +
> +       mmc_remove_host(mmc);
> +       sunxi_mmc_exit_host(host);
> +       tasklet_disable(&host->tasklet);
> +       dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_d=
ma);
> +       mmc_free_host(mmc);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver sunxi_mmc_driver =3D {
> +       .driver =3D {
> +               .name   =3D "sunxi-mci",
> +               .owner  =3D THIS_MODULE,
> +               .of_match_table =3D of_match_ptr(sunxi_mmc_of_match),
> +       },
> +       .probe          =3D sunxi_mmc_probe,
> +       .remove         =3D sunxi_mmc_remove,
> +};
> +module_platform_driver(sunxi_mmc_driver);
> +
> +MODULE_DESCRIPTION("Allwinner's SD/MMC Card Controller Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("David Lanzend=F6rfer <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>");
> +MODULE_ALIAS("platform:sunxi-mmc");
[..]

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/groups/opt_out.
