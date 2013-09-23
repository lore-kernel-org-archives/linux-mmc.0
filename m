From: Johan Hovold <jhovold@gmail.com>
Subject: [PATCH 0/7] driver core: prevent deferred probe with
 platform_driver_probe
Date: Mon, 23 Sep 2013 16:27:25 +0200
Message-ID: <1379946452-25649-1-git-send-email-jhovold@gmail.com>
References: <20130923134028.GF21013@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20130923134028.GF21013@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-usb@vger.kernel.org, Mark Brown <broonie@linaro.org>, Johan Hovold <jhovold@gmail.com>, linux-pcmcia@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, Grant Likely <grant.likely@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Deferred probing cannot be used with platform_driver_probe as by the
time probing is retried either the driver has been unregistered or its
probe function has been set to platform_drv_probe_fail.

With commit e9354576 ("gpiolib: Defer failed gpio requests by default")
the gpio subsystem started returning -EPROBE_DEFER, which in turn
several platform drivers using platform_driver_probe return to driver
core. Other subsystems (e.g. regulator) has since started doing the
same.

The first patch in this series prevents platform drivers using
platform_driver_probe from requesting probe deferral while warning that
it is not supported.

The remaining patches move six platform-driver probe functions that rely
on gpio_request out of __init. There are likely other probe functions
that might return -EPROBE_DEFER and should be moved out of __init as
well.

Note that the mvsdio, at91_cf and pxa25x_udc patches are completely
untested.

Johan


Johan Hovold (7):
  driver core: prevent deferred probe with platform_driver_probe
  mmc: mvsdio: fix deferred probe from __init
  mtd: atmel_nand: fix deferred probe from __init
  pcmcia: at91_cf: fix deferred probe from __init
  usb: gadget: pxa25x_udc: fix deferred probe from __init
  usb: phy: gpio-vbus: fix deferred probe from __init
  backlight: atmel-pwm-bl: fix deferred probe from __init

 drivers/base/platform.c                | 17 +++++++++++++----
 drivers/mmc/host/mvsdio.c              | 11 ++++++-----
 drivers/mtd/nand/atmel_nand.c          | 13 +++++++------
 drivers/pcmcia/at91_cf.c               | 11 +++++------
 drivers/usb/gadget/pxa25x_udc.c        |  9 +++++----
 drivers/usb/phy/phy-gpio-vbus-usb.c    | 11 +++++------
 drivers/video/backlight/atmel-pwm-bl.c |  9 +++++----
 include/linux/platform_device.h        |  1 +
 8 files changed, 47 insertions(+), 35 deletions(-)

-- 
1.8.3.2


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
