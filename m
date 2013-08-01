From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add missing MFD_SYSCON dependency for SOCFPGA
Date: Fri, 02 Aug 2013 08:22:00 +0900
Message-ID: <000901ce8f0d$ec52f6d0$c4f8e470$@samsung.com>
References: <002601ce8e4e$027246c0$0756d440$@samsung.com>
 <51FA7620.9090504@samsung.com> <1375369153.20685.62.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:63533 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab3HAXWD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 19:22:03 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQV00IECKWG4X00@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Aug 2013 08:22:00 +0900 (KST)
In-reply-to: <1375369153.20685.62.camel@linux-builds1>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Dinh Nguyen' <dinguyen@altera.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Fengguang Wu' <fengguang.wu@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>, Jingoo Han <jg1.han@samsung.com>

On Thursday, August 01, 2013 11:59 PM, Dinh Nguyen wrote:
> On Thu, 2013-08-01 at 23:52 +0900, Jaehoon Chung wrote:
> > When I used socfpga_defconfig, MFD_SYSCON is enabled.
> > Which config do you use?
> >
> 
> Yes, select MFD_SYSCON is in mach-socfpga/Kconfig. This should have
> fixed this error.
> 
> commit 1780db9e2104 ARM: socfpga: Add syscon to be part of socfpga

+CC Fengguang Wu, Dan Carpenter, Arnd Bergmann

I used exynos_defconfig, and enabled socfpga mmc driver through menuconfig.
Also, 'drivers/mmc/host/dw_mmc-socfpga.c' is used by ARCH_SOCFPGA.
However, even though other configs are used, it should not make build error
or link error.

Please look at other drivers using MFD_SYSCON.
i.mx config also selects MFD_SYSCON; however, it added MFD_SYSCON
dependency in order to prevent link error.

(./arch/arm/mach-imx/Kconfig)
786: config SOC_IMX6Q
804:	select MFD_SYSCON

813: config SOC_IMX6SL
825:	select MFD_SYSCON

 (./drivers/regulator/Kconfig)
90: config REGULATOR_ANATOP
91:    tristate "Freescale i.MX on-chip ANATOP LDO regulators"
92:    depends on MFD_SYSCON


Best regards,
Jingoo Han

> 
> Dinh
> > Best Regards,
> > Jaehoon Chung
> >
> > On 08/01/2013 09:28 AM, Jingoo Han wrote:
> > > Added missing MFD_SYSCON dependency for SOCFPGA in order to fix
> > > the following link error.
> > >
> > > drivers/mmc/host/dw_mmc-socfpga.c:49: undefined reference to `syscon_regmap_lookup_by_compatible'
> > >
> > > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > > ---
> > >  drivers/mmc/host/Kconfig |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > > index 8a4c066..84102bc 100644
> > > --- a/drivers/mmc/host/Kconfig
> > > +++ b/drivers/mmc/host/Kconfig
> > > @@ -569,7 +569,7 @@ config MMC_DW_EXYNOS
> > >
> > >  config MMC_DW_SOCFPGA
> > >  	tristate "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
> > > -	depends on MMC_DW
> > > +	depends on MMC_DW && MFD_SYSCON
> > >  	select MMC_DW_PLTFM
> > >  	help
> > >  	  This selects support for Altera SoCFPGA specific extensions to the
> > >
> >
> >
> 


