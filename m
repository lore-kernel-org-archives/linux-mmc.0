Return-Path: <SRS0=i1XN=4W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EE8C3F2D1
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898CA208C3
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Mar 2020 15:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dAuliF8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgCEPKo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:10:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36108 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgCEPKn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Mar 2020 10:10:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025FAbls002251;
        Thu, 5 Mar 2020 09:10:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583421037;
        bh=Ngro9zW0SsWLavCdH7X0E50umfW1jc4G742BvyvMTW8=;
        h=From:To:CC:Subject:Date;
        b=dAuliF8YGjjOIPKNYP59YdJ5jPdWIXQ4FoLt3M4L5sJ137gz53xW+VM0AQrhLA4Jd
         0EUYrQXdcdrL/EY257ur8k2kWfitG7hFpNeHZI0W3Bai8KPEWuzyvUS4IV4xZwPQBX
         AhHrUoYqwgz0aBDnc0+EpdhkiQFhu9HjFlgzUcl4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 025FAbrI082863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 09:10:37 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 09:10:36 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 09:10:36 -0600
Received: from a0230074-OptiPlex-7010.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 025FAY45114541;
        Thu, 5 Mar 2020 09:10:34 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2] mmc: sdhci-omap: Add Support for Suspend/Resume
Date:   Thu, 5 Mar 2020 20:42:28 +0530
Message-ID: <20200305151228.24692-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add power management ops which save and restore the driver context and
facilitate a system suspend and resume.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
v2:
1. Save and restore only those registers which are not written to by
   core
2. Use force_suspend()/resume() APIs instead of runtime_resume()/suspend()
   as the driver has no runtime PM support.
 drivers/mmc/host/sdhci-omap.c | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 882053151a47..989133ec74d6 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -108,6 +108,11 @@ struct sdhci_omap_host {
 	struct pinctrl		*pinctrl;
 	struct pinctrl_state	**pinctrl_state;
 	bool			is_tuning;
+	/* Omap specific context save */
+	u32			con;
+	u32			hctl;
+	u32			sysctl;
+	u32			capa;
 };
 
 static void sdhci_omap_start_clock(struct sdhci_omap_host *omap_host);
@@ -1232,12 +1237,64 @@ static int sdhci_omap_remove(struct platform_device *pdev)
 
 	return 0;
 }
+#ifdef CONFIG_PM_SLEEP
+static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
+{
+	omap_host->con = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
+	omap_host->hctl = sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL);
+	omap_host->capa = sdhci_omap_readl(omap_host, SDHCI_OMAP_CAPA);
+}
+
+static void sdhci_omap_context_restore(struct sdhci_omap_host *omap_host)
+{
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, omap_host->con);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_HCTL, omap_host->hctl);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CAPA, omap_host->capa);
+}
+
+static int __maybe_unused sdhci_omap_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	sdhci_suspend_host(host);
+
+	sdhci_omap_context_save(omap_host);
+
+	pinctrl_pm_select_idle_state(dev);
+
+	pm_runtime_force_suspend(dev);
+
+	return 0;
+}
+
+static int __maybe_unused sdhci_omap_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+
+	pm_runtime_force_resume(dev);
+
+	pinctrl_pm_select_default_state(dev);
+
+	sdhci_omap_context_restore(omap_host);
+
+	sdhci_resume_host(host);
+
+	return 0;
+}
+#endif
+static SIMPLE_DEV_PM_OPS(sdhci_omap_dev_pm_ops, sdhci_omap_suspend,
+			 sdhci_omap_resume);
 
 static struct platform_driver sdhci_omap_driver = {
 	.probe = sdhci_omap_probe,
 	.remove = sdhci_omap_remove,
 	.driver = {
 		   .name = "sdhci-omap",
+		   .pm = &sdhci_omap_dev_pm_ops,
 		   .of_match_table = omap_sdhci_match,
 		  },
 };
-- 
2.19.2

