Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1BA228CB0;
	Fri,  9 Jan 2026 03:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929309; cv=none; b=Wc1NOZnFLejjWD/Mm+OgajCpI0XoMLJulcyAvGy8fJzYqFjxvdCh92I6xD//tUVlXpcPP4K5zZQWwiyzxTsa6XRnCBL7wopHPMBau2ZTxkiKNjTiBpyidrrwSb2GoXbw3TewA5joDmHi9sw+y+RAA7GaVjNEO1N6HQpijh5MvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929309; c=relaxed/simple;
	bh=FwfsZDZmlFFk5kevB5TSB/JImhd2KFDCoj5ANics4vc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rj4+5YEBr5lUqKj4RCfWBU9aozpoysgDJspiN2sBjilh+cAys97AWt1rpvS5AiF+lZ5u/hvWZLs8lKSxYoxMy9OeA1EcQt+sHQQDRLnvv6tXttNNjtfamJ76Odcl/Vir8eL7FgG0H6L+P/v6MYrxNJ08dOtxo6NDIRBtrV3IyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgBXUmrMdWBpN26SAA--.64703S2;
	Fri, 09 Jan 2026 11:28:13 +0800 (CST)
From: hehuan1@eswincomputing.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: fix init for AXI clock and DMA 128MB boundary
Date: Fri,  9 Jan 2026 11:28:10 +0800
Message-Id: <20260109032810.204-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgBXUmrMdWBpN26SAA--.64703S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xXFW3Xr4fGrW7Gw4UJwb_yoW8CrWxpa
	1ktF12kFW5GF4SgFyDAa1qva1agrs3W39rtrWfGw4FvanIyFWUtFy2ka4jyF1rGrWfC3Wf
	JF4vqry5CF12yaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

1.Accessing the High-Speed registers requires the AXI clock to be enabled.
2.This DWC MSHC has a 128MB limitation where the data buffer size and
  start address must not exceed the 128MB boundary. Registering the
  missing 'adma_write_desc' callback function.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 51949cde0958..147f8046707f 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1588,6 +1588,7 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 {
 	u32 emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
 	unsigned int val, hsp_int_status, hsp_pwr_ctrl;
+	static const char * const clk_ids[] = {"axi"};
 	struct of_phandle_args args;
 	struct eic7700_priv *priv;
 	struct regmap *hsp_regmap;
@@ -1605,6 +1606,11 @@ static int eic7700_init(struct device *dev, struct sdhci_host *host, struct dwcm
 		return ret;
 	}
 
+	ret = dwcmshc_get_enable_other_clks(mmc_dev(host->mmc), dwc_priv,
+					    ARRAY_SIZE(clk_ids), clk_ids);
+	if (ret)
+		return ret;
+
 	ret = of_parse_phandle_with_fixed_args(dev->of_node, "eswin,hsp-sp-csr", 2, 0, &args);
 	if (ret) {
 		dev_err(dev, "Fail to parse 'eswin,hsp-sp-csr' phandle (%d)\n", ret);
@@ -1726,6 +1732,7 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
 	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
 	.set_power = sdhci_set_power_and_bus_voltage,
 	.irq = dwcmshc_cqe_irq_handler,
+	.adma_write_desc = dwcmshc_adma_write_desc,
 	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
 };
 
-- 
2.25.1

