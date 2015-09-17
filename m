From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 0/3] mmc: Fix module autoload for OF platform drivers
Date: Thu, 17 Sep 2015 23:48:59 +0200
Message-ID: <20150917214859.GA7926@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Fabian Frederick <fabf@skynet.be>, Stephen Warren <swarren@nvidia.com>, Jonas Jensen <jonas.jensen@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

These patches add the missing MODULE_DEVICE_TABLE() for OF to export
the information so modules have the correct aliases built-in and
autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (3):
  mmc: mmc_spi: Fix module autoload for OF platform driver
  mmc: moxart: Fix module autoload for OF platform driver
  mmc: omap: Fix module autoload for OF platform driver

 drivers/mmc/host/mmc_spi.c    | 1 +
 drivers/mmc/host/moxart-mmc.c | 1 +
 drivers/mmc/host/omap.c       | 1 +
 3 files changed, 3 insertions(+)

-- 
2.4.6
