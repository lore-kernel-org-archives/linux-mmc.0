Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970636C0AB;
	Mon,  9 Mar 2026 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090841; cv=none; b=Sy/qSBKZ6Isp5VWh8TG7EXCNjOVpD+OdVfQ4f+LAWbqYCzqIPXQIv39Gd/Sn/nHTpr1oHzKkJizCss8yRf5O/2p90T++/708tqThafYMfiydFOOBQRW+9+T83UI81VMSSWBZ7FoPVCLs2sVNw4iLwvvCPGWi16CN9S0yurOteuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090841; c=relaxed/simple;
	bh=rKQAI9jsW07J/dl6Tu/F2wDc2dPihQySZWIEdODlFL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NyW4A/N6V5wEBYk2CBs5nO6xOi9ak91vqy56nOPohGd4W88cfJrnhYHi3tISZr2z0sdz1Z/s1nZ6PwbN138Mt95xg0/XStzU93RwPHVdOx+ZSr7B9rjEyGn0jTcz5teT2DEFGxJEazeG/AhhCIzrVtAGIoQAJzBr1di5MGT3lwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=kgb1Uknz; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="kgb1Uknz"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629K3Tpw4085364;
	Mon, 9 Mar 2026 21:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=jww1v19lZkiei
	W9EUM1EgMr59oeKTjR6xCbi5xTDGSg=; b=kgb1UknzVY911506tO9aIa3bFCDAa
	43q5F6HjGxItzv9JJYi+Vm2zSfNyvu8FUlXBlvlZGSeMp9yof+KNZLTeaXTEPP51
	ECc0P/yX313h+dNR/l8HEH2NS59esMPiWntp5dCxSGuQkoDlyD/U+7ZkRWF5g67P
	qWkmB4iO370Z+qCI4Tb+zlR/ky6zdLAAzjIwcpyYnf+OkpVFx+mQRpbOZM6hm/gP
	tx4M2QHLp4j9l8GDSsU3yzmXrBBzmmF7X+WcZ5QQtg9NvRt/7em76KtndzcQR1NA
	qwT0bnl/FOSor5QJ4zLws/XiDom0PKigimVWv04uglmmJX/YUnv9FUBwQ==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4ct2eyjmuy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 21:13:43 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 1C885808049;
	Mon,  9 Mar 2026 21:13:43 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id AF27A805EAA;
	Mon,  9 Mar 2026 21:13:42 +0000 (UTC)
From: nick.hawkins@hpe.com
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: jszhang@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nick Hawkins <nick.hawkins@hpe.com>
Subject: [PATCH v2 2/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
Date: Mon,  9 Mar 2026 16:13:33 -0500
Message-Id: <20260309211333.977919-3-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260309211333.977919-1-nick.hawkins@hpe.com>
References: <20260309211333.977919-1-nick.hawkins@hpe.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: xwB9sCYJwXJFRU_u4Wc2xJcg_G86slO6
X-Proofpoint-ORIG-GUID: xwB9sCYJwXJFRU_u4Wc2xJcg_G86slO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4OCBTYWx0ZWRfX9iq/uUpdkXnG
 IfyBwZdbs3h170ij+zvPwsKa4G0YVFDVhzUNir6lk902Kr937l9EhkpDuIjkCHgkVNzqSz2pD2h
 qVYCyDaP0GusSt4XfeleSezpCNFlNkiP+IvcBQbBZecg8HSkMscUaVibYyzJ9LnyLaqf5hdQDv/
 2Gj0o2D1l3p1X3F0iGsLcOyjGZCwDgI7gy2eS49jfCeZfEToBRX5qAqw5xzatrd9TxVexdWupN6
 vv6uYsYK8y19BDuPThAHF4sY6b3g6EzjULaEwo5jlJJgSq1qCbhKZv/woHy6BVYCJsnJzBlIG6K
 qhR1Dm4jjOjfdrgnuJPwXrbVXl99Hzj4v0Kh3RSlvbbVW1MgBEan5PBZ9ftzdEAAaYaTO7Vk73c
 t3ybE+uTkYQEdelD9DG8pf9FOON0yu4gC7EJx+bp3PJ4dLoB656+Tbp1EjzszB7EXF8iVovbiYU
 as4kaQm5Xj+Vzwe/C6w==
X-Authority-Analysis: v=2.4 cv=RO2+3oi+ c=1 sm=1 tr=0 ts=69af3807 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gQcMVamqm3wCPoSYhaRC:22
 a=6_mrDcixewTG61oOsKN3:22 a=MvuuwTCpAAAA:8 a=nF61wpLpEZ16pzAobAkA:9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090188

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
  programs ATCTRL = 0x021f0005:
    BIT(0)       auto-tuning circuit enable
    BIT(2)       centre-phase auto-tuning
    BIT(16)      tune-clock-stop enable
    BITS[18:17]  pre-change delay = 3
    BITS[20:19]  post-change delay = 3
    BIT(25)      sample-window threshold enable
  This combination is required for reliable HS200 signal integrity on
  the GSC PCB trace topology.

Reset (dwcmshc_hpe_reset):
  Calls sdhci_reset(), re-applies the vendor config above, and then
  sets DWCMSHC_CARD_IS_EMMC unconditionally.  The GSC controller
  clears this bit on every reset; leaving it clear causes card-detect
  mis-identification on an eMMC-only slot.

UHS signaling (dwcmshc_hpe_set_uhs_signaling):
  Mirrors upstream dwcmshc_set_uhs_signaling() but always sets
  CARD_IS_EMMC regardless of timing mode, for the same reason.

Init (dwcmshc_hpe_gsc_init):
  Obtains the SoC register block via the 'hpe,gxp-sysreg' syscon
  phandle and sets SCGSyncDis (BIT(18)) in MSHCCS (offset 0x110)
  to allow the HS200 RX delay lines to settle while the card clock
  is stopped during auto-tuning.  Enables SDHCI v4 mode.

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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 173 ++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 2b75a36c096b..78f5480f4662 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1245,6 +1245,156 @@ static int sg2042_init(struct device *dev, struct sdhci_host *host,
 					     ARRAY_SIZE(clk_ids), clk_ids);
 }
 
+/*
+ * HPE GSC-specific vendor configuration: disable command conflict check
+ * and program Auto-Tuning Control register.
+ *
+ * ATCTRL value 0x021f0005 field breakdown:
+ *   BIT(0)      - Auto-tuning circuit enabled
+ *   BIT(2)      - Center-phase auto-tuning
+ *   BIT(16)     - Tune clock stop enable
+ *   BITS[18:17] - Pre-change delay = 3
+ *   BITS[20:19] - Post-change delay = 3
+ *   BIT(25)     - Sample window threshold enable
+ */
+static void dwcmshc_hpe_vendor_specific(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u8 extra;
+
+	extra = sdhci_readb(host, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+	extra &= ~BIT(0);
+	sdhci_writeb(host, extra, dwc_priv->vendor_specific_area1 + DWCMSHC_HOST_CTRL3);
+	sdhci_writel(host, 0x021f0005, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_ATCTRL);
+}
+
+static void dwcmshc_hpe_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *dwc_priv = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl;
+
+	dwcmshc_reset(host, mask);
+
+	dwcmshc_hpe_vendor_specific(host);
+
+	/* HPE GSC eMMC always needs CARD_IS_EMMC set after reset */
+	ctrl = sdhci_readw(host, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	ctrl |= DWCMSHC_CARD_IS_EMMC;
+	sdhci_writew(host, ctrl, dwc_priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+}
+
+static void dwcmshc_hpe_set_uhs_signaling(struct sdhci_host *host,
+					  unsigned int timing)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	u16 ctrl, ctrl_2;
+
+	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+
+	/* HPE GSC: always set CARD_IS_EMMC for all timing modes */
+	ctrl = sdhci_readw(host, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+	ctrl |= DWCMSHC_CARD_IS_EMMC;
+	sdhci_writew(host, ctrl, priv->vendor_specific_area1 + DWCMSHC_EMMC_CONTROL);
+
+	if ((timing == MMC_TIMING_MMC_HS200) ||
+	    (timing == MMC_TIMING_UHS_SDR104))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+	else if (timing == MMC_TIMING_UHS_SDR12)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+	else if ((timing == MMC_TIMING_UHS_SDR25) ||
+		 (timing == MMC_TIMING_MMC_HS))
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+	else if (timing == MMC_TIMING_UHS_SDR50)
+		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+	else if ((timing == MMC_TIMING_UHS_DDR50) ||
+		 (timing == MMC_TIMING_MMC_DDR52))
+		ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+	else if (timing == MMC_TIMING_MMC_HS400)
+		ctrl_2 |= DWCMSHC_CTRL_HS400;
+
+	if (priv->flags & FLAG_IO_FIXED_1V8)
+		ctrl_2 |= SDHCI_CTRL_VDD_180;
+	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
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
+ * The DTS node provides a syscon phandle ('hpe,gxp-sysreg') to access
+ * this register at offset 0x110 within the SoC control block.
+ */
+#define HPE_GSC_MSHCCS_OFFSET		0x110
+#define HPE_GSC_MSHCCS_SCGSYNCDIS	BIT(18)
+
+static int dwcmshc_hpe_gsc_init(struct device *dev, struct sdhci_host *host,
+				struct dwcmshc_priv *dwc_priv)
+{
+	struct regmap *soc_ctrl;
+	int ret;
+
+	/* Disable cmd conflict check and configure auto-tuning */
+	dwcmshc_hpe_vendor_specific(host);
+
+	/* Look up the GXP sysreg syscon for MSHCCS access */
+	soc_ctrl = syscon_regmap_lookup_by_phandle(dev->of_node, "hpe,gxp-sysreg");
+	if (IS_ERR(soc_ctrl)) {
+		dev_err(dev, "failed to get hpe,gxp-sysreg syscon\n");
+		return PTR_ERR(soc_ctrl);
+	}
+
+	/* Set SCGSyncDis (bit 18) to disable sync on HS200 RX delay lines */
+	ret = regmap_update_bits(soc_ctrl, HPE_GSC_MSHCCS_OFFSET,
+				HPE_GSC_MSHCCS_SCGSYNCDIS,
+				HPE_GSC_MSHCCS_SCGSYNCDIS);
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
@@ -1834,6 +1984,25 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_eic7700_pdata = {
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
@@ -1942,6 +2111,10 @@ static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
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

