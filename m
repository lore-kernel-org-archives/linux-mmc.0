Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975916E2B9
	for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193431; cv=none; b=YGRGAW26xn4wz2ChHtwkLGZOq/IXR+C5jGk57Iynin5wSKS+vi8Mog9BX6MhZPCPLcAAB0a283CHt7kjdIG7uiUYtaOoqj3J49/WTxi15jfVaXcMlTZqTH/wJozeCfSokN2nkmCVZdMkJ1Hb18d3c+3x2xlHU6osnVunbqqKuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193431; c=relaxed/simple;
	bh=Kek+Scrv6+UCfq5BBGg2zaWiIeeEWdDOIWCeg8Mvbsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DgzMm7cEcpBGPrr5iAFyr7ZVYt5X+t5ri3aN7245a7VaW8N8ImkvZqUPltpa+JA7Y4C4R12m1jBRA+mCvmyUQ5HLiRh1thACC55fj/mHGIw7blKx9Yw6BmumnpEDox1Zzl+0zoSRFWFJkfLU10i+1UPOeFyJoB90lBj0qj2L5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iF/8jP/0; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iF/8jP/0"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2cf1b770833so30162251fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 25 Jan 2024 06:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706193427; x=1706798227; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+N5XQAayZgM276rPgCazC+JMbS0uzbwzoNPf1gEMYQA=;
        b=iF/8jP/0rwEyRVzZBs9YGEMsuacgS8TzhhIJHX2J0dgjhGY9TyHXJ0+SdEX1xOIb8v
         0VVA/Z8jWRjuoffRbDgEuSlwsLsZwykHqONywOkKTvLt7I+dulQeYVUIaxLWXSnR1z5Y
         9wlDghknzk7H3+GHbAdL7JN4PmC434stLfGNQIn/fiI0bL9Y09aRf6co4zFop1MFxOZW
         h0vHZlbikEnNnkfErUUBiQI8UtBvLlqDmI4svhNy6FsEVOJ872vdIPoGLnHb++5L8Xth
         Fjjom6k7LmWaIfNlGwrP0M9Rn4GxHWtafReLczGYNT6Y4tCEmK73KLhZHOL8nGkGGryz
         ahRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193427; x=1706798227;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+N5XQAayZgM276rPgCazC+JMbS0uzbwzoNPf1gEMYQA=;
        b=FFMYQZRrKD/EMrVekD458fsDxHzo8hX3zeV1gRo14D+W2+E8u5qxNbJPzltd/t/uuM
         hzLfrBDPCo5Cl9+YM7UjgGa12UHOtaPUFR3FUszTP2nc6F8A1pQF5bk5MymIoLlb+Wfp
         p/zhSwAGupYzL9gFpi65CvE50Eka9pnJhb1oXZ2m2qbAB2GwmgVMkTMrsouUUcv0AZSA
         6Fr0QsFvKDvKusgCaj6EtF3htDGAC11HG96Nvc8G6EI8/rOsEc2AxF9nyDZBvjGWQ3XE
         0J8uOPOcfYDnTShtAAg6Q96tckLWAe4NCdS26ag7MN15+pLH0YDLGY3Vwrxm8GEZ1BCE
         HMAA==
X-Gm-Message-State: AOJu0YzJCSJY5JIYRIuieFsuIvX+d9m/skOWxEGs2JryHyHmK/lFoP4t
	rXQqd8iDai2HgIWtkyOvWbwemY1K5YqbOMZ0q9ZrQfPED57jAcOjmOanZKOR3uk=
X-Google-Smtp-Source: AGHT+IGs3o7wZDD6VJzuezIX0ktPG7wilQ0jcQWaR8BKd3udA01+8LyjxKr+DUfe0ol8eZ7VY2/FuA==
X-Received: by 2002:a05:651c:506:b0:2cf:2a82:7871 with SMTP id o6-20020a05651c050600b002cf2a827871mr715556ljp.26.1706193427689;
        Thu, 25 Jan 2024 06:37:07 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id y24-20020a2e3218000000b002ce098d3f0asm292644ljy.115.2024.01.25.06.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:37:06 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jan 2024 15:37:05 +0100
Subject: [PATCH 1/7] mmc: davinci_mmc: Map the virtual page for PIO
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-mmc-proper-kmap-v1-1-ba953c1ac3f9@linaro.org>
References: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
In-Reply-To: <20240125-mmc-proper-kmap-v1-0-ba953c1ac3f9@linaro.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
 Ming Lei <ming.lei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Pitre <nico@fluxnic.net>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Angelo Dureghello <angelo.dureghello@timesys.com>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

Use kmap_local_page() instead of sg_virt() to obtain a page
from the scatterlist: sg_virt() will not perform bounce
buffering if the page happens to be located in high memory,
which the driver may or may not be using.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-mmc/20240122073423.GA25859@lst.de/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ee3b1a4e0848..4e9f96b1caf3 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -216,7 +216,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id);
 static void mmc_davinci_sg_to_buf(struct mmc_davinci_host *host)
 {
 	host->buffer_bytes_left = sg_dma_len(host->sg);
-	host->buffer = sg_virt(host->sg);
+	host->buffer = kmap_local_page(sg_page(host->sg));
 	if (host->buffer_bytes_left > host->bytes_left)
 		host->buffer_bytes_left = host->bytes_left;
 }
@@ -261,7 +261,13 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 			p = p + (n & 3);
 		}
 	}
-	host->buffer = p;
+
+	if (host->buffer_bytes_left == 0) {
+		kunmap_local(host->buffer);
+		host->buffer = NULL;
+	} else {
+		host->buffer = p;
+	}
 }
 
 static void mmc_davinci_start_command(struct mmc_davinci_host *host,

-- 
2.34.1

