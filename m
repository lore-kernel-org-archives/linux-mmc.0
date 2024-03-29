Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DC13B5A6
	for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 17:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733101; cv=none; b=rlOGUPZZw1OGa3wWM0W0YxMfzxPAWbrhEEtBu+65i6wpyU3BWHZLlQu5AChIu+uM2jhaGKMDWd3jzH5zJm1tK1ffOhdqRFPb++N8eaWcYUHYW3AyLnRBWdLCVl/1sqxSxmUyfpxkHHkEH60Mt63Dd8eyjr73Fj25RZ4W2nvetAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733101; c=relaxed/simple;
	bh=nydkRqQqfWxB+bwGXT+pWOUlUp96ndfzIb+plXc0Luk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7STg6vF2UL5tStEA3kunsA+ZuMndPxHVXvZvEj88zKca82bzlbpwrrvZ7XHxMAmD9IRoKcQDjBe6zOwTFcijX5GtREvMyAqdq7ZJf/umq05B5N98bQ5B1GMjz6n7CtASm+knWtY7XEDRfvQVlDuqnyx0d/tPmmJBGuQfNMeMNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q6llHLjY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6llHLjY"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4154471fb59so12284675e9.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733098; x=1712337898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Roqxke+jisLthE7YZS3ozhXKeGeqrvDxoYL7VwBZiOM=;
        b=Q6llHLjYD70FTWVaWuc2Z6ZpiA4Z0UW6Kq6ehNzw1Rn5JzT938v6rKRLmIcEQb47zQ
         zThPLKrSSZlNoCNPezdfH5gB4gzTHdPUA1ohBbJH7cxfb9i8a/JB2G1pqtolUQ/Ef8jA
         geoFH5Qlhh2RPD3r9R1vLVJnjo8UOYc9CSgdkSjHdCdE/nt5wXgc5Mo9RtwIvNgvxHaR
         dxEtVsypO73WVyOkQnLKIS5L+QZvVmKzX5wSRCqL1TohMg1ceQc7r1A5fop/bw22HfWk
         091nT6a6n7jrghNVEkludWJA33irrVLvEnjD/inNwZ1zS5qN/sBrtSl2eCPyrSD3Af4E
         HQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733098; x=1712337898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Roqxke+jisLthE7YZS3ozhXKeGeqrvDxoYL7VwBZiOM=;
        b=p920G/vu2TBbcWMVIt2LfvAAFbTrtlD4QW+f6mAU0KuTzkOGs7ysRT03Z89PlD0YVj
         Z1wFhB9ZQjpqUrFkSQ8INZveWOQFg/utBa7EOriQ6khjuoouxgcOJqNnEjVBGKdYoInt
         Ul+y48H4sHm2bcjr0jsPfiiKHvV/ls7r2dQIX4EW3aqPKgQ11PyLd9kmt1mc1aAt5coI
         FvaUmnEnYX3IjgWBiOqujBUDCQB3PbpN1qMCc2DS9OsDc6F3zf7dWqoh8Cidf8o8lT3V
         zNwr9k6Ei8Mvbq2JhMDtFmX7zcJkQMnwEOhAjFL8FEgNPwEc9mV5YkXo7mgvVDrRajXx
         7SwQ==
X-Gm-Message-State: AOJu0Yz4wu0X2sySWUSO/uYThWIakkCAyaE+S6TqhPSBGRXQLITByfh5
	BhNJqc8otPp9ffQyVG12beG2+l8wiaMTrfkGuVIh+ZIAhw8wsej33auOPPFa5h0=
X-Google-Smtp-Source: AGHT+IHX1RYKXweNoW/4aWXP4wll4zlnxIIegaGH0ndDYfOaiowD/kZKctfWDkTRS7cSWKil7XXIoQ==
X-Received: by 2002:a05:600c:3556:b0:415:45ea:9922 with SMTP id i22-20020a05600c355600b0041545ea9922mr1810546wmq.35.1711733097986;
        Fri, 29 Mar 2024 10:24:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:36 +0100
Subject: [PATCH 6/7] wifi: marvell: mwifiex: drop driver owner
 initialization
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-6-e4010b11ccaa@linaro.org>
References: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
In-Reply-To: <20240329-module-owner-sdio-v1-0-e4010b11ccaa@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Arend van Spriel <arend.vanspriel@broadcom.com>, 
 Brian Norris <briannorris@chromium.org>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, brcm80211@lists.linux.dev, 
 brcm80211-dev-list.pdl@broadcom.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=792;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=nydkRqQqfWxB+bwGXT+pWOUlUp96ndfzIb+plXc0Luk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlbB3ikwQPsoocZuYMqkRrpjcu9xVmLzCYer
 i6ERPR5OLmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5WwAKCRDBN2bmhouD
 1xrED/9h7qikJ7wiFUT5mJeAPPb56pHQIR3znbanFDO8iSSWRpJqkniw3tF0vuvMayv8QUnMn8k
 gbqHlF+enH3aqH0STc32gU582CkuZAI3UE2s3B5cQOYtxyDqYLA2F8bllNV3XEAABvOErLxU02x
 CJdEx6q0e+XPHvbxjfDX7r3Umv50WsrfGjtvLJVVRYCqRHMXei+5w2VrOILx89PegmnLbMZ6vn1
 oBTzHypnSTmhweyK2O/o+7mfO5WZ2azj6PNiBVPCXh+Fu1ENwjnJCUE8pfB2k7e8mxPK3FXQ6Ph
 njBzMk5BNW+RPXqN+yMOy+cC2wievLZtxKFVAca32Psvq5KbdZb48tOkYI5grOkigkFYjHzX0yK
 3OpZj4z/mB5A/Ioe3NYSq0tuvuEyYT+2IAC8DuBZ49JpcYqHkQEF3EwbLqOCKz/whyziiIYSZ+B
 tSIWpe4XmJVH6/NhmPLfR9ggYy7Z8SyZQp3gD1KHpkVRqVUIoIyMZQGYzYuRVxmnECSpi2zLda8
 g7pggI5y4t4k8puQZld/fxmKSYrfoAeIhgFnDjmHucgYUEbd70PChlJaGfKXIUBQhsbjoU38vLh
 72VvpFmDV0wLK5iUYnAT6fSG8bB88zS2LroeJ3y1rfCTA/1VMPT9fVOnZCCwLWyQ+kJ3JMCUHVK
 /ald/SQ8O0m98sg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Core in sdio_register_driver() already sets the .owner, so driver does
not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Depends on the first patch.
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index e1b58ca1b3ba..588140453821 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -979,7 +979,6 @@ static struct sdio_driver mwifiex_sdio = {
 	.probe = mwifiex_sdio_probe,
 	.remove = mwifiex_sdio_remove,
 	.drv = {
-		.owner = THIS_MODULE,
 		.coredump = mwifiex_sdio_coredump,
 		.pm = &mwifiex_sdio_pm_ops,
 	}

-- 
2.34.1

