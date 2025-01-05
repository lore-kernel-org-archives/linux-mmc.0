Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50C1292CE;
	Sun,  5 Jan 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736093631; cv=none; b=g6OVbNyigB128MQlZvSJX7zlFP0wS7SvculEKurWoavlMgiDp6s6+JtFeGhOg5OaLC6fX52DdX+I6AkiyJLilFkxROtS1g2nLUf5yvqMf8wgvzzQAkonspP8g24FIwUQk13EQrHeG7uLFpvKG1AHfkAPhMk6DADay856Ltd/1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736093631; c=relaxed/simple;
	bh=ir7eCNa0pUFT0PWxNzIJEnp2AeMywMR3paXMTK+TSbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9KyOFf/HW83oXWmOfCQ/DN4PI9qd//XQ8SlZKjdviaZkH3i4mkHi6dWxC03KbJUpWD+uQsUHYDNjbVG3g2r8bnPI9xKFjI1CE1ugD6RWD74ohiYSuqHw9zmEjd04w5eENjqlaByAZ6oP5joyAbxLhzCk5RyhggsrS7cxfBiay8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhOnwqZQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhOnwqZQ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso90214145e9.0;
        Sun, 05 Jan 2025 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736093628; x=1736698428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lchnjuFpSdhQx9L/rOYviPRo396F7o6vIvEXCybU6U=;
        b=VhOnwqZQIIg/AG0yRBqtisdY4jUD3n4j+COJVMx2qHLETbBR9jG3FUBWp7noOfP/Fi
         d2HZwLYtiGpqZOnOpa055og6ZeA37pVHYaVCIgeDyQRu54CA+We5o2puCgImlXrV9QBp
         GPuCMHe7KMpCKBOKWpecLOFiYA3PMHT18nfrghX68DxgZ5/TEBoAGqqHLDQ02koW0/Ts
         F3+d7vaV9K5Rlie20qlMaWrXI73Hn5HnMbR3rjk8zcD47xD/4/xElgl1GtrPEGqA0Hpb
         rTAvaZiTMlDrkEo6VPfnf6PpTxQOvQFIuP2dSTbmWFktnVjNPyhXp+/MtBMpxy8ol+5n
         GTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736093628; x=1736698428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lchnjuFpSdhQx9L/rOYviPRo396F7o6vIvEXCybU6U=;
        b=GLi2gtOTd5ea7UjzCxk3J8t9SL10IzFpyd7ofbZ/nB09WLwdJuJXLV39iQ187gJnLI
         UIG3vlJbnqf3mJNVs5z8Eby7StW2mCD1Jit9TP5L5QEPHdjWkan7v0aFVBSWAlWhxFqa
         1XO828sAYY/CS+tzzsG1MjyjmxsZUz5Nmi5BhvujA9UE2jaULQm5XzZkbmgVOnDFLBLk
         l/u/ZR0kpcBRCT6w7QFDB7d0VLElefZSvy53hCt005aOR22FB80X3NlARc1V1cmvxoz1
         UvRA+mpj7SOTS9PyqZpEJiro/CPyiCFLtNjc0/Aifzlrl0yjAGx/7cQ3rjVZyOSup4W4
         Od5g==
X-Forwarded-Encrypted: i=1; AJvYcCUHlXl2JaxZLw9AEkLNMvpDx+TF5bJzlFnUpVdfdUmfgHOMw5lGp0mOQvG+uc2iFc8Qlr8IiEJ8cPJDk1QL@vger.kernel.org, AJvYcCWT42XxZv+7uyINjY4O5Uk08OkjJGrCv1WTV7k4bJUIWx+4N4PtY+yP78uNIFKePlFWGyWJ7YE6ykQCc4aiq1MempE=@vger.kernel.org, AJvYcCXYbDqlnbNb3GhkeYvibkXMDLD62bOUT+GjWTZMD/ypZYNpgdpWYMrqfGbFmf3bFkHA7td/4qPWHvq4@vger.kernel.org
X-Gm-Message-State: AOJu0YzSdfIBmxqjTPC/YlbmR/pPAFB5v3rj7KLb6f7fv4mNaKvp6Pl0
	m33a6DJG5Qvnfl0QoOsu/erp2dIf4ELDVrLBtW4WOXG6JUiCUVYI
X-Gm-Gg: ASbGncsH5i8gfAdwqy5z2oCX0CANigAyg2QfowLcH9mRMyg1HMlgO0adkU20FRNRQuW
	PVazXSQUE/koMPrRknv90qXCGtA4JERkyWK2RH4mxJ1deGf8oKKmNk1M6uBkYi4sWy3Xqhd5Weq
	+NdbTzoZx5DjdjvqcAtjAYDu3nBT3mTll/iI23sb8Y9C7GMBs0UbJOawKt0GRcR1P9NLmETQQoh
	HgouObdpCeEhbX2rnmzAzazLxS+cSQJ6ggVQeLyk2yMAvmEjbrIyhd7UvcCIcD8GnPFL7Y=
X-Google-Smtp-Source: AGHT+IGw2sZkN+3zUikmgjWtTwI/TC0FpreoFdTU9b17v9+gno+YL3QK9BsYjEcviI4Uu8upAU04EA==
X-Received: by 2002:a05:600c:68d7:b0:434:f270:a513 with SMTP id 5b1f17b1804b1-4366d357401mr442740625e9.29.1736093628312;
        Sun, 05 Jan 2025 08:13:48 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4274csm578250565e9.38.2025.01.05.08.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jan 2025 08:13:47 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] arm64: dts: exynos8895: define usi and mmc nodes
Date: Sun,  5 Jan 2025 18:13:38 +0200
Message-ID: <20250105161344.420749-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patch series adds the required syscons for controlling USI, as well
as defines all USIv1 nodes for Exynos8895 and adds support for utilizing
the external SD card storage in dreamlte as well as touchscreen. Due to
PMIC not being supported yet, we'll assume that the regulators are
pre-enabled by the previous bootloader for vqmmc, ts_vdd/avdd
(in our case uniLoader).

The patchset relies on [1]. I also expect the exynos mmc binding
maintainer to pick the specific-compat patch.

Best regards,
Ivaylo

[1]: https://lore.kernel.org/all/20250105160346.418829-1-ivo.ivanov.ivanov1@gmail.com/

Changes since v3:
  - change USI_V2 constant to USI_MODE in the touchscreen support patch
 
Changes since v2:
  - add r-b from Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  - drop hsi2c_pclk clock-name where it was left accidentally
  - utilize _I_PCLK instead of _I_SCLK_USI for all usi hsi2c nodes
  - move assigned-clocks properties to dtsi
  - set mmc's clock-frequency to 800mhz as per vendor's dt
  - add a pinctrl node describing cd-gpios
  - drop the fixed gpio regulator
  - add a new patch to the series for enabling s6sy761

Ivaylo Ivanov (6):
  dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for
    exynos8895
  arm64: dts: exynos8895: add syscon nodes for peric0/1 and fsys0/1
  arm64: dts: exynos8895: define all usi nodes
  arm64: dts: exynos8895: add a node for mmc
  arm64: dts: exynos: exynos8895-dreamlte: enable support for microSD
    storage
  arm64: dts: exynos: exynos8895-dreamlte: enable support for the
    touchscreen

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   1 +
 .../boot/dts/exynos/exynos8895-dreamlte.dts   |  72 ++
 arch/arm64/boot/dts/exynos/exynos8895.dtsi    | 908 ++++++++++++++++++
 3 files changed, 981 insertions(+)

-- 
2.43.0

