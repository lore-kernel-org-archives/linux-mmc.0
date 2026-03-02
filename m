Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E04379EFC
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 13:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459240; cv=none; b=kbmxYP2nrH9zlmlqmcjkmXEbdUT/BLz9Ux6dRdTheAWUzz0V8at7S08C4oUbcR3WrmeTceI8BfgqEoeXl3+9qrhWQaPvldniVT/heXcCV0v/3GSL5h7VKpTfVgfG5bkNRXgSRMr/OIjlh3COiIxyJ6j9mvdpjkmJPPCCikvL+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459240; c=relaxed/simple;
	bh=xCJrwcDDyo8LLH18A68PDQVaRjBZZCLL4CceXSPjnU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S5z2Q3LlLSM82H/kRVD6c3TN5fOklGzLTvmsZlPg14rSwcQW5kHDHRBNs/SJfZJNm0a9uGnTiNeqKiF2kcW5smL/Q9z5kOaVUt4GiXrzwFzXPJyNYd3IN40AxZbhZFpA/PiMi83h3S067pWjVG5t5Di5qI3BN06OdJs3qOhhN3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4Zsj7bn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4Zsj7bn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aae146b604so35021565ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 05:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772459238; x=1773064038; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19etRSJE9t4MqtgRfKOwWBsjZmOQTD0TaU9pT3V0aNA=;
        b=U4Zsj7bnMCtkthDj91l7MaW2gOYi/FEE5F1yOpmWggl1c/Uw2oRYs8lnVbGHssiNx/
         dAMAfCZgNq9jVKpzDsiyChBiDI4xdHe+4g5wj5pDMQqGfUzE94qs74OATPMZLOcuVyZq
         SE5zGC3gZ0lHcUV/Kc4v9ink+ae4JgYBgANcGIOdqhXwqdxGyZBTr7ba2DjwMEz36Pgs
         0SodbdmgPprmz5qMvX5SzUWBbSdyaJj0MrYXMn6SdbAmIonOJRd+eiPplU802amcQmhC
         FjEwHZW5qdFylMsMv+a/AQVA0EafwX7RhiqzyoV3Up9QHEWkaIrXg8eknaTnu3dW4l2k
         SfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772459238; x=1773064038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19etRSJE9t4MqtgRfKOwWBsjZmOQTD0TaU9pT3V0aNA=;
        b=bMW8XePpX2ZPRJe334nfOBzDA06xqZ3S1jlnKPBjosd0Fzrqm1Krq4s7uFetzLF+ot
         JXXTqgDKlpNXaEgy6f/W2lnwrPFyyMiXwRbCjEPFTM4+oMNFTcEJfKl2bMjzsiVrh/u7
         E5t2Vs3M8ML3I8cEFIgTsSy+oqlyazMLlrDCYKF2SKBySuJkMDtR9eBQvzqKB0/16c3P
         /CoX4LKq4iio2gYcHaT3/he5JZxE5ZqpU/3EXnTQm/uOHHuOk1f9bbt2B51D2BLJeM9e
         j3c9lA9VACc9zXupa3d2flSZSGzlD7j8QFQOGDlw5NZNhLC+ehuEpMFwikIGMocxCQc1
         c5Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXWr4mXtWMOSvXLh46YW3gVDy1PviaE5ejGKRuPJx1EbRaUkRa3axRMwgLff5EYFGaBrPnnTLamEIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj/LFj3LI10ScSgvOQHD9ElbHoJBA2kfv4Vu7G5qA1KdGZwmyq
	4Zs6gl7YaQv7DO2lunNxhRuvM0Ue/dWToLGKXmke6xGLheRwW8Vxu39g
X-Gm-Gg: ATEYQzylJ5xWHL5Rb8tStuhCuxy03+X5Iz0L/cjUHQmfEv2frqznBYV1aOnPUcOXxUh
	awfADSoN7Zpbdzd82h46Vjaf5LPCVMmoxTCAFygOL8ptMRO7xf3E4svnP4+ndofmaGIt1437JeV
	qPXu4gwnFrN6UxWFJWgI053SbZ+1WzZo3BI/NR0ZiOkStahfFYsxooiSlI+vI7sx2GsgRejRQXO
	3j9bQby/dlIzAsdzDC/WTzdE/m1WoryLim0f63UbKGjpgwoxyC8X1i3f24NRP0t1RH89Si/5FZn
	OzENK3aft8Xm+6BIlkJXlUDSprRxp0JXTXWrP0INGeJH84C1z7cx9wJPj7E7EKycsP9MVrTDtDR
	atYQZH/EFfxXwb3FltS/eVKuvM8PMIVg7cqb8zgZzKyfnYMwqZyZ5J8PN44pdbj5AuLCbVQ5BEB
	pQ93/SdYdYLoChTYyoFVW9csJuuBtDoOHLwppF
X-Received: by 2002:a17:902:e550:b0:2aa:d287:693d with SMTP id d9443c01a7336-2ae2e402022mr117574295ad.20.1772459237982;
        Mon, 02 Mar 2026 05:47:17 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:4c92:fc5c:54e5:712e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4e571b90sm37553965ad.62.2026.03.02.05.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:47:17 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 02 Mar 2026 21:47:12 +0800
Subject: [PATCH v2] mmc: sdhci-of-bst: Fix memory leak in
 sdhci_bst_alloc_bounce_buffer()
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-bst-v2-1-c7bfbed68d10@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN+UpWkC/1WMywqDMBBFf0Vm3ZQ8IMGu+h/FhUmmOlBNyUiwS
 P69qbsuz+WecwBjJmS4dQdkLMSU1gb60kGYx3VCQbExaKmtNFIJz5tw1nsXbHS9UdCe74xP2s/
 KY2g8E28pf85oUb/13y9KKBGjD1pjMBj7+7SM9LqGtMBQa/0CSp/Zc5YAAAA=
X-Change-ID: 20260301-bst-76bb7c6d7931
To: Adrian Hunter <adrian.hunter@intel.com>, Ge Gordon <gordon.ge@bst.ai>, 
 BST Linux Kernel Upstream Group <bst-upstream@bstai.top>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Albert Yang <yangzh0906@thundersoft.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772459234; l=1415;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=xCJrwcDDyo8LLH18A68PDQVaRjBZZCLL4CceXSPjnU4=;
 b=0DCQ9xxPJewQ/HpTkeeyfaNTm8Jm/WD7oQHkoQgp71kyn27fZMrrkq0Hz3P8CN4TuwKvRyLY2
 llzB6hbF953D69a6QL+fnDpluz9AFWpdUnI1NVDVlFYcTMwFNtxh5S6
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In sdhci_bst_alloc_bounce_buffer(), if dma_alloc_coherent() fails, the
function immediately returns -ENOMEM without releasing the reserved
memory, which results in a memory leak.

Add the missing of_reserved_mem_device_release() call before returning
-ENOMEM to properly clean up the reserved memory.

Fixes: 695824f45629 ("mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix Adrian's comment.
- Link to v1: https://lore.kernel.org/r/20260301-bst-v1-1-ddbc22ec3ed9@gmail.com
---
 drivers/mmc/host/sdhci-of-bst.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-bst.c b/drivers/mmc/host/sdhci-of-bst.c
index c124990a64f4..f8d3df715e1a 100644
--- a/drivers/mmc/host/sdhci-of-bst.c
+++ b/drivers/mmc/host/sdhci-of-bst.c
@@ -425,8 +425,10 @@ static int sdhci_bst_alloc_bounce_buffer(struct sdhci_host *host)
 
 	host->bounce_buffer = dma_alloc_coherent(mmc_dev(mmc), bounce_size,
 						 &host->bounce_addr, GFP_KERNEL);
-	if (!host->bounce_buffer)
+	if (!host->bounce_buffer) {
+		of_reserved_mem_device_release(mmc_dev(mmc));
 		return -ENOMEM;
+	}
 
 	host->bounce_buffer_size = bounce_size;
 

---
base-commit: 3fa5e5702a82d259897bd7e209469bc06368bf31
change-id: 20260301-bst-76bb7c6d7931

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

