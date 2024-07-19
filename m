Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489F957CBA;
	Fri, 19 Jul 2024 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378688; cv=none; b=h80ac5EFtQwyJSUUKM3BqEpC2NVq+cGgA9/YQdhn9UsEDP+xQCzn1h4cDUPNGcbBkBfTkf/t/Fb+YqmCB8zLYNgT5vvAE3i2fy7rZfR8xP9S6PGLinPNQch5G97GpYpjNaL91131xg6QvsbHVR80HEAG3wAiAVDVY0mBL7fE8Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378688; c=relaxed/simple;
	bh=PpFsMykj2rMA155uFBm0+rZUiyDQ+1ebRKvd+Xi1cVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZSQQnhWB7oIABhKGlBn0yNRtM3VPg1Qn3s5Sro63hOi1ZSoDtl6SeWjlkDjxtX0aV53hCDS21eDL35MB8kcHC2Ze85J40qWr2M2ceyM8JcWDw12KUCf4KrLjABnzIfHhvxmF4ly9VaAZte8nk+ciGufZ6imthx2BJYhbYRoT4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i37XtB3P; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i37XtB3P"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d4fb707895so964941eaf.0;
        Fri, 19 Jul 2024 01:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721378686; x=1721983486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qqWzTgIPyPc3kjOh738BaLUwdtHiWUrZxYzCR8XzUmI=;
        b=i37XtB3PM2fy9ICULge1nIemNDVNjoIVIb8FCZ+GORsCIW6A89lg9g1EEMkGalomHM
         HMI+Py4FOlxlULWTwEVTJ5egqUCQMKlZQTwloWUlw3SP1EM5d+Tr+p6s9HKEpA6wA4Zq
         fES+PZP/YwRpQvMZWbwnb2Kt66pdo4H2NV9otOuVxajEn0PXyRAOa2KQmoRIP6dQfYPC
         iP8brDoLiwtZOqjLROjyRs46Ne9amJYYn8uuSoftNSNDPHGOJ7BJeLhue8zGyTrt5wlc
         0BlWWikZI/CSoZXBs119tKxcy55/Spau9EGC62QlfkokCgYT/J9PHfBQyUFyJfUGgoRA
         x4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721378686; x=1721983486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qqWzTgIPyPc3kjOh738BaLUwdtHiWUrZxYzCR8XzUmI=;
        b=FlpqFsnNeSyhrFJfMR6jxL8pdyyuI7kzeQRUdIjIATurUJPOIklpjVNN8+cL6grh0T
         WONXvUzm1lhnbD9fP38OZksRBw8fJJcqyv2mYWkT1ftw0vphduTmwFb+K9lx+PPlNBHo
         dHIhvFJkwy/x0nmqVJAIYD1X6JfF5q3vdfxL3PeDYt6k7XdijANwaw/aac7sW/z9Bnkq
         CuCVjUaajKKkF9jSqKelBKldQ/jBT2quiNBpzBCLWRgkkEF37yzxYFnhCv8Fqw5U4lgj
         rOGGUgP28X/s9MQpZn454ypQm8SYru0w7nNUICoCgyWOzVSWD7FI5NN9S9I86DsBJat1
         7Z4A==
X-Forwarded-Encrypted: i=1; AJvYcCWWSSJHqAZNP3U3zVEEQqyN3RwxJ5a7wKQxGSTD4LR3Jj/9ZvCQflkOIuJ0nESPln3Zm2VuvHJkLRO/IKBwbLRytqCO/s+XJj3wp7YYLgaL4XF9kSocVb/z5xnh++sVbM9LT17qpfiRjsquLqCZpI/rJwasAG+KiOCsZQr3WZ++LwhkvQ==
X-Gm-Message-State: AOJu0Yw8ZUn41GUPv+8zWCvwoO/qVpvx3/wIRaMNLVQjfacyUfKHQrdY
	GRr2gi5GurruqV7GTW/alpA0IT08ZZ1MvqJO84cdKeHX5HLokPJV
X-Google-Smtp-Source: AGHT+IGU3zGdzTzo6n56ZVu275VrbT2ZJepaZOccFd487bTwWFRutlJaZP+B20zx67pngOdZbMRwmQ==
X-Received: by 2002:a05:6820:1a0d:b0:5c6:9293:ed9d with SMTP id 006d021491bc7-5d41bf30324mr9004479eaf.4.1721378686237;
        Fri, 19 Jul 2024 01:44:46 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d55a7fa3b1sm171808eaf.7.2024.07.19.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:44:45 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: adrian.hunter@intel.com,
	aou@eecs.berkeley.edu,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	tingzhu.wang@sophgo.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v5 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
Date: Fri, 19 Jul 2024 16:44:38 +0800
Message-Id: <cover.1721377374.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

This patchset is composed of two parts:
- one is the improvement of the sdhci-of-dwcmshc framework,
- the other is the support for sg2042 based on the improvement of the
  framework.
The reason for merging the two parts into one patchset is mainly to
facilitate review, especially to facilitate viewing why we need to
improve the framework and what benefits it will bring to us.

When I tried to add a new soc(SG2042) to sdhci-of-dwcmshc, I found
that the existing driver code could be optimized to facilitate expansion
for the new soc. Patch 1 ~ Patch 5 is for this.

Patch 6 ~ 7 are adding support for the mmc controller for Sophgo SG2042.
Adding corresponding new compatible strings, and implement
custom callbacks for SG2042 based on new framework.

Patch 8 is the change for DTS.

By the way, although I believe this patch only optimizes the framework
of the code and does not change the specific logic, simple verification
is certainly better. Since I don't have rk35xx/th1520 related hardware,
it would be greatly appreciated if someone could help verify it.
Note, the DTS change has dependency on clock changes for SG2042, which
has not been merged in master/upstream, so if you want to test this
new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
pick patch 8.

Clocks changes for SG2042 are expected to be in 6.11-rc1 soon, I will
do catch up with that when it is relased and provide a new revision,
but anyway please feel free review this version and welcome your comments.

---

Changes in v5:

  The patch series is based on latest 'next' branch of [mmc-git].

  - Based on Adrian's suggestion, split the first part of the patch into 5.
  - Updated bindings and DTS as per suggestion from Krzysztof, Jisheng and Conor.

Changes in v4:

  The patch series is based on latest 'next' branch of [mmc-git]. You can simply
  review or test the patches at the link [4].

  Improved the dirvier code as per comments from Adrian Hunter, drop moving
  position and renaming for some helper functions.

  Put the sg2042 support as part of this series, improve the bindings and code
  as per comments from last review.

Changes in v3:
  
  The patch series is based on latest 'next' branch of [mmc-git]. You can simply
  review or test the patches at the link [3].

  Improved the dirvier code as per comments from Adrian Hunter.
  Define new structure for dwcmshc platform data/ops. In addition, I organized
  the code and classified the helper functions.

  Since the file changes were relatively large (though the functional logic did
  not change much), I split the original patch into four for the convenience of
  review.

Changes in v2:

  Rebased on latest 'next' branch of [mmc-git]. You can simply review or test the
  patches at the link [2].

Changes in v1:

  The patch series is based on v6.9-rc1. You can simply review or test the
  patches at the link [1].

Link: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git [mmc-git]
Link: https://lore.kernel.org/linux-mmc/cover.1713257181.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-mmc/cover.1714270290.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-mmc/cover.1718241495.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-mmc/cover.1718697954.git.unicorn_wang@outlook.com/ [4]

---

Chen Wang (8):
  mmc: sdhci-of-dwcmshc: add common bulk optional clocks support
  mmc: sdhci-of-dwcmshc: move two rk35xx functions
  mmc: sdhci-of-dwcmshc: factor out code for th1520_init()
  mmc: sdhci-of-dwcmshc: factor out code into dwcmshc_rk35xx_init
  mmc: sdhci-of-dwcmshc: add dwcmshc_pltfm_data
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
  mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
  riscv: sophgo: dts: add mmc controllers for SG2042 SoC

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  60 ++-
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  17 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  28 ++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 459 ++++++++++++------
 4 files changed, 391 insertions(+), 173 deletions(-)


base-commit: b85e021853976aaebd3788e7e721020570754199
-- 
2.34.1

