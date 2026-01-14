Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438A23939D2;
	Wed, 14 Jan 2026 12:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393319; cv=none; b=Os5nEuwpmSCGCxLhSOkGQAA6xO0znFjZapLj/kIS2U5D7cYkMCrWFjRp7sab1mrAftuJ9HS/P2Z3s3ZY0yjT4dj6cbDMS8pYUYQggidwLDZ9X87FjrzwaKa6HHIz3NJVKL2oXmWdnLQsOFEHvqbYN3bR/on1GkZ+hqY7qyGefnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393319; c=relaxed/simple;
	bh=f1xGIOi0RVwj2Q0pZ82NSqMjRr1A+nixk8xHB8tZfeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jMpHVVQCGbBhWgInDAPbOS59XgJk7DgF3nEplxNxw3x1jFLKYJTS8sCUX8DURUvvj4jb3SPRzlD12AkLKCjvPdJ+MAlCScWMvDRLdTFnCmu/2eNT5wjSvS4CacMxjzZjKQHWaRKwKfSvfZvFfSflZR0DG00WfaIGLOoC+3TTXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgAXbG1YimdprzcBAA--.6061S2;
	Wed, 14 Jan 2026 20:21:45 +0800 (CST)
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
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: fix init for AXI clock
Date: Wed, 14 Jan 2026 20:21:41 +0800
Message-Id: <20260114122141.1529-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAXbG1YimdprzcBAA--.6061S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw45tw18JrykXF1UGrWDXFb_yoW8Jw13pa
	1kXFyYkFW5GFsagFZ7Aa1Du3W3Kws2ga9rtrWfGw4Fva12yFyUGF9rCa4jyFyrGFWfu3WS
	qF4kXr15CF17AaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqFAJUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Accessing the High-Speed registers requires the AXI clock to be enabled.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 51949cde0958..d795745987e3 100644
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
-- 
2.25.1

