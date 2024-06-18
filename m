Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8D1AD9E8;
	Tue, 18 Jun 2024 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718699857; cv=none; b=rpwp3t3834NrJy25zcjo4eOqI41dy8GCeicd6h+gyDTtJZnfYRBeH/4LO60PMQyrFzGciQTBM2Lx17l3zzXHUogQaVCzjIO4yLSet+slBirFtm0vFTITr3LqEfGGhzfZyPeh52GRZePVa11Ligqs8RpXd9KYMjV4koo9t0JRbag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718699857; c=relaxed/simple;
	bh=ofhnaPVNg2qs87WnUKL3NVwbpwdHWn2ssq1pcOARm/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Oegu+14pJRJUHqQwrHGqay11zcozZW3AwGOdEjcYQIrIFND2PimYv6Hr82I3t0ttGvt+rpcOnb1gPYqorOjx4Ut9IjajjWCoRYSE1WDvmXq+yzujajjwKG9h4P4X/3IkNZDuNFZTT0D0MS0e/eZLxzvf+QshcO8JVa+whhZveHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWAUSi5T; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWAUSi5T"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254871388d3so2675903fac.1;
        Tue, 18 Jun 2024 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718699855; x=1719304655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFsReauRW7BnbGOq0QDl+qJ280PvXf5SBObURVpdknI=;
        b=WWAUSi5TuJ6EzUwt37PfkTqG4MhbrwpqMkxw/xt+B3iV2V7Nu0IIPzk844PdYStLuc
         0otkoraoCOz0e2Wd1K6LiQhzEVpXxRRPlInjfOKO5egrXf3OG/WZ6y4ZSH89FvxYiAh6
         YY5KV2jZr9SHX/LN0gl+aJpKsy4dKTyv1mbzBqz+w0TL15avupUndF02TXphPhTb8G1P
         6N5f8piVf59abf6sh0r7pDSzVnE878cRNdp9ntD6/Wze0TmkO7rCVCW3L9/DqVjlxCUa
         YIbZ+hMpE2cVHHISc2JNrtL4GaKBgAbmVAEqRPbWQWyUnPdEwzC3ptvBWQICCt7uohfD
         5uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718699855; x=1719304655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFsReauRW7BnbGOq0QDl+qJ280PvXf5SBObURVpdknI=;
        b=vFxjnFxt3yrsSoci+J0PnXu7VK4ME5EbzDWG9wSELcdml4KfxX1zmQi8L/fMSGRqdG
         7MOux4Oe4eFo5pbiOU330Erxa+XAlEBn+9uKXbq9NCS8AR67upf2XgvYiuK2EkeJGe8G
         z4G23tv036hm6gRfXB1Y9LfRsVsLyzwZAZr29oLEifBRtt+73gRnu+6UAXDyiZhhLSbp
         nr4azSKTk0HjLMkm9htM88sIF2wktR8WnrvdC3SvZQuAhGKqHVn7BLKZWgaF1AUsqjss
         vhfyolj6/O8Cttfvo3nySUE4U7Yx1bpnhiLLYLPZIlNFJh+O8UsSvgA9lgBNO0rdOMSu
         u+fA==
X-Forwarded-Encrypted: i=1; AJvYcCWnb59smSYiNFgjp6VnGm0aklBGwqwPDP3RGRgr5VpDkCF/XrKRTEBpsWXX6BEYzV34VR9JIHx2DCNG9Y2xWRFkebvBmHlB4i3I5M75p7+A8t2OWoiBQvxQRUKN0FbI4KPjjkuxCxXMzhUoWQZuwZU7K2yPeDt5H+Xc4eqCM80xVfUY0A==
X-Gm-Message-State: AOJu0YwnfUR3rPdsFEOC94wfreZEFc4U7r8O8SJ5hGczP9cxr1TFW7Lu
	XQg5eazUgsnRe2fOcFcEFyWOTDSg3i+F85KnpXqYwvNQ7z4XJ4PN
X-Google-Smtp-Source: AGHT+IGnRWRr2o+oA3EM/VynZOBdxxp9ijkn0OKBKLyHSsXT40cOAd4QJXajBgNbKMlE+nu9v5KLMw==
X-Received: by 2002:a05:6870:c095:b0:254:7cd4:9092 with SMTP id 586e51a60fabf-258428eb176mr11682004fac.20.1718699854751;
        Tue, 18 Jun 2024 01:37:34 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-256993a0d23sm3052169fac.58.2024.06.18.01.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:37:24 -0700 (PDT)
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
Subject: [PATCH v4 0/4] mmc: sdhci-of-dwcmshc: Add Sophgo SG2042 support
Date: Tue, 18 Jun 2024 16:37:08 +0800
Message-Id: <cover.1718697954.git.unicorn_wang@outlook.com>
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
for the new soc. Patch 1 "mmc: sdhci-of-dwcmshc: add callback functions
for dwcmshc" is for this.

Patch 2 ~ 3 are adding support for the mmc controller for Sophgo SG2042.
Adding corresponding new compatible strings, and implement
custom callbacks for SG2042 based on new framework.

Patch 4 is the change for DTS.

By the way, although I believe this patch only optimizes the framework
of the code and does not change the specific logic, simple verification
is certainly better. Since I don't have rk35xx/th1520 related hardware,
it would be greatly appreciated if someone could help verify it.
Note, the DTS change has dependency on clock changes for SG2042, which
has not been merged in master/upstream, so if you want to test this
new sdhci-of-dwcmshc driver for other hardware except SG2042, don't
pick patch 4.

---

Changes in v4:

  The patch series is based on latest 'next' branch of [mmc-git].

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

---

Chen Wang (4):
  mmc: sdhci-of-dwcmshc: add callback functions for dwcmshc
  dt-bindings: mmc: sdhci-of-dwcmhsc: Add Sophgo SG2042 support
  mmc: sdhci-of-dwcmshc: Add support for Sophgo SG2042
  riscv: dts: add mmc controllers for Sophgo SG2042 SoC

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  69 ++-
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  17 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  32 ++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 499 ++++++++++++------
 4 files changed, 447 insertions(+), 170 deletions(-)


base-commit: d6cd1206ffaaa890e81f5d1134856d9edd406ec6
-- 
2.25.1

