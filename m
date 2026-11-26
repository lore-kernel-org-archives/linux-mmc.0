Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717792;
	b=DWdxRk2Nv39ACRHoER0DZ51inu/tms0SWu5UUhEbrsQsgSSiC+W4lcbcJrcOQTCVM+f5
	 fp4C9Kf5J4dLpuqWcx7x/10WVDEfezAunYvepFQttY10Mta49KBT2AxJ+V80138A8LbtP
	 rQwGqRh4irbbWqy0r0SnrKxxc15/TGm25I3rO5+qtBIAsNpiJqJ4a+UdiotiWQ2lDueR0
	 V7rWDYvpADBNvXUWwIK1BZvTa/Ap+A8FXOYbryg1/GsvhLkMmBXj2DRL96m3Zxww3KaXk
	 2FV9mrbqUzUi+1PJtV1b3FUnlU5vGU7ZRdU/XV35Gp+n8a8ovMS9uuSPc+ln8t4Casg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/q8f729eKxMWvV8pzxhn9Gn25ubKt4vbGrfRah8m1Uk=;
	b=sEntsyJZcvRZL1mnjoEUTHX7unpeUR3ziT4LQprkyoVl+jRfbRReQEYRQTVABm10pk1v
	 oXyuvrBmsFLWE9CmeejykvZ1Po/bO67KLFHBttFC0nFkAHEGGimPgpHmXlxhD/3w+oHPr
	 23HzYQF/XyYljp2YV01iZxIIDVjVscQtgkmDEEMDV03sKbCl9LtX5XjjuG6a6APyiY5g6
	 R8l4FQvQnwO+bs4yFFqOJdHkp4a+jyHOzs9OYvbqYYvrXc8WOWxRryIGOhS0iaed20+Sd
	 ZaGM9lahz0OSM8ljpol3MM8YIU1bEJOtP+RAJ3DVofrBN+Dkn/4M8OKmzOjPlxOsI4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xV0vkAwp;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0019606A329
	for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 18:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0019606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xV0vkAwp
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4a357b1c649so4250725f8f.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 Nov 2026 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795717790; x=1796322590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/q8f729eKxMWvV8pzxhn9Gn25ubKt4vbGrfRah8m1Uk=;
        b=xV0vkAwpuwZNdzGyJjsCOChioy5HLjYi/ssfMex0l+IfAaOzd9N7HH9+Wqv2XwvvaS
         NMsmEUnwolvruXOgLj3uCoIwDFAJjGbMCcvVrTtA1PqGGzCmpqTC0B/WyHAVsMLV+s4J
         aX9K+MljvWRnnPaBWdo00Ji/DOF3s0glZ8tGmcfqRpaA3LlTgFQIVEKNq0SQYYDBHGKZ
         7RBE9/QB7IW3GOnuitIP+YpztVSkmz+nYFSN8PqiMy8pNd+pfX7fxKFvZ5OJ3EarKU1F
         jK4/e7zhhwa/exSUE4xdobLXwlpm00pmz9hs8NSarb+d84lVp/iyoYtz6eFFiELY61SL
         lWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795717790; x=1796322590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/q8f729eKxMWvV8pzxhn9Gn25ubKt4vbGrfRah8m1Uk=;
        b=1h5j0KTSvOMHeLTifQXk2lynfewR2J9rJhLpeZrziOzLEgVeCnAeW0+xTyJ9xcEHAe
         YZ4JOvtb5B8UI99Ae2ZzM9papNB7aCydayMrHr5H++xv0I9fxbltDrP/1/V15uwl7kgU
         fOgOOistsSDGRHEFDdHqyj5rFzsHiBqX+FkD0QnZYIWc1Q2QxhWQsycwslNsOZG4cmRt
         J4EtYeIWdbfpDAPLgIbYO6kfyW7Gp0CRlaNw4TjZoh9YHzn4icsjz1j60HvRg5wJGIZC
         o758B6ZblCKNiSdSy7KEXK6NUF6Y3S4Lgw/HiSU4NNowcB7TIFJe+xXczo/zAtMekllA
         hUHw==
X-Forwarded-Encrypted: i=1; AL+hErFfFAqQuyZaXJLSmrnWVgApu8Hv3YnO+mBEpVyWHh+7D4bnCwKI0voqcdN3t9ymhGEf/6ALVeS5PH8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DATJrya/WVOFaMplIm9uM8RmXIifa7hnDLGEu/JJz4IGD1w7p
	iwTOiUqDZEgD7VMBNsoiB8/PEc5+O61cBzRQ3f0bcYOLUiu8Qas7dFwS
X-Gm-Gg: AZFdTZf8nOPdK4bkeRpawYAjjOWbR9di7hb5oT038hQq7hzZym5rkZHToCd+3uXMNcF
	zNwMiQ8MD4iLespQXTOVlRP3vYpoRdY4I7zRNF08zoe05mamZp5P0tUy7Royg4UmerixtlSUA7E
	/pH2bl9TTbJgIQc/0H3Sx0K2XxYoz427iJggGcT6650cQqPH5movWq8YpdYjY7L+9TqxHmU7Utt
	tdnJ+YIwFKNzfea+lPN96ZJsmK2xFGszV6CGkD6wQh1E9jefx0sipJoGOtgksIzkM22OJCpqhci
	E6Dp3HlM4ncTsnCUQaKnIP7pirgQTqeXlJ2GhiS7fsXjt5odj3iQj4gvDFIYDjhfFICrDGpRlnQ
	1XqNMoWib4qpjHsrEWmeYGkuq3jAmI+8guHeWnzGspTMeqw8texAmOAewlKe97hnvawuESTHRZK
	fHBLfKnjZfWvpflTg2yqTHbbIlAgjffwbWBTDaGMRLwoF6Q5fJs9xOfvcB/V30KU8qWU0ldYNhD
	CJMB2908VbH8cHK8jrji/+aZgZFYSUnqF/2tCS4JChjvZoltzxnVgNljQknd/vWTVrA9EBXkGR5
	6n4orS4sLcgt3gd6U9o+kb+Zx9lHgVtxI6yKW7PsmiUSPlNFZYan9i2iOpYG4rULc+gs2Yt/d6O
	duAgG7ivL3h89+OZW8P2g41ICMQ0r0d2J5H51xT+mAaLNh7jrIzRMFl8aUD7cTNqic6UJOLZ5Wr
	sFZp0e5TuK6+RY1Ys8CJft36CeCuDTEzfEpfvIWB0EYgtO6PQYQo+5I0BjwqGMp/ovPulAGi5zM
	XMk4KPT5AiWMihsh+DKsQDD2s4vUWsoeoPoTBZ6aw==
X-Received: by 2002:a05:6000:200f:b0:4b7:6dcb:e906 with SMTP id ffacd0b85a97d-4b76dcbea3emr16532367f8f.43.1795717790229;
        Thu, 26 Nov 2026 10:29:50 -0800 (PST)
Received: from jernej-laptop (77-38-7-250.dynamic.telemach.net. [77.38.7.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm42382159f8f.41.2026.11.26.10.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 10:29:49 -0800 (PST)
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
Subject: [PATCH v2 1/3] mmc: sunxi: Set the IDMA DMA mask
Date: Thu, 26 Nov 2026 19:29:42 +0100
Message-ID: <20261126182944.3136900-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126182944.3136900-1-jernej.skrabec@gmail.com>
References: <20261126182944.3136900-1-jernej.skrabec@gmail.com>
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
index c7fda9c66537..c53d47576864 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1390,6 +1390,11 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = dma_set_mask_and_coherent(&pdev->dev,
+					DMA_BIT_MASK(32 + host->cfg->idma_des_shift));
+	if (ret)
+		goto error_disable_mmc;
+
 	host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
 					  &host->sg_dma, GFP_KERNEL);
 	if (!host->sg_cpu) {
-- 
2.43.0

