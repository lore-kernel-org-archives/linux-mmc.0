From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/7] serial: 8250_omap: Fix PM regression with deferred probe for pm_runtime_reinit
Date: Wed, 10 Feb 2016 15:02:47 -0800
Message-ID: <1455145370-20301-5-git-send-email-tony@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1455145370-20301-1-git-send-email-tony@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
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
Cc: linux-serial@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---

Greg & Peter, I'd like to merge this along with other related fixes
via the ARM SoC tree if no objections, please review and ack if this
look OK to you.

---
 drivers/tty/serial/8250/8250_omap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index a2c0734..81ff337 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1235,7 +1235,8 @@ static int omap8250_probe(struct platform_device *pdev)
 	pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
 err:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return ret;
 }
@@ -1244,6 +1245,7 @@ static int omap8250_remove(struct platform_device *pdev)
 {
 	struct omap8250_priv *priv = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	serial8250_unregister_port(priv->line);
-- 
2.7.0
