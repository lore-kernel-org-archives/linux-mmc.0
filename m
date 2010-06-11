From: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [PATCH 1/5] sdhci-s3c: depend on plat-samsung
Date: Fri, 11 Jun 2010 06:24:07 +0100
Message-ID: <20100611052407.GX7248@trinity.fluff.org>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com> <1276076383-24825-2-git-send-email-m.szyprowski@samsung.com> <000701cb08fd$2f8e15a0$8eaa40e0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:52200 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab0FKFYM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Jun 2010 01:24:12 -0400
Content-Disposition: inline
In-Reply-To: <000701cb08fd$2f8e15a0$8eaa40e0$%kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: 'Marek Szyprowski' <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org

On Fri, Jun 11, 2010 at 09:29:38AM +0900, Kukjin Kim wrote:
> Marek Szyprowski wrote:
> > 
> > Most Samsung SoC have support for SDHCI block, so make the driver
> > dependent on the Samsung platform instead on listing all SoCs in the
> > Kconfig (and updating it again when support for the new SoC variant is
> > added).
> > 
> Hi, Marek
> 
> Kyungmin Park already submitted same patch.

Hmm, Mr Park and Co really need to learn how to handle the treatment of
patches. I'm really disapointed that these patches get submitted without
the proper authour accreditation. If this isn't sorted out then I for
one will start thinking about giving this stuff an automatic reject.

Please ensure that the original authour of a patch is accredited for
the work, and the right sign-off and any other ack data is kept with
the patch. There's documentation about most of this in the kernel
already at Documentation/SubmittingPatches.
 
> And Andrew Morton added to the -mm tree.
> http://www.spinics.net/lists/mm-commits/msg79159.html
> 
> But, I think your comment is better...
> 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/host/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index e171e77..acf5bf6 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -123,7 +123,7 @@ config MMC_SDHCI_PLTFM
> > 
> >  config MMC_SDHCI_S3C
> >  	tristate "SDHCI support on Samsung S3C SoC"
> > -	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> > +	depends on MMC_SDHCI && PLAT_SAMSUNG
> >  	help
> >  	  This selects the Secure Digital Host Controller Interface (SDHCI)
> >  	  often referrered to as the HSMMC block in some of the Samsung S3C
> > --
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.

