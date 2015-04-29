From: <micky_ching@realsil.com.cn>
Subject: [PATCH 08/12] mmc: sdhci: add SD4.0 operations
Date: Wed, 29 Apr 2015 09:23:40 +0800
Message-ID: <3c3a1feab6fe3300b65467f928215ed111e5d192.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

SD4.0 operations include UHSII interface detect, go/exit dormant
and uhsii ios settings.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/sdhci.c | 183 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 182 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c80287a..df1b88d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -143,6 +143,32 @@ static void sdhci_dumpregs(struct sdhci_host *host)
  *                                                                           *
 \*****************************************************************************/
 
+static int sdhci_checkw(struct sdhci_host *host, int reg,
+	u16 mask, u16 done, int msec)
+{
+	while (msec > 0) {
+		if ((sdhci_readw(host, reg) & mask) == done)
+			return 0;
+		mdelay(1);
+		msec--;
+	};
+	DBG("check %x(%x) %x failed\n", reg, mask, done);
+	return -ETIMEDOUT;
+}
+
+static int sdhci_checkl(struct sdhci_host *host, int reg,
+	u32 mask, u32 done, int msec)
+{
+	while (msec > 0) {
+		if ((sdhci_readl(host, reg) & mask) == done)
+			return 0;
+		mdelay(1);
+		msec--;
+	};
+	DBG("check %x(%x) %x failed\n", reg, mask, done);
+	return -ETIMEDOUT;
+}
+
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
 	u32 present;
@@ -2224,6 +2250,158 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static int sdhci_switch_uhsii_if(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+	int err = 0;
+	u32 present;
+	u16 clk, ctrl2;
+	u8 pwr;
+
+	host->uhsii_if_enabled = false;
+	spin_lock_irqsave(&host->lock, flags);
+
+	clk = SDHCI_CLOCK_INT_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	if (sdhci_checkw(host, SDHCI_CLOCK_CONTROL,
+			SDHCI_CLOCK_INT_STABLE,
+			SDHCI_CLOCK_INT_STABLE, 20) < 0) {
+		pr_err("%s: Internal clock not ready.\n",
+			mmc_hostname(host->mmc));
+		sdhci_dumpregs(host);
+		err = -ETIMEDOUT;
+		goto out;
+	}
+
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl2 |= SDHCI_CTRL_UHSII_IF_ENABLE;
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+	pwr = (SDHCI_POWER_ON | SDHCI_POWER_330) << SDHCI_VDD1_SHIFT;
+	pwr |= (SDHCI_POWER_ON | SDHCI_POWER_180) << SDHCI_VDD2_SHIFT;
+	sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+	ctrl2 |= SDHCI_CTRL_UHSII;
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+	/* Wait Power Ramp Up Time */
+	spin_unlock_irqrestore(&host->lock, flags);
+	msleep(20);
+	spin_lock_irqsave(&host->lock, flags);
+
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	udelay(200);
+
+	present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	if (present & SDHCI_STBL_DETECT) {
+		if (sdhci_checkl(host, SDHCI_PRESENT_STATE,
+				SDHCI_LANE_SYNC,
+				SDHCI_LANE_SYNC, 20) < 0) {
+			pr_err("%s: UHS-II PHY is not initialized\n",
+				mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			err = -ETIMEDOUT;
+			goto out;
+		}
+		host->uhsii_if_enabled = true;
+	} else {
+		pr_info("%s: UHS-II IF is not detected\n",
+			mmc_hostname(host->mmc));
+		goto out;
+	}
+
+out:
+	if (!host->uhsii_if_enabled) {
+		pwr = SDHCI_POWER_330 << SDHCI_VDD1_SHIFT;
+		pwr |= SDHCI_POWER_180 << SDHCI_VDD2_SHIFT;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+		spin_unlock_irqrestore(&host->lock, flags);
+		msleep(100);
+		spin_lock_irqsave(&host->lock, flags);
+
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl2 &= ~SDHCI_CTRL_UHSII_IF_ENABLE;
+		ctrl2 &= ~SDHCI_CTRL_UHS_MASK;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+		err = -ENXIO;
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+	return err;
+}
+
+static int sdhci_exit_dormant(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u16 clk;
+
+	clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	clk |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+	udelay(200);
+
+	if (sdhci_checkl(host, SDHCI_PRESENT_STATE,
+			SDHCI_IN_DORMANT_STATE, 0, 100) < 0) {
+		pr_err("%s: Still in dormant state.\n",
+			mmc_hostname(host->mmc));
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void sdhci_set_uhsii_ios(struct mmc_host *mmc, struct mmc_uhsii_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	u32 reg;
+
+	sdhci_runtime_pm_get(host);
+
+	/* speed range */
+	if (ios->flags & SETTING_SPEED_RANGE) {
+		reg = sdhci_readl(host,
+			host->uhsii_settings_ptr + SDHCI_UHSII_PHY_REG);
+		reg &= ~SDHCI_UHSII_RANGE_MASK;
+		reg |= (ios->speed_range << SDHCI_UHSII_RANGE_SHIFT) &
+			SDHCI_UHSII_RANGE_MASK;
+		sdhci_writel(host, reg,
+			host->uhsii_settings_ptr + SDHCI_UHSII_PHY_REG);
+	}
+
+	/* n_fcu */
+	if (ios->flags & SETTING_N_FCU) {
+		if (host->n_fcu) {
+			if (!ios->n_fcu || (ios->n_fcu > host->n_fcu))
+				ios->n_fcu = host->n_fcu;
+		}
+		reg = sdhci_readl(host,
+			host->uhsii_settings_ptr + SDHCI_UHSII_LINK_REG_L);
+		reg &= ~SDHCI_UHSII_N_FCU_MASK;
+		reg |= (ios->n_fcu << SDHCI_UHSII_N_FCU_SHIFT) &
+			SDHCI_UHSII_N_FCU_MASK;
+		sdhci_writel(host, reg,
+			host->uhsii_settings_ptr + SDHCI_UHSII_LINK_REG_L);
+	}
+
+	/* power control mode */
+	if (ios->flags & SETTING_PWR_CTL_MODE) {
+		reg = sdhci_readl(host,
+			host->uhsii_settings_ptr + SDHCI_UHSII_GENERAL_REG);
+		reg |= SDHCI_UHSII_LOW_PWR_MODE;
+		sdhci_writel(host, reg,
+			host->uhsii_settings_ptr + SDHCI_UHSII_GENERAL_REG);
+	}
+
+	sdhci_runtime_pm_put(host);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.post_req	= sdhci_post_req,
@@ -2237,7 +2415,10 @@ static const struct mmc_host_ops sdhci_ops = {
 	.prepare_hs400_tuning		= sdhci_prepare_hs400_tuning,
 	.execute_tuning			= sdhci_execute_tuning,
 	.card_event			= sdhci_card_event,
-	.card_busy	= sdhci_card_busy,
+	.card_busy			= sdhci_card_busy,
+	.switch_uhsii_if		= sdhci_switch_uhsii_if,
+	.exit_dormant			= sdhci_exit_dormant,
+	.set_uhsii_ios			= sdhci_set_uhsii_ios,
 };
 
 /*****************************************************************************\
-- 
1.9.1
