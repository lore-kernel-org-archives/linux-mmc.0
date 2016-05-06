From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add rockchip,
 default-drv-phase
Date: Fri,  6 May 2016 17:41:13 +0800
Message-ID: <1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1462527648-24443-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

rockchip,default-drv-phase is used to set the default drv degrees.
drv phases will decide the write timing of mmc controller.

Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index ea5614b..c48dba6 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -29,6 +29,9 @@ Optional Properties:
   probing, low speeds or in case where all phases work at tuning time.
   If not specified 0 deg will be used.
 
+* rockchip,default-drv-phase: The default phase to set ciu_drv at probing
+  for host to write data to devices. If not specified 180 deg will be used.
+
 Example:
 
 	rkdwmmc0@12200000 {
-- 
2.3.7
