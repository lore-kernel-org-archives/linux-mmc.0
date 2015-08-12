From: michal.suchanek@ruk.cuni.cz
Subject: [PATCH resend 1/3] mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
Date: 12 Aug 2015 12:23:10 -0000
Message-ID: <7f9c6f99b31702c02436ef3356b3ebffa4754260.1439381423.git.hramrach@gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1439381423.git.hramrach@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-sunxi@googlegroups.com, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Michal Suchanek <hramrach@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The 250ms timeout is too short.

On my system enabling the oclk takes under 50ms and disabling slightly
over 100ms when idle. Under load disabling the clock can take over
350ms.

This does not make mmc clock gating look like good option to have on
sunxi but the system should not crash with mmc clock gating enabled
nonetheless.

This patch sets the timeout to 750ms and adds debug prints which show
how long enabling/disabling the clock took so more data can be collected
from other systems.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>

--

 - fix formatting
---
 drivers/mmc/host/sunxi-mmc.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 4d3e1ff..f808a02 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -595,7 +595,7 @@ static irqreturn_t sunxi_mmc_handle_manual_stop(int irq, void *dev_id)
 
 static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 {
-	unsigned long expire = jiffies + msecs_to_jiffies(250);
+	unsigned long start, end;
 	u32 rval;
 
 	rval = mmc_readl(host, REG_CLKCR);
@@ -604,6 +604,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 	if (oclk_en)
 		rval |= SDXC_CARD_CLOCK_ON;
 
+	start = jiffies;
+	end = start + msecs_to_jiffies(750);
 	mmc_writel(host, REG_CLKCR, rval);
 
 	rval = SDXC_START | SDXC_UPCLK_ONLY | SDXC_WAIT_PRE_OVER;
@@ -611,15 +613,29 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 
 	do {
 		rval = mmc_readl(host, REG_CMDR);
-	} while (time_before(jiffies, expire) && (rval & SDXC_START));
+	} while (time_before(jiffies, end) && (rval & SDXC_START));
+	end = jiffies;
 
 	/* clear irq status bits set by the command */
 	mmc_writel(host, REG_RINTR,
 		   mmc_readl(host, REG_RINTR) & ~SDXC_SDIO_INTERRUPT);
 
 	if (rval & SDXC_START) {
-		dev_err(mmc_dev(host->mmc), "fatal err update clk timeout\n");
+		dev_err(mmc_dev(host->mmc),
+			"fatal err update oclk timeout. Could not %s in %ims.\n",
+			oclk_en ? "enable" : "disable",
+			jiffies_to_msecs(end - start));
 		return -EIO;
+	} else {
+		int msecs = jiffies_to_msecs(end - start);
+		const char *ing = oclk_en ? "enabling" : "disabling";
+
+		if ((msecs > 150) || (oclk_en && (msecs > 50)))
+			dev_warn(mmc_dev(host->mmc),
+				 "%s oclk took %ims", ing, msecs);
+		else
+			dev_dbg(mmc_dev(host->mmc),
+				 "%s oclk took %ims", ing, msecs);
 	}
 
 	return 0;
-- 
2.1.4
