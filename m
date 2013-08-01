From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH] mmc: dw_mmc: add missing MFD_SYSCON dependency for
 SOCFPGA
Date: Thu, 1 Aug 2013 09:59:13 -0500
Message-ID: <1375369153.20685.62.camel@linux-builds1>
References: <002601ce8e4e$027246c0$0756d440$@samsung.com>
	 <51FA7620.9090504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:18002
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755217Ab3HAO67 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 10:58:59 -0400
In-Reply-To: <51FA7620.9090504@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Jingoo Han <jg1.han@samsung.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>

On Thu, 2013-08-01 at 23:52 +0900, Jaehoon Chung wrote:
> When I used socfpga_defconfig, MFD_SYSCON is enabled.
> Which config do you use?
> 

Yes, select MFD_SYSCON is in mach-socfpga/Kconfig. This should have
fixed this error.

commit 1780db9e2104 ARM: socfpga: Add syscon to be part of socfpga

Dinh
> Best Regards,
> Jaehoon Chung
> 
> On 08/01/2013 09:28 AM, Jingoo Han wrote:
> > Added missing MFD_SYSCON dependency for SOCFPGA in order to fix
> > the following link error.
> > 
> > drivers/mmc/host/dw_mmc-socfpga.c:49: undefined reference to `syscon_regmap_lookup_by_compatible'
> > 
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/mmc/host/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 8a4c066..84102bc 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -569,7 +569,7 @@ config MMC_DW_EXYNOS
> >  
> >  config MMC_DW_SOCFPGA
> >  	tristate "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
> > -	depends on MMC_DW
> > +	depends on MMC_DW && MFD_SYSCON
> >  	select MMC_DW_PLTFM
> >  	help
> >  	  This selects support for Altera SoCFPGA specific extensions to the
> > 
> 
> 



