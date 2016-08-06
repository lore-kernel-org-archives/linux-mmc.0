From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/6] Add support of inverting power control and some minor
 cleanup
Date: Sat,  6 Aug 2016 13:36:18 +0800
Message-ID: <1470461784-3955-1-git-send-email-shawn.lin@rock-chips.com>
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
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


By default, dw_mmc outputs high level voltage to indicate powering
up the card and outputs low level vcltage to indicate powering
off the card. But that is not always correct. The power io should
be able to control different kind of hw components to supply or
cutoff power to the card. We have boards that need this patchset
to make the power control correct. Meanwhile let's expose it to
DT for board-specific usage.



Shawn Lin (6):
  dt-bindings: rockchip-dw-mshc: add description of
    rockchip,power-invert
  mmc: dw_mmc: cleanup power setting of set_ios callback
  mmc: dw_mmc: split out dw_mci_set_power
  mmc: dw_mmc: split out dw_mci_set_power_reg
  mmc: dw_mmc: support inverted power control
  mmc: dw_mmc-rockchip: add parsing of power control from DT

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   6 +
 drivers/mmc/host/dw_mmc-rockchip.c                 |   8 ++
 drivers/mmc/host/dw_mmc.c                          | 134 ++++++++++++---------
 drivers/mmc/host/dw_mmc.h                          |   1 +
 4 files changed, 90 insertions(+), 59 deletions(-)

-- 
2.3.7
