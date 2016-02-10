From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/7] i2c: omap: Fix PM regression with deferred probe for pm_runtime_reinit
Date: Wed, 10 Feb 2016 15:02:45 -0800
Message-ID: <1455145370-20301-3-git-send-email-tony@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1455145370-20301-1-git-send-email-tony@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-mmc@vger.kernel.org

Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
error and driver unbind") introduced pm_runtime_reinit() that is used
to reinitialize PM runtime after -EPROBE_DEFER. This allows shutting
down the device after a failed probe.

However, for drivers using pm_runtime_use_autosuspend() this can cause
a state where suspend callback is never called after -EPROBE_DEFER.
On the following device driver probe, hardware state is different from
the PM runtime state causing omap_device to produce the following
error:

omap_device_enable() called from invalid state 1

And with omap_device and omap hardware being picky for PM, this will
block any deeper idle states in hardware.

The solution is to fix the drivers to follow the PM runtime documentation:

1. For sections of code that needs the device disabled, use
   pm_runtime_put_sync_suspend() if pm_runtime_set_autosuspend() has
   been set.

2. For driver exit code, use pm_runtime_dont_use_autosuspend() before
   pm_runtime_put_sync() if pm_runtime_use_autosuspend() has been
   set.

Fixes: 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
error and driver unbind")
Cc: linux-i2c@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Wolfram, I'd like to merge this along with other related fixes via
the ARM SoC tree if no objections, please review and ack if this
look OK to you.


---

 drivers/i2c/busses/i2c-omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 08d26ba..13c4529 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1450,7 +1450,8 @@ omap_i2c_probe(struct platform_device *pdev)
 
 err_unuse_clocks:
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
-	pm_runtime_put(omap->dev);
+	pm_runtime_dont_use_autosuspend(omap->dev);
+	pm_runtime_put_sync(omap->dev);
 	pm_runtime_disable(&pdev->dev);
 err_free_mem:
 
@@ -1468,6 +1469,7 @@ static int omap_i2c_remove(struct platform_device *pdev)
 		return ret;
 
 	omap_i2c_write_reg(omap, OMAP_I2C_CON_REG, 0);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
-- 
2.7.0
