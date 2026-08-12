Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9B4334CE
	for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533651; cv=none; b=Clea3oL+jNIxHwVSyhTln6dpgy8atsXhtZRzphkMkD6JO5U4m8QeLj1avAJVWmARl6XMHOoY8kivdBOZPO0iFCPQNujsWiWK0KTUuVw42PdZeu7ndP7E8ffjMJnHQ2xeYk1XfjvRSyq+WO6ZKSS8W9Koa2Q0dycDO6aBeh6SDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533651; c=relaxed/simple;
	bh=+4UanzD44hCJmgC20DfI+OizByBl/tAq1xq63Nt1/hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FyawYm5xb9AGLKxtfcglwWldI371yf7WvxmmxfUcQVrhHn+Qlm4PGv8QBvOSc5v00Vjhwv6frJzIBMTqw+a1mTqiFfrvY6YTrkscd9pXDzSwNSquyDzwhVj0DFRua/3+h1PYIY5HMK33pfCizGbnrn2/lN4LEOfO8gwsBNna1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kA0Dt27X; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kA0Dt27X"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so911103a91.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Aug 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533649; x=1787138449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qtuJK+NS7IlYpY3lUfxDpExS70jRA4KXDLtMxQhzExE=;
        b=kA0Dt27XPEg8AtDqlD0/tIcghWKbcJGQRYwtWBnMi5h1o/lY9hCX/LIRMZjwEU+cYN
         hUIxUtDwA7AnWCwNEiabIKgrDOjFsZ2w9m1jUd6NyEMx/IVoSaxp/LfnFUbmgNvdx3uX
         WyeuxYMUw3j65Is6w0+n7JZQIE1SHvj6yG5ivTfOccm3adHzEXheXnGRsLGYGNREJ2mN
         13vIrBtXkNngk76UBJuCaAUcMsABZmDneXd0WR34RLPRir+BQIRpv5nuQGRB2+yTCTWv
         WKDxCG198/NQcLLxQDTRXW2Fssx9FhPKoDODPxq5d+wDhe2cw2Dl/COqq+HpXrxntTwl
         5IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533649; x=1787138449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qtuJK+NS7IlYpY3lUfxDpExS70jRA4KXDLtMxQhzExE=;
        b=SbqLktMCpkAMVeJFwFMf96DbZSWwsMqOt10eRczlI3nuiTzgmRPpeXe3DRfvXK0oIk
         3lJu8noveTqD6gEdlpWm/dAS9aJIRcFJbO2xyKv3+zE/0kSpTH+5WyBQvX4bQzq/oXwt
         GZy9+mavOpbHtVZhBp6RHNcEmONrpTaZGKPlIe5dV8kem60t1YIURUbLlUSBEbbIaaUK
         jMUMg2tO3c1/LbiwD+9R5Iugk0DYplNg9qrWsztGY1LECZRiohhqchxeU8jy0qYvpKRv
         m1OZUdyCliemX7jmhYER2Azr7Mt/DqwJJIIUYg2Dx6dABDYq1jmlKnyx54Qp5SHY/ZOu
         k5SA==
X-Forwarded-Encrypted: i=1; AHgh+RooKB+lpTbv9qmUyuFaVUMGo1qDA6NJyxvL2G8XvYDdiTe2rEkHsAQfD17Mh47n29hWUB6p9tRQC08=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd9kE7a89hpnRiBIvvLSmr3Cg3lkOUhUSmhOGLQ4yeWK87Ynxy
	m+VkNegreMIttIOL4alOlgN2ASs31pd4bNjIyu5yjwX6+ripNKXe+ujM
X-Gm-Gg: AR+sD13cC5YhRp2TNcYFn38rc7BmdiTo1eBw8EfNFLpWRdH3fGx01RfYwn4xoTlecNf
	68yg8QdUcH5skM/DPAK6ACzsNDd6JkZNf/GKh+beJlYYKmRPpDSEVBkP1ItSURGfLx+sb51XrVl
	WF8SEbvvNL+j+u1+17C0bMUfSQmesZuC+RPbOhAnAc+ZBiXzZaI37bLoly/mQaktKvVBFXAVaEr
	qvPhEdKiGPLBpg2JkfJ6LBDKrMEpR+aXIFMdXrjogwLjp3Dd1QFKKRoSGQ3N/ys4fwAXbOkYBz4
	cZy1LDEiBYCmE5wMJEKW0f40k2kWi2FuUW9A/B9zupDbEi2guWNODkykokGgWcsmC4Xj55ggAZr
	uaijJTvLlcNPW1CSuSmnlP1D1auS+0pwjr6bLHUkDN6/MOjN3md6NFBcboFSMW0XrDX59LteDI4
	BbgCNxJhcKvZUg9iDhTbQY+zK3RRZsLEnGPqnvxMQszs2Jc8BQvtVq3JXmzJoJM1Z/XPGYV14Rr
	eKTz8JdFBaV7NVH4350PwpSFdTwdrqPxWgEFWlpToouAYVTrV4SPB6HCMVvmkKuEgAxukLmCu/O
	6ocJ
X-Received: by 2002:a17:90b:48c7:b0:38e:7168:281 with SMTP id 98e67ed59e1d1-39301490a70mr4771248a91.10.1786533649457;
        Wed, 12 Aug 2026 04:20:49 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f5ecsm3193765a91.5.2026.08.12.04.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 04:20:49 -0700 (PDT)
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
Subject: [PATCH 1/3] mmc: meson-gx: Handle errors from optional IRQ lookup
Date: Wed, 12 Aug 2026 18:20:21 +0700
Message-ID: <20260812112023.42254-2-phucduc.bui@gmail.com>
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

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no optional IRQ is available. Other errors, such as -EPROBE_DEFER
and -EINVAL, should be propagated so that the caller can handle them
appropriately.

However, the driver currently stores the return value directly in
cd_irq and continues probing.

Propagate negative errors other than -ENXIO, and only assign the IRQ to
cd_irq when a valid IRQ number is returned.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 694bb443d5f3..af94c8138fcf 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1185,7 +1185,11 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	if (host->irq < 0)
 		return host->irq;
 
-	cd_irq = platform_get_irq_optional(pdev, 1);
+	ret = platform_get_irq_optional(pdev, 1);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
+	if (ret > 0)
+		cd_irq = ret;
 	mmc_gpio_set_cd_irq(mmc, cd_irq);
 
 	host->pinctrl = devm_pinctrl_get(&pdev->dev);
-- 
2.43.0

