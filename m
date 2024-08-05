Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F33BB48;
	Mon,  5 Aug 2024 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849329; cv=none; b=Gz0+8JomoMybdWYJoY789iwjfXKE6bqt9THTCmAm53tiCVmg/hMXg755xhHHzVLbbsfo+bC8auK48T6Ev4YPuCsgitvfPLJGKrVIWlXiSBplfm18lRkx9r1kz41E965XMb1+gVIEjKzxUhwKgSA8FRSpCbfMfXeDEYLwurzgVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849329; c=relaxed/simple;
	bh=q3WBhJXNnWW89LoRGboHkm88GaFomhoK+0qXcAOXq0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q8K/uZZrlrz8fX8NelQqsfMkoeEkIU5PeMa0dQF0Uz6LA0H7IWePCAIfl6qSsQzuuNtfhwVPOQPAWK0zOWG/HuqgKLVBvLRs8P3N7nnBNvvLo1IaIQdn30wNHDjB07kSlti8+aDHGdc8NQaRrOruWv6lmjDIM54e6f6AFuEMsps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFZ++Xdw; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFZ++Xdw"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7093abb12edso7678507a34.3;
        Mon, 05 Aug 2024 02:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722849327; x=1723454127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3+rIztQE6WRU9ZBeY+g9kfmjd9A7zQwu+i8aRi8HSU=;
        b=cFZ++Xdw6LEz/7keAGkvpv7uhX8g8PgMB7Xo92KVYDcn/Bpbse6UHCwCdlGVpE6R09
         hH6tKKTfoPT7s9jpBDu6LdOS90duOKvcYzz6YSZ6S2X5ZUBhEAVOjcowvHSvZt15U+3t
         OdFJlfFQYJiPzzgNfkg49B1W+yivOZOmaE6MeGK7CG0I1HKcWbORWSJgB8FCdERHMSXc
         tgCuXUnLq6lvjtuu5bQ1+CtMFooEkMOml4NHc+mskLOANuRPd1j0exhaMxPq9IEKT+o+
         n6x4uWmXXA+4SxywFMHYvxD789XA4v025p50pHlfx949LYkpx9tnSt2Gt84CJYz1lJ0B
         S7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849327; x=1723454127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3+rIztQE6WRU9ZBeY+g9kfmjd9A7zQwu+i8aRi8HSU=;
        b=S8Xsq8j2OdLIarAHMFH1Mmyy21AKUmh4qM2qPzQU+nSmIHIQJEzA63fGf5SD2OuK2/
         RIJpQf9znsESOOkvbVRVh2U5XNTZ2boPSZ1cgMrRJhohue/nRSCfR2sSJuC8G+I6MVsA
         rMCDNxB/s7a0z/nxChKrfHpWGM9eNFhlX06/7/igT10fWnhzrqOUDX6PJflKIexEmfQg
         kj9lzCn9c/TT2R8lwy9zfAt3zFDoxztG3LOmGi0x28LKOjIprUBeeNYI9pBTdesiwMq9
         PePRwJFR1p5Djrs4kfQeOXE1pELyTcns+XaL435qRD3zkdbi9pjULhjXpBKirIWo1BZW
         R95A==
X-Forwarded-Encrypted: i=1; AJvYcCX68XMKXKaxk/ITjxcQrG1ILltBoTwe9Y4+IYu02w9CFJPHV3NSnEgaCothWjC08aVmbDKYeTZdDBAeWk/Fqa+8uW3ibjSS7jyXdwczBDnmjnkhuA4+DI80w6QQBsh/G7naZ6CTqyAt3Jdw5aIDmnxuuWI4mExCfAC7d2UXzx0MuzJW/Q==
X-Gm-Message-State: AOJu0YwJCnux6N7bRJGpv0v0vDLbxOy0+44eLNwApZ6+hu+W4ErnVqZZ
	XiLl58LNlCVcNiF9VgFP+N8APUAsMk6xz3keLcS3QTSgr01tpYzj
X-Google-Smtp-Source: AGHT+IEhCrVhi6RjKsMaNG35hoJ2syJpEEnWGuaWja14l87nxPCwfBClsO+7Fw8Kz2q8MRArLRT/mw==
X-Received: by 2002:a05:6830:3509:b0:70a:9876:b76b with SMTP id 46e09a7af769-70a9876b930mr11856521a34.2.1722849327046;
        Mon, 05 Aug 2024 02:15:27 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70a3a76ef7fsm2899595a34.74.2024.08.05.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:15:26 -0700 (PDT)
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
Subject: [PATCH v6 0/8] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
Date: Mon,  5 Aug 2024 17:15:18 +0800
Message-Id: <cover.1722847198.git.unicorn_wang@outlook.com>
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

---

Changes in v6:

  The patch series is based on latest 'next' branch of [mmc-git].

  - Some minor improvements based on Adrian's review suggestions.
  - Added Reviewed-by and Tested-by signatures from Conor/Drew/Inochi.

Changes in v5:

  The patch series is based on latest 'next' branch of [mmc-git]. You can simply
  review or test the patches at the link [5].

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
Link: https://lore.kernel.org/linux-mmc/cover.1721377374.git.unicorn_wang@outlook.com/ [5]

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
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 451 ++++++++++++------
 4 files changed, 383 insertions(+), 173 deletions(-)


base-commit: 538076ce6b8dfe5e8e8d9d250298030f165d8457
-- 
2.34.1

