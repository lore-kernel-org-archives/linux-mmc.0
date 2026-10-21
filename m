Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792587998;
	b=2lSWeM6IG+a/MNry2NXLi1QcT19WWxzck8x7fx45tvcCQfsmNY707uAiuV4KebL3s9Ry
	 KgMUxUACxt6QU/5LxxNcYembmMmqQx0iLnaUqm41vB3lxjpvmxrJJoe/Gsl2MxfxSUphD
	 7lvNbglESjzBu81p+1BJIS132BNRdyHpCVP+h5NH3eYsTFg32uwbEejeh0NkR2e4hVjqc
	 cLQBw2XPQGw8rNHmYWKGWHTOKYzhhf5k1oheNTkYH7YmoNt/njk+N+YREZBi7+9OuU8za
	 FHb9CYItJSrfcMcSN0K+MzeldyOpd18bQeHdjIiodpcRD3tgN7gIi4/OzRnPWCOnJXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587998;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+98zVGkdMsxdWJwCnDrHSWyfkX34gPs6MPu3KuqYYng=;
	b=D36rGpBWP3YtpwJez01lhoJVlKg9wzIKALsb9T+1Dsb06CNyWSBPzGQkvzZjz+t7L1vC
	 LY6NLRW2cbMebEqk0ImUCnP1HC5QeDhenKZnzep2KpmSJBWoEJE0QnUuRXL1F8C69oiLs
	 CPo9r7m6k0sgz+YoEHQKPyA7LsKTzXhbYBESnysC3HQT3uq9gYvyu+WWjyJXvmHIo/21s
	 hcRUvjoVN9Q5oVQpNFysCartbscOeqNQdqDcxgrcTE8qyqCU/6dfXYUfkpMrOAnKL94PX
	 TTZCkq8lpk19jEaipsYt9xOFWXIdUsTuPjT4cNjL2xmMQeveNqATn7BOyaK+Vs0Oqbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="IMNH/VJz";
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC9606A319
	for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2026 13:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDC9606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IMNH/VJz
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-396affa9420so103888a91.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587998; x=1793192798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+98zVGkdMsxdWJwCnDrHSWyfkX34gPs6MPu3KuqYYng=;
        b=IMNH/VJzZK++yVZogwJ+u8f3k7Uub/aPMS/Qkm/JCEC8znBpumIgeGOotyQxUnfnB5
         /kBdQJB7w7sp1On/V24Ik6c4NhQWSfKRhMX0CZPauxcYRCXN4We/O2ugqhdoZKlRUY9S
         y1TJtSZQZ+1w4aUIar8FMMK7B3pPQNwmkT6Ju5lY3jAVPKDquHfjqBKU89s0wZZNqVLj
         N3zpcKJdSYaYW+8Ua2EvThpR5NYD9ur2BqgJ/4q2AxLRTvVfwrQRJaTDC+xStFdUjRUU
         0Rfc6HnpJmtW5WAlA3lafLtwG3hyzXwM8lUGbLsvc1JznK7Uo+K3w6Do+OPrQnc1VdWQ
         vSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587998; x=1793192798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+98zVGkdMsxdWJwCnDrHSWyfkX34gPs6MPu3KuqYYng=;
        b=eEqO/0giCL+WD2M2h9k0qNU/JhA0UPWw2EcNrJDaTt4BI7XILOpF3zYrmYeWuwGgYM
         HGDpc5uh8dJb+W7qOoRez41SNQ2Bt/FxJyF6l/B/SM521iWjC9RiebTSP7AmqtFpsl43
         BTzmPQg+O6lvj0T7A1Q30r+XADt6T9qjDetieoC8XkdX2vdpYA6TNojSs1qF+AElXV9a
         /KrLa2KKH06H8fuNT3Ia+4kqeIcd/rEmCzJHE6GMzlsP6gxJ9v5nHeuUSx2sYePX3mm0
         9lX9O3BMMaiTbpf4enRKFF/9svpVJKlayQl5dJfv+RRBhKFuw750Aa8N55lIH5u3MeJv
         7b4A==
X-Forwarded-Encrypted: i=1; AKwUvBxp692bTcxK42/HE6POIuGOB27LFphCMkIH+cBo4VzXR2txu+D8SVIfhnAj4fgMu4g2wnbmiSFjeWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpq/ood0NAA9DnosR7gGYYvorZooFAJJYYEcZVrOf5rUw5kDKM
	5j9SV8nZikTGqhLp7sRWAXKbfHR5zgZpJYgFBE0UWoVabdPG0iwe9hz4
X-Gm-Gg: AYBFou1N6vpI8jL4590n8vutX1p8lQucaTvw4MxwVd4GEorJo58IE3eJvJrNDkh91E6
	7KT9kQoo6mqKMBZuKTlcpJqdriQ0mdJLcAmXKp0h3thzC4zcnTQhvxTzIkCavp/8gmfusr4etxM
	JVCMEu6JP8m6A7uLrGsSCcCcm4HdzdqyCMCVu8BVjTf4DJsgDgCfYLatmWB4ARXtw0NI1ugZRgO
	0UmDuEOeJDt9/IsjMHlorJXkJfjzql+WuW4zC9XZGD3eJiU5EMBTEIvgWjSjfoiCYSouwPW1WhS
	oDbVqtxSQ9sqjiEpy4gRv6cRa69qfTM0K2yhtc40l/6cjnYIKWAzl80KxNJL4BZqxxvxsR9SwXI
	2zgmeIIn3iK4KCf+SUjxAe66oStvcWAdK/lHukZzOtbuoqDtZCUEBr/nEpLggvMN8nxnJVW+WAa
	6pkhQ++81UwadNms1QjKrWg+SemKv6Mkai8Y7euFfiWs9gZNqA5j+LRbjjemya61LtRiKk6QwOZ
	zBertGSzfDEY2Hm12axfEjBCcVY3xuChJmX78f75AoJJnJKn/WlGyN76w==
X-Received: by 2002:a17:90b:4cc2:b0:3a7:fef3:8561 with SMTP id 98e67ed59e1d1-3ad86f44cfemr2971957a91.5.1792587997602;
        Wed, 21 Oct 2026 06:06:37 -0700 (PDT)
Received: from LSSP.. ([2001:da8:7001:22:77e7:e706:c482:1610])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6a8723e87sm780033a12.25.2026.10.21.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:06:37 -0700 (PDT)
From: Guanxin Li <bruceli20040604@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Guanxin Li <bruceli20040604@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Rosen Penev <rosenp@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: moxart: Stop host before releasing DMA channels
Date: Wed, 21 Oct 2026 21:06:25 +0800
Message-ID: <20261021130625.1616753-1-bruceli20040604@gmail.com>
X-Mailer: git-send-email 2.43.0
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

moxart_remove() currently releases the TX and RX DMA channels before
calling mmc_remove_host(). This allows the MMC host to remain active while
the DMA channels are being torn down.

Call mmc_remove_host() before masking controller interrupts and releasing
the DMA channels. Terminate any active DMA transfers before releasing
their channels.

Keep the power and clock shutdown after DMA teardown. Do not call
mmc_free_host(), since the host is allocated with devm_mmc_alloc_host()
and is released automatically by devres.

Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index 28aed13549a6..bece33f4792d 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -684,13 +684,25 @@ static void moxart_remove(struct platform_device *pdev)
 	struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
 	struct moxart_host *host = mmc_priv(mmc);
 
-	if (!IS_ERR_OR_NULL(host->dma_chan_tx))
-		dma_release_channel(host->dma_chan_tx);
-	if (!IS_ERR_OR_NULL(host->dma_chan_rx))
-		dma_release_channel(host->dma_chan_rx);
+	/*
+	 * Stop the MMC host before releasing DMA channels.
+	 * Keep controller interrupts enabled during MMC teardown.
+	 */
 	mmc_remove_host(mmc);
 
 	writel(0, host->base + REG_INTERRUPT_MASK);
+
+	if (!IS_ERR_OR_NULL(host->dma_chan_tx)) {
+		dmaengine_terminate_sync(host->dma_chan_tx);
+		dma_release_channel(host->dma_chan_tx);
+		host->dma_chan_tx = NULL;
+	}
+	if (!IS_ERR_OR_NULL(host->dma_chan_rx)) {
+		dmaengine_terminate_sync(host->dma_chan_rx);
+		dma_release_channel(host->dma_chan_rx);
+		host->dma_chan_rx = NULL;
+	}
+
 	writel(0, host->base + REG_POWER_CONTROL);
 	writel(readl(host->base + REG_CLOCK_CONTROL) | CLK_OFF,
 	       host->base + REG_CLOCK_CONTROL);
-- 
2.43.0

