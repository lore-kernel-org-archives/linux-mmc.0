Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9705738F80
	for <linux-mmc@vger.kernel.org>; Thu,  8 Feb 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423704; cv=none; b=jHzR/dD1sfPv448Z7VUYkNjKzrXW8zLv7ZZpw4CkPsiPsMbObsGPSG2GduzhmF5E12EXXZYrNPgmUy9AYrsaj2GN/X5Wsunf3iMnoZRCnEVCqhwvi/SE+vG3gYojjHXCUojVqDy8aJdmf/WAx1tiVwc5nl0r0Q4BCMR68aUiD04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423704; c=relaxed/simple;
	bh=tsee4NBKtAR96KWrN8Sd6UvcENo+6pEmAXhvCXNQMq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZQGm3gHQ/WM/hOGU9s5+P4EPdpgJXzsXxPi959riWidjkgfNdOunkeZ5HNBY/wiwQmMzvPF9e6B8P7eZzJknpvayXWcFuazNzvoOU01t2QSd+O4aGvZEFHCmHssJytYdytQ2EKPNDdt6m3sn3ELxBYTGXOI7Ezj7HCQ6Br44f7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BVeZdwrr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BVeZdwrr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41059577f26so2422345e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 08 Feb 2024 12:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707423701; x=1708028501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z3acf27u1UG3FXBRbQIS8gUvuFH8u3NdpIthkRuoAGs=;
        b=BVeZdwrrCLaIVIFuK2LY9K5gYOpCsreks9oeZtLWj/NF4VNHELY4kYE9IXsjqUctJ/
         9g1k8bHjHo7wWDf1aAsZSfFaAL9cwvNrk3w5Tu/NJ9fVVfw4LnR2M4qzxk0e88Ao831Y
         niXLyt5q/O7/U4AW+hLVn+UF0xgHrzCNFCg3CytLOnB2U6GwjpzOx1dOG1MBk1drt+Ch
         9deIiQKgrNaYNGnXP25Vf4S/4FLBJmzpNwwUXm7Lisf8qKvH0B/uVu0KcuWDWCJMdSeL
         U4okl5jGkY5wZ40pfD67ppnstvZ/BmNvSxHIKL3PHhQVWBZBU5aUb1HY+wP+w55xKa4p
         PRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707423701; x=1708028501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3acf27u1UG3FXBRbQIS8gUvuFH8u3NdpIthkRuoAGs=;
        b=payU1Dws8+RnBPtZGcXqGe0mzy64Bsu4YpIuG1XTed0beAB6mky79DyyDNPbFpg75j
         5L6rNBu8dga2Okui6vQLLzWJvgF+Zcpn/wpjkJUGEu4/L9CyZRqvvMo5vPUu/d2oob9b
         W05TbamBs9cJBg2HjVXxd3pIGIPdHOP1EKP1F8GkeK6k1pAxyQR1Pr0UhqV9osZ7OtQm
         kb21u6HZn9S7BiEfCrFAA3MNTqHmCHV04WThyus8i1tqaFoU0eSGout3ufQTxV+jf6bx
         sZjZTRTFIPXmu2lljvubr7tVQrRlQ510xAT+2Fa9z88BuSTGPblX9pco0ZS9GDqJ/OXZ
         xG+A==
X-Gm-Message-State: AOJu0Yyk+Ii3mVAZ3raVyJd//jLFVexPK7yIsprKnEDDwyUdQFYvHZ2d
	j8yrR3wOwYHbOfeeAz+KRYLfIWoiNta2EBTPPt+JPsX1YOmGQPJ1M8VdAgk84DE=
X-Google-Smtp-Source: AGHT+IFUWsEumF3+dMYhr2VTrnxGuMPs8G4EV8UXVWSxI4vbqAdO8nTLkOk8hnwSe6Tv81llsq5ixQ==
X-Received: by 2002:adf:f891:0:b0:33b:28c0:7c98 with SMTP id u17-20020adff891000000b0033b28c07c98mr349299wrp.61.1707423700730;
        Thu, 08 Feb 2024 12:21:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWntY+LUqqaL/5/EQFIUEI5qSZCAvHwoNIb4PBn6lcNZRcol6KYHwLo3eRIa2UjHTXrWcyeyGLdv21pn4gWcBuGFBjLGWBk9gxpgtXfKt6l6kspZ9qvKBkF02ORU4wjY3i3IAPLeWkejOyjgiXpJ0LEUrnZUkgRkQeTlyDU0uE4W24d9iPWuT+yBSx3vy7XyYDo7u1Yibwa3WNRd5kx8QijQw=
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5305000000b0033af5086c2dsm102548wrv.58.2024.02.08.12.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 12:21:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] mmc: renesas_sdhi: use typedef for dma_filter_fn
Date: Thu,  8 Feb 2024 21:21:37 +0100
Message-Id: <20240208202137.630281-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing typedef for dma_filter_fn to avoid duplicating type
definition.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mmc/host/renesas_sdhi.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index c1fb9740eab0..586f94d4dbfd 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -9,6 +9,7 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include "tmio_mmc.h"
 
@@ -63,7 +64,7 @@ struct renesas_sdhi_of_data_with_quirks {
 struct renesas_sdhi_dma {
 	unsigned long end_flags;
 	enum dma_slave_buswidth dma_buswidth;
-	bool (*filter)(struct dma_chan *chan, void *arg);
+	dma_filter_fn filter;
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
 	struct completion dma_dataend;
 	struct tasklet_struct dma_complete;
-- 
2.34.1

