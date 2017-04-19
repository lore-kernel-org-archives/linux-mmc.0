From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/2] Specify tuning count for individual board
Date: Wed, 19 Apr 2017 17:00:32 +0800
Message-ID: <1492592434-81312-1-git-send-email-shawn.lin@rock-chips.com>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


I was seeing that it spends almost 700ms to init eMMC on RK3368 platform.
It also happened when resuming from S3 for each time. dw_mmc-rockchip
was trying to scan all degrees. However I wonder whether it's worth
doing that? Look at how the other host drivers do, for instance,
sdhci. At least sdhci-of-arasan on RK3399 platform only do tuning
for 32 times executed by PHY. Anyway, 360 times by default looks crazy
to me. I hope we could vote for it in DT instead of hard-coding it in
the code.

[    1.193248] dwmmc_rockchip ff0f0000.dwmmc: IDMAC supports 32-bit
address mode.
[    1.193316] dwmmc_rockchip ff0f0000.dwmmc: Using internal DMA
controller.
[    1.193332] dwmmc_rockchip ff0f0000.dwmmc: Version ID is 270a
[    1.193387] dwmmc_rockchip ff0f0000.dwmmc: DW MMC controller at irq
18,32 bit host data width,256 deep fifo
[    1.193410] dwmmc_rockchip ff0f0000.dwmmc: 'clock-freq-min-max'
property was deprecated.
[    1.193446] dwmmc_rockchip ff0f0000.dwmmc: No vmmc regulator found
[    1.193458] dwmmc_rockchip ff0f0000.dwmmc: No vqmmc regulator found
[    1.205185] mmc_host mmc1: Bus speed (slot 0) = 400000Hz (slot req
400000Hz, actual 400000HZ div = 0)
[    1.219611] dwmmc_rockchip ff0f0000.dwmmc: 1 slots initialized

....

[    1.912482] dwmmc_rockchip ff0f0000.dwmmc: Successfully tuned phase
to 182
[    1.912683] mmc1: new HS200 MMC card at address 0001
[    1.914511] mmcblk1: mmc1:0001 M8G1GC 7.28 GiB
[    1.915527] mmcblk1boot0: mmc1:0001 M8G1GC partition 1 4.00 MiB
[    1.916388] mmcblk1boot1: mmc1:0001 M8G1GC partition 2 4.00 MiB
[    1.917232] mmcblk1rpmb: mmc1:0001 M8G1GC partition 3 512 KiB



Shawn Lin (2):
  dt-bindings: rockchip-dw-mshc: add optional
    rockchip,default-num-phases
  mmc: dw_mmc-rockchip: parse rockchip,default-num-phases from DT

 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |  4 ++
 drivers/mmc/host/dw_mmc-rockchip.c                 | 48 ++++++++++++++--------
 2 files changed, 34 insertions(+), 18 deletions(-)

-- 
1.9.1
