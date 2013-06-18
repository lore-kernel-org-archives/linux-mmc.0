From: <dinguyen@altera.com>
Subject: [PATCHv2 0/2] mmc: dw_mmc: Add support and bindings for SOCFPGA dw_mmc driver
Date: Tue, 18 Jun 2013 15:42:48 -0500
Message-ID: <1371588170-17149-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:10565
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932235Ab3FRUm6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jun 2013 16:42:58 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinh.linux@gmail.com
Cc: Dinh Nguyen <dinguyen@altera.com>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Pavel Machek <pavel@denx.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux@arm.linux.org.uk

From: Dinh Nguyen <dinguyen@altera.com>

Hi Chris,

If you don't have any comments for this patch series and if Arnd is
satisfied with my response regarding the regmap_write() in the driver,
then can you apply this patch series?

There is also a patch series from Heiko Stuebner <heiko@sntech.de> that is 
dependent on this series:

http://article.gmane.org/gmane.linux.kernel.mmc/20932

> On Wednesday 12 June 2013 10:53:33 Dinh Nguyen wrote:
> > On Wed, 2013-06-12 at 17:31 +0200, Arnd Bergmann wrote:
> > > On Wednesday 12 June 2013, dinguyen <at> altera.com wrote:
> > > > +static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
> > > > +{
> > > > +       struct dw_mci_socfpga_priv_data *priv = host->priv;
> > > > +
> > > > +       clk_disable_unprepare(host->ciu_clk);
> > > > +       regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET,
> > > > +               priv->hs_timing);
> > > > +       clk_prepare_enable(host->ciu_clk);
> > > > +
> > > > +       host->bus_hz /= (priv->ciu_div + 1);
> > > > +       return 0;
> > > > +}
> > > 
> > > 
> > > Sorry for being so late in the game here, but why do you need a
> > > regmap_write() call in the driver here? Shouldn't you just be able
> > > to use the clk_set_rate() interface from the generic dw_mmc-pltfm
> > > code?
> > 
> > This write is necessary for setting phase_shift(s) for the clocks that
> > are feeding the CIU clock. 
> 
> I don't understand. Shouldn't that be an implementation detail
> of the clock controller rather than the mmc controller?

The clock controller provides 2 clock to the mmc controller. 1 clock is
for the IP and another is for clocking the Card Interface Unit(CIU). The
CIU does exactly like the name states, it interfaces with the physical
SD card. The IP allows for adjusting the phase_shift of this CIU clock
to support different data rates on SD cards. 

So this "clocking" register is very specific to the SD block. Socfpga
has them in the system manager, while the exynos platform has them in
the SD block itself.

Hope that was clear...
Dinh

Thanks,
Dinh

Dinh Nguyen (2):
  ARM: socfpga: dts: Add support for SD/MMC
  mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA

 .../devicetree/bindings/mmc/socfpga-dw-mshc.txt    |   60 +++++++++
 arch/arm/boot/dts/socfpga.dtsi                     |   13 +-
 arch/arm/boot/dts/socfpga_cyclone5.dts             |   13 ++
 arch/arm/boot/dts/socfpga_vt.dts                   |   12 ++
 drivers/mmc/host/Kconfig                           |    8 ++
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/dw_mmc-exynos.c                   |    2 -
 drivers/mmc/host/dw_mmc-socfpga.c                  |  140 ++++++++++++++++++++
 drivers/mmc/host/dw_mmc.h                          |    1 +
 9 files changed, 247 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-socfpga.c


CC: Seungwon Jeon <tgih.jun@samsung.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Pavel Machek <pavel@denx.de>
Cc: Chris Ball <cjb@laptop.org>
CC: linux-mmc@vger.kernel.org
Cc: linux@arm.linux.org.uk

-- 
1.7.9.5


