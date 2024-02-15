Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6024B12FF88
	for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003704; cv=none; b=H7XFayKdQRILVVKS5LoCzUTM8ZgJti5gUWgW0rNv3maw6cEHHFrXBjUqA0Q1Zs3YEcVKoawVUdJkk5HSQkUK9OpLOYZwbLpLqpAQfmcoC0MxmIji95lPtCWsJfTm4b3girBdQuIZ3e83tIGXYMQkW4cVIUdO98EyyU2/5Kty6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003704; c=relaxed/simple;
	bh=NDRU3SvsOKVtvQqpAlVw8yPhgNVYLrkJEzuQZxhYqkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uWC/23FKyHoaR2vO5BtuFbRpw2KC8PWMMqHX0U8kCXg+NRy7doCsLX2jMMzsWPYkpt0zWazqNBTsPny1qEQG+Iwam1wkGY3LKjX4G/wPoSkriMHjJEizOSVLDDELINmuG45vMip1cT5PQOV3xVx9GtouQW1RsF57V2tvz3uEepE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtkpY+IA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtkpY+IA"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5128881b155so543980e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 15 Feb 2024 05:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708003700; x=1708608500; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7RUHNxptrkwdfRQ2tUig0h21GrxlTsZC6Hmm6HrBNjY=;
        b=MtkpY+IAUlgwYTCkblG7qJcJh8Frcji7zB/8uyTA9Bagrm8fN067jpMRaVWyh5V1MP
         2OZdVOyrHkLZrP+M7STcIidQSAe/fFW2uma9eGWBngToui3ZcJQTzfzvm6nuuTrNbkGH
         h2p01lJloUANQ6aXXlv+9CtUs6LkM2s09LtnL+VFaCn1QOtic8iMD3Z4B1A9QyDkR6+I
         hExo4Qp5jY5xLbBHeci4M4eaAl5gM+Q09MRj4tqFx/jGDyVAmt73rdevsDC5P6/rdgvY
         pf5u5NRibgjGnDm+9qLJVc2P/sDZxuy2LVrr2yJ+vDuNuZ26Sk53i4s8Lx0cc2IU3A52
         yXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003700; x=1708608500;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7RUHNxptrkwdfRQ2tUig0h21GrxlTsZC6Hmm6HrBNjY=;
        b=gPsHwaZCFvkIIQ6VT1nCgWvR24T+iqXO5N+OTCFs+HdIhJ5dVp5I99+A3Yp/Ze+M0f
         IemjRDfg43xzKIleW0gdjWkEw+VYMME2cWcXId+bNJpu/d5e8GywOjs6aMPbblnnqK4Y
         a6ui1VQ8vUQmeuYMfKs7DuV5glcOLUKu2KoTr5YL82ae2BSAFMjI+u98s19qE1wqCHmb
         u2qFz75NzS0vSOwMeHFYpzoVS9U4NY5VjbHQWSE3wwfpYYMsUe0Hx+qNK6+r4rYa5ri9
         yJZeNy1KnyIi4pi20JhWFtRcMqks/RzZjtnsgu+asyT0wZeVrbWVCDJn+ujPJiQFMZhi
         DxrA==
X-Gm-Message-State: AOJu0YxvgarUdhiwuHWU2+unxAky23XD7YMir77f9lzf1enMg+Xk61wD
	qdtm2zUyRVt4JrzgJjkaO7aRKTnXDiWmIhUolpJMVFx4rEi8DQatnaBGkwyBFOE=
X-Google-Smtp-Source: AGHT+IEd60AisevbOE5eZnC0HOXGkWUZE9qbvQCw0nnb1bbK/p/0LPvkDdq3Ih6/6myP/SovA233kg==
X-Received: by 2002:a19:7710:0:b0:511:ad09:288f with SMTP id s16-20020a197710000000b00511ad09288fmr501272lfc.10.1708003700374;
        Thu, 15 Feb 2024 05:28:20 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id j21-20020a19f515000000b005128a8f4bf3sm179333lfb.217.2024.02.15.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:28:19 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 15 Feb 2024 14:28:18 +0100
Subject: [PATCH] mmc: davinci_mmc: Drop dangling variable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-mmc-fix-davinci-v1-1-a593678ca7bf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHIRzmUC/x2MywqAIBAAf0X23EJKD+tXooPpVnvIQiGC8N9bO
 g7DzAuZElOGUb2Q6ObMZxTQlQK/u7gRchAGU5umNrrF4/C48oPB3Rw94xJcby1Zom4Aqa5Eov/
 jNJfyAaWXSvphAAAA
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.4

The sg_miter conversion left a dangling unused variable.
Drop it.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402142042.vg0lnLdb-lkp@intel.com/
Fixes: ed01d210fd91 ("mmc: davinci_mmc: Use sg_miter for PIO")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c46577305138..8bd938919687 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -211,7 +211,6 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 					unsigned int n)
 {
 	struct sg_mapping_iter *sgm = &host->sg_miter;
-	size_t sglen;
 	u8 *p;
 	unsigned int i;
 
@@ -224,7 +223,6 @@ static void davinci_fifo_data_trans(struct mmc_davinci_host *host,
 		return;
 	}
 	p = sgm->addr;
-	sglen = sgm->length;
 
 	/* NOTE:  we never transfer more than rw_threshold bytes
 	 * to/from the fifo here; there's no I/O overlap.

---
base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
change-id: 20240215-mmc-fix-davinci-bda788e8ee69

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

