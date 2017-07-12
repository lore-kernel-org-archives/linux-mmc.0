From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next v3 0/4] mmc: renesas_sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Wed, 12 Jul 2017 12:12:22 +0200
Message-ID: <20170712101220.GA5428@verge.net.au>
References: <1498053630-7780-1-git-send-email-horms+renesas@verge.net.au>
 <CAPDyKFqBUi36_AAOHmNhH-0p4jD9wNLOor19k0g0H3s78_geyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqBUi36_AAOHmNhH-0p4jD9wNLOor19k0g0H3s78_geyg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 11, 2017 at 04:43:00PM +0200, Ulf Hansson wrote:
> On 21 June 2017 at 16:00, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Hi,
> >
> > this series adds support for the internal DMAC used by r8a779[56] SoCs.
> > This is achieved by adding a new variant of the SDHI driver for this
> > DMA controller with compat strings for the r8a779[56] SoCs.
> > Compat strings for these SoCs are also removed from the existing SYS DMAC
> > variant of the SDHI driver.
> >
> > Based on mmc/next
> >
> > Headline performance boost: 9.5MB/s -> 39.7MB/s
> > Details below.
> >
> > Simon Horman (3):
> >   mmc: tmio, renesas-sdhi: add dataend to DMA ops
> >   mmc: renesas-sdhi: add support for R-Car Gen3 SDHI DMAC
> >   mmc: renesas-sdhi: remove gen3 support from SYS-DMAC driver
> >
> > Yoshihiro Shimoda (1):
> >   mmc: tmio, renesas-sdhi: add max_{segs,blk_count} to tmio_mmc_data
> >
> >  drivers/mmc/host/Kconfig                      |  19 ++
> >  drivers/mmc/host/Makefile                     |   8 +-
> >  drivers/mmc/host/renesas_sdhi.h               |   2 +
> >  drivers/mmc/host/renesas_sdhi_core.c          |   2 +
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 271 ++++++++++++++++++++++++++
> >  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |  29 +--
> >  drivers/mmc/host/tmio_mmc.h                   |   2 +
> >  drivers/mmc/host/tmio_mmc_core.c              |  16 +-
> >  include/linux/mfd/tmio.h                      |   2 +
> >  9 files changed, 323 insertions(+), 28 deletions(-)
> >  create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
> 
> Thanks, applied patch 1->3 for next!

Great, thanks.
