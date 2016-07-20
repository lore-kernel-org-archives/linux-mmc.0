From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: [PATCH 3/3] mmc: sunxi: Add support to the Allwinner A83T
Date: Wed, 20 Jul 2016 20:28:47 +0200
Message-ID: <0ddc5f7d9a42515f901c95b8c0c1f5a5e4d575e9.1469082481.git.moinejf@free.fr>
References: <cover.1469082481.git.moinejf@free.fr>
Reply-To: moinejf-GANU6spQydw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCV6DL6LYMNBB24IYK6AKGQEHVEYXKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <cover.1469082481.git.moinejf-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

The rate of the PLL-PERIPH clock is usually set to 1.2GHz in the A83T.
This patch sets the phase delays of the output and sample clocks
accordingly.

Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
---
Note: The impacted phase delays are only for 50MHz.
The phase delays are not used in 50MHz 8 bits DDR (new timing mode).
---
 drivers/mmc/host/sunxi-mmc.c | 11 +++++++++++
 1 file changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 7f9c31a..e161a64 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -961,6 +961,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", },
 	{ .compatible = "allwinner,sun5i-a13-mmc", },
+	{ .compatible = "allwinner,sun8i-a83t-mmc", },
 	{ .compatible = "allwinner,sun9i-a80-mmc", },
 	{ /* sentinel */ }
 };
@@ -986,6 +987,14 @@ static const struct sunxi_mmc_clk_delay sunxi_mmc_clk_delays[] = {
 	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  90, .sample = 180 },
 };
 
+static const struct sunxi_mmc_clk_delay sun8i_a83t_mmc_clk_delays[] = {
+	[SDXC_CLK_400K]		= { .output = 180, .sample = 180 },
+	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
+	[SDXC_CLK_50M]		= { .output =  90, .sample = 105 },
+	[SDXC_CLK_50M_DDR]	= { .output =  60, .sample = 120 },
+	[SDXC_CLK_50M_DDR_8BIT]	= { .output =  180, .sample = 180 },
+};
+
 static const struct sunxi_mmc_clk_delay sun9i_mmc_clk_delays[] = {
 	[SDXC_CLK_400K]		= { .output = 180, .sample = 180 },
 	[SDXC_CLK_25M]		= { .output = 180, .sample =  75 },
@@ -1007,6 +1016,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 
 	if (of_device_is_compatible(np, "allwinner,sun9i-a80-mmc"))
 		host->clk_delays = sun9i_mmc_clk_delays;
+	else if (of_device_is_compatible(np, "allwinner,sun8i-a83t-mmc"))
+		host->clk_delays = sun8i_a83t_mmc_clk_delays;
 	else
 		host->clk_delays = sunxi_mmc_clk_delays;
 
-- 
2.9.2
