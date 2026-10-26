Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003969;
	b=YG3wUcshWxPDmKtJotV0V933yS5GuLYCTBhurJxWDqHr+EJ3ZhHzMEUT7D89cyLjkhpV
	 hPYJ1LMLYJDeLyEsmGEuGcfwo4+JsWYs2e4dz+6M+HziaJvLuwXp68/Retz2oiKe+9n/F
	 bWRDGIUrXrb+RiRjV2isD0iPxYzGqJ7aIGiidxNAh7dbenVeGdlMvzcandzPEfP6z1U3w
	 wj7KbHtC2ghKvcCtrExRxxB3n1xsP9fqJ5dBIw+ucbe/drm/ZKCe2TtuXbAzxh6pYtmp5
	 nl9uh6dmxH4B5AXBM2krKprociet/XzTiGV17RFoUC/e+6Ib0ivcHbi6D6GSu0flscw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FNsk93EuVFBxLJj508WFUJM8x83vnwjCep0MYdpKjqI=;
	b=fzB1jSt/ssHErv8mULjgor3iWbYafBHdsAQxBs/JJojp8ytVgFn8LbQD3OLCHl8h8bFR
	 lTNt2EkQJrwmdFcn52isG8Ut6vCKu19OwIPzBhsNjIlhif9WuUtZyug21SZfgTYsJ2wgQ
	 ysHGrucWGHu8FbTLJ/1xyVBUqAlMXrxyQDWLOhFJU47FYgCvLUuXcEvy9BG1s409RaPAV
	 iHRaJvsCb95zILDPlSitOTKd8Hw4u9escjHboTUcMmYX1u7H9VwoRUm1vziACyKU7Uoay
	 TTaYq9ZrW4zmi1eh2POq/MyJYw1lmz3eBMe19m93ggLqklElRVO0XEn2mtekQg80d6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rg1j5lHg;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05834606A31E
	for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 08:39:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05834606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=rg1j5lHg
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df54150dfso1417648f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 26 Oct 2026 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1793003967; x=1793608767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FNsk93EuVFBxLJj508WFUJM8x83vnwjCep0MYdpKjqI=;
        b=rg1j5lHgIKe2pYctEnUSlK2gfR/BB707z/jC+v7QfZhX6VzgxZxs5z0aKmRwx9kbZL
         ixyd4iSTbbqPzYfy8XapAwDptOtJt+8GNnzD9HPmy/99EIf6ii3UmYFWTzXcPMNYNXXd
         gujqsxf2RTyoezpIOyMzyNuZQ0JRiySvH6S1qTephY9OxOZoH0s4k/+72RJ6Ssy/5WhS
         RzaAbPq87Rxhvn54uLbQm9t/kzWXMFupa5HSMYU1YVbMMn5MRih0CzP6FpM81bcM/o54
         +cIQDQJIQos50HjcBcdryfXvAurhHjB0oBs5c+Z8L4eweKXt8qRL/dE5F3FRqidRWIYu
         9hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003967; x=1793608767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FNsk93EuVFBxLJj508WFUJM8x83vnwjCep0MYdpKjqI=;
        b=PdoS0duCGXU61zpklpLvreKorOvZjk9gTCqe4OJKb/ZxbVntaUxVeuRx6/t337GvNV
         6ED5Jk2Z714GFjooEQjdvSc5bMrsGKU9pMzG9hVFCDWkMqKG95mQUpkP8j+J2cbutUUC
         gbNquopMMejyEbVV09ik1jS6RpBKwG7Rksn729iuVcdvuhX2KkER9jwQPXoIQisDzsjK
         WKDy8mvRVfOjE/U11dQB1kjZFJwdBoUlX5RS5EELoYuBfzhZAjtFflCNVhb34TaH/53Q
         ACng6yLTdwhY/wJXx0JeGgf5cbt5niMsWmJNfA9KJ5EexvLssnOgflvEz14O+dF3ZFI/
         QX1g==
X-Forwarded-Encrypted: i=1; AKwUvBwrKS7eVQNfuGFU3XW3JJeIJ2nBPKHNUs5AB0Raz6O6qRIufynArOaNDPXs169tb8/tMmQcNgNyTaI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKgIZ7V/dd9xSmmGtpz2E895cb8NYTTFHWpDRKw8J1hNDxbE5aY
	Da83y9cdD1hNZJZIkPgJXeBQtnnxXGOavjObQ95SxfZLkSh1GwBJl7F47/ugpG4NW9Y=
X-Gm-Gg: AYBFou1PCu/8hD3w14cp8nngnd4J9ZX7c0j2FBFyITfON6ArFYEjHN+VXCErEQ8S+5E
	xLWF/NkdDQDVs23GhRaU2mpLLSdW4ASsR2blapFfZV4Kqg/jwhFrw864OPjYuEN5l4/2wt/av9U
	RZhHJdp4B0dmOhSMmIS71rMH5UKyWf/sNETvzz3ag2z1OnD3hkpP48mrNcs7j8Kgmg/uREIZcl1
	Zz1iXv7xMVldcwBVSYfqoPqJXjN63S9Tq9BBpYOwfm4cvnN6UF+138b6UdzcK9DLRk/9KUMq7kT
	w7+2MlyBjxrK2+UkqGEG1TvsBphFjbXOFN1KMwCeQk7MQwz3li2nMckiMxHodTfV4PlT3OsSE+T
	HSn3/BA2L1OTWRlpc8SkIP1IX5N3JNtvKq84NSl4VYb9wx8AvUXxvtxS5lhJ0EptqHE9D3enC2N
	4TeNdG8gq8kdziPlXwnejwxkLezRpgsxcipVimWehNEvqmMPqkrCKao8hFPRfV5AcoUHbZJyNuM
	1Imo+pz0+93Ck/NnhCdRJRdMxYG8QJ1L98JUtrScPqPqrdazi6gXDSnQ7rWRiXU1ch67bWHNZU6
	eidvhRppCsr5Mw==
X-Received: by 2002:a05:6000:188b:b0:488:8bc1:a2eb with SMTP id ffacd0b85a97d-48e3eb98ee3mr11807123f8f.39.1793003967452;
        Mon, 26 Oct 2026 01:39:27 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3eb8f25fsm14673690f8f.2.2026.10.26.01.39.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 01:39:27 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: Re: [PATCH RFC 0/2] mmc: jz4740: Use the integrated DMA controller on the X1600
Date: Mon, 26 Oct 2026 09:38:11 +0100
Message-ID: <20261026083811.67574-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025140325.73204-1-olivier@mgcrea.io>
References: <20261025140325.73204-1-olivier@mgcrea.io>
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

Hi Ulf,

Please drop this RFC, both its premise and its question turned out to
be wrong.

The X1600's MSCs do have request lines to the system DMA controller:
the programming manual lists PDMA request types for both (0x34 to 0x37),
and MSC_DMAC.DMASEL picks between the two DMA paths. With dmas in the
device tree, the existing PDMA path works on the HiBy R1, card setup
included, and reads as fast as the integrated DMA did (23.0 to 23.5 MB/s
against 23.5 MB/s with dd, the CPU about 20% busy for both).

And DMA_DATA_DONE does come. jz_mmc_irq() clears the flags of masked
interrupts, DMA_DATA_DONE among them, and on the X1600 writing that bit
also clears DATA_TRAN_DONE and DMAEND, which most likely is why reads
looked unfinished.

So the X1600 needs no driver change here, only dmas in its device tree
like the other Ingenic SoCs.

Sorry for the noise,
Olivier
