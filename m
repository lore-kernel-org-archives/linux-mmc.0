Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C240758A;
	Wed,  4 Feb 2026 13:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770210039; cv=none; b=UhdNj1j7vhJzUc8W4WhgfV+kKjCGZ5EX8ag9fNGFUeKTody01FibK8kjrUAJ00cj0PN3C5XFWm/4i/T4cBdpvIw4Uqtf7kE91wuk/LMfIMVFy+R5eGqa6HKDQruGI4QydgW5BaGVEvSHu5t0UfYYCbu171mJ+8kQPHZUalpEfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770210039; c=relaxed/simple;
	bh=6BzlqE5f8JsaCNH0scfjLkqSnF2Qd4TPXWH8WKOYnxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TS97F14pmv6lkHTzXGASzrjqdVgt8dXwZzWlfhMLH/BeNCiz4/FvazVy5o8FtFu6HCTJaWb4LN5ODtJWopYIbeZy0Ebapd4d6tPM0PAy9WdzfXHktv42xOgUO+m4IW99UNekGwpoehyyaK6Rbam6wnBeYSKcKAV7sch1v+hD/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0JUhp0q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0JUhp0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA434C4CEF7;
	Wed,  4 Feb 2026 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770210039;
	bh=6BzlqE5f8JsaCNH0scfjLkqSnF2Qd4TPXWH8WKOYnxU=;
	h=From:To:Cc:Subject:Date:From;
	b=B0JUhp0qE9gxtibL3GdycPIm9hM8BmItbyOWHiTDp49r0AI9FyD5EB4ayK98XaCIY
	 GMwUlCa2D6SyHYHC8vMQQ4F6ZUqqnEV39vSlyUW95uxRc4Q3WSxOGvHTnAOg/gi9P5
	 nuTugv+mGngwH3d6vkpgBcCBKCGlYRJZ2NqKPXeyBr9IeiKQX68n6Bk8BHhmm+/JaQ
	 EkUDwHpxLmUvR5cEg+0RH3MFvaaxHGhCct5PRdOLp+gzj5ESsX9TbH5KV6/971faV6
	 qbARYpED1gO1/WE/RjdgRzX2hhrJMhiB2oWXaccC54XUoVDivYRdJ70VRj4YJhk5ec
	 r/QlrUu9t7o+Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: dw_mmc: move pmops into core driver
Date: Wed,  4 Feb 2026 14:00:19 +0100
Message-Id: <20260204130035.4088103-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Since the platform power management structure is now shared with the PCI
front-end, there is a link failure if only the PCI variant is enabled:

arm-linux-gnueabi/bin/arm-linux-gnueabi-ld: drivers/mmc/host/dw_mmc-pci.o:(.data+0x74): undefined reference to `dw_mci_pltfm_pmops'

This could be fixed by selecting the platform driver from the PCI one
in Kconfig, or by reverting the change to the PCI driver, but since this
is now used by all dw_mmc variants, just move the structure into the core
code as well.

Fixes: d9346fb36d84 ("mmc: dw_mmc-pltfm: use modern PM macros")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I ended up not renaming the structure in the process, but that
would be another option.
---
 drivers/mmc/host/dw_mmc-pltfm.c | 9 ---------
 drivers/mmc/host/dw_mmc.c       | 6 ++++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
index fde465a4bf5d..079d0cc97766 100644
--- a/drivers/mmc/host/dw_mmc-pltfm.c
+++ b/drivers/mmc/host/dw_mmc-pltfm.c
@@ -56,15 +56,6 @@ int dw_mci_pltfm_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(dw_mci_pltfm_register);
 
-const struct dev_pm_ops dw_mci_pltfm_pmops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
-};
-EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
-
 static int dw_mci_socfpga_priv_init(struct dw_mci *host)
 {
 	struct device_node *np = host->dev->of_node;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b2ac61f3a8f7..97e880022007 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3523,6 +3523,12 @@ int dw_mci_runtime_resume(struct device *dev)
 }
 EXPORT_SYMBOL(dw_mci_runtime_resume);
 
+const struct dev_pm_ops dw_mci_pltfm_pmops = {
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
+
 static int __init dw_mci_init(void)
 {
 	pr_info("Synopsys Designware Multimedia Card Interface Driver\n");
-- 
2.39.5

