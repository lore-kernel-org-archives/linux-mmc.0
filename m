From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH 1/2] mmc: dw_mmc: Handle late vmmc regulator with EPROBE_DEFER
Date: Thu,  6 Jun 2013 21:46:45 -0700
Message-ID: <1370580406-10254-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Will Newton <will.newton-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Alim Akhtar <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

It is possible to specify a regulator that should be turned on when
dw_mmc is probed.  This regulator is optional, though a warning will
be printed if it's missing.  The fact that the regulator is optional
means that (at the moment) it's not possible to use a regulator that
probes _after_ dw_mmc.

Fix this limitation by adding the ability to make vmmc required.  If a
vmmc-supply is specified in the device tree we'll assume that vmmc is
required.

Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |  3 +++
 drivers/mmc/host/dw_mmc.c                          | 22 ++++++++++++++++++++--
 include/linux/mmc/dw_mmc.h                         |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
index 726fd21..b09d2d0 100644
--- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
@@ -55,6 +55,9 @@ Optional properties:
 
 * broken-cd: as documented in mmc core bindings.
 
+* vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
+  specified we'll defer probe until we can find this regulator.
+
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bc3a1bc..d3a0f8a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1987,8 +1987,17 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	host->vmmc = devm_regulator_get(mmc_dev(mmc), "vmmc");
 	if (IS_ERR(host->vmmc)) {
-		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
+		ret = PTR_ERR(host->vmmc);
 		host->vmmc = NULL;
+
+		if (host->pdata->vmmc_required) {
+			if (ret != -EPROBE_DEFER)
+				pr_err("%s: vmmc required: %d\n",
+					mmc_hostname(mmc), ret);
+			goto err_setup_bus;
+		}
+		pr_info("%s: no vmmc regulator found %d\n", mmc_hostname(mmc),
+			ret);
 	} else {
 		ret = regulator_enable(host->vmmc);
 		if (ret) {
@@ -2026,7 +2035,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 err_setup_bus:
 	mmc_free_host(mmc);
-	return -EINVAL;
+	return ret;
 }
 
 static void dw_mci_cleanup_slot(struct dw_mci_slot *slot, unsigned int id)
@@ -2162,6 +2171,13 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		pdata->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
 
+	/*
+	 * If vmmc is directly specified in the device tree then we'll assume
+	 * it's required and honor EPROBE_DEFER so it can show up late.
+	 */
+	if (of_find_property(np, "vmmc-supply", NULL))
+		pdata->vmmc_required = 1;
+
 	return pdata;
 }
 
@@ -2352,6 +2368,8 @@ int dw_mci_probe(struct dw_mci *host)
 	/* We need at least one slot to succeed */
 	for (i = 0; i < host->num_slots; i++) {
 		ret = dw_mci_init_slot(host, i);
+		if (ret == -EPROBE_DEFER)
+			goto err_workqueue;
 		if (ret)
 			dev_dbg(host->dev, "slot %d init failed\n", i);
 		else
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 198f0fa..e84d288 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -244,6 +244,9 @@ struct dw_mci_board {
 	/* delay in mS before detecting cards after interrupt */
 	u32 detect_delay_ms;
 
+	/* If true then we won't probe until vmmc is available */
+	bool vmmc_required;
+
 	int (*init)(u32 slot_id, irq_handler_t , void *);
 	int (*get_ro)(u32 slot_id);
 	int (*get_cd)(u32 slot_id);
-- 
1.8.3
