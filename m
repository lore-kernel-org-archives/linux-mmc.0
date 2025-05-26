Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1831C8639
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239597; cv=none; b=PhpyQJ+/qoHeTD6oWfSeqbEh3Y7MUNL63C7P4nhtxD+UpiwQ41YBrYAEamaRCW2vU3teBhH7K7VicGA8dGtFXNdE/8706NV92QlSFJnH8lPcxsjXVSFtFmVj2wE4cD3vSXkBcHgtLA6r0kqMkzLOWcK6lDyrENP1YOBmDubBAPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239597; c=relaxed/simple;
	bh=iBvLrWpKPPKkHZRA5tS2OQEXF2RSUU32lpoqamb0YcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7WE/ViI5VK0r3YyJXn6Ywq9doo3uoFqKmCKyuog4/n5agqMvSs5vQwCnyEX+8BCeBs6PI+yzUzZPQaj3Z0TKArFpYqLm7sITVxpvpzezaP2uAERefL9aYPrV9h+hUqPxcH8XgT1HwlhMTDtbdyHeHqRoTU4OJlejRUxutIE8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.3])
	by gateway (Coremail) with SMTP id _____8AxaeDqBDRor4X8AA--.15343S3;
	Mon, 26 May 2025 14:06:34 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.3])
	by front1 (Coremail) with SMTP id qMiowMDx_MTmBDRoQwTyAA--.30214S5;
	Mon, 26 May 2025 14:06:33 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	linux-mmc@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH 17/34] mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
Date: Mon, 26 May 2025 14:06:21 +0800
Message-ID: <75f58a7bc0fef1236cd94cee8c9dc83bbc6a037c.1747792905.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1747792905.git.zhoubinbin@loongson.cn>
References: <cover.1747792905.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MTmBDRoQwTyAA--.30214S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF48ZFyrCr1UCr4fWr15trc_yoW8tF4DpF
	s5XFWrt3W5Wrs5Wr93tw4UZr18J345KayUKryrCwn7ZrZ0kryDKF1xAFyIvFyqyFy8uw13
	Ww1fXr48CF4Uu3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
	67AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq
	3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr
	0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWx
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0hvtJUUUUU==

Since the devm_mmc_alloc_host() helper is already in
use, sdhci_pltfm_free() is no longer needed.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/mmc/host/sdhci-of-arasan.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 8c29676ab662..42878474e56e 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1883,34 +1883,26 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 		sdhci_arasan->soc_ctl_base = syscon_node_to_regmap(node);
 		of_node_put(node);
 
-		if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
-			ret = dev_err_probe(dev,
+		if (IS_ERR(sdhci_arasan->soc_ctl_base))
+			return dev_err_probe(dev,
 					    PTR_ERR(sdhci_arasan->soc_ctl_base),
 					    "Can't get syscon\n");
-			goto err_pltfm_free;
-		}
 	}
 
 	sdhci_get_of_property(pdev);
 
 	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
-	if (IS_ERR(sdhci_arasan->clk_ahb)) {
-		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
+	if (IS_ERR(sdhci_arasan->clk_ahb))
+		return dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
 				    "clk_ahb clock not found.\n");
-		goto err_pltfm_free;
-	}
 
 	clk_xin = devm_clk_get(dev, "clk_xin");
-	if (IS_ERR(clk_xin)) {
-		ret = dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
-		goto err_pltfm_free;
-	}
+	if (IS_ERR(clk_xin))
+		return dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clock not found.\n");
 
 	ret = clk_prepare_enable(sdhci_arasan->clk_ahb);
-	if (ret) {
-		dev_err(dev, "Unable to enable AHB clock.\n");
-		goto err_pltfm_free;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to enable AHB clock.\n");
 
 	/* If clock-frequency property is set, use the provided value */
 	if (pltfm_host->clock &&
@@ -2029,8 +2021,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	clk_disable_unprepare(clk_xin);
 clk_dis_ahb:
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
-err_pltfm_free:
-	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-- 
2.47.1

