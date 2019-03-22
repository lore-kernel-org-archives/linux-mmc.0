From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: [PATCH v3 2/3] mmc: sdhci-of-arasan: Add DTS property to disable
 DCMDs.
Date: Fri, 22 Mar 2019 12:38:05 +0100
Message-ID: <20190322113808.16858-2-christoph.muellner@theobroma-systems.com>
References: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Randy Li <ayaka@soulik.info>, linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, Vicente Bergas <vicencb@gmail.com>, Douglas Anderson <dianders@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Tony Xie <tony.xie@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Ezequiel Garcia <ezequiel@collabora.com>, linux-kernel@vger.kernel.org, Christoph Muellner <christoph.muellner@theobroma-systems.com>
List-Id: linux-mmc@vger.kernel.org

Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
which exposes a control register bit to enable the feature.
The current implementation sets this bit unconditionally.

This patch allows to suppress the feature activation,
by specifying the property disable-cqe-dcmd.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c9e3e050ccc8..88dc3f00a5be 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_arasan_voltage_switch;
 		sdhci_arasan->has_cqe = true;
-		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
+		host->mmc->caps2 |= MMC_CAP2_CQE;
+
+		if (!of_property_read_bool(np, "disable-cqe-dcmd"))
+			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
 	}
 
 	ret = sdhci_arasan_add_host(sdhci_arasan);
-- 
2.11.0
