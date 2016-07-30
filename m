From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/5] mmc: sunxi: Disable sample clks on remove
Date: Sat, 30 Jul 2016 16:25:44 +0200
Message-ID: <1469888748-26085-2-git-send-email-hdegoede@redhat.com>
References: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1469888748-26085-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Icenowy Zheng <icenowy@aosc.xyz>, linux-arm-kernel@lists.infradead.org, Hans de Goede <hdegoede@redhat.com>
List-Id: linux-mmc@vger.kernel.org

When support for the sample clks was added calls to prepare_enable
were added to the probe path, but matching calls to disable_unprepare
were forgotten in the remove path, this fixes this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes
---
 drivers/mmc/host/sunxi-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index a4d2b63..71a480b 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1160,6 +1160,8 @@ static int sunxi_mmc_remove(struct platform_device *pdev)
 	if (!IS_ERR(host->reset))
 		reset_control_assert(host->reset);
 
+	clk_disable_unprepare(host->clk_sample);
+	clk_disable_unprepare(host->clk_output);
 	clk_disable_unprepare(host->clk_mmc);
 	clk_disable_unprepare(host->clk_ahb);
 
-- 
2.7.4
