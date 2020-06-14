Return-Path: <SRS0=Ri8i=73=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D892C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Jun 2020 15:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40ECF20747
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Jun 2020 15:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/YBoK6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgFNPFm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Jun 2020 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNPFl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Jun 2020 11:05:41 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586D7C05BD43;
        Sun, 14 Jun 2020 08:05:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so415460lfb.0;
        Sun, 14 Jun 2020 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jRN/HR4F++IslnosjZ0Jc2D50bmMrKdxXHVDxzGEF2w=;
        b=A/YBoK6ytHkvLhlqGe40kcpNjerQRsqboc0YQH1PVbrstvPlIjgtbVibbhvKt75so0
         FCUugJgNOmn6fRxjYCdlfIThh8UROQZjymXKMD+mDZ3bTNS6Zr/vy76beLCDmgtrpjiI
         0IAZm2iu9vpbuh7K4VoAe7z3x2RpvYHucNugewMg0tqbIOIPYE+sEP6lCY+wWak+emSY
         Auaz0ooXFCSY6+Hp5le9OivEzoHM5rmXWwSD+T/3fE7ex9NuEQv3xCzCgdYZ8xPE+Syh
         3W+XMMYBe+CM/LqdN3/jfJSTpVpFzyDP2DshIUX2r77iCVxhd4HT228O0hbZLgwkW/EG
         6OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jRN/HR4F++IslnosjZ0Jc2D50bmMrKdxXHVDxzGEF2w=;
        b=iL0z4Gqe1ZS4b7AF1qpyhmL2E64V/5qv2lPf73szE+aLFAZnb24SSbCWyQcoGaCzgg
         fqxCLui/GLSzZGv557568oA2snLCzpy04Nbw5RROa7FlnFvSaUJM+S7LKv2o1svAaPvx
         kLlQBkUtR3Z1PJExGEzHUwIqDO6gvUM+hFX7Cykrd8qJmmp2Exs5N6JhOZOnwPrrZ9Ij
         y3EM9wam8jIYErAnn+0mTBMUAQZvdQl3gs8V3IoJ7TIfj7qHI3XVx/WRjsUp4HqMP8R0
         P/mcoaGDTR+uzcpgyDy3d0QE4ZmpwkQsyOVD729vpyZ+OlT43+4e0gjShF83ES1mrm1I
         vJAA==
X-Gm-Message-State: AOAM531ifG0QNn1ERN9MVYUM3j8mEGVji8Zlo8NJX9RHC1C1KnfF1bhJ
        yBahBHpdZwqrTch5In1q0YhWt7Ta8qqn08Il4t4=
X-Google-Smtp-Source: ABdhPJwqIfLeiVCTK5mC5vTMCkrM89FrEVUOHwtcQAOLgVe+elM89ZgNuRF7stH1licb6uYs4ttGwlnnkb/Pa2yHs9s=
X-Received: by 2002:ac2:51a7:: with SMTP id f7mr11177702lfk.13.1592147139618;
 Sun, 14 Jun 2020 08:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1581478568.git.baolin.wang7@gmail.com> <CAPDyKFppDWKqCKPcLGC-0daihDZmv=1jBagTMV=4zSGGnoX12A@mail.gmail.com>
 <CADBw62rik7YR78w8MZh2wSc=qs_N3ZUGWxJYrJxRSVO2vk4V6Q@mail.gmail.com>
 <VI1PR04MB5294D8921B1250AF0C2B5B0D90850@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <CADBw62oLgpUdkwShC3cSqSNx8fo=E=jiw2JeqT86j4GruqouAA@mail.gmail.com> <VI1PR04MB529454ADB4E52D5BF2EAF30990830@VI1PR04MB5294.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB529454ADB4E52D5BF2EAF30990830@VI1PR04MB5294.eurprd04.prod.outlook.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 14 Jun 2020 23:05:28 +0800
Message-ID: <CADBw62o2T1xTWn9U-hrOJmrcv+zvfyj4jfwGSJnhHJ9q7_pbRA@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] Add MMC software queue support
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 10, 2020 at 10:26 AM BOUGH CHEN <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Baolin Wang [mailto:baolin.wang7@gmail.com]
> > Sent: 2020=E5=B9=B46=E6=9C=888=E6=97=A5 19:54
> > To: BOUGH CHEN <haibo.chen@nxp.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>; Adrian Hunter
> > <adrian.hunter@intel.com>; Asutosh Das <asutoshd@codeaurora.org>; Orson
> > Zhai <orsonzhai@gmail.com>; Chunyan Zhang <zhang.lyra@gmail.com>; Arnd
> > Bergmann <arnd@arndb.de>; Linus Walleij <linus.walleij@linaro.org>; Bao=
lin
> > Wang <baolin.wang@linaro.org>; linux-mmc@vger.kernel.org; Linux Kernel
> > Mailing List <linux-kernel@vger.kernel.org>; dl-linux-imx <linux-imx@nx=
p.com>
> > Subject: Re: [PATCH v9 0/5] Add MMC software queue support
> >
> > Hi Haibo.
> >
> > On Mon, Jun 8, 2020 at 2:35 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: linux-mmc-owner@vger.kernel.org
> > > > [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Baolin Wang
> > > > Sent: 2020=E5=B9=B42=E6=9C=8819=E6=97=A5 9:35
> > > > To: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: Adrian Hunter <adrian.hunter@intel.com>; Asutosh Das
> > > > <asutoshd@codeaurora.org>; Orson Zhai <orsonzhai@gmail.com>;
> > Chunyan
> > > > Zhang <zhang.lyra@gmail.com>; Arnd Bergmann <arnd@arndb.de>; Linus
> > > > Walleij <linus.walleij@linaro.org>; Baolin Wang
> > > > <baolin.wang@linaro.org>; linux-mmc@vger.kernel.org; Linux Kernel
> > > > Mailing List <linux-kernel@vger.kernel.org>
> > > > Subject: Re: [PATCH v9 0/5] Add MMC software queue support
> > > >
> > > > On Wed, Feb 19, 2020 at 7:38 AM Ulf Hansson <ulf.hansson@linaro.org=
>
> > > > wrote:
> > > > >
> > > > > On Wed, 12 Feb 2020 at 05:14, Baolin Wang <baolin.wang7@gmail.com=
>
> > > > wrote:
> > > > > >
> > > > > > Hi All,
> > > > > >
> > > > > > Now the MMC read/write stack will always wait for previous
> > > > > > request is completed by mmc_blk_rw_wait(), before sending a new
> > > > > > request to hardware, or queue a work to complete request, that
> > > > > > will bring context switching overhead, especially for high I/O
> > > > > > per second rates, to affect the IO performance.
> > > > > >
> > > > > > Thus this patch set will introduce the MMC software command
> > > > > > queue support based on command queue engine's interfaces, and
> > > > > > set the queue depth as 64 to allow more requests can be be
> > > > > > prepared, merged and inserted into IO scheduler, but we only
> > > > > > allow 2 requests in flight, that is enough to let the irq
> > > > > > handler always trigger the next request without a context switc=
h, as
> > well as avoiding a long latency.
> > > > > >
> > > > > > Moreover we can expand the MMC software queue interface to
> > > > > > support MMC packed request or packed command instead of adding
> > > > > > new interfaces, according to previosus discussion.
> > > > > >
> > > > > > Below are some comparison data with fio tool. The fio command I
> > > > > > used is like below with changing the '--rw' parameter and
> > > > > > enabling the direct IO flag to measure the actual hardware
> > > > > > transfer speed in 4K block
> > > > size.
> > > > > >
> > > > > > ./fio --filename=3D/dev/mmcblk0p30 --direct=3D1 --iodepth=3D20
> > > > > > --rw=3Dread --bs=3D4K --size=3D1G --group_reporting --numjobs=
=3D20
> > > > > > --name=3Dtest_read
> > > > > >
> > > > > > My eMMC card working at HS400 Enhanced strobe mode:
> > > > > > [    2.229856] mmc0: new HS400 Enhanced strobe MMC card at
> > address
> > > > 0001
> > > > > > [    2.237566] mmcblk0: mmc0:0001 HBG4a2 29.1 GiB
> > > > > > [    2.242621] mmcblk0boot0: mmc0:0001 HBG4a2 partition 1 4.00
> > MiB
> > > > > > [    2.249110] mmcblk0boot1: mmc0:0001 HBG4a2 partition 2 4.00
> > MiB
> > > > > > [    2.255307] mmcblk0rpmb: mmc0:0001 HBG4a2 partition 3 4.00
> > MiB,
> > > > chardev (248:0)
> > > > > >
> > > > > > 1. Without MMC software queue
> > > > > > I tested 5 times for each case and output a average speed.
> > > > > >
> > > > > > 1) Sequential read:
> > > > > > Speed: 59.4MiB/s, 63.4MiB/s, 57.5MiB/s, 57.2MiB/s, 60.8MiB/s
> > > > > > Average
> > > > > > speed: 59.66MiB/s
> > > > > >
> > > > > > 2) Random read:
> > > > > > Speed: 26.9MiB/s, 26.9MiB/s, 27.1MiB/s, 27.1MiB/s, 27.2MiB/s
> > > > > > Average
> > > > > > speed: 27.04MiB/s
> > > > > >
> > > > > > 3) Sequential write:
> > > > > > Speed: 71.6MiB/s, 72.5MiB/s, 72.2MiB/s, 64.6MiB/s, 67.5MiB/s
> > > > > > Average
> > > > > > speed: 69.68MiB/s
> > > > > >
> > > > > > 4) Random write:
> > > > > > Speed: 36.3MiB/s, 35.4MiB/s, 38.6MiB/s, 34MiB/s, 35.5MiB/s
> > > > > > Average
> > > > > > speed: 35.96MiB/s
> > > > > >
> > > > > > 2. With MMC software queue
> > > > > > I tested 5 times for each case and output a average speed.
> > > > > >
> > > > > > 1) Sequential read:
> > > > > > Speed: 59.2MiB/s, 60.4MiB/s, 63.6MiB/s, 60.3MiB/s, 59.9MiB/s
> > > > > > Average
> > > > > > speed: 60.68MiB/s
> > > > > >
> > > > > > 2) Random read:
> > > > > > Speed: 31.3MiB/s, 31.4MiB/s, 31.5MiB/s, 31.3MiB/s, 31.3MiB/s
> > > > > > Average
> > > > > > speed: 31.36MiB/s
> > > > > >
> > > > > > 3) Sequential write:
> > > > > > Speed: 71MiB/s, 71.8MiB/s, 72.3MiB/s, 72.2MiB/s, 71MiB/s Averag=
e
> > > > > > speed: 71.66MiB/s
> > > > > >
> > > > > > 4) Random write:
> > > > > > Speed: 68.9MiB/s, 68.7MiB/s, 68.8MiB/s, 68.6MiB/s, 68.8MiB/s
> > > > > > Average
> > > > > > speed: 68.76MiB/s
> > > > > >
> > > > > > Form above data, we can see the MMC software queue can help to
> > > > > > improve some performance obviously for random read and write,
> > > > > > though no obvious improvement for sequential read and write.
> > > > > >
> > > > > > Any comments are welcome. Thanks a lot.
> > > > > >
> > >
> > > Hi Baolin,
> > >
> > > I refer to your code, and add the software queue support on i.MX base=
d on
> > the Linux next-20200602, but unfortunately, I see an obvious performanc=
e drop
> > when change to use software queue.
> > > I test on our imx850-evk board, with eMMC soldered.
> > > From the result listing below, only random write has a little perform=
ance
> > improve, for others, seems performance drop a lot.
> > > I noticed that, this software queue need no-removable card, any other
> > limitation? For host?
> > > From the code logic, software queue complete the request in irq handl=
er,
> > seems no other change, I do not figure out why this will trigger a perf=
ormance
> > drop on my platform. Any comment would be appreciate!
> >
> > Have you tested with below patches, which introduce an atomic_request h=
ost
> > ops to submit next request in the irq hard handler context to reduce la=
tency?
>
> Hi Baolin,
>
> The Linux code base I use is Linux-next-20200602, which already contain a=
ll the patch you listed, including the atomic_request.
> I do not test the atomic_request alone. I just enable software queue, and=
 this software queue use the atomic request.
> So, do you mean, I need to first disable software queue, and just enable =
the atomic_request, to confirm whether the atomic_request has some performa=
nce impact on my platform?

NO, the HSQ will support  atomic_request ops, and I think you should
implement the atomic_request ops in your driver if possible, like
below patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D61ab64e2f54f4c607428667f83f411cb659843a3

> > > Without software queue, normal read/write method:
> > > Sequential read: 56MB/s
> > > Random read: 23.5MB/s
> > > Sequential write: 43.7MB/s
> > > Random write: 19MB/s
> > >
> > > With mmc software queue:
> > > Sequential read: 33.5MB/s
> > > Random read: 18.7 MB/s
> > > Sequential write: 37.7MB/s
> > > Random write: 19.8MB/s
> > >
> > >
> > > Here, I also list my change code to support software queue
> > >
> > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig inde=
x
> > > eb85237bf2d6..996b8cc5c381 100644
> > > --- a/drivers/mmc/host/Kconfig
> > > +++ b/drivers/mmc/host/Kconfig
> > > @@ -254,6 +254,7 @@ config MMC_SDHCI_ESDHC_IMX
> > >         depends on MMC_SDHCI_PLTFM
> > >         select MMC_SDHCI_IO_ACCESSORS
> > >         select MMC_CQHCI
> > > +       select MMC_HSQ
> > >         help
> > >           This selects the Freescale eSDHC/uSDHC controller support
> > >           found on i.MX25, i.MX35 i.MX5x and i.MX6x.
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index 1d7f84b23a22..6f163695b08d 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -29,6 +29,7 @@
> > >  #include "sdhci-pltfm.h"
> > >  #include "sdhci-esdhc.h"
> > >  #include "cqhci.h"
> > > +#include "mmc_hsq.h"
> > >
> > >  #define ESDHC_SYS_CTRL_DTOCV_MASK      0x0f
> > >  #define        ESDHC_CTRL_D3CD                 0x08
> > > @@ -1220,6 +1221,15 @@ static u32 esdhc_cqhci_irq(struct sdhci_host
> > *host, u32 intmask)
> > >         return 0;
> > >  }
> > >
> > > +static void esdhc_request_done(struct sdhci_host *host, struct
> > > +mmc_request *mrq) {
> > > +       /* Validate if the request was from software queue firstly. *=
/
> > > +       if (mmc_hsq_finalize_request(host->mmc, mrq))
> > > +               return;
> > > +
> > > +       mmc_request_done(host->mmc, mrq); }
> > > +
> > >  static struct sdhci_ops sdhci_esdhc_ops =3D {
> > >         .read_l =3D esdhc_readl_le,
> > >         .read_w =3D esdhc_readw_le,
> > > @@ -1237,6 +1247,7 @@ static struct sdhci_ops sdhci_esdhc_ops =3D {
> > >         .set_uhs_signaling =3D esdhc_set_uhs_signaling,
> > >         .reset =3D esdhc_reset,
> > >         .irq =3D esdhc_cqhci_irq,
> > > +       .request_done =3D esdhc_request_done,
> > >  };
> > >
> > >  static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata =3D { @@
> > > -1301,6 +1312,19 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_h=
ost
> > *host)
> > >                         writel(tmp, host->ioaddr +
> > ESDHC_VEND_SPEC2);
> > >
> > >                         host->quirks &=3D
> > ~SDHCI_QUIRK_NO_BUSY_IRQ;
> > > +
> > > +                       /*
> > > +                        * On i.MX8MM, we are running Dual Linux OS,
> > with 1st Linux using SD Card
> > > +                        * as rootfs storage, 2nd Linux using eMMC as
> > rootfs storage. We let the
> > > +                        * the 1st linux configure power/clock for th=
e
> > 2nd Linux.
> > > +                        *
> > > +                        * When the 2nd Linux is booting into rootfs
> > stage, we let the 1st Linux
> > > +                        * to destroy the 2nd linux, then restart the
> > 2nd linux, we met SDHCI dump.
> > > +                        * After we clear the pending interrupt and h=
alt
> > CQCTL, issue gone.
> > > +                        */
> > > +                       tmp =3D cqhci_readl(cq_host, CQHCI_IS);
> > > +                       cqhci_writel(cq_host, tmp, CQHCI_IS);
> > > +                       cqhci_writel(cq_host, CQHCI_HALT,
> > CQHCI_CTL);
> > >                 }
> > >
> > >                 if (imx_data->socdata->flags &
> > ESDHC_FLAG_STD_TUNING)
> > > { @@ -1351,9 +1375,6 @@ static void sdhci_esdhc_imx_hwinit(struct
> > sdhci_host *host)
> > >                  * After we clear the pending interrupt and halt CQCT=
L,
> > issue gone.
> > >                  */
> > >                 if (cq_host) {
> > > -                       tmp =3D cqhci_readl(cq_host, CQHCI_IS);
> > > -                       cqhci_writel(cq_host, tmp, CQHCI_IS);
> > > -                       cqhci_writel(cq_host, CQHCI_HALT,
> > CQHCI_CTL);
> > >                 }
> > >         }
> > >  }
> > > @@ -1555,6 +1576,7 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> > >         struct sdhci_pltfm_host *pltfm_host;
> > >         struct sdhci_host *host;
> > >         struct cqhci_host *cq_host;
> > > +       struct mmc_hsq *hsq;
> > >         int err;
> > >         struct pltfm_imx_data *imx_data;
> > >
> > > @@ -1664,6 +1686,16 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> > >                 err =3D cqhci_init(cq_host, host->mmc, false);
> > >                 if (err)
> > >                         goto disable_ahb_clk;
> > > +       } else if (esdhc_is_usdhc(imx_data)) {
> > > +               hsq =3D devm_kzalloc(&pdev->dev, sizeof(*hsq),
> > GFP_KERNEL);
> > > +               if (!hsq) {
> > > +                       err =3D -ENOMEM;
> > > +                       goto disable_ahb_clk;
> > > +               }
> > > +
> > > +               err =3D mmc_hsq_init(hsq, host->mmc);
> > > +               if (err)
> > > +                       goto disable_ahb_clk;
> > >         }
> > >
> > >         if (of_id)
> > > @@ -1673,6 +1705,11 @@ static int sdhci_esdhc_imx_probe(struct
> > platform_device *pdev)
> > >         if (err)
> > >                 goto disable_ahb_clk;
> > >
> > > +       if (!mmc_card_is_removable(host->mmc))
> > > +               host->mmc_host_ops.request_atomic =3D
> > sdhci_request_atomic;
> > > +       else
> > > +               host->always_defer_done =3D true;
> > > +
> > >         sdhci_esdhc_imx_hwinit(host);
> > >
> > >         err =3D sdhci_add_host(host);
> > > @@ -1737,6 +1774,8 @@ static int sdhci_esdhc_suspend(struct device
> > *dev)
> > >                 ret =3D cqhci_suspend(host->mmc);
> > >                 if (ret)
> > >                         return ret;
> > > +       } else if (esdhc_is_usdhc(imx_data)) {
> > > +               mmc_hsq_suspend(host->mmc);
> > >         }
> > >
> > >         if ((imx_data->socdata->flags &
> > > ESDHC_FLAG_STATE_LOST_IN_LPMODE) && @@ -1764,6 +1803,8 @@
> > static int
> > > sdhci_esdhc_suspend(struct device *dev)  static int
> > > sdhci_esdhc_resume(struct device *dev)  {
> > >         struct sdhci_host *host =3D dev_get_drvdata(dev);
> > > +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > > +       struct pltfm_imx_data *imx_data =3D
> > > + sdhci_pltfm_priv(pltfm_host);
> > >         int ret;
> > >
> > >         ret =3D pinctrl_pm_select_default_state(dev);
> > > @@ -1777,8 +1818,11 @@ static int sdhci_esdhc_resume(struct device
> > *dev)
> > >         if (ret)
> > >                 return ret;
> > >
> > > -       if (host->mmc->caps2 & MMC_CAP2_CQE)
> > > +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > >                 ret =3D cqhci_resume(host->mmc);
> > > +       } else if (esdhc_is_usdhc(imx_data)) {
> > > +               mmc_hsq_resume(host->mmc);
> > > +       }
> > >
> > >         if (!ret)
> > >                 ret =3D mmc_gpio_set_cd_wake(host->mmc, false); @@
> > > -1799,6 +1843,8 @@ static int sdhci_esdhc_runtime_suspend(struct devi=
ce
> > *dev)
> > >                 ret =3D cqhci_suspend(host->mmc);
> > >                 if (ret)
> > >                         return ret;
> > > +       } else if (esdhc_is_usdhc(imx_data)) {
> > > +               mmc_hsq_suspend(host->mmc);
> > >         }
> > >
> > >         ret =3D sdhci_runtime_suspend_host(host); @@ -1851,8 +1897,11
> > @@
> > > static int sdhci_esdhc_runtime_resume(struct device *dev)
> > >         if (err)
> > >                 goto disable_ipg_clk;
> > >
> > > -       if (host->mmc->caps2 & MMC_CAP2_CQE)
> > > +       if (host->mmc->caps2 & MMC_CAP2_CQE) {
> > >                 err =3D cqhci_resume(host->mmc);
> > > +       } else if (esdhc_is_usdhc(imx_data)) {
> > > +               mmc_hsq_resume(host->mmc);
> > > +       }
> > >
> > >         return err;
> > >
> > >
> > >
> > > > > > Changes from v8:
> > > > > >  - Add more description in the commit message.
> > > > > >  - Optimize the failure log when calling cqe_enable().
> > > > > >
> > > > > > Changes from v7:
> > > > > >  - Add reviewed tag from Arnd.
> > > > > >  - Use the 'hsq' acronym for varibles and functions in the core=
 layer.
> > > > > >  - Check the 'card->ext_csd.cmdq_en' in cqhci.c to make sure th=
e
> > > > > > CQE can work normally.
> > > > > >  - Add a new patch to enable the host software queue for the SD=
 card.
> > > > > >  - Use the default MMC queue depth for host software queue.
> > > > > >
> > > > > > Changes from v6:
> > > > > >  - Change the patch order and set host->always_defer_done =3D t=
rue
> > > > > > for the  Spreadtrum host driver.
> > > > > >
> > > > > > Changes from v5:
> > > > > >  - Modify the condition of defering to complete request
> > > > > > suggested by
> > > > Adrian.
> > > > > >
> > > > > > Changes from v4:
> > > > > >  - Add a seperate patch to introduce a variable to defer to
> > > > > > complete data requests for some host drivers, when using host
> > software queue.
> > > > > >
> > > > > > Changes from v3:
> > > > > >  - Use host software queue instead of sqhci.
> > > > > >  - Fix random config building issue.
> > > > > >  - Change queue depth to 32, but still only allow 2 requests in=
 flight.
> > > > > >  - Update the testing data.
> > > > > >
> > > > > > Changes from v2:
> > > > > >  - Remove reference to 'struct cqhci_host' and 'struct
> > > > > > cqhci_slot', instead adding 'struct sqhci_host', which is only =
used by
> > software queue.
> > > > > >
> > > > > > Changes from v1:
> > > > > >  - Add request_done ops for sdhci_ops.
> > > > > >  - Replace virtual command queue with software queue for
> > > > > > functions and  variables.
> > > > > >  - Rename the software queue file and add sqhci.h header file.
> > > > > >
> > > > > > Baolin Wang (5):
> > > > > >   mmc: Add MMC host software queue support
> > > > > >   mmc: core: Enable the MMC host software queue for the SD card
> > > > > >   mmc: host: sdhci: Add request_done ops for struct sdhci_ops
> > > > > >   mmc: host: sdhci: Add a variable to defer to complete request=
s if
> > > > > >     needed
> > > > > >   mmc: host: sdhci-sprd: Add software queue support
> > > > > >
> > > > > >  drivers/mmc/core/block.c      |   61 ++++++++
> > > > > >  drivers/mmc/core/mmc.c        |   18 ++-
> > > > > >  drivers/mmc/core/queue.c      |   22 ++-
> > > > > >  drivers/mmc/core/sd.c         |   10 ++
> > > > > >  drivers/mmc/host/Kconfig      |    8 +
> > > > > >  drivers/mmc/host/Makefile     |    1 +
> > > > > >  drivers/mmc/host/cqhci.c      |    8 +-
> > > > > >  drivers/mmc/host/mmc_hsq.c    |  343
> > > > +++++++++++++++++++++++++++++++++++++++++
> > > > > >  drivers/mmc/host/mmc_hsq.h    |   30 ++++
> > > > > >  drivers/mmc/host/sdhci-sprd.c |   28 ++++
> > > > > >  drivers/mmc/host/sdhci.c      |   14 +-
> > > > > >  drivers/mmc/host/sdhci.h      |    3 +
> > > > > >  include/linux/mmc/host.h      |    3 +
> > > > > >  13 files changed, 534 insertions(+), 15 deletions(-)  create
> > > > > > mode
> > > > > > 100644 drivers/mmc/host/mmc_hsq.c  create mode 100644
> > > > > > drivers/mmc/host/mmc_hsq.h
> > > > > >
> > > > > > --
> > > > > > 1.7.9.5
> > > > > >
> > > > >
> > > > > Applied for next, thanks! Also, thanks for your patience while
> > > > > moving forward during the reviews!
> > > >
> > > > I am very appreciated for you and Arnd's good sugestion when
> > > > introducing the hsq.
> > > >
> > > > >
> > > > > Note, I did some amending of patch1 to resolve some checkpatch
> > > > > warnings. SPDX licence and Kconfig help texts, please have a look
> > > > > and tell if there are something that doesn't look good.
> > > >
> > > > Thanks for your help and looks good to me.
> >
> >
> >
> > --
> > Baolin Wang



--=20
Baolin Wang
