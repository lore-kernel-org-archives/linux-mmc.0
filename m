Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880880;
	b=c+gx4dPoxgGIFVrCrBHJnoIpiYMbaxcf2k/24kn8fctEEcmROa4a9/ir3GA6xbOfIbee
	 VUvwXwJ004cd0tpPiRcjnUvHbg3ipXVo9SmwpyWHtsDTvrPXONXdbzXblmgY9NhfQ6awI
	 SQVfjQhZkkbtiQ3oItgMIaD0UHMS/OTfQYYFCbY5HdbDVqpMMBbh0zDzz8l0sf7ag36jc
	 t5ZArCbnyILWV7SuO4X4g08gackiqpuJuQOHvLtrfMx8NkVWHLmGMxfns691P2yyOu1cs
	 F+oIQ8V9D60g5u1zo8ntqxSP2aZzRwNiWjOAbtHPiCC52ytH82YzxGg5swl3hFq4eKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880880;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uOsHFAtogT/MrzfNUERoWDcF2GRA3UI2D+Hhin/pE7c=;
	b=msTj39BXoKdQ3t+yAHYcyc/yWn98ge+s58dnNs+TQb9MXifiQsuF7oused+uP/PLdPcO
	 U6Npa6UVqs+TFSBs0ilSbDIsJ6v00t7oiSKLiJAojue5st3AnORazpC4z213KXMB5sADT
	 0MHrk2lJXs4TW07vLvmSNVqkcKEvwHgf7FJ25VLpXOJxKxpQxBjv75tx+2GlLi5giADk6
	 aCNXrUxVVfbR4CkHCo9uayvrvAMSJrVbUhD0TmOXg1vRQDuZG4CdTuZt8ZQCQ7wDI5tHl
	 J3encv5XhsCYxJEgmi9E5/wZmfLvHEyVoMe91d8BpNTA3ahSWSn6Hg1fOi5BNKusJfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qCO4mJZT;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FAA606A31C;
	Tue, 17 Nov 2026 02:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61FAA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=qCO4mJZT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qCO4mJZTMDd0Kz8fFDtxZGi3prdj2CsONaUObuHjJNrsB5AuP180X8kL/pmxZzUnVUDtBEm/3oGG/
	 gp1sLeVMf5uWr0z9NpQ0oUhpgskut5Q5ub+zemwe8beJUgfOOMMsYhZXK7jqb88Zq418/daOd+QOL4
	 1ffnHN3dwGt/23Ac=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96afbb56cbc0-09369;
	Tue, 17 Nov 2026 10:01:16 +0800 (CST)
X-RM-TRANSID:2ee96afbb56cbc0-09369
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86afbb56a481-07544;
	Tue, 17 Nov 2026 10:01:16 +0800 (CST)
X-RM-TRANSID:2ee86afbb56a481-07544
From: Luo Yifan <luoyifan@cmss.chinamobile.com>
To: Chaotian Jing <chaotian.jing@mediatek.com>,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: mtk-sd: roll back clocks when msdc_ungate_clock() fails
Date: Tue, 17 Nov 2026 10:01:19 +0800
Message-Id: <20261117020119.19847-1-luoyifan@cmss.chinamobile.com>
X-Mailer: git-send-email 2.24.4
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msdc_ungate_clock() enables h_clk, bus_clk, src_clk, src_clk_cg and
crypto_clk before enabling the bulk clocks, but ignores the return values
of those clk_prepare_enable() calls.  If one of them fails, the function
keeps going and returns the result of clk_bulk_prepare_enable() or
readl_poll_timeout() instead, leaving the clocks enabled so far on.

The probe error path then calls msdc_gate_clock(), which also disables the
clocks that were never enabled.  The runtime resume path only propagates
the error, so the clocks stay on and the next suspend or resume works on
an inconsistent clock state.

Check every clk_prepare_enable() and unwind the clocks in reverse order
when one fails, including the controller clock stabilization timeout.
Since msdc_ungate_clock() now cleans up after itself, a failure from it in
the probe path can go directly to release_mem, without disabling the
clocks a second time.  The other probe error paths still gate the clocks
through release.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
---
 drivers/mmc/host/mtk-sd.c | 54 +++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c9c6367553..49238acedb 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -957,19 +957,53 @@ static int msdc_ungate_clock(struct msdc_host *host)
 	u32 val;
 	int ret;
 
-	clk_prepare_enable(host->h_clk);
-	clk_prepare_enable(host->bus_clk);
-	clk_prepare_enable(host->src_clk);
-	clk_prepare_enable(host->src_clk_cg);
-	clk_prepare_enable(host->crypto_clk);
+	ret = clk_prepare_enable(host->h_clk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(host->bus_clk);
+	if (ret)
+		goto err_h_clk;
+
+	ret = clk_prepare_enable(host->src_clk);
+	if (ret)
+		goto err_bus_clk;
+
+	ret = clk_prepare_enable(host->src_clk_cg);
+	if (ret)
+		goto err_src_clk;
+
+	ret = clk_prepare_enable(host->crypto_clk);
+	if (ret)
+		goto err_src_clk_cg;
+
 	ret = clk_bulk_prepare_enable(MSDC_NR_CLOCKS, host->bulk_clks);
 	if (ret) {
 		dev_err(host->dev, "Cannot enable pclk/axi/ahb clock gates\n");
-		return ret;
+		goto err_crypto_clk;
 	}
 
-	return readl_poll_timeout(host->base + MSDC_CFG, val,
-				  (val & MSDC_CFG_CKSTB), 1, 20000);
+	ret = readl_poll_timeout(host->base + MSDC_CFG, val,
+				 (val & MSDC_CFG_CKSTB), 1, 20000);
+	if (ret)
+		goto err_bulk_clks;
+
+	return 0;
+
+err_bulk_clks:
+	clk_bulk_disable_unprepare(MSDC_NR_CLOCKS, host->bulk_clks);
+err_crypto_clk:
+	clk_disable_unprepare(host->crypto_clk);
+err_src_clk_cg:
+	clk_disable_unprepare(host->src_clk_cg);
+err_src_clk:
+	clk_disable_unprepare(host->src_clk);
+err_bus_clk:
+	clk_disable_unprepare(host->bus_clk);
+err_h_clk:
+	clk_disable_unprepare(host->h_clk);
+
+	return ret;
 }
 
 static void msdc_new_tx_setting(struct msdc_host *host)
@@ -3130,7 +3164,8 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	ret = msdc_ungate_clock(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot ungate clocks!\n");
-		goto release_clk;
+		platform_set_drvdata(pdev, NULL);
+		goto release_mem;
 	}
 	msdc_init_hw(host);
 
@@ -3186,7 +3221,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	pm_runtime_disable(host->dev);
 release:
 	msdc_deinit_hw(host);
-release_clk:
 	msdc_gate_clock(host);
 	platform_set_drvdata(pdev, NULL);
 release_mem:
-- 
2.24.4



