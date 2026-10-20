Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510618;
	b=fW4P2YB+ASXxVIWIlVMCbWdVyEnTWgjERwRnmYN0QqYGMyhpVnUrOdEGwxhh/vwNh28M
	 Z/qw6agFpZOGzVkAJ14JfFOoLgHQm8cJhJTgwqXl6GhGEwYH3IBYzE2dwVVFxBuspKaw4
	 fc30OBvzvjpOoRb4fL809aty+WmZBYPey2PzPejojVjl77G1ckQ/ZFjgJdxtiMTiPn1K2
	 XoghDD7V3EEHCW+P/aSRgfTgxa7ImZDZY42H2c+mUYQGhBwwKcu4RhTZ8UZFNRJOExDK0
	 tum8a8lkulyHZ+PjUDi5gpfWQZse1E7CubN/z9FvVz6TYxvAa52ndR9WzJfnlJ1g7+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QsiPImWCvspsQxeNXp3kuF7NO55DXC+1f0q/BU544lY=;
	b=jKkB9VrBjBIFlTQuxIXJLh7jBCfaAOlEWkz+AWLGUp+XMPCmV7cHltwc58ke5CFLuMpg
	 BElIBO5I4FEPm+tjFvDVwA7frPiSwxPVOVoDFB8iX3qdRVzCo84BtRpF/dy/EiDp4LmfZ
	 XBgjaWJv+HRSRJ2dseZZa7yfvuz5Hzoyfd6SV1IJmKpIqEist0ub1l87QC/Ac/9FiGgwd
	 1v+efB1YId8n3wtdE4hRtCcSbm26mO7y4E5M/OPMCSyxDzSBdK6l3CFASeTw1h2EjJKyo
	 92YCt/8oAl2RQP1NkCxKAmXd5ERzBEppxdX7k9ck/YR0jZ0/OQZWkq3KXR9/6+dMWxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QxwPQKAT;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3A6606A31F
	for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2026 15:36:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C3A6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QxwPQKAT
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e8c028eefeso1654085ad.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792510617; x=1793115417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsiPImWCvspsQxeNXp3kuF7NO55DXC+1f0q/BU544lY=;
        b=QxwPQKATMMhq1wcaCoghwBql8AJi3xjPSAVIYzLLmzrdmYVKsQ2onos0epejV9xXNm
         db3Pp9xm6ceGTfW90WhW3oOfIt5noanhnvThBIrnznlX35Fg+JCEBF4zo69y8IWFrEct
         i7mpzY+riOHUuW+S0V/Tps/rbJYjulQwAGxtsJnjcLNc7mbOx8lI+j4x6wJsvV1Zi687
         4ecu2uV2EKVt5USTxElS6gxk/SRAlso+goKjgL/5Cq5ZUXArC4WYSr8eEenxx8wXKKGX
         0SRJ0AHvCUw1ULKJk7uFFEQiHyFkXlJiuwUJoG4QDBPtkGPo5jaHU0SZeSHxaa7NqVnM
         DCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510617; x=1793115417;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QsiPImWCvspsQxeNXp3kuF7NO55DXC+1f0q/BU544lY=;
        b=SoDK0Psx93xQ2icX1LM07uytzCJyQFjPFQcxzKn6eSHn/v5j8pUVpxuCJvxyaXw7fI
         fw1Ueqg6VPaoliEecvifPCyxt72Pqy3nE7pj8XY8h84ZUPy5woHKq/NwwfJrhzDPlcNA
         dJISgyDFjB0oEjN+7DYPDiIsKPOil/biYkGZ7fWlBJdiNmGzuFi1BqDLEI5UlxX9wVl3
         unaJIyLXjkBB1K+3Y4pZc1jzPJPCfCpB0Wug9JRF/PR/s9Jfd3MI98vVNVG8hqdxNU/b
         jCUfNE9jysD1yeEndK658OvyAJjc2qhDbfyByJBTjsl1XuF8RgJVrEK0L0bJH0i8Pjm8
         4vfw==
X-Forwarded-Encrypted: i=1; AKwUvByk+wmgATblJAqQ65quknJvHYm3nvth0fI9uC52QkN58kidi3m+i05jLoR8XW35BES3GMaqXRt0HS4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUSnugxyDYAXCgRTSku8KIWBrc5XLV27uqIO0QPYUF1E7z4U9D
	cmU5L1iey+AwlXqvplGLYLTN2rHPJiBRjGzRHQlBzXVzV4OQo37wgSzq
X-Gm-Gg: AYBFou2L+ASogPpAztCT86+5tYbSkrDxL1/MywTibqLlmxtAgeEkOLtBLy/nNDZUUVu
	9n6BXFwza0IBS2EmOwN+GT4cLo0sGvYOv+x11e48Eumgd4kaRG9ZhJh71HvFdNjaN+PN44cYZZE
	x4AFJg3OTboIebgOfS9oAGe/jerBeMwMYwrjouDSX8nPhkkKGmGRZVKwQJgqVqkF+0INWZ+CeQ6
	5UXLFXhkohRDHInmM155VlV9HeekdwgktbtrNHuhLnMYa2YAORCyjnNxVc5RXxF0ZTlrw5Qcqu6
	Auj84fdn+Dhz4r3rkcwQtjGJxLo95qpTZDbxbrIoiDKjXy2U7UCLvwIcP5oiuI/fSsja3+6W8DS
	p320qTM9zz42uo+dNGuNinPokKBr1Q6zzYiapp6umQZcbXoMq65yx6+hi7Fmhtf2U/Lj3WC3hkY
	n6w+ubKVOMWAUCtQwbrQ+01t8zCpvujIk4XPQLxqd4dLUH7NOJMYCJ1/P07YwmGfUChVdL7nY5i
	JxibAJcuzWD5T79U2MN+H16Aw==
X-Received: by 2002:a17:902:fdad:b0:2e9:4f73:83d4 with SMTP id d9443c01a7336-2e9a6d2404amr167599885ad.4.1792510616796;
        Tue, 20 Oct 2026 08:36:56 -0700 (PDT)
Received: from [192.168.31.234] ([183.193.19.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b486970sm736655ad.62.2026.10.20.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:36:56 -0700 (PDT)
From: Anfernee Cao <anferneemelokc5@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH] mmc: sunxi: fix clock and runtime PM leaks on probe failure
Date: Tue, 20 Oct 2026 23:36:47 +0800
Message-ID: <179251060762.3832.10358805890614600473@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

sunxi_mmc_resource_request() enables the bus, card, output and sample
clocks before returning. Several failure paths later in
sunxi_mmc_probe() leave them running:

 - If devm_request_threaded_irq() fails, the clocks enabled by
   sunxi_mmc_enable() are never disabled.
 - If dma_alloc_coherent(), mmc_of_parse() or sunxi_mmc_init_host()
   fails, probe only frees the DMA buffer and the mmc_host.
 - If mmc_add_host() fails, runtime PM has already been enabled, but
   pm_runtime_disable() is never called.

Besides leaking the clocks, this leaves the clock enable counts
unbalanced, so a reprobe (for example after -EPROBE_DEFER) calls
clk_prepare_enable() on the same clocks again.

Disable the IRQ and the clocks in the probe error path, and disable
runtime PM on the mmc_add_host() failure path. Also handle a failure of
devm_request_threaded_irq() in sunxi_mmc_resource_request().

Tested with QEMU's orangepi-pc machine: with forced sunxi_mmc_init_host()
and mmc_add_host() failures the MMC clocks stay disabled in clk_summary,
and a normal probe with an emulated SD card still works.

This issue was found by manual code inspection.

Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Anfernee Cao <anferneemelokc5@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fe4c0f6d73f3..437fdadb5950 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1354,8 +1354,13 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_disable_mmc;
 	}
 
-	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
-			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
+	ret = devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
+					sunxi_mmc_handle_manual_stop, 0,
+					"sunxi-mmc", host);
+	if (ret)
+		goto error_disable_mmc;
+
+	return 0;
 
 error_disable_mmc:
 	sunxi_mmc_disable(host);
@@ -1385,9 +1390,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
-	if (!host->sg_cpu)
-		return dev_err_probe(&pdev->dev, -ENOMEM,
-				     "Failed to allocate DMA descriptor mem\n");
+	if (!host->sg_cpu) {
+		ret = dev_err_probe(&pdev->dev, -ENOMEM,
+				    "Failed to allocate DMA descriptor mem\n");
+		goto error_disable_mmc;
+	}
 
 	if (host->cfg->ccu_has_timings_switch) {
 		/*
@@ -1467,7 +1474,7 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto error_free_dma;
+		goto error_disable_rpm;
 
 	dev_info(&pdev->dev, "initialized, max. request size: %u KB%s\n",
 		 mmc->max_req_size >> 10,
@@ -1475,8 +1482,13 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 
 	return 0;
 
+error_disable_rpm:
+	pm_runtime_disable(&pdev->dev);
 error_free_dma:
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
+error_disable_mmc:
+	disable_irq(host->irq);
+	sunxi_mmc_disable(host);
 	return ret;
 }
 
-- 
2.54.0.windows.1

