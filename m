Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4981E507;
	Sat,  4 Jan 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009008; cv=none; b=lTsYQkab0dbwEMUkiBreSq7Q1yk0n5YzRkk2c/t3bOMlc7eSQCjPFCogLNp7JPW9/v8zNCvyLKSlJc2basVSYtw9gLYaSdNJDFCZBQnQNztFZ7+pbPSIOob54xBUJP4qB4wcLdSIjyj1EKxuBaiR3RlMuVRJcj56xxiVOseT+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009008; c=relaxed/simple;
	bh=JdQDEHdQdZQtsn6BK1z0F0fiP7yQmG3+XFbBkDi0PTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pr1+9OygaWpG1dUi6UNn97xv1Dtj/V6DcX77lSLAvX3fundP1MmkzNQIaYF3X1HzGYs9MHx1Qm0IQZtXrdW3JwJEvUqo16R21M9aQwLLCx0z79cw3Y1Dbepfh6cLWHxmf3Gbqo7Q7+MVa4cMHMe3WO+QV00IwwLCHSc/JJLmvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bThop2Db; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bThop2Db"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso130240225e9.0;
        Sat, 04 Jan 2025 08:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009005; x=1736613805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OeT7GH5ILmC7+ZwAvbXrLYZE10VxTwPPtXsqOi8ctH8=;
        b=bThop2Dbb48VZikvnrBhfUdWruXevRthXXlmzg9azlfPxmQXpD+X6dbnjO8D8ILv1l
         h6ZGk6AZSYb2CoCUXLK+TeIIgWQlTbYHU11wB2+tStQAE90HOVlVpXsFQLG3f83JbFdy
         CUYhc2JEU8uZAXs5ht3ikyXDWLj/lrZG3Mwin59tNq7GeJG0xP0Bt4RrTcnTHtsMJNIM
         Optik/dX0RsqgZIVGnreA1ahqVSKMAG94qPVgO7FbEG3BN/1kDFE1DY51pYA0sbaOUWP
         GOIy0O93Hu5Nk7d8ykRaztFmCvWmeGFwinrMdyLs1WGo3JK69wS5/KSr2VRPObbP3XRC
         B3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009005; x=1736613805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeT7GH5ILmC7+ZwAvbXrLYZE10VxTwPPtXsqOi8ctH8=;
        b=gjAEXGGbrNqTF7fmp9KzpMJo206aBnA+PqfTpUUd3cphEtze+hsfo17RjahYqto31s
         yGASKmBs83/m/Mm+clC5bKfFcdVnr1yGnP6+Ujgd6ZKWrBZXM9FnWImbHvi5MHEJcWFu
         R+9PsjUKvQOY08JJTe2nZJqmXhwjsHbqm4DlFbNBKOutlv65bXucJbwAwWWgXTI8oQhW
         hpnLpwlQyqT1/CjnYwHSawReDcjyXXC+Y5ZmUU+wlLubkBOaHFdSQe2jd9o6bNtWoVZY
         7gcj4NOGhJY/9fwEDup5waqoYipri3oBX9JlBiSKvX3pIEZu0SJNZgmVWvMV4Ph8uYUf
         s9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVJnp4dA67D0AiNJhAHlzVuf5zGtbrrytxemtaF9bu0v803LcYhaLbGvxhGgxQ1EeD9eoKc9EGs+LgFuAt0mx6mIpQ=@vger.kernel.org, AJvYcCVUtUK2k/mQJ0ISRT0VqqXvm75NojTxyAMLWTXq926f7vJWHywIUnr2QC3rhAgvjcteVkvloDkQgXzLf1lv@vger.kernel.org, AJvYcCWYfl5id6SBXpyfwPkmHuxtMhMEVLIXZmNBI/Lu5y3HnUqB2G6lvt13hqGSNise9yq/FeLqlNF7RbDF@vger.kernel.org
X-Gm-Message-State: AOJu0YzpwafkJrrZgMvBwCgHoIGgk0ONF6vLqIETpqxmgIdy3h5OEgso
	6tM0CmwYOn2RNuVQRLvYoUILCOzo2Z8kV3O0PM2NC46xTrGLMT/LBj6jFw==
X-Gm-Gg: ASbGncsCyVKdLhlfPhKMh8M/25xlzgFN6xDjTKEmrzCuJYM5L77JCJaCGtisjWTnNCB
	jACeySbva6Chr4NnrpM5Q04ctN9V8L2ko+vvlibgzVX6PrPWiLt+cCcPnOs7FwR4lFewyeRxDcW
	F/AJiGiHWtemk3WVzM1/EC+xqijFg5xklGsM0rALtfpJc9eskPAK+RyUUbGzT05NBrPmihL7OIR
	V0NVkbm9rJOM5g99z9ZTUFogI20eIUi5kxlQ4wCRoaWCvGwee7fRW6yqAfNBc+ZYiV/tFQ=
X-Google-Smtp-Source: AGHT+IFflzQBanz+qf0JlHxJWMbBsbQVmFQjmWt8PkrghEauNxkIGwkUDzPNrVC0sT0q5/EXW8FMXw==
X-Received: by 2002:a5d:6486:0:b0:38a:4575:5ffd with SMTP id ffacd0b85a97d-38a45756035mr25928426f8f.45.1736009004663;
        Sat, 04 Jan 2025 08:43:24 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:24 -0800 (PST)
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
Subject: [PATCH v2 0/6] arm64: dts: exynos8895: define usi and mmc nodes
Date: Sat,  4 Jan 2025 18:43:15 +0200
Message-ID: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
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

[1]: https://lore.kernel.org/all/20250104162915.332005-1-ivo.ivanov.ivanov1@gmail.com/

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

