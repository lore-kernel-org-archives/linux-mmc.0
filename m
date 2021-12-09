Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAF2C4167D
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Dec 2021 20:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhLIVCg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Dec 2021 16:02:36 -0500
Received: from smtp2.axis.com ([195.60.68.18]:28320 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232400AbhLIVCg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Dec 2021 16:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639083542;
  x=1670619542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ifjz8wSLY/DbbYjZkM2WeIXUgShoeDmFBZtH4lFMR1k=;
  b=P5WhHKKFOdp5DPFbyJBYoA8vQu9tSA1w3/Jv8IJN+yHA+VIeuqy65Oym
   PosPeC3Hdgt6MNwByr3yOf6B35rxPxJFtuCtf+B+wJb6YD013YWmdS/Sr
   SLqPu4Og893fNYLLPfulk9cxqefrFY2wZbFPmErK8zrZlIdk/kHmp5BaS
   9SF2XR/cLZvdDJ30aY7+Oy9sHcXQfqt3hCuMPa1/hV+fXYH9VK1renTez
   4CvsUvm3XCwtPXkG+YAk0Zt64HKH5faBiATn9W6RStxir5+ws0H0IW4o3
   nAm3fvOKxffgl5TKqDiYiOiPY+CuWJusq6LLT7x3LumckoQmpnuTZFWXa
   g==;
From:   =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
CC:     Doug Anderson <dianders@google.com>, <kernel@axis.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH v4 3/4] mmc: dw_mmc: Add driver callbacks for data read timeout
Date:   Thu, 9 Dec 2021 21:54:55 +0100
Message-ID: <20211209205456.11027-4-marten.lindahl@axis.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211209205456.11027-1-marten.lindahl@axis.com>
References: <20211209205456.11027-1-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Current dw_mci driver supports a TMOUT register which consists of a 24
bit field (TMOUT[31:8]) for the DATA_TIMEOUT. The maximum value of this
field is 0xFFFFFF, which with a 200MHz clock will give a full DRTO of:

0xFFFFFF / 200000000 => ~84 ms

However, the ARTPEC-8 SoC DWMMC IP version has a TMOUT register with an
extended DATA_TIMEOUT field, which supports longer timers for the DRTO.
In this version the DATA_TIMEOUT field is split into two, which with the
same 200MHz clock as above will allow a maximum timeout of:

((TMOUT[10:8] -1) * 0xFFFFFF + TMOUT[31:11] * 8) / 200000000 => ~587 ms

Add driver callbacks for implementation specific data timeout, and
implement callback functions for the ARTPEC-8 SoC.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---

v2:
 - Removed unnecessary comment
 - Change 1<<0 to BIT(0)

v3:
 - Add callback for implementation specific control of data timeout
 - Add callback for implementation specific read of cycle count for
   data timeout.
 - Remove definition and use of DW_MMC_QUIRK_EXTENDED_TMOUT.

v4:
 - Add Krzysztof's Acked-by tag from v2

 drivers/mmc/host/dw_mmc-exynos.c | 49 ++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c        | 12 +++++++-
 drivers/mmc/host/dw_mmc.h        |  5 ++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index 86486e6659de..4e5612d04504 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -539,6 +539,53 @@ static int dw_mci_exynos_prepare_hs400_tuning(struct dw_mci *host,
 	return 0;
 }
 
+static void dw_mci_exynos_set_data_timeout(struct dw_mci *host,
+					   unsigned int timeout_ns)
+{
+	u32 clk_div, tmout;
+	u64 tmp;
+	unsigned int tmp2;
+
+	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
+	if (clk_div == 0)
+		clk_div = 1;
+
+	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER_SEC);
+	tmp = DIV_ROUND_UP_ULL(tmp, clk_div);
+
+	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
+	tmout = 0xFF; /* Set maximum */
+
+	/*
+	 * Extended HW timer (max = 0x6FFFFF2):
+	 * ((TMOUT[10:8] - 1) * 0xFFFFFF + TMOUT[31:11] * 8)
+	 */
+	if (!tmp || tmp > 0x6FFFFF2)
+		tmout |= (0xFFFFFF << 8);
+	else {
+		/* TMOUT[10:8] */
+		tmp2 = (((unsigned int)tmp / 0xFFFFFF) + 1) & 0x7;
+		tmout |= tmp2 << 8;
+
+		/* TMOUT[31:11] */
+		tmp = tmp - ((tmp2 - 1) * 0xFFFFFF);
+		tmout |= (tmp & 0xFFFFF8) << 8;
+	}
+
+	mci_writel(host, TMOUT, tmout);
+	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
+		timeout_ns, tmout >> 8);
+}
+
+static u32 dw_mci_exynos_get_drto_clks(struct dw_mci *host)
+{
+	u32 drto_clks;
+
+	drto_clks = mci_readl(host, TMOUT) >> 8;
+
+	return (((drto_clks & 0x7) - 1) * 0xFFFFFF) + ((drto_clks & 0xFFFFF8));
+}
+
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
 	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA,
@@ -564,6 +611,8 @@ static const struct dw_mci_drv_data artpec_drv_data = {
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
 	.execute_tuning		= dw_mci_exynos_execute_tuning,
+	.set_data_timeout		= dw_mci_exynos_set_data_timeout,
+	.get_drto_clks		= dw_mci_exynos_get_drto_clks,
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f2a14a434bef..a7745e193afa 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1287,9 +1287,13 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 static void dw_mci_set_data_timeout(struct dw_mci *host,
 				    unsigned int timeout_ns)
 {
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	u32 clk_div, tmout;
 	u64 tmp;
 
+	if (drv_data && drv_data->set_data_timeout)
+		return drv_data->set_data_timeout(host, timeout_ns);
+
 	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
 	if (clk_div == 0)
 		clk_div = 1;
@@ -1995,12 +1999,16 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
 
 static void dw_mci_set_drto(struct dw_mci *host)
 {
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	unsigned int drto_clks;
 	unsigned int drto_div;
 	unsigned int drto_ms;
 	unsigned long irqflags;
 
-	drto_clks = mci_readl(host, TMOUT) >> 8;
+	if (drv_data && drv_data->get_drto_clks)
+		drto_clks = drv_data->get_drto_clks(host);
+	else
+		drto_clks = mci_readl(host, TMOUT) >> 8;
 	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (drto_div == 0)
 		drto_div = 1;
@@ -2008,6 +2016,8 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
 				   host->bus_hz);
 
+	dev_dbg(host->dev, "drto_ms: %u\n", drto_ms);
+
 	/* add a bit spare time */
 	drto_ms += 10;
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 771d5afa3136..0a85d05eaf12 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -556,6 +556,8 @@ struct dw_mci_slot {
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
  * @execute_tuning: implementation specific tuning procedure.
+ * @set_data_timeout: implementation specific timeout.
+ * @get_drto_clks: implementation specific cycle count for data read timeout.
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
@@ -573,5 +575,8 @@ struct dw_mci_drv_data {
 						struct mmc_ios *ios);
 	int		(*switch_voltage)(struct mmc_host *mmc,
 					  struct mmc_ios *ios);
+	void		(*set_data_timeout)(struct dw_mci *host,
+					  unsigned int timeout_ns);
+	u32		(*get_drto_clks)(struct dw_mci *host);
 };
 #endif /* _DW_MMC_H_ */
-- 
2.20.1

