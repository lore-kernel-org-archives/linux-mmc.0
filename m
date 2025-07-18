Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825C1DED49
	for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839256; cv=none; b=NmhG+zcgbT5X9FUlDJFJyrKPUFhjMLDYe9rGBB8FUihj3PUXUngm+A7C8/M9drXJL62I86CQirkhMNBkDsF5h9fpJX5DRjs9tIF5nNhIbkC4BLllhPf5VSiSXgK7L2kBWVL2hQmhuQv44jmlFiCGJcf9NDPwaC2I0S8Pwiae+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839256; c=relaxed/simple;
	bh=vjfrfVcxNqKDhGCUPlAt5rybcyfcyYZ3YCHSqwTE02w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ1t3LOckG9VUNo2+8kwCGre2p1VHLnzAsV11jA4Odifm9Qt1u1XSowQUCrmUDUYWQd6vePYw4kHIYh3PYLb3joHAk80A0P6MzgHkD7/eYZA9ozPZb2yy4wz7n1YWvu3cublcCk1b0LNi+CV0vCiTrJQMBF2jSu8wZ1ppPOKOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PRhonWcz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRhonWcz"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-558facbc19cso1737410e87.3
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752839253; x=1753444053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+w1tv+6ZrnZaqoFk2pt6S8MAUlFF/qNsTMF9yI+xEJ4=;
        b=PRhonWczMHIObY2EBbQ5on0q2/LNGPC/R2ZooArmI2NmD+rwnSXm+Oj2tMAVMg5zs8
         sQqiC6Xrz0tqK5NC2hbFFXnTThHsbK2NXl8RlxXfKu8wsvCHpChBXDSR5dvK4ah9YbyA
         hGT6vNxBagFVFXru3bo94u3axq/SxGr0eyOfSFz6N5NHPxrQg/N7qrzHPU1AW9c9IIVd
         dvKDs04G3JDXSIeGAO+v19J/KWp5AWHRgT8wNVoJO+x6pBn7uyRSqF+Py1itMScberrB
         zkxvRSKxlveme1mOanQBJXL/16mGnYxUkXFaDtuDeMPUi9DK/oIFTmwKyiNZh6eykUJ0
         5kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839253; x=1753444053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+w1tv+6ZrnZaqoFk2pt6S8MAUlFF/qNsTMF9yI+xEJ4=;
        b=pjfP3ZvZPyFJ9BR2abD4dFC9qh4CeLLtEI+NAuRxHY7yyv7YvQtH2Ia2q8ZTP+i/Yl
         +nh9xL0vrPTsBi8tTWQiCQCyGyw2FInAJM6J0yyDPiCOD5NcG2yrROYkeqFkBypU2c8P
         h6d1UQHTwfSvmIJRCupFxquUj2TsrhPqz83UXwunEn+HnvPGvsCFjVaFV2sqlqlbIsDh
         cksb+smk1lFcuYnWWatlY69VwM4nUMLiXVx9SEbs9H8zR+ir2FMO2DgE8JT5XuvZVVAb
         +bgyx5Ks6psanfH7LFz5izah2q/EJi8q4LfcFdglo8MZ4R5TQcv/6PXt/c3Aj5hWnVvg
         xd4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8g4U2WJGiiEn1uDOcJdY5OapxuV2U77uyTyDkTJz03iSmL2ettuT02Ky6aeCu5xsDZ2OJpQt/KC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6KQ/HcSk0ZBtrmFtrlgWWo09m1HX+xY8DQjQjLfFVVSgrXhDY
	IbTIc96jlBVYdqpdaEcgGWI5a7atIOA0R7kIRgc9MRK0HLg37HrgjPiZ79WEaoU6wMw=
X-Gm-Gg: ASbGncuvIZdDrUAgGFRLIVjTQfccgzsHvT4JHbPCskzTcBEY5/+yiYJGuWb4S11iDVh
	yD9bf2bCHu8FnxVZcBfGx0pYjejMLrnyuOYmRKcr/Y6rdkhSy3aFbPQP7mjJYXaGg3kq/lMyNzy
	3zV28D7N7NCXI7pDYa2n1cyM+0NDp38Dts1KDZ9I/LnghNAMiS5MBU0+a1u2XAdc4LqOFi0UB3y
	Fjivvf3gX4by5Oz2Lx/8irD4OL4PuP5ZfTlsMH1BBb0cksVUjoEAcBwSyWMnomDhpwulRT/0+DH
	YlYZuBWOJbTJpgBRXE90H1A2aEef/AciJ4EiCOLEmt2m1vU48R2qZZYY3mGNd3tOh9ojBJCo4hz
	JzoaqPxXzmDzULJGuhcVRl9RXk/6irv4BYf5rmwIihgnM+5EYcipykKJ7c3CR+cjyNBPmCjO9
X-Google-Smtp-Source: AGHT+IGe5iQhJ8RtaE3t8aIOSYCMzo/BFynE8ZTwCF6QY+F4zOhxkCumRTONdBkQ5LzrAkAsCuDpHg==
X-Received: by 2002:a05:6512:3a87:b0:553:aed7:9807 with SMTP id 2adb3069b0e04-55a23ee82bdmr3314901e87.9.1752839252595;
        Fri, 18 Jul 2025 04:47:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55a31da25c9sm223482e87.178.2025.07.18.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:47:32 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC/MEMSTICK fixes for v6.16-rc7
Date: Fri, 18 Jul 2025 13:47:31 +0200
Message-ID: <20250718114731.81879-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC and MEMSTICK fixes intended for v6.16-rc7.
Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit ec54c0a20709ed6e56f40a8d59eee725c31a916b:

  mtk-sd: reset host->mrq on prepare_data() error (2025-06-25 14:42:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16-rc1-2

for you to fetch changes up to 21b34a3a204ed616373a12ec17dc127ebe51eab3:

  memstick: core: Zero initialize id_reg in h_memstick_read_dev_id() (2025-07-16 12:01:09 +0200)

----------------------------------------------------------------
MMC host:
 - bcm2835: Fix dma_unmap_sg() nents value
 - sdhci_am654: Add workaround for maximum HW timeout
 - sdhci-pci: Disable broken CQE Intel GLK-based Positivo models

MEMSTICK:
 - Zero initialize id_reg in h_memstick_read_dev_id()

----------------------------------------------------------------
Edson Juliano Drosdeck (1):
      mmc: sdhci-pci: Quirk for broken command queuing on Intel GLK-based Positivo models

Judith Mendez (1):
      mmc: sdhci_am654: Workaround for Errata i2312

Nathan Chancellor (1):
      memstick: core: Zero initialize id_reg in h_memstick_read_dev_id()

Thomas Fourier (1):
      mmc: bcm2835: Fix dma_unmap_sg() nents value

 drivers/memstick/core/memstick.c  | 2 +-
 drivers/mmc/host/bcm2835.c        | 3 ++-
 drivers/mmc/host/sdhci-pci-core.c | 3 ++-
 drivers/mmc/host/sdhci_am654.c    | 9 ++++++---
 4 files changed, 11 insertions(+), 6 deletions(-)
