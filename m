Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24B3437478
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533665; cv=none; b=V/E4ZMxQQFzNwHoBlT6RBojm52GIf5Dg+UEVHyV1eU7nYnv1Jgd7tTHEEOifwhSh9RXoSVbQawXRt4z8+RttSJ13IwZHu3xvMUK6Tc31XH/yvAYBbcdWjnZwibihOgUCLJd7Ke2ns2o1LoOjcW7hAuRzZC5iagh7sXrdTMhTqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533665; c=relaxed/simple;
	bh=AQEbC5gXjnq96gD4UbxnJsrrXRSK8uBtmRVGLbSyuhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujXtWgWTT/JKn5dXDx6GU+eJDUk9NQ04/0MX4sVpS1ffvCJw+pHLA85XK6YXusoUzRwXygtWLo/EwNa18TR9xBrFFmvUJ0tnV/JZw6VDceiZ3Sh2WuSMDfs3W1nXNIn9SCCY8bwJIWX9yYJEIsSYYLWhor/mpoOKDDAlfOYqGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lILSSDuv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lILSSDuv"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so1409086a91.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533663; x=1787138463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=doym3QyHT8bL7rPyfRL2QEekEkOSH3JrEcV5LcFpHT4=;
        b=lILSSDuvd2PlLtSY2uzE95zBDvcg7bHZUUirPl3InUMuTh2qaUI/6tE4xa3QMTEM3x
         jSyMm55r0wUSVbMWwZ9oCu00JELdehFLAhwGdOPEkeaMKECLGsZfVmgbQDk7Ty/swtvK
         F1LYbqYHJpfu4A99pxObUQ7lT0sEJoa1beWeykipkHk5pK6TXYx95u+2V+nd2cimONV/
         qaQXWn0vDvUxhc7ZLPZGSGQIxkudK7BuM+Q6e/f34dx4LZLySSoWhXGF/42rVyXUgkHo
         dUp11x0cgCp5OILA/wFYkHTw5KZypIaytF/ncOvE00WcydcDBw/gZ3moCpopjKGk/b9u
         6GvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533663; x=1787138463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=doym3QyHT8bL7rPyfRL2QEekEkOSH3JrEcV5LcFpHT4=;
        b=cvUalGr97R5ab6Z0kLSFtEaWUGPBQ7nlsTths3UHC3Vth7OqZZPr1P0pxHxCidbS3O
         uhYDEgOXkAW2bYXQDde+gw8CE5WzORiKnXZpjFYoEyIu7l6F9R9bpAkMSgkUraq2XGxs
         Xp8kEjIjGfjF0AQGdW+CvjIzF62YLGu0ED3lTpdQMmoWstjhSnbbcgo7gJbAQ9+YRiSI
         ho3QeI5QkM4RBBZDNqx6bqB5rx91kAGsuzZQ9l81MzQmVDX/Kjl7pMUS2zmFG+fZ41HN
         XxCfDmcbg4i1hCFMG6sXBw5CKDZAssolT56yKovGyPGGWuvOuMIqC4WMa1k6oVGbYlHX
         KDmg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7lzW62Wgq5wTv3jMgkGpK01HZeCujm9M4p1qEspeXhBXLXCviJhQxHeN/riYCRkqxgjZfZTG6aAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZBYUWvqOrLpnpzwqi39/2aEYQRtjXgtczUwvglqvQidbbs4Sp
	bsaF46Mq/z4B02cpsPRnXX8bLcHfGl8sgAZI4A0i0KQUpAy7lR4fWYKo
X-Gm-Gg: AR+sD13Zj0KcJ2e9WS0yZJp7WiJmbp2LWt/3IM6tNelfAJyLXDgapeZNHf3IKhxxqgG
	2nQl6PH+YaGPdbTJmwhVBuaL19xsJlBLg5RO5eO1Vv6hMJdaWbzFTbdpJNhUjkmmS2n67tz7aNN
	FilQC1pFbQ/Rt3IjzOkkUUBmt503GAuGcssp/wRS9L4cY+CU/S5QEC0D5G2rYxB0fTxqdfxAn28
	DcCDOupi0ZS7GPBxvJrSSHy+UsZbvpacMgGa4nc7SzKFTfsafwxzhTTHKGcEuxMLKci6m25cZuj
	m9CAvhpWj1Tfyv66WRyDXCD/LWLqIzLrHC4tyQaELgm74Yz+1OYjtQS71E4quqzOuPo7RnSkn7o
	3znGzv7zyIJ4C2ptcRkmMEsBQf6fyd1Lj+Tw5nhu8ZKHac9xK19ZeCfHQGZ4chGoNXe/FdKidui
	m33RZ1smcddsiN3HScIQ6eSmyHiPxIR19mAHjUJ2SA47ab2aUyqhWVY+jvBIrsvmu1IQJrZYYrn
	spKBtjzEbwfA53GAdCjnNC2Gk7he4SDl/953JH6wGTWY0wkmrrByct0PL3qe1CzFIpwBdeI41FZ
	2AjdpjZTgQ==
X-Received: by 2002:a17:90b:3807:b0:38d:f096:a1dc with SMTP id 98e67ed59e1d1-393013e58ecmr4752057a91.11.1786533662842;
        Wed, 12 Aug 2026 04:21:02 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f5ecsm3193765a91.5.2026.08.12.04.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:21:02 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 3/3] mmc: davinci: Handle optional IRQ return value correctly
Date: Wed, 12 Aug 2026 18:20:23 +0700
Message-ID: <20260812112023.42254-4-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812112023.42254-1-phucduc.bui@gmail.com>
References: <20260812112023.42254-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

host->sdio_irq is assigned from platform_get_irq_optional(), which
returns a positive IRQ number on success or a negative error code on
failure. Therefore, 0 is not a possible return value from this API.

Check for a positive IRQ number before requesting the SDIO IRQ instead
of treating zero as a valid IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 4765d2dee599..dddd152d2ec4 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1303,7 +1303,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	if (ret)
 		goto mmc_add_host_fail;
 
-	if (host->sdio_irq >= 0) {
+	if (host->sdio_irq > 0) {
 		ret = devm_request_irq(&pdev->dev, host->sdio_irq,
 				       mmc_davinci_sdio_irq, 0,
 				       mmc_hostname(mmc), host);
-- 
2.43.0

