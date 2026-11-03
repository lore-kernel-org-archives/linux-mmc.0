Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730655;
	b=lSq6KInBtiqETOBfKWcDTXPZrJcXSGmdP8ycf//ewqnjF2HK+FrYNrfeUvBtHvQ7PTzD
	 8yzKk6Uze60jTOivJcSOrRaGqNt2jqG3melrjl6NbsPqa3gffHzgLKBEol00WGEkO7M6t
	 p93exwk2YdMkIAp18essEJ8R+K8eRImj/ITleIwujpDqb4vlYeXlSpc5d0UWJSXgd7DDI
	 wuqCQW+lTv2BqLYp5eDsLsEh4yEggkjrG+i3d8yp1a7wiqYNw2VaYOSytLWs/kTxxyWep
	 WV2BU8Z3NWydKUGojgAf3+MFXtn9hn0Dd3+60JJd5J2q+wynI5HDuA9axqCNxua0g1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xrBttNfHIp1ZblNkZtgms9+zlx0LAPZlPGiQYyXduk4=;
	b=sGIyT8M8hNaFLFH6trC6b7QDbsK8NFbqISPULmBPwzAooydeN4bnCSm7Es13vfri9wy/
	 zSDSGOTXRqv5CO0TTKWhg8Dy7eE5oEC3675VYqm5tlsZjiy91/mMIAdCQzzRKvF3qDzJv
	 3APOSbfh7/mBlPHLTl7YBIjA86HCVJmCLsaelb5iseIImpURaWRX/MbMjsp4ZgoQZOLta
	 EYtjqtfxS/TrpwN1NK+BL2mtT0xYe1hQi66uUtVVay08cLvssBl2rPMSq965+sRjzUIbx
	 dviMQs0DA+lpnHF8RZ4wV0cYzDn53b1fugT+CYniRHfQK60sH3ehjO1tcygd+T2172g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GE7Hmpj9;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9783606A334
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 18:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9783606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GE7Hmpj9
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a208d93758so48074655e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 10:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730653; x=1794335453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xrBttNfHIp1ZblNkZtgms9+zlx0LAPZlPGiQYyXduk4=;
        b=GE7Hmpj9ocv1ncj+ksOvEoyAKHd1Itzoc4rYp3Oal13d+3luOnKwoBRWjwDFPI/Tec
         xzwTZiw4zOWDWRxClVcCsyblFeGM14IUyYy/p9yyigzma+Vmv2aPnjls26oq8/BZz+4I
         VBUbEXkjgmcOiI0rfYIW8a0KmWJTc+h7597tEEphaBPasEtnrsXSx+ia/scyMP1IEq6i
         puoCMaiNYIf5Rt/T79U018LOzKoVuvua5Fwg8LICnw+Dj5Oh07uN48Atnx9DnApYY2VJ
         6YPjpB5e1pHZvUE2kG7UDhiLT7QS69A70Gh+16eYaf1ZYKTGnuvjsPF7SqXQKCpHIfeI
         1FjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730653; x=1794335453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xrBttNfHIp1ZblNkZtgms9+zlx0LAPZlPGiQYyXduk4=;
        b=qaqF0QU+EilAhQluKhfGtq1oyP+soVNGc0xoB9PzxZNGk44mGj9LwItu6lkp3lz4Qv
         1XgrXjpXwDfm3hZ0vD4jp3em0jpDGO/iG21rh839Z3ckmMV9xMeWMSRQzkw7QHSgbFrz
         u78F5myp7Qe74AKJ2h5yUozeyMgtL7wOHkkHMpf68mBRU/CGM8ozhUvN5lfiuAIOXllX
         EWoeasaX9wLqYmOYecgHzuvweUAXkd9U+b8Gctr7ebCNNQA7+9oJ9327jfADsdWVNJjB
         FSY+KznSKp67mLyrnOA4t5GftD7u1izMCjKJJ/zFFLCOf/3VhitFWZ2y4PKuKlHyfOWe
         d40g==
X-Forwarded-Encrypted: i=1; AKwUvBx2eBwAX59c/hC+g/lWi6JWAkAbapCluXDuFY7oB8z2qxcu0lSnJG9/4dmnP0yFZ2IqFSeNKLcqTjk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9i1kLUSRYumhS0ouhkeCkKkyRU36Jio0l7Tk7rIvd4FgLF449x
	7j2syf3aNxO4ipYpbUUGo4PupUnsUvenjx+EJZY7B/QQP3Ty+OlQtsZG
X-Gm-Gg: AYBFou3789OcDuUsAv6V3wFo9wkfiD1ceRyK0ersExOpqMct8RR7siknWqvdSaWLrm4
	DNc5lebXIdMvT0ag/PqmrhCTVDCV5F6jKzkNmM31Zafvyi4VtygcmPN+X/uvb5faM7JWtCeNlsw
	FlAsUpt3kD652ZSBiH0xwv0KUEEIqvfzjpOfvvk8Dj/TwYRMKNq3UaMgpGV6PQeQUaYrYo5ZLhV
	OvQ1LCL3SEc7BnOqE8Ut7hkh3k4kfW/30cAwLBumfM5z2FVFsCkJuxvEmIkrPN1BM6TZsyL3YA9
	go6k2CkepHQe9wJPJQua5nsyEvrm/B4rWkxxASf0ijx4BsoSXgcRsnsDTfq8JvNhyrkhh4c3kTv
	dWDtcf5vFrTJJsIQZ7IHYzynqgPRWy5ioLCvIBlaILzKfPAw/J2LYagflh+PWd2qNALYNCup7tG
	JxdsCiVL1gOyx3gjQZ0z7GiyECOsp2pVlYzQ+0FDogmfvYhX5JqkKSdXTICaVHjv5bsodqWW6gV
	pitLpEzUtQTzSvEaH+P84X70l4/XYZ67m2RqNqzkkSKkXLnjOUbs+Qv3Jwc+LJdYst5ZzwBRIZp
	mnC5AE3tmNsH86T5O8qlXyx0ZBpjV4brFkSbWOj98N6/vJ7N+A7mEK6d6IgtziylSAUI3wDPSJL
	D1LgdjMgexXItdILTxeqFKX7eUyvMl97d/CVnk9Ycf7g2q+fgCCJwVX7B/LnI3UY6TO1KbaI4Z1
	YNU3PfFX9I2nW7mNDJ7ZoWfkoUSD529IEWX8fZ8SkZXwoRLWPxISOVnkSHeKKcldBNDbqyVqR8O
	SkD0YKIV6CWbZORiiuCcnU6W6VdF3OFyO1JkA89HdVDr10D+A==
X-Received: by 2002:a05:600c:638f:b0:4a2:c2b:a91b with SMTP id 5b1f17b1804b1-4ac17d168a6mr314385885e9.10.1793730653132;
        Tue, 03 Nov 2026 10:30:53 -0800 (PST)
Received: from jernej-laptop (194-152-27-116.dynamic.telemach.net. [194.152.27.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm146339785e9.14.2026.11.03.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:30:52 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/4] mmc: sunxi: Set the IDMA DMA mask
Date: Tue,  3 Nov 2026 19:30:28 +0100
Message-ID: <20261103183030.81078-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103183030.81078-1-jernej.skrabec@gmail.com>
References: <20261103183030.81078-1-jernej.skrabec@gmail.com>
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

Controllers with a non-zero idma_des_shift (D1, A100 and H616) store
buffer and descriptor addresses shifted right by two, so they can
address 34 bits of physical memory. The driver never sets a DMA mask,
so the default 32-bit mask applies. On boards with DRAM above 4 GiB,
like H616 boards with 4 GiB of DRAM starting at 0x40000000, every
buffer above that limit is needlessly bounced through SWIOTLB.

Set the DMA mask to the range the controller can address. For the
other controllers, it stays at 32 bits.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 9744b6b860ac..479420071c2d 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1385,6 +1385,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev,
+					DMA_BIT_MASK(32 + host->cfg->idma_des_shift));
+	if (ret)
+		goto error_disable_mmc;
+
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
 	if (!host->sg_cpu)
-- 
2.43.0

