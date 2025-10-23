Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84300330B2F
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231284; cv=none; b=NpeCoOQgcAxoHrkOTk2PpfhyQMYkD2TkdaRnEPaflXxPigC8lX3UQsT03plCjf9DG3/IiLwAXvfZjxwghgh3TZC7AqGxF8L3/Hh0F8Z/DuzIiYZh7riXPatFB5fPlWnyHtAq87HestvIeqAfbnoTwTcRsHlC81rdVQNttxSBQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231284; c=relaxed/simple;
	bh=T8WDD3FPKDFq4jZeX4r8iK4zRk5CyZideAEyYUc9+ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WrARNsrCgDmMQ98k96tkuY2TRn2wGbY+++XnopEtEKkgYbnNt0RZjo0DULzs8mIdUNNPECcRH3qgwjtvNU6vI3ijkS5G6WEZ16Lxy78VITAqFPjTSx07SLw8qhbRYvyJjSiEKPs/nRAhQDiGzIqJgk2Rti8y75A8ZL5/z2lA8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS5pxEWZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS5pxEWZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f343231fcso606055b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231282; x=1761836082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PWkC5vEbffnTD2msqF1a1ad0yN4rdP1qu6b7OiUsdc=;
        b=VS5pxEWZk/niMq7N5uBMDYut0ph1bnc2N+MUl3TYHpX4rl4S/lAG9Uum6/khRr8vn4
         nEy2iBpzoJZJsg0qK81avF4usVX0MKd6GcVoMK3suxZn53jVje4/rJ0hGNvHZ6+Exi+7
         XJdhv3kOBinf9BM5uNMYJlRxDEHCGdvK/jonblZVGsA+6ilsogg6NcP1h9SHzSwVxmNx
         JOAu/5N9Z6aH10bfx3IwDp1eV8lz423U5F4g4HAMo9EXi3PXoZNXFNAw10QDLwjXmHs8
         uOk2kPa/Qg1CYG06pD0bZ43VH1zXX/F0bqTXVNyKhjSDx5SBIZ4k0loCeGw+4ePLTv4x
         LYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231282; x=1761836082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6PWkC5vEbffnTD2msqF1a1ad0yN4rdP1qu6b7OiUsdc=;
        b=utimvJA4g4AJGOxENP0sKi5uYHnhOPv21ekPHBRbh4kq1rLfPgjG7/EW9vjjoPgXc+
         qkNbyKpplLSnaYlXOK9sxoMTT4pa7jmRDd2+necRIsaSk3FcknjIjFro822XNYusRDf3
         oy9KHQWItUdNK1OXBTCTkKwOjKN2unjcF+omrg3QGEH+nAhy7I/JtXvP0NJmCaF3SlEt
         flV/ehlgKWXecaQvBy8MGe7Hxdjxokp3bjIEiSMjIO9hTlzqGi5FaA0qpNVEzwibLmjd
         HGbl172JzbOIMBov82vDM2Tnou6f7oNBoI9Pg8ZcJQmnOEPWlbPp6Jhhw8J/vuPVx8tu
         hx2A==
X-Forwarded-Encrypted: i=1; AJvYcCVGNIbR8bmISqG10ooUNxDIVlvGxZ0smv2MerWOesuh3Y0RHsXCYLsp8sLpZX8O9YjmQnTd9MAtbm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuqaTAo9QiF6ksABfA8OU1y9poWWcNgnhiyFKdCYQqayO0voVM
	0+4FIocbX+gvLmOCZmeCWE4dAwYz7VBPC7iP0JtcGEUWI3piIJjEpCOP
X-Gm-Gg: ASbGncuXdW/0K35pJFCVjYVCLUwljAbsJN58telprjQ3M2AwKA1iAVVemdkVbbH/RGL
	6UQpDnJjMtJjlKA81k+pug/IXRnvc1AM7H7TnIRZc5tc9MPDTzMZK5kO/hdZwhXLjXsk5KEMWiY
	RHGZMMC6IvHy7WDDO+ol1ulAav3hsVtttnVkrFUu4sqPPMuubKAwV+fuqrtEzqDlll7cHuQxeAm
	qPl6vPtaoDcXUufleE3TXZLW8SpAtI2KqiItWom9BiLAX9x/I0x+ItbmPDNlHi1dSsYPO3AOtuf
	FPgcOBNx5qo6lmiDdi/cxjDrsEZFR+nNd7/wTxC5MqmqWnQnUcbdRv7dCwJMdxp3dTvBjFGS2JD
	SoSWE3yp+uuAZ00VKE/puvBrXYunkkoELPWV14QcnqZ5QcdJalMHsvbcVZtLJoRbehicdNvc/0/
	bi77/5QDQ=
X-Google-Smtp-Source: AGHT+IG4jW0xt+pP9DVrPMcL2PAlFdoxSZhMCK+ZCC4fZeK1oMvAPXo/S/LPShSFOkL1hwFOo7+F2w==
X-Received: by 2002:a05:6a21:32aa:b0:306:51fd:5542 with SMTP id adf61e73a8af0-334a861feb9mr31305654637.44.1761231281323;
        Thu, 23 Oct 2025 07:54:41 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:2040:16ed:f15f:ed0a:f0b7:34d2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb37dbsm2748241b3a.57.2025.10.23.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:54:40 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: ulf.hansson@linaro.org,
	u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	zhoubinbin@loongson.cn,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org
Subject: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Thu, 23 Oct 2025 20:24:32 +0530
Message-ID: <20251023145432.164696-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch refactors pxamci_probe() to use devm-managed resource
allocation (e.g. devm_dma_request_chan) and dev_err_probe() for
improved readability and automatic cleanup on probe failure.

It also removes redundant NULL assignments and manual resource release
logic from pxamci_probe(), and eliminates the corresponding release
calls from pxamci_remove().

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---

Changes since v2:
- Dropped redundant dma_release_channel() calls from pxamci_remove() as
  devm_dma_request_chan() automatically handles resource cleanup.
- Added link to v2 for reference:
  https://lore.kernel.org/linux-mmc/20251014184657.111144-1-rakuram.e96@gmail.com/

Changes since v1:
Following Uwe Kleine-König’s suggestion:
- Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
  channel allocation devm-managed and avoid manual release paths.
- Adopted dev_err_probe() for improved error reporting and consistent
  probe failure handling.
- Removed redundant NULL assignments and obsolete goto-based cleanup logic.
- Updated commit message to better describe the intent of the change.
- Added link to v1 for reference:
  https://lore.kernel.org/linux-mmc/20251007161948.12442-1-rakuram.e96@gmail.com/

Testing note:
I do not have access to appropriate hardware for runtime testing.
Any help verifying on actual hardware would be appreciated.

Build and Analysis:
This patch was compiled against the configuration file reported by
0day CI in the above link (config: s390-randconfig-r071-20251004) using
`s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.

Static analysis was performed with Smatch to ensure the reported warning
no longer reproduces after applying this fix.

Command used for verification:
  ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
  ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c

 drivers/mmc/host/pxamci.c | 56 +++++++++++++--------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..b5ea058ed467 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -652,10 +652,9 @@ static int pxamci_probe(struct platform_device *pdev)
 	host->clkrt = CLKRT_OFF;
 
 	host->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		host->clk = NULL;
-		return PTR_ERR(host->clk);
-	}
+	if (IS_ERR(host->clk))
+		return dev_err_probe(dev, PTR_ERR(host->clk),
+					"Failed to acquire clock\n");
 
 	host->clkrate = clk_get_rate(host->clk);
 
@@ -703,46 +702,37 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	host->dma_chan_rx = dma_request_chan(dev, "rx");
-	if (IS_ERR(host->dma_chan_rx)) {
-		host->dma_chan_rx = NULL;
+	host->dma_chan_rx = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(host->dma_chan_rx))
 		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
 				     "unable to request rx dma channel\n");
-	}
 
-	host->dma_chan_tx = dma_request_chan(dev, "tx");
-	if (IS_ERR(host->dma_chan_tx)) {
-		dev_err(dev, "unable to request tx dma channel\n");
-		ret = PTR_ERR(host->dma_chan_tx);
-		host->dma_chan_tx = NULL;
-		goto out;
-	}
+
+	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_chan_tx))
+		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
+					"unable to request tx dma channel\n");
 
 	if (host->pdata) {
 		host->detect_delay_ms = host->pdata->detect_delay_ms;
 
 		host->power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
-		if (IS_ERR(host->power)) {
-			ret = PTR_ERR(host->power);
-			dev_err(dev, "Failed requesting gpio_power\n");
-			goto out;
-		}
+		if (IS_ERR(host->power))
+			return dev_err_probe(dev, PTR_ERR(host->power),
+						"Failed requesting gpio_power\n");
 
 		/* FIXME: should we pass detection delay to debounce? */
 		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
-		if (ret && ret != -ENOENT) {
-			dev_err(dev, "Failed requesting gpio_cd\n");
-			goto out;
-		}
+		if (ret && ret != -ENOENT)
+			return dev_err_probe(dev, ret, "Failed requesting gpio_cd\n");
 
 		if (!host->pdata->gpio_card_ro_invert)
 			mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 
 		ret = mmc_gpiod_request_ro(mmc, "wp", 0, 0);
-		if (ret && ret != -ENOENT) {
-			dev_err(dev, "Failed requesting gpio_ro\n");
-			goto out;
-		}
+		if (ret && ret != -ENOENT)
+			return dev_err_probe(dev, ret, "Failed requesting gpio_ro\n");
+
 		if (!ret)
 			host->use_ro_gpio = true;
 
@@ -759,16 +749,8 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (ret) {
 		if (host->pdata && host->pdata->exit)
 			host->pdata->exit(dev, mmc);
-		goto out;
 	}
 
-	return 0;
-
-out:
-	if (host->dma_chan_rx)
-		dma_release_channel(host->dma_chan_rx);
-	if (host->dma_chan_tx)
-		dma_release_channel(host->dma_chan_tx);
 	return ret;
 }
 
@@ -791,8 +773,6 @@ static void pxamci_remove(struct platform_device *pdev)
 
 		dmaengine_terminate_all(host->dma_chan_rx);
 		dmaengine_terminate_all(host->dma_chan_tx);
-		dma_release_channel(host->dma_chan_rx);
-		dma_release_channel(host->dma_chan_tx);
 	}
 }
 
-- 
2.48.1

