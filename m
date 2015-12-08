From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 1/5] powerpc/fsl: move mpc85xx.h to include/linux
Date: Tue, 8 Dec 2015 11:38:05 -0600
Message-ID: <1449596285.15946.120.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-2-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFpkiG=m1gKioJaWtu-EJk4sndEDH1X7w6eNvUDueiCdGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bbn0101.outbound.protection.outlook.com ([157.56.111.101]:6717
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751096AbbLHRiV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Dec 2015 12:38:21 -0500
In-Reply-To: <CAPDyKFpkiG=m1gKioJaWtu-EJk4sndEDH1X7w6eNvUDueiCdGw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@freescale.com>, Lee Jones <lee@kernel.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On Tue, 2015-12-08 at 14:49 +0100, Ulf Hansson wrote:
> +Lee Jones
> 
> On 27 November 2015 at 04:20, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > Move mpc85xx.h to include/linux and rename it to fsl-svr.h as
> > a common header file. It has been used for mpc85xx and it will
> > be used for ARM-based SoC as well.
> > 
> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > ---
> > Changes for v2:
> >         - None
> > Changes for v3:
> >         - Added this patch
> > ---
> >  arch/powerpc/include/asm/mpc85xx.h       | 95 ---------------------------
> > ----
> >  drivers/clk/clk-qoriq.c                  |  2 +-
> >  drivers/i2c/busses/i2c-mpc.c             |  2 +-
> >  drivers/iommu/fsl_pamu.c                 |  2 +-
> >  drivers/net/ethernet/freescale/gianfar.c |  2 +-
> >  include/linux/fsl-svr.h                  | 97
> > ++++++++++++++++++++++++++++++++
> >  6 files changed, 101 insertions(+), 99 deletions(-)
> >  delete mode 100644 arch/powerpc/include/asm/mpc85xx.h
> >  create mode 100644 include/linux/fsl-svr.h
> 
> I am not sure, but perhaps the more proper location is:
> 
> include/linux/mfd/fsl-svr.h
> 
> ...or maybe even better:
> 
> include/linux/mfd/syscon/fsl-svr.h

There is nothing mfd or syscon specific about this data (and in fact I'm a bit
skeptical about using syscon for this, especially since it seems to require a
device tree modification); it's already used in other places that read the SVR
via the PPC SPR.

-Scott

