From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: revision-specific configuration from
 Device Tree
Date: Mon, 5 Aug 2013 17:30:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1308051722490.22479@axis700.grange>
References: <Pine.LNX.4.64.1308051514350.22479@axis700.grange>
 <8661vkgqdw.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <8661vkgqdw.fsf@void.printf.net>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, Daniel Drake <dsd@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Mon, 5 Aug 2013, Chris Ball wrote:

> Hi Guennadi,
> 
> On Mon, Aug 05 2013, Guennadi Liakhovetski wrote:
> > Add compatibility strings to configure MMCIF revision-specific features.
> > MMCIF blocks are always integrated into SoCs, so, we use SoC model to
> > distinguish between MMCIF versions.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >
> > Hi Chris,
> > I marked this as RFC, because having no access to the MMC standard I'm not 
> > certain about VccQ requirements for MMC DDR. On the one hand a comment in 
> > mmc.c says
> > 	 * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
> > which suggests, that DDR (DDR50?) can be used with VccQ = 3.3V, 1.8V and 
> > 1.2V at least. But in mmc_init_card() DDR50 is only requested from the 
> > driver if either MMC_CAP_1_8V_DDR or MMC_CAP_1_2V_DDR is specified in 
> > host's capabilities. So, I'm actually not sure whether MMC_CAP_UHS_DDR50 
> > alone without 1_8V or 1_2V makes sense. That's also what I implemented in 
> > this patch - DDR50 is only enabled in combination with either 1.2 or 1.8V 
> > capability. Is this correct?
> 
> OLPC's using DDR50 at 3.3V in production.  Honestly, I don't know
> whether it's spec compliant (I think the spec claims that 1.8V is
> required) but it happens to work on these parts.  The host controller
> does support 1.8V, there's just no hardware capable of supplying 1.8V
> to MMC on the board.

Thanks for the example. So, I think, for now it should be ok to just act 
in a way, compatible with the mmc core, i.e. always set one of 
MMC_CAP_1_8V_DDR or MMC_CAP_1_2V_DDR, when aiming at MMC_CAP_UHS_DDR50. 
So, the patch should be ok then.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
