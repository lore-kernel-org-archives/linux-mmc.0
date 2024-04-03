Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD76314900C
	for <linux-mmc@vger.kernel.org>; Wed,  3 Apr 2024 14:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153832; cv=none; b=ZXDX3cnW3k67d/yZBNaM0/NIimPnr0N1BCEdwJCYKzNtWrbDJZYrdLlE6TrCCrXeJxbVnKn8pPpjdQ/PVaSvieDmA+Tm0GY1zUTSSQyN7uX8zYtHF+0TrJx5JQShgxGbW2RQldHJC4r0gtN60cSSLBswd7fgd0Funxv7xshDRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153832; c=relaxed/simple;
	bh=lVZTs4L//r8zQlK3x3Oc75ANgngPjdrDJm5Fps37rmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPUKwKRWDekowqRBcDtmTcXKKte7AWogKI20JkSV94ZTSOCt5yEPrKhTW9K65+9JHhsBorcEWOGsJHdrSajFdtAo3ZQx9KqN6cuCz5pwQHynwkAXEVBmyHNcKk1ZoYsaPMbZLbSKEe+GFbiItFC+4rqdM3w4euuyqJBRzqF6eUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kKi3r01I; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kKi3r01I"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d700beb60bso107471171fa.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Apr 2024 07:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712153828; x=1712758628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ppr78xyfds4y/gs/HuD/HQU1sIXqrSXm2ElFf1uWhWk=;
        b=kKi3r01IANKLKmDHolOdQ/mQ9QxEHTbS3PH3uspjpHk9ZbnvGmZHcvAZveBKCJOtej
         KFu0mbl66hqyS0Y5azmA0/s8UDvlWFfaJu2sQH1wUuc3PFuRcVxQdOCBnfaGWuoKVND0
         l7heXxOmee+isDnmW9iMR+qR6lES7P3yZQFznsb399eRCpGufpeRd1KCHt0C/0H7RGzU
         QN7rim9Cou2wZlLMgBWuqVqkRr0E2zdBI5XlOuBrZw7BGxcPIWZ6nBdjuNOsHF7GK4Xy
         y126oIFQW1GeMM1yYjnBaDminaZWZH2wZDaez6szzqAMgGa0odyC27E/tQJzkzB+Sjid
         2gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712153828; x=1712758628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ppr78xyfds4y/gs/HuD/HQU1sIXqrSXm2ElFf1uWhWk=;
        b=wJjRyPDmFIlW3S+ha82M8Cs4pDbjqUEQmBAw0MBAGNVg1UgS/n40KKh+6/EcQnzj+e
         94AKAcmpVz69v4nV5Kd3/d3AShOUGrOCsOQDJairuxDI95WKCM7GoOz/u9eHl9C7v3k4
         l1d8L3zPifZLF8cwfL5CmQjoMSX2fmRTC1WvIQKMQJsfs3bD/EagZCgoc4cwzKgclLhq
         CXMnrp6KDr1uUWGWXX74k8v41booIzHIfoysW9ObVKPUiOWqe1c9GXSN1DpKfhzEJUoU
         2LYC5wOr3aZ9tkDTGYmuYou3NpzmB2cPv1CAUf3yn2DX4ZHZsxzb2q31aVWyFrLhVeB9
         gSVA==
X-Gm-Message-State: AOJu0YwYIXs7cdnQ+aYdXNTvERJ8jxHz03a3XAkDrEwwIfF3slEBYFJr
	liHt1xnLYzvmOjpYcSj2ASYGBR2d437EQYwWeApElh9BGJYdT3zcgd0M2dxO5LE=
X-Google-Smtp-Source: AGHT+IHITyspHTuJLJiCm3uD5L9whotmJI6PL52WRKyXjtd6x/6wj7dT0DrrdPKaed6/6QZtx4wChQ==
X-Received: by 2002:a2e:a783:0:b0:2d4:132b:9f21 with SMTP id c3-20020a2ea783000000b002d4132b9f21mr5823286ljf.6.1712153827878;
        Wed, 03 Apr 2024 07:17:07 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id he18-20020a1709073d9200b00a4729f093ecsm7737819ejc.53.2024.04.03.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 07:17:07 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 03 Apr 2024 16:16:50 +0200
Subject: [PATCH v2 1/7] Bluetooth: btmrvl_sdio: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-module-owner-sdio-v2-1-ae46d6b955eb@linaro.org>
References: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
In-Reply-To: <20240403-module-owner-sdio-v2-0-ae46d6b955eb@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=738;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=lVZTs4L//r8zQlK3x3Oc75ANgngPjdrDJm5Fps37rmQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmDWTZ7I4ClqbblsU/YDwuN+xIc/3Y1gTjSNaZy
 JhDcyaZJcaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZg1k2QAKCRDBN2bmhouD
 15VlD/44soyCyJj5Aluw9HL3+8omGcrBNFacDN0qbC729QPsGy00VDC7y9+1wNu1vEvG1h3r74i
 VrDi1MGtgLEjHG7XuZcay3wAJesHb+XtOZUtqPs988gXdBZZyzkxhDxzH1/BXCm21RWfAEiOiWO
 Uj9Q/Uy13NwxKP/ru8D95XdP+XWojOYoiQ/9oIogUTwkQLg/F05hBzYDnMmVWp6QIlQ1dSFDJTJ
 hGBLDYYoIm2fssEtsNou8pSg8sH1YlcP5pSbjhEXhptzQZqrB8XhSvY1dKjctGHh83b1CG2r6ED
 OjO7APPuodk6E+Zj2Qlig+VfPEyEykkXzsa/U8VeK23TJdcwJVkN+IPuWHFZaTaizN0DKWHsZ9u
 4pDuWAtLzKgOiJlGOOWhZUZTJnvMQa74Z0nAAGV2uOt9js0JqMZwBO+hl31UigQsrTd7QF2kYJB
 FTdap1mLHfHU9YHjEbLFgtN1cgZI2n62ggnstDFswV+DLF8QjlpVBU0L3z1td1njJ4M49bJ4eC4
 H/09oNwtL5iUz+2zGmJ3lhLHcZNh8zz3nXk4ax/DZ2Fm4yoxOICenz1/Ls1p6T2uQYm2sKHaxgZ
 n3qDO8FP7KxC7NUJii6Orbej2ORa2mUgnMzw4MisSdX9mg/n8qsRuLY3e7jj6/xJD4h7nNbIjj0
 RgLP9zBk3Q9ByvA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the patch in mmc tree.
---
 drivers/bluetooth/btmrvl_sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index d76c799553aa..85b7f2bb4259 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -1736,7 +1736,6 @@ static struct sdio_driver bt_mrvl_sdio = {
 	.probe		= btmrvl_sdio_probe,
 	.remove		= btmrvl_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.coredump = btmrvl_sdio_coredump,
 		.pm = &btmrvl_sdio_pm_ops,
 	}

-- 
2.34.1

