Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C4212FB27
	for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711733093; cv=none; b=SMmSvVPQjb3xxiS/bcp6K10T4QpxYO4p60mi+25bIxpxuw+C5dpKsegp+LQBLwJqSWloR94GS53rQFIWAuwb/H+IFrPZ9czzs4C5F9kMayLTt6rNGESePyeBMnTH8hn3GUuLiBl5ABJ8zFGiNOYFf6hkS8/vvmKk9h1hben6by0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711733093; c=relaxed/simple;
	bh=qIRA9OHgdR8YIBTlq3gIwcNOO+uS8S8xKPRXlpB/umk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFGLj8Q3IuDONMcz93rhsAEUM4onEvbLQ0/ycDVgzIBYUDsGVxYftLWxPJXI+tOGSJkEMwX4O2/+Rc6zciaBo/mjhSr5ZQ8m+RaBewcaVk5+T3QaOoWC1Nt/u6yVAMfo1f4V4K6gK/8s9tVe1FHJ+E/5QpD4u0F5KxTlQgQI2RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X/qzsjPH; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/qzsjPH"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so2634768e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 29 Mar 2024 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711733089; x=1712337889; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kFzm6a3OkT0i9mJjLjkWWJLXNlo1hESx6fgfPVhA+Mo=;
        b=X/qzsjPHaZv1y4ISWIvdnKtmmK4fxUkvSnOiIeC/a+XoxGGcdF/Xd5Ql4B1DojuJnY
         jcWuUQOBuGnOMLl/6yKGhAEyUE5Qb1IFNJIHtuSXsdboGN3+ncRNPswrZpSS5vldA+q1
         eRAajVpF6XM17WHlZ1r1pH0YXrKR7QKjP6uFdFfLFqGEkAYh1z0e+I7xcVT5GPc9IQyE
         3O7HKK7bh4oa1jLV3Dx2G5Xeq8c45R7pDUhSLnukhSYyCxIwYs6aC+W77i9eE4Kk+Tpk
         UI6GnCP8GczkFNDWPeBgUWwCtPw5pPn/1BPPH2KsNvb7I69At66TgB//QEszrUjRHO2Q
         xs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711733089; x=1712337889;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFzm6a3OkT0i9mJjLjkWWJLXNlo1hESx6fgfPVhA+Mo=;
        b=lZh/yOsPYq/CG226MYvpqUlX/mcro17zjHQBeY33wKfcG2lAUv1flMWTLwRhtY7x4r
         H8Byu3Exb2I8nA+tXagXzcW4tMn+9SzanF5JWF9YW3uv+Kfzhb31m8anYTHMi7C09ZHQ
         sbNqWlLT2L2I0pG/Js9DAzE1m8LlVy8LAn5QF0Fe5QrhW4WThLMokcXVWvdrZ3sPL8g5
         BV8V2WfODWmU+tpJOt0OdEYAASE/YzZB5Qi3KQ94KydNNV0Q6Ka6NvG134mlANYaQg03
         ifbAHK/gvjLCTElGuqEQ98YtNl2qUgj/0BB8tD79aDQbzeuiCoz07TDwNk1iGIm5alle
         KSxQ==
X-Gm-Message-State: AOJu0Yy8CDbGLRrMv6pabOSOcSiwx5ExKyJvLyeRnvKGf/A+A6jl2+rE
	qmCejADXnQQbYM4d+ovhC2tVXHT3cW3oEr+Jl+0yyy+sVXvAkoeGPQ7p/e/+RPU=
X-Google-Smtp-Source: AGHT+IEvlw0UDH7tzNTWU9VGLGTzRW3UloZfuSRTHRpoMppAqvCzJhzmyXnGRBdjVA8i4o7Ah1qRHg==
X-Received: by 2002:a2e:aa14:0:b0:2d6:fb69:114e with SMTP id bf20-20020a2eaa14000000b002d6fb69114emr1610147ljb.21.1711733089178;
        Fri, 29 Mar 2024 10:24:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c470800b004149543c82fsm8491069wmo.39.2024.03.29.10.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:24:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 29 Mar 2024 18:24:31 +0100
Subject: [PATCH 1/7] mmc: sdio: store owner from modules with
 sdio_register_driver()
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-module-owner-sdio-v1-1-e4010b11ccaa@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2435;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qIRA9OHgdR8YIBTlq3gIwcNOO+uS8S8xKPRXlpB/umk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBvlXjkx37wyBAQGQOT6sB1E4cO+yYNWsO5eLT
 rZK/pkw8gKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgb5VwAKCRDBN2bmhouD
 12Q+D/4r2bAXL0I+Rva8krUxwDKONjhLy/RAdoomv1G8VLLxgxmRMOfpm1Pkxfo9yTW9xR0MrXU
 F0kxQO2ER7mBPNdakHZtypI3ta0tuqVPymL4CPLM+PlkzV+HQeerwPcrRK47nag4Hp96k1+UihU
 2mXL4J96PzaFw1gUSyVp0R/qXXbnYL5mHdRtQODuH3UKrGles3CpAGCcNNJ0IbRGizylng4Gydd
 P83OjP3n6MPDstQzggysCFJ6SwZ8Xfwx3KGZdIezOx/iHBAKnezGHYRbaM8iRTkVQ+/poTSmkMh
 IKPK3lqz7DlsykQ5m6hW5ON8FKt0wKzepa7yR5dG0z143oWXLzCGrQXLaclD7preMMjprbuyDpn
 pI/bzPvl4IsP9DPOXQZP2Zs26nJghFSH2i/U6awAMDC2p6E/fsf4NVw+OQTVm8lkSStZDzV6/Re
 7mYjBBMVt3wMA4PN7Gc3uidvAQyYOdEDQeS+iUSlpLZ3V8b9QiiU/QGirxRmvpNHc3rr42O2XPR
 zJWsf5wVpTTlEGkl4WojuuesQzHs7Pp5xjl2L+GfiQ1vLypFxr31wnjMmqUTbHfhH0SWKcA+jke
 SaIstusD9D1XQLVDVaUEowVbTM/223LViZ8CIY9saoDAv5BwcQAVxH1XFJA1TkLrg+GybsqZ3X3
 rUDwGILZTCIgEyg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with sdio_register_driver() might
forget to set .owner field.  The field is used by some of other kernel
parts for reference counting (try_module_get()), so it is expected that
drivers will set it.

Solve the problem by moving this task away from the drivers to the core
code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Since many drivers forget to set the .owner, this effectively will fix
them.  Examples of fixed drivers are: ath6kl, b43, btsdio.c, ks7010,
libertas, MediaTek WiFi drivers, Realtek WiFi drivers, rsi, siano,
wilc1000, wl1251 and more.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/mmc/core/sdio_bus.c   | 9 ++++++---
 include/linux/mmc/sdio_func.h | 5 ++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 71d885fbc228..c5fdfe2325f8 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -265,16 +265,19 @@ void sdio_unregister_bus(void)
 }
 
 /**
- *	sdio_register_driver - register a function driver
+ *	__sdio_register_driver - register a function driver
  *	@drv: SDIO function driver
+ *	@owner: owning module/driver
  */
-int sdio_register_driver(struct sdio_driver *drv)
+int __sdio_register_driver(struct sdio_driver *drv, struct module *owner)
 {
 	drv->drv.name = drv->name;
 	drv->drv.bus = &sdio_bus_type;
+	drv->drv.owner = owner;
+
 	return driver_register(&drv->drv);
 }
-EXPORT_SYMBOL_GPL(sdio_register_driver);
+EXPORT_SYMBOL_GPL(__sdio_register_driver);
 
 /**
  *	sdio_unregister_driver - unregister a function driver
diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 478855b8e406..fed1f5f4a8d3 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -106,7 +106,10 @@ struct sdio_driver {
 	.class = (dev_class), \
 	.vendor = SDIO_ANY_ID, .device = SDIO_ANY_ID
 
-extern int sdio_register_driver(struct sdio_driver *);
+/* use a macro to avoid include chaining to get THIS_MODULE */
+#define sdio_register_driver(drv) \
+	__sdio_register_driver(drv, THIS_MODULE)
+extern int __sdio_register_driver(struct sdio_driver *, struct module *);
 extern void sdio_unregister_driver(struct sdio_driver *);
 
 /**

-- 
2.34.1

