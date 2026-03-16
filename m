Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265D31ED8B;
	Mon, 16 Mar 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673317; cv=none; b=Yo+fzvuIYAQyrHUqfcmQ5wlpNBpU5jojyVJ0r2lMnZk11Gq1VHrLYHbly0K0zib3Wh/9j9+4mkGxcqIpWG2t7GsMoR4FDWw4JPIb3CZO/UU91d/xZAdO35a+gfUJmc9tGG9WQ15XxS7LDO97+XvnjrVCCIJFK4HhQ6ACJbePIVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673317; c=relaxed/simple;
	bh=TCROuLuCvVeKGHY5amP+gF+F//RDY9vZAv5sgyX4Owg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VOKZqPF74y5NptvFxM7FWm0GD+qVKjDzg4HF0jUVnlPPUaWrtV7a+NrlBks9zhbaRrEre/i0CPO2z9YfcJFCbC60I4WQV7MroUMO+GC3ykRGn+hd4eJQkhOD+uYTMXLS0fZSO7RrlHgbcpwMVYZu+s3LIPTjdWrudSDk+xvVbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=j+KHzDuH; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="j+KHzDuH"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEuIZl1744343;
	Mon, 16 Mar 2026 15:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=wHyC1l7rZl3tS
	EG4pMWax2RHxMo4mUmVt95b2pocSHA=; b=j+KHzDuHR0tVPixYesdq/OY6irpnO
	1KZ3BUEdqm7DTvG0MsC/pXX593l0QTj0DoyqKqcrifxJ+GdzkKFBYia5pzSIvmCA
	bMB57K3nZR6kAH+eHk9npyl1jiZvp9mF9KLb4xy5+y5o+7hpi4HlFLoYE3LB+GQd
	7EZbLD49RW/xtJlCURBV0JStBM2DfRMDJNwSOKVieazZzP2MUHEG5ZE8J/uqE0n6
	qavjGf5KB/ISY/FYo44PWov0SNu4tdKUd/S2iG9HaVdSdfjMxhBaU3jv9puGTOkt
	ZhfgE6EVw5ycJq/ssGvimMyCbuKQpslxPV0p8lrwLnKrU3chmD1xSw2ZQ==
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4cxm2m029n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:01:22 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 5C695295C6;
	Mon, 16 Mar 2026 15:01:21 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id DEBB0808040;
	Mon, 16 Mar 2026 15:01:20 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jszhang@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v4 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Date: Mon, 16 Mar 2026 10:01:15 -0500
Message-Id: <20260316150115.2616827-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316150115.2616827-1-nick.hawkins@hpe.com>
References: <20260316150115.2616827-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H8bWAuYi c=1 sm=1 tr=0 ts=69b81b42 cx=c_pps
 a=UObrlqRbTUrrdMEdGJ+KZA==:117 a=UObrlqRbTUrrdMEdGJ+KZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=g3u0LPWLDYfGfufhFw6-:22 a=MvuuwTCpAAAA:8 a=zvCiIjuygFczqSAEsLgA:9
X-Proofpoint-GUID: 8vagLWUSOI5VRFVz7T5bXtp9dwuweExq
X-Proofpoint-ORIG-GUID: 8vagLWUSOI5VRFVz7T5bXtp9dwuweExq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExMSBTYWx0ZWRfX8KHF8xuhJzwC
 LyLHomoTRkg1ZHw3yUki2ycCDXCzjU0Ha2WJSRE1jeXmR2dxRxKcA+lbV4BNZjSx+BERX6vSyc/
 k45TRidENn5yl5xdqEIqoh9tpb0c9Bdo9gvzWWLpT1+aYgPywJYFyDY6b1See9NWiZxInnkobL7
 C0EP/9bCN55LEiM9w6fFv9JQB5RJPIh6Y9RlV7yNUIrYNKg3rgjCpNCn7hEsF5ojqGy6TKyLNHH
 5i0nTSpEO0CWJeIvJcNnhNCUJT5VlVxM/KOEFwlYmydwONMcKxh0roneUaW/99anqLAl7L7oeLJ
 mb9NQZ5MbH6WGhLQOvqJRLPa9JIQ9olazoJNIdiwSfgPiHC1SbPSAa799ENklquqSYmh1wcDax5
 Yz+HNFOOOze9GfSf9Z2RLe28mx06KhfoTpSxCFXRqapopMC+lPBtmQEwDJS47Gd84MOliA1nvwD
 SmKb07fx1pOE9ATQmCw==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160111

From: Nick Hawkins <nick.hawkins@hpe.com>

Add support for the eMMC controller integrated in the HPE GSC (ARM64
Cortex-A53) BMC SoC under the new 'hpe,gsc-dwcmshc' compatible
string.

The HPE GSC eMMC controller is based on the DesignWare Cores MSHC IP
but requires several platform-specific adjustments:

Clock mux (dwcmshc_hpe_set_clock):
  The GSC SoC wires SDHCI_CLOCK_CONTROL.freq_sel directly to a clock
  mux rather than a divider.  Forcing freq_sel = 1 when the requested
  clock is 200 MHz (HS200) selects the correct high-speed clock source.
  Using the generic sdhci_set_clock() would otherwise leave the mux on
  the wrong source after tuning.

Auto-tuning / vendor config (dwcmshc_hpe_vendor_specific):
  Disables the command-conflict check (DWCMSHC_HOST_CTRL3 BIT(0)) and
  programs the ATCTRL register using existing AT_CTRL_* macros:
    AT_CTRL_AT_EN           auto-tuning circuit enable
    AT_CTRL_SWIN_TH_EN      sampling window threshold enable
    AT_CTRL_TUNE_CLK_STOP_EN tune-clock-stop enable
    PRE_CHANGE_DLY  = 3     pre-change delay
    POST_CHANGE_DLY = 3     post-change delay
    SWIN_TH_VAL    = 2      sampling window threshold
  This combination is required for reliable HS200 signal integrity on
  the GSC PCB trace topology.

eMMC mode (dwcmshc_hpe_set_emmc):
  Helper that sets DWCMSHC_CARD_IS_EMMC unconditionally.  Called from
  both the reset and UHS-signaling paths.

Reset (dwcmshc_hpe_reset):
  Calls dwcmshc_reset(), re-applies the vendor config above via
  dwcmshc_hpe_vendor_specific(), and then calls dwcmshc_hpe_set_emmc().
  The GSC controller clears the CARD_IS_EMMC bit on every reset;
  leaving it clear causes card-detect mis-identification on an
  eMMC-only slot.

UHS signaling (dwcmshc_hpe_set_uhs_signaling):
  Wraps dwcmshc_set_uhs_signaling() and calls dwcmshc_hpe_set_emmc()
  to ensure CARD_IS_EMMC is set for all timing modes, not just HS400.

Init (dwcmshc_hpe_gsc_init):
  Obtains the SoC register block and MSHCCS offset via the
  'hpe,gxp-sysreg' syscon phandle argument and sets SCGSyncDis
  (BIT(18)) to allow the HS200 RX delay lines to settle while the
  card clock is stopped during auto-tuning.  Enables SDHCI v4 mode.

Quirks:
  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN:  base clock not advertised in
    capabilities; must be obtained from the DTS 'clocks' property.
  SDHCI_QUIRK2_PRESET_VALUE_BROKEN:  preset-value registers are not
    populated in the GSC ROM.

All HPE-specific code is isolated to the new hpe_gsc_init / hpe_ops /
hpe_gsc_pdata symbols.  No existing platform (Rockchip, T-Head, sg2042,
etc.) is affected.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 147 ++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 2b75a36c096b..f4c5c1aa0ebe 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -40,7 +40,10 @@
 #define DWCMSHC_AREA1_MASK		GENMASK(11, 0)
 /* Offset inside the  vendor area 1 */
 #define DWCMSHC_HOST_CTRL3		0x8
+#define DWCMSHC_HOST_CTRL3_CMD_CONFLICT	BIT(0)
 #define DWCMSHC_EMMC_CONTROL		0x2c
+/* HPE GSC SoC MSHCCS register */
+#define HPE_GSC_MSHCCS_SCGSYNCDIS	BIT(18)
 #define DWCMSHC_CARD_IS_EMMC		BIT(0)
 #define DWCMSHC_ENHANCED_STROBE		BIT(8)
 #define DWCMSHC_EMMC_ATCTRL		0x40
@@ -1245,6 +1248,127 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
 					     ARRAY_SIZE(clk_ids), clk_ids);
 }
 
+/*
+ * HPE GSC-specific vendor configuration: disable command conflict check
+ * and program Auto-Tuning Control register.
+ */
+static void dwcmshc_hpe_vendor_specific(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u32 atctrl;
+	u8 extra;
+
+	extra = sdhci_readb(host, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+	extra &= ~DWCMSHC_HOST_CTRL3_CMD_CONFLICT;
+	sdhci_writeb(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+
+	atctrl = AT_CTRL_AT_EN | AT_CTRL_SWIN_TH_EN | AT_CTRL_TUNE_CLK_STOP_EN |
+		FIELD_PREP(AT_CTRL_PRE_CHANGE_DLY_MASK, 3) |
+		FIELD_PREP(AT_CTRL_POST_CHANGE_DLY_MASK, AT_CTRL_POST_CHANGE_DLY) |
+		FIELD_PREP(AT_CTRL_SWIN_TH_VAL_MASK, 2);
+	sdhci_writel(host, atctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+}
+
+static void dwcmshc_hpe_set_emmc(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	ctrl |= DWCMSHC_CARD_IS_EMMC;
+	sdhci_writew(host, ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+}
+
+static void dwcmshc_hpe_reset(struct sdhci_host *host, u8 mask)
+{
+	dwcmshc_reset(host, mask);
+	dwcmshc_hpe_vendor_specific(host);
+	dwcmshc_hpe_set_emmc(host);
+}
+
+static void dwcmshc_hpe_set_uhs_signaling(struct sdhci_host *host,
+					   unsigned int timing)
+{
+	dwcmshc_set_uhs_signaling(host, timing);
+	dwcmshc_hpe_set_emmc(host);
+}
+
+/*
+ * HPE GSC eMMC controller clock setup.
+ *
+ * The GSC SoC wires the freq_sel field of SDHCI_CLOCK_CONTROL directly to a
+ * clock mux rather than a divider. Force freq_sel = 1 when running at
+ * 200 MHz (HS200) so the mux selects the correct clock source.
+ */
+static void dwcmshc_hpe_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	host->mmc->actual_clock = 0;
+
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+
+	if (clock == 0)
+		return;
+
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+
+	if (host->mmc->actual_clock == 200000000)
+		clk |= (1 << SDHCI_DIVIDER_SHIFT);
+
+	sdhci_enable_clk(host, clk);
+}
+
+/*
+ * HPE GSC eMMC controller init.
+ *
+ * The GSC SoC requires configuring MSHCCS.  Bit 18 (SCGSyncDis) disables clock
+ * synchronisation for phase-select values going to the HS200 RX delay lines,
+ * allowing the card clock to be stopped while the delay selection settles and
+ * the phase shift is applied.  This must be used together with the ATCTRL
+ * settings programmed in dwcmshc_hpe_vendor_specific():
+ *   AT_CTRL_R.TUNE_CLK_STOP_EN  = 0x1
+ *   AT_CTRL_R.POST_CHANGE_DLY   = 0x3
+ *   AT_CTRL_R.PRE_CHANGE_DLY    = 0x3
+ *
+ * The DTS node provides a syscon phandle ('hpe,gxp-sysreg') with the
+ * MSHCCS register offset as an argument.
+ */
+static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
+				struct dwcmshc_priv *dwc_priv)
+{
+	unsigned int reg_offset;
+	struct regmap *soc_ctrl;
+	int ret;
+
+	/* Disable cmd conflict check and configure auto-tuning */
+	dwcmshc_hpe_vendor_specific(host);
+
+	/* Look up the GXP sysreg syscon and MSHCCS offset */
+	soc_ctrl = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+							"hpe,gxp-sysreg",
+							1, &reg_offset);
+	if (IS_ERR(soc_ctrl)) {
+		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
+		return PTR_ERR(soc_ctrl);
+	}
+
+	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
+	ret = regmap_update_bits(soc_ctrl, reg_offset,
+				 HPE_GSC_MSHCCS_SCGSYNCDIS,
+				 HPE_GSC_MSHCCS_SCGSYNCDIS);
+	if (ret) {
+		dev_err(dev, "failed to set SCGSyncDis in MSHCCS\n");
+		return ret;
+	}
+
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
 static void sdhci_eic7700_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1834,6 +1958,25 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
 	.init = eic7700_init,
 };
 
+static const struct sdhci_ops sdhci_dwcmshc_hpe_ops = {
+	.set_clock		= dwcmshc_hpe_set_clock,
+	.set_bus_width		= sdhci_set_bus_width,
+	.set_uhs_signaling	= dwcmshc_hpe_set_uhs_signaling,
+	.get_max_clock		= dwcmshc_get_max_clock,
+	.reset			= dwcmshc_hpe_reset,
+	.adma_write_desc	= dwcmshc_adma_write_desc,
+	.irq			= dwcmshc_cqe_irq_handler,
+};
+
+static const struct dwcmshc_pltfm_data sdhci_dwcmshc_hpe_gsc_pdata = {
+	.pdata = {
+		.ops = &sdhci_dwcmshc_hpe_ops,
+		.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
+		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+	},
+	.init = dwcmshc_hpe_gsc_init,
+};
+
 static const struct cqhci_host_ops dwcmshc_cqhci_ops = {
 	.enable		= dwcmshc_sdhci_cqe_enable,
 	.disable	= sdhci_cqe_disable,
@@ -1942,6 +2085,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
 		.compatible = "eswin,eic7700-dwcmshc",
 		.data = &sdhci_dwcmshc_eic7700_pdata,
 	},
+	{
+		.compatible = "hpe,gsc-dwcmshc",
+		.data = &sdhci_dwcmshc_hpe_gsc_pdata,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
-- 
2.34.1

