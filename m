From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH] mmc: sdhci-of-arasan: Properly set corecfg_clockmultipler on
 rk3399
Date: Fri, 26 Aug 2016 11:22:16 +0800
Message-ID: <1472181736-17848-1-git-send-email-shawn.lin@rock-chips.com>
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
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

corecfg_clockmultipler indicates clock multiplier value of
programmable clock generator which should be the same value
of SDHCI_CAPABILITIES_1. The default value of the register,
corecfg_clockmultipler, is 0x10. But actually it is a mistake
by designer as our intention was to set it to be zero which
means we don't support programmable clock generator. So we have
to made it to be zero on bootloader which seems work fine until
now. But now we find a issue that when deploying genpd support
for it, the remove callback will trigger the genpd to poweroff the
power domain for sdhci-of-arasan which magage the controller, phy
and corecfg_* stuff.

So when we do bind/unbind the driver, we have already reinit
the controller and phy, but without doing that for corecfg_*.
Regarding to only the corecfg_clockmultipler is wrong, let's
fix it by explicitly marking it to be zero when probing. With
this change, we could do bind/unbind successfully.

Reported-by: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
---

 drivers/mmc/host/sdhci-of-arasan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 0b3a9cf..c1eb263 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -67,10 +67,12 @@ struct sdhci_arasan_soc_ctl_field {
  * accessible via the syscon API.
  *
  * @baseclkfreq:	Where to find corecfg_baseclkfreq
+ * @clockmultiplier:	Where to find corecfg_clockmultiplier
  * @hiword_update:	If true, use HIWORD_UPDATE to access the syscon
  */
 struct sdhci_arasan_soc_ctl_map {
 	struct sdhci_arasan_soc_ctl_field	baseclkfreq;
+	struct sdhci_arasan_soc_ctl_field	clockmultiplier;
 	bool					hiword_update;
 };
 
@@ -100,6 +102,7 @@ struct sdhci_arasan_data {
 
 static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
 	.baseclkfreq = { .reg = 0xf000, .width = 8, .shift = 8 },
+	.clockmultiplier = { .reg = 0xf02c, .width = 8, .shit = 0},
 	.hiword_update = true,
 };
 
@@ -528,6 +531,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 					ret);
 			goto err_pltfm_free;
 		}
+
+		if (of_device_is_compatible(pdev->dev.of_node,
+					    "rockchip,rk3399-sdhci-5.1"))
+			sdhci_arasan_syscon_write(host,
+						  &soc_ctl_map->clockmultiplier,
+						  0);
 	}
 
 	sdhci_arasan->clk_ahb = devm_clk_get(&pdev->dev, "clk_ahb");
-- 
2.3.7
