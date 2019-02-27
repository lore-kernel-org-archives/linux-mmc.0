From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/3] Add hardware unbusy interrupt support for dw_mmc
Date: Wed, 27 Feb 2019 11:36:40 +0800
Message-ID: <1551238603-82412-1-git-send-email-shawn.lin@rock-chips.com>
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
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


DesignWare MMC controler lacks proper hardware wait
busy support, so the software must check the busy
state if the following tranfser need use data line.
And dw_mci_wait_while_busy() now use busy check mostly
with host's lock hold, and we can't relinguish CPU
at this moment, which makes it rather painful when used
in low-end platform. To solve this, Rockchip invent
a new hardware unbusy interrupt module, which could
generate interrupt if the state machine runs from
busy state into idle state.



Shawn Lin (3):
  mmc: dw_mmc: Check busy state in dw_mci_request()
  mmc: dw_mmc: Add hardware unbusy interrupt support
  mmc: dw_mmc-rockchip: Enable hardware unbusy interrupt support

 drivers/mmc/host/dw_mmc-rockchip.c | 30 +++++++++++++++++++
 drivers/mmc/host/dw_mmc.c          | 60 +++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h          |  6 ++++
 3 files changed, 95 insertions(+), 1 deletion(-)

-- 
1.9.1
