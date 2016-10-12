From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/9] mmc: dw_mmc: add runtime PM callback
Date: Wed, 12 Oct 2016 10:50:35 +0800
Message-ID: <1476240643-5701-2-git-send-email-shawn.lin@rock-chips.com>
References: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.136]:48894 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbcJLCpT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Oct 2016 22:45:19 -0400
In-Reply-To: <1476240643-5701-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

This patch add dw_mci_runtime_suspend/resume interfaces
and expose it to dw_mci variant driver to support runtime
PM.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- use struct device as argument for runtime callback

 drivers/mmc/host/dw_mmc.c | 32 ++++++++++++++++++++++++++++++--
 drivers/mmc/host/dw_mmc.h |  4 +++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4fcbc40..67fa088 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3266,7 +3266,7 @@ EXPORT_SYMBOL(dw_mci_remove);
 
 
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 /*
  * TODO: we should probably disable the clock to the card in the suspend path.
  */
@@ -3324,7 +3324,35 @@ int dw_mci_resume(struct dw_mci *host)
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_resume);
-#endif /* CONFIG_PM_SLEEP */
+
+int dw_mci_runtime_suspend(struct device *dev)
+{
+	int err = 0;
+	struct dw_mci *host = dev_get_drvdata(dev);
+
+	err = dw_mci_suspend(host);
+	if (err)
+		return err;
+
+	clk_disable_unprepare(host->ciu_clk);
+
+	return err;
+}
+EXPORT_SYMBOL(dw_mci_runtime_suspend);
+
+int dw_mci_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct dw_mci *host = dev_get_drvdata(dev);
+
+	ret = clk_prepare_enable(host->ciu_clk);
+	if (ret)
+		return ret;
+
+	return dw_mci_resume(host);
+}
+EXPORT_SYMBOL(dw_mci_runtime_resume);
+#endif /* CONFIG_PM */
 
 static int __init dw_mci_init(void)
 {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index e8cd2de..d14a391 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -234,9 +234,11 @@
 
 extern int dw_mci_probe(struct dw_mci *host);
 extern void dw_mci_remove(struct dw_mci *host);
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 extern int dw_mci_suspend(struct dw_mci *host);
 extern int dw_mci_resume(struct dw_mci *host);
+extern int dw_mci_runtime_suspend(struct device *device);
+extern int dw_mci_runtime_resume(struct device *device);
 #endif
 
 /**
-- 
2.3.7


