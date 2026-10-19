Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D674FD29E
	for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420409; cv=none; b=s9wQYJL7x+KcKB4ZylYC2TK6NfQ8EKomX32XliCjLWimIQe/AQYjMSjSeq9m1sFj0XngWnTNaiEphLXVxogNyA3ZaFAP8mJkzyI/7Is1vPAwS9Yjb/fwgUe9ZEskkk62EPgHm6NDx5uLfUDGYQIzPapagWkLHLBBTH8jJB2140s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420409; c=relaxed/simple;
	bh=HkPfe4TwSkVsbnZmS4H8xckQ8k5iAfFxgOmrbcXbDY4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F4/51pWxQ26coY0hvLnp5+se9TZmc/yGHDK4dnaf9m9SWuBJRpqWiMW3xN5115jijzaHil0ozuFOgwTpfr0ULgbK+a4QLaHYzegfFmogoGHbZyWZIB/fQbBto7ypsrbl4G3+UiUMxG+E93mxKYiIeOurdl15PRfDbgtYNcHUuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYkvkZ6+; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYkvkZ6+"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd5f2834b19so91689a12.0
        for <linux-mmc@vger.kernel.org>; Mon, 19 Oct 2026 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792420407; x=1793025207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rjxEHDZhnxdkStUSnVdQe9iZZzJrl+XY6zteXqLUhxo=;
        b=BYkvkZ6+I2101KxneXqIrnwd0x9FAN8CDp6MlXghoF/zAegQ2x4TPXi8zzZ8yvfxpa
         naOrhjf0yzux96+Nu34k3aUlERG/gJ0VqEIY4BBIS9+DJGJdw8Ne7nZuLL1PCYmfEYvU
         pcuGFt+4EqpHFrvJaBoEKYJSqlfw02z3Qetd98b23PIk7+Ih9XuIHXwN5GLzHj77kRWi
         Gd2yCElCcAXK8ZG1IH43CQy9O4L/QjqyvjSdQqCjAW12AnC3q3D7ANwtwn2+ncTVcSK8
         nlrNDcQSNp2mhfYKBgc79ktfByvl7YYwHyNrxOLZUxTOcm1LYGfG1+7Is8NNJ6sMFZNs
         ViYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420407; x=1793025207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rjxEHDZhnxdkStUSnVdQe9iZZzJrl+XY6zteXqLUhxo=;
        b=1dtfap10U88R7WR3swCvCbyguWc0fTV+xxsU/xPtLXr2jQv7vVVND1caYkEIl1bZVO
         6u2qs5CFtRI1CeYzgyL/v/AMZ/69vzVC6t3+kFLA6peNuSWYeiJ4DqfaYu5UVa7ts8s5
         JTQlWbhmhLtFhQ9FHJxvRgY5iKfXOdF7hAZ8ixy5vXuevin58EZvhJrUzhZVbnRNoIRo
         OUALIkjir76ZaJlQHiA41CpQwGqHrQKo6HsvhLWQRsNWqRo8doTX8gd+LSR63m7fvx/r
         hEzVrnpDmEgbxuSKEN9Xk/tUO59T+9bmm271U5HBqkzCQJU/iSAJVDgGdWLCxKNnz7+Z
         Fbzg==
X-Forwarded-Encrypted: i=1; AKwUvBzOZGFpiNL8Ariqn5kMlb6hxTQ8CWGjWqya+xJDDHIMWOwjJK7Y08vWep9e3iMgYNYovw6C2L8P2Wk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrchXy2wqYTOuI1dK/gQmui3QZ0vza6e//YIidsolkn2PkiEkh
	xng2J8HyOz6r/DH2B9rCYdF59SjEmyQoHY5xO86lAackTFl1Yd3t+id6
X-Gm-Gg: AYBFou24/IBIE5ZR7Ty9pbK6OFdJepzuwkQNYgPTv9r8jyMPb+/EfzsX86FaR53+puE
	YVm7y8437xMJA/nwjVRM3CizfHhTutBF/PDnF+uoEIHiIyUE3khLTZicuEXeXH8EayRWXi9dt7F
	/39AAyC8Kuw2vjkXw+Uz7aeZfK+zeN9pqzq+9spF6T+qe0YvyYw6nbz2Fgar/JrP92ELYKTkagU
	d2giWVSuD6CYlKWeoVFjnTSHzIQkqkKDhc+kvz9uFc59OPj+/npAtpn/iGMPVb7u+ouCBZuGbo4
	GDrjlhm13c/0hp9nlNjnVgsVDqZMoxikdMa3eKLL1Vk491W6JLA+MJEX5GpNhGJUofx047BSOwM
	+1sh6VrM+ZnO1uvmpYmLegoWv4vPx8l5hlWSIacHU37MKDg0uyRpbxOPP6ycBb42FeGx5iQRfxH
	U/cYpkMsVLLA4wF2tIRwlsTQAn+34PQqSPUl5+wx8DFA5IQ/sFaT7lzHTOIl4iR2wYpNgJU9Mex
	3zRdNo=
X-Received: by 2002:a05:6a00:4807:b0:89d:88bc:d9f5 with SMTP id d2e1a72fcca58-8a04ba25e3amr6477601b3a.3.1792420406628;
        Mon, 19 Oct 2026 07:33:26 -0700 (PDT)
Received: from LSSP.an0.nb ([2001:da8:7001:22:db98:829a:1281:5d10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a06a6407e0sm1249239b3a.5.2026.10.19.07.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:33:26 -0700 (PDT)
From: Guanxin Li <bruceli20040604@gmail.com>
To: Alexey Charkov <alchark@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Guanxin Li <bruceli20040604@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: wmt-sdmmc: release DMA descriptors after stopping the host
Date: Mon, 19 Oct 2026 22:33:17 +0800
Message-ID: <20261019143317.2222236-1-bruceli20040604@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wmt_mci_remove() currently frees the DMA descriptor buffer before
calling mmc_remove_host() and freeing the controller IRQs. The
controller may still be using the descriptors, and an interrupt
handler may still access them during this window.

Stop the MMC host and free both IRQs before releasing the DMA
buffer to prevent DMA or interrupt accesses to the freed memory
during device removal.

Signed-off-by: Guanxin Li <bruceli20040604@gmail.com>
---
Changes in v2:
- Wrapped commit message lines to comply with the 72-column limit.
- Moved the DMA buffer comment next to dma_free_coherent().

 drivers/mmc/host/wmt-sdmmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 489daee4f4fc..55675aa8d08a 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -895,15 +895,15 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	writeb(0xFF, priv->sdmmc_base + SDMMC_STS0);
 	writeb(0xFF, priv->sdmmc_base + SDMMC_STS1);
 
-	/* release the dma buffers */
-	dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
-			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
-
 	mmc_remove_host(mmc);
 
 	free_irq(priv->irq_regular, priv);
 	free_irq(priv->irq_dma, priv);
 
+	/* release the dma buffers */
+	dma_free_coherent(&pdev->dev, priv->mmc->max_blk_count * 16,
+			  priv->dma_desc_buffer, priv->dma_desc_device_addr);
+
 	iounmap(priv->sdmmc_base);
 
 	clk_disable_unprepare(priv->clk_sdmmc);
-- 
2.43.0

