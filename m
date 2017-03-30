From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v7 03/13] mmc: sdhci: Export sdhci_set_ios() from sdhci.c
Date: Thu, 30 Mar 2017 17:22:55 +0200
Message-ID: <e03ff1bc129aac815ca5859024c1fe23e5d30965.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
In-Reply-To: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
References: <cover.51071caa64e5df81264a91b9a81ed1e94f47d2c4.1490886907.git-series.gregory.clement@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Jimmy Xu <zmxu@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Mike Turquette <mturquette@baylibre.com>, Nadav Haklai <nadavh@marvell.com>, Ziji Hu <huziji@marvell.com>, Victor Gu <xigu@marvell.com>, Doug Jones <dougj@marvell.com>, linux-clk@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Kostya Porotchkin <kostap@marvell.com>, Hanna Hawa <hannah@marvell.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Ryan Gao <ygao@marvell.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, Wilson
List-Id: linux-mmc@vger.kernel.org

From: Hu Ziji <huziji@marvell.com>

Export sdhci_set_ios() in sdhci.c.
Thus vendor sdhci driver can implement its own set_ios() routine.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 811981394e6e..d5bca886419d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1583,7 +1583,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u8 ctrl;
@@ -1738,6 +1738,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	mmiowb();
 }
+EXPORT_SYMBOL_GPL(sdhci_set_ios);
 
 static int sdhci_get_cd(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index fdb5d7e1911f..b0cb805937c0 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -703,6 +703,7 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 #ifdef CONFIG_PM
 int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.9.1
