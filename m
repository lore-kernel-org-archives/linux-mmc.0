Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169821CC55
	for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760467676; cv=none; b=kgTvrPn5Rdi2nxnvYSjo7T1D+5jlHs4vqhsYtU1zhYJErRO4S2c81sE6hRFDtdrDavdLJ1fk+kS315I4CRmaY4hVL5+TpBxPUAJ0PkNhhs1HuuPDZ2yvZKu25ZlRgZdLV2TdJH/0DEkwxUicjlUHaCjlCTuUvQXqrvEQaRLR9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760467676; c=relaxed/simple;
	bh=hgw2ak5c1O2M/5ChYQ01W+oW1brr/FJVECKIUnmfon0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sBivtD6sT07OzMdHD4O9qQ8SXV7jPeOyR67Xax0m52hXk6qgMnwyeO2ez0RPQcT126KZoPWh2ZwvAf3FyvaoMihlzVDAp5Q6ov2OWAf890FQVLcV3RaBAa8h2zafIgWoIXBE57mfrLnBvuuXqveXEMdLO1KpnIwlmd3yOvAFIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxl5KouS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxl5KouS"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781db5068b8so4555717b3a.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Oct 2025 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760467674; x=1761072474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QPOmoKy9wR88I2He99PlsgEdkB2xOEgVxLxZe9Nh3wU=;
        b=lxl5KouSUbl+06eZsDj2jTAS0+gBsDfBNGskpGam3kXUxXNmYKhkE/hEeo3E0xbymm
         /dtkBKeB/U9mSwdfk03CIcZdXuMYqguYpProE9ExGcRD1J66e3gvgUwlbdsazrVN7GCu
         4p7elDXJGC25a84CmqODIeekKbg2IeG1v/FOJvaWe+wG1vQgBYoZW4vrWSLagoT2q8rX
         IwpAPRF+Q2G9uvw3mpiMz9Tr4VlKwmsKoRKdJirujvVn4VXNuHO5nyl6zhw0JKbJlhlP
         8YYsqsXwmvUebFpDoUKCiklcCWudtb4zpeMY8zlynQuwSYd+//fJCwsA7XtiwlxrJ5p7
         SdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760467674; x=1761072474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QPOmoKy9wR88I2He99PlsgEdkB2xOEgVxLxZe9Nh3wU=;
        b=Obovi0sfWmADFAfRCV6GZyfkEzks8ARaJ3YQVuAlKSZ/OtHtmFIw606zELuFOoOduE
         2vyJ+Ww0Sah6FMf+xBdBlgWRC6YiMY69V/i0cpBvf2Fbf0bwLswVDIfjgk/dNhQqoD/o
         I9ivHCEtUWmQXdMMJV2b16YL2JzHFL8P9pJ8mal9rupAildiJdegub9DgESwVEZ6WoK3
         PSM/3XeQzogDSUsZWp5yrGCIWYBT2QFYfiwruxApREg/k2sXhWr6BoNovummGoJOIqaP
         4I/Z4VLi7Fg2jYxfjInf7JbXRDyb8on8JMWXuqiS5c34Qw8JxJSTVtLOc0rvY4C6eN2u
         +rLA==
X-Forwarded-Encrypted: i=1; AJvYcCX3VqluScuhUIhzXojeD14XsVazriBAZwnxe2joA+kuYJIirbCodLE+3dBQDaSLG1tUTszCWRqu/wo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0doWs4jacMHgSg5YdESlGXERqp/5kRTD+I38h16ua92MARNUt
	oh42lYFIGFtpFzNicqfMksSUEQ8KPAxKEYT4jPPCWnNW95n55Im1keA0
X-Gm-Gg: ASbGncsu2jUxIEBZMcYUsAlP56dIitkWlE8srteTLGX1RxVuDcDjIxLgzIikU1VJsUA
	46i2H+SClZ+ciV4bhdOPsB3zD8Dzi86iJvFvLUjJyLMuJFCQll0vr7D1a6fRY+3THDjcP8sc0Ft
	SCjdwSUW/0nNRpT6MWJV5+sOGoiWp/Ep+NvSiDPorzC5E1mC0JGz4CEniRLl3OmeK9LFR7l9ehh
	4xuE3+vmKwxftxVIm0t6dbOsOLXfabHGUtgAR16fvexhvqhaw3rvV1fXqYq7/U3kaq47iuPVtEz
	pNLb2xPNjnhA7RT60Cva47+b+UJgIJLDcjejDdDcPw5UlRSFM4qKKDgUd3qkvcczJHk9jCvPcEL
	C4aQYTgdToEigQHki/wC/Craww8MmVtsxdpmo3CsizvkfeoUnJlqns74PUTEOafY7JVsGNw==
X-Google-Smtp-Source: AGHT+IFEopthtCtStgyG+ij0kvK9buFqkz9ixbvsbeY4hA3xqXjl5owuM5LciKd/1gGbiE8hOUtHow==
X-Received: by 2002:a05:6a21:8312:b0:334:7bf4:ff3c with SMTP id adf61e73a8af0-3347bf50146mr1476712637.31.1760467674296;
        Tue, 14 Oct 2025 11:47:54 -0700 (PDT)
Received: from rakuram-MSI.. ([2405:201:d027:f04e:f00a:2e90:a424:4c03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678dcbf919sm12697212a12.9.2025.10.14.11.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 11:47:53 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: ulf.hansson@linaro.org
Cc: u.kleine-koenig@baylibre.com,
	chenhuacai@kernel.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	skhan@linuxfoundation.org,
	zhoubinbin@loongson.cn,
	rakuram.e96@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Wed, 15 Oct 2025 00:16:57 +0530
Message-ID: <20251014184657.111144-1-rakuram.e96@gmail.com>
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
allocation (e.g. devm_dma_request_chan()) and dev_err_probe() for
improved readability and automatic cleanup on probe failure.

This eliminates redundant NULL assignments and manual release logic.

This issue was originally reported by Smatch:
drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'

The warning occurred because a pointer was set to NULL before using
PTR_ERR(), leading to PTR_ERR(0) and an incorrect 0 return value.
This refactor eliminates that condition while improving overall
error handling robustness.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---

Changes since v1:
Following Uwe Kleine-König’s suggestion:
- Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
  channel allocation devm-managed and avoid manual release paths.
- Used dev_err_probe() for improved error reporting and consistent
  probe failure handling.
- Removed redundant NULL assignments and obsolete goto-based cleanup logic.
- Updated commit message to better describe the intent of the change.

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

 drivers/mmc/host/pxamci.c | 57 +++++++++++++++------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..d03388f64934 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -652,11 +652,14 @@ static int pxamci_probe(struct platform_device *pdev)
 	host->clkrt = CLKRT_OFF;
 
 	host->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(host->clk)) {
-		host->clk = NULL;
-		return PTR_ERR(host->clk);
-	}
+	if (IS_ERR(host->clk))
+		return dev_err_probe(dev, PTR_ERR(host->clk),
+				     "Failed to acquire clock\n");
 
+	/*
+	 * Note that the return value of clk_get_rate() is only valid
+	 * if the clock is enabled.
+	 */
 	host->clkrate = clk_get_rate(host->clk);
 
 	/*
@@ -703,46 +706,36 @@ static int pxamci_probe(struct platform_device *pdev)
 
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
+	host->dma_chan_tx = devm_dma_request_chan(dev, "tx");
+	if (IS_ERR(host->dma_chan_tx))
+		return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
+				     "unable to request tx dma channel\n");
 
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
 
@@ -759,16 +752,8 @@ static int pxamci_probe(struct platform_device *pdev)
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
 
-- 
2.48.1

