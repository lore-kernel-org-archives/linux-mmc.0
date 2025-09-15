Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C902EFDBA
	for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925225; cv=none; b=RmOT0x2L9W8W+kN6ep9p1F/sDAU/ATNxKVtYFqBHfhCikEtvCx8lOkSctxdyYf+mc/Z8e5/LPnfgXGSqbbak+ytG0x0tjoqjccv2j3m+f0tMzzpNlBCTxf6wvyjW+68VE8U4BOcd2CGu4VD0J5aAtd8bMhCB2hhSZuDudvErw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925225; c=relaxed/simple;
	bh=4xBLRpCawgXwmwp45+4Vn/1qIcsXuj61DVBKu4ZeQ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2QcDq8+i3nC7Uz11f17Yl1p7hYeZhZvjh0EN+Zagcbvu83qYUkjD7ZvCJULh9yRKnMUXCJXMyCPiCtrXtXam9fbR0vCuOfMCJlQch6O4xH2xXlTMgQKFiu+t4Xvwb7jJBaWLQvFizHrIbmX1Vj/+VE8oNkYY/QNDRUIqjMqf4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBBtXSb9; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBBtXSb9"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55f7a34fb35so3645946e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Sep 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757925222; x=1758530022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SAepVheBc2VKd/HWr2jgYD1wCXMnZhybbLdY99EVCQ=;
        b=IBBtXSb9riBau9tCF6vXm9UYSx0llGxx57O4t25tImszLyVghMiUun2ITYBAOGdySb
         5O62DZoV3Rotw2uM6VC4sECxHOI6GMBf1Kmda0lX7Ju5BUoKUGaBAIdTG+yWCIFWBwMY
         DSSOGxZTC7Klz0e129w7+/8pq2F2brCj2E69fUhr4YQ+2akk97Z4QjYO06+ju0IrxIHR
         yKza8Jh7GMmmNhuzc8iGRevtmdMW8dqV5X2HxgfVxNdBgSX2h47TnfoXOu6KIZOuVTlB
         JZcoLXT3zNqiW3SbbKR9T83wnd3scwK4C+KmBBhZBWRz4m6Gck84WWUBsRBF1o4n+EMb
         GSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925222; x=1758530022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9SAepVheBc2VKd/HWr2jgYD1wCXMnZhybbLdY99EVCQ=;
        b=hOyMoecG0+s0cByoLK3U4s4b7nd7YENhB8rj5QMo9CFf8itgCWttPNTLN0PBwQn9ke
         VeNK4VisDbWUOtM8nEb22vvXG4wdGKStMaDsgOY54tluqHxhX/QaQUESx64Tfa2J1DI3
         DzWyqoaWrV6P4Yt0rN2UARpmaWxzcZXAkkP4msX5rExPwFSwSDIK2776OE0IBPurQGJd
         Q2ihunD57qOi5HvgLmLIgEyfI/XHbFtxNWCRpRw3CTeEuKo1wuvMJEfXGn1zPWmEIMOM
         VDacNagoU9/SKuyXfI3l+1zT3ZVJ1aZTVWDtcP7SNW3ohm+KyqOf3N+fF1eLyUWDaS+s
         iyww==
X-Forwarded-Encrypted: i=1; AJvYcCXhRReC8O9nymXHleqyHcK7M+LK9OWVqqm0r9lWCHehWP1PEyCo4T/jGIE9OmcipvyUFYWM/HWHtyM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9Gdh/EM1tgKyxNBWn4q/81EAAHOrr/wF04ZBq198aoF45JHl
	jVoMb6U7OeUimLv9aJzR6AKPoEhZj0e6l1tn/mr0FDzVTq3c8R5/Jzi0WmpfOd+RiV0=
X-Gm-Gg: ASbGncv1uw8CnWAuqaQK607tIorc+gXLgZbj+E4/IIU8gQTvI6WUy5kDPLD/vY65QeK
	SIgyrFLm5fXI0IKx20Hi8Wh2q2VznFlhNqB1SOowGwMm50LGb/jMVKv8mjkwc6c+NXLalbY5Bjm
	xgHYl4rT4M0FoIrNGyCHlyU0qEKoAduy20JTYZTYIccItZXqRYkVNkZjCJ8uW5QMzNVy2bvb7R8
	8uLS9R4Tkix5zbrdczdchzBRUZ6Y0kvaUFtpnbupWQL69gRMBVLgfGieC517xqTPAotM47pSd3K
	wbiUi/3GxHMVTKr+5kJVV9Ul55O3JiUpFOz06rK12ERq/XwjsXObfrjY+1+CQQNvwe6dlOzegOb
	8Y7WMSujsUEzCVOyM70Ckd18071HZw3bqmcQBF3zNlM/lBVNx18oP4DE=
X-Google-Smtp-Source: AGHT+IFijRhuu9NRr2ZBM2GuQ4gfxZbDSURIOqckSOM/gNBlLBKx7V4oU2eD/51Fe4veRTnL+2Myuw==
X-Received: by 2002:a05:6512:4024:b0:55f:3d7c:3880 with SMTP id 2adb3069b0e04-57050fe1dd2mr3397083e87.48.1757925221761;
        Mon, 15 Sep 2025 01:33:41 -0700 (PDT)
Received: from nuoska (87-100-249-247.bb.dnainternet.fi. [87.100.249.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a6a33ba8sm2335142e87.46.2025.09.15.01.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:33:41 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 3/4] mmc: select REGMAP_MMIO with MMC_LOONGSON2
Date: Mon, 15 Sep 2025 11:33:16 +0300
Message-ID: <20250915083317.2885761-4-mikko.rapeli@linaro.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

COMPILE_TEST with MMC_LOONGSON2 failed to link due to
undeclared dependency:

ERROR: modpost: "__devm_regmap_init_mmio_clk"
[drivers/mmc/host/loongson2-mmc.ko] undefined!

Fixes: 2115772014bd ("mmc: loongson2: Add Loongson-2K SD/SDIO controller driver")

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index b14daa045eff9..394724dcee8f8 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1116,6 +1116,7 @@ config MMC_LOONGSON2
 	tristate "Loongson-2K SD/SDIO/eMMC Host Interface support"
 	depends on LOONGARCH || COMPILE_TEST
 	depends on HAS_DMA
+	select REGMAP_MMIO
 	help
 	  This selects support for the SD/SDIO/eMMC Host Controller on
 	  Loongson-2K series CPUs.
-- 
2.34.1

