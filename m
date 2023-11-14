Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46B2FC29
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FK3zKbze"
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA6CD
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:08:12 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cbd2cf3bbso1845061cf.0
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699996091; x=1700600891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=FK3zKbzeIgWzX5lIdVaswmcv9aog4JXRljUPXuE7vVQtBnBMiZ72urNNOh/bsBxSTU
         Qbi1HOVa1ZXdObkN/jKDcoNiSMqkYdJ2jpp0EQKSAgpg7dm4wI7d9Co++2fhqJA82fhU
         ZVpFjrsHtg2u4v2RM3fmxiTxBFpTwkRSUR/H8Tf6Gme8Sv51C9DAU7be01n40QkNTkYQ
         lmEfri2jiuHT9OEoCGxU6R9QvsKFKcG3Zu9iKRGijKMEl87ZLR+Tal0Sy6vqOuzOGO9q
         a9naKT9v0nMCjr8rnuz1c/KPNadqRArztbOLkpZsOdX/m1n+fxE20bX+NN89ffdoKkmD
         A1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996091; x=1700600891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY9e61NSBd34WKgwLiextVdIl1pEHWCBao7kYEHaYbc=;
        b=Cs5m12nAtPTHwSb4Ju7OWi6+VTpxMaLqI+/hKWoEkfCHIm9z8+f51JtNJJH2Ne1BhH
         JH7x+65meqW8VV+yDzQrKHTQXszoIpRbhT5X2YHxEMky5brsi/4AntyvAKzYvXXKIePf
         Q0tDlFyWvzzaSOiwFssUKFCvHZ03ptP2gNNI2ZJb/IQfdQNeBuUWX8+chNGN+ia++yRf
         YS1Jw/dacrSHJu9OxoeFTdF+0qqo8wCTykHd/D2xNG9F80Y34Bf85hlUOS1n+aTBkz6v
         oMGdGtowjYGelG32hZDyBd7PBlb6qQZscFn3OSks9opyX8/az8zJPMGJstCaWXpkmYHO
         1Tvw==
X-Gm-Message-State: AOJu0YyicQdHkjI3Al3tipne6m+fWH1CIsi2MCcN1w6IX4jAkmpTkWSb
	GXNSH+Y54zBV5RXdON5xFjV9ajJkbb1DqLrRzKs7WQ==
X-Google-Smtp-Source: AGHT+IFJvqoQROwwnZlNFrPWPbi+KrCcUZmD+wBQHJolGGJaCfaUKesmouXXRiY5zwFysxdAbpnclA==
X-Received: by 2002:a05:622a:18a9:b0:403:a662:a3c1 with SMTP id v41-20020a05622a18a900b00403a662a3c1mr6177219qtc.29.1699996091186;
        Tue, 14 Nov 2023 13:08:11 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id x16-20020ac85390000000b004198d026be6sm3027549qtp.35.2023.11.14.13.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:08:10 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Date: Tue, 14 Nov 2023 16:07:58 -0500
Subject: [PATCH v6 4/7] riscv: defconfig: Enable mmc and dma drivers for
 T-Head TH1520
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-th1520-mmc-v6-4-3273c661a571@baylibre.com>
References: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
In-Reply-To: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699996085; l=915;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=ht5Rt9iMCRM1t5yThjxoCTbuOVz3OXmRTAYLzzfd3/s=;
 b=JTamoh/lCi7AMcxyCl7HeTkxkkYYuIc66GCiiSy4UUWu0BsgiDMdM/Ez/NrXpxAMeY8exyl1a
 Ey4mBBQRxwqBZTsGmBhcVQPqjRvWp7v4rtzBvBsm7SyVjBWPZDXMJS3
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

Enable the mmc controller driver and dma controller driver needed for
T-Head TH1520 based boards, like the LicheePi 4A and BeagleV-Ahead, to
boot from eMMC storage.

Reviewed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index ab86ec3b9eab..c5a8583236d0 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -168,12 +168,14 @@ CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_DMADEVICES=y
 CONFIG_DMA_SUN6I=m
+CONFIG_DW_AXI_DMAC=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y

-- 
2.34.1

