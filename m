From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v2 0/6] Add enhanced strobe support for emmc version 5.1 or
 later
Date: Fri, 29 Apr 2016 10:42:31 +0800
Message-ID: <1461897751-28810-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


Hello Ulf and Adrian,

This patch is going to support enhanced strobe function
for emmc version 5.1+ introduced by JEDEC recently.

Enchanced strobe is a optional function, so we add a new cap* for drivers to
decide whether to use it.

When introduing hs400 mode, JEDEC asks controllers to use data strobe line
to latch the data from emmc devives. But for cmd-reponse, not mentioned yet.
Since emmc version 5.1 published, JEDEC adds enhanced strobe function to deal
with cmd-response the same way as data-read. This feature is optional.

>From the spec(section 6.6.2.3), the standard scenario to select HS400 enhanced
strobe mode illustrated like this:
(1) set HS_TIMIMG (Highspeed)
(2) Host change freq to <= 52Mhz
(3) set the bus width to Enhanced strobe and DDR8Bit(CMD6), EXT_CSD[183] = 0x86
instead of 0x80
(4) set HS_TIMING to 0x3 (HS400)
(5) Host change freq to <= 200Mhz
(6) Host select HS400 enhanced strobe complete

I can't find a upstreamed controller claimed to support it, as well as the
mmc stack. But my "arasan,sdhci-5.1" actually supports this function. So I decide
to work for this part.

By looking into the SDHCI spec, I find there isn't any registers to enable the
enhanced strobe function. But from my "arasan,sdhci-5.1" databook, it describes a
register called VENDOR_REGISTER(0x78) to trigger this mode. So I guess other sdhci
variant drivers may also need s vendor specific register to deal with it.

If we are sure that our controller supports enhanced strobe mode, just add
mmc-hs400-enhanced-strobe in DT. Once emmc devices claims to support this mode,
we enable it automatically. Of course, other sdhci*/non-sdhci drivers should
implement/overwrite the prepare_enhanced_strobe by themselves. I believe all of the
platforms which need to support this mode should do some basic preparation for their
controllers. Currently I just limit the callback within ths scope of arasan,sdhci-5.1,
but I prone to believe arasan will use VENDOR_REGISTER to tirgger this mode from now on
because I do believe vendor will consider the registers' compatibility.

With this patchset applied, we can successfully run in HS400 enhanced strobe mode on
RK3399 platform with Samsung eMMC KLMBG2JENB-B041(v5.1, 16GB).

mmc1: new HS400 Enhanced strobe MMC card at address 0001
mmcblk0: mmc1:0001 AJNB4R 14.6 GiB
mmcblk0boot0: mmc1:0001 AJNB4R partition 1 4.00 MiB
mmcblk0boot1: mmc1:0001 AJNB4R partition 2 4.00 MiB
mmcblk0rpmb: mmc1:0001 AJNB4R partition 3 4.00 MiB


Changes in v2:
- switch to HS400ES from Highspeed mode directly

Shawn Lin (6):
  Documentation: mmc: add mmc-hs400-enhanced-strobe
  mmc: core: add mmc-hs400-enhanced-strobe support
  mmc: core: implement enhanced strobe support
  mmc: debugfs: add HS400 enhanced strobe description
  mmc: sdhci: implement enhanced strobe callback
  mmc: sdhci-of-arasan: overwrite enhanced strobe callback

 Documentation/devicetree/bindings/mmc/mmc.txt |  1 +
 drivers/mmc/core/bus.c                        |  3 +-
 drivers/mmc/core/debugfs.c                    |  4 +-
 drivers/mmc/core/host.c                       |  2 +
 drivers/mmc/core/mmc.c                        | 77 ++++++++++++++++++++++++---
 drivers/mmc/host/sdhci-of-arasan.c            | 22 ++++++++
 drivers/mmc/host/sdhci.c                      | 11 ++++
 include/linux/mmc/card.h                      |  1 +
 include/linux/mmc/host.h                      | 18 +++++++
 include/linux/mmc/mmc.h                       |  3 ++
 10 files changed, 134 insertions(+), 8 deletions(-)

-- 
2.3.7
