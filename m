Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE612C494
	for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 14:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351728; cv=none; b=StgYi/KqaJoaUbRyghW54n7O+lV/LhY3tGoz2zdq5pKK/Z0jT39SyiRQ4poCCHjXzq7H9poZcTAlFjYh4w664vUY64tYiVCEzt8bf1YqXyLjQyfwxkPMIF4JIa9mDwyGMSq0sVZ6KY/hkxrPnTghC4Vogqaiz9a7CKkw7UTZZVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351728; c=relaxed/simple;
	bh=HmqN4Y2qfe+qiS8OCMxYIoCYYp8YoP49efyrVtxAzLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=urMmhPulnsS2hm3O9i6lWT2ag7Xb53nT5YezQw8/Pm8HXsydQ+hSKaaIdAbdhvS3e8OIAkIiUVr7IfHaZMjGG7mujKzqyV6+u+GVOtZanmAFX01sJ4CC/hUZ6xSnEtEIK4zrg+6YfszE5FDjEpVJc/GUAjMdwA0wubkx6puy7i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OdQumhKo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OdQumhKo"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a0168c75so557273566b.1
        for <linux-mmc@vger.kernel.org>; Fri, 10 May 2024 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715351725; x=1715956525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+L8ioAsAchAICMfzBcWsl13awgXH6DvKJHhUEwMw4lc=;
        b=OdQumhKo8l2p94gJ8q0kX4HY9Yug/dcug8um1MvUrV0hL/xm9Q8gmzMRECkZGr1v1E
         oZKbljDukVQMNp4Xm8Uy6uURjaMH1X26n6su4/9SkewHtju6ZupQ9MyxUVa9tOi4c9sl
         x/yGgQ/Z7grAeX53vzjemadr0zFOeydDMqfnumfc8LhnwUmG7eIPBF6t5ck4nNpA/dmJ
         fI+1wEX/DatCaEoY7LOHvHZmimO6gTNyA52LLZQ5o/eX4p1+4z12ZbGmmss/p2porbJT
         036bWZ6xyhKmZ1fqbFw9DFiQBevpTtEWE8XpmZF7Bh2YUM7vCcl2q6j/jrxACkM2xo1f
         D4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351725; x=1715956525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+L8ioAsAchAICMfzBcWsl13awgXH6DvKJHhUEwMw4lc=;
        b=NCL7EGAqwO+LV4fmVYatjKEdU+nlRl5zDP28PrSfwnaNVsztj5NaU2OIpNeNnFNgde
         W16Ns3WR0EbrRzVBCxKRHIzNPuH2YxZcs1+/7fivQF0vcqXxq6IS3xX95JPxx+V1Lk49
         u6cOAdAbbvkR3jYtzoYeK0lluosz0/PpYT/IDyBrg2EPtqXQyl9DDbIYrg/6wcxWowjI
         XKS41fIQNJzvbkFzoGWRFo3+vwAxnSwRR4G6yNRJ0u7pn9y5hcGQGtiE5I1derwcEsOD
         32bqSZKmvqgJ28r1Bhm3dfv/MuvRtqLya8vy6Uocul0HgQZDa3weDi1hddwbhQGhgfNe
         QJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCVE9gQ18euAkXoXwTryHMyk0XvkreAteruXji+V8jZ7ecr38/TQSbaS6ugyCzer8v44u8l34bk4uCn8pPeBx8gWNhzc3uw+ig8i
X-Gm-Message-State: AOJu0YyUJFHbo4mwI/IFAK788mlus8U6Jy6+EcnLc5DOC8Ew1YvexFnT
	4KVjBPmSUW577Ws1E+KoLWMBSsLYPJOvvby0fG7XVNmHS7Ayon+NIE2quPHYWq8=
X-Google-Smtp-Source: AGHT+IEfB00TSyx2m8PYgYVtXx6zGkM7eP4zIy2ysPMoUokR5lQDpc/14tsnYvzn3fDHx3nAmbCz1w==
X-Received: by 2002:a17:906:c79a:b0:a5a:3a6c:8b57 with SMTP id a640c23a62f3a-a5a3a6c90ecmr84446166b.6.1715351724687;
        Fri, 10 May 2024 07:35:24 -0700 (PDT)
Received: from localhost (host-95-235-217-160.retail.telecomitalia.it. [95.235.217.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce5dsm190002366b.42.2024.05.10.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:35:24 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Eric Anholt <eric@anholt.net>,
	Stefan Wahren <wahrenst@gmx.net>,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 0/4] Add minimal boot support for Raspberry Pi 5
Date: Fri, 10 May 2024 16:35:26 +0200
Message-ID: <cover.1715332922.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset adds minimal support for the Broadcom BCM2712 SoC and for
the on-board SDHCI controller on Broadcom BCM2712 in order to make it
possible to boot (particularly) a Raspberry Pi 5 from SD card and get a
console through uart.
Changes to arm64/defconfig are not needed since the actual options work
as they are.
This work is heavily based on downstream contributions.

Tested on Tumbleweed substituting the stock kernel with upstream one,
either chainloading uboot+grub+kernel or directly booting the kernel
from 1st stage bootloader. Steps to reproduce:
- prepare an SD card from a Raspberry enabled raw image, mount the first
  FAT partition.
- make sure the FAT partition is big enough to contain the kernel,
  anything bigger than 64Mb is usually enough, depending on your kernel
  config options.
- build the kernel and dtbs making sure that the support for your root
  fs type is compiled as builtin.
- copy the kernel image in your FAT partition overwriting the older one
  (e.g. kernel*.img for Raspberry Pi OS or u-boot.bin for Tumbleweed).
- copy arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dtb on FAT partition.
- make sure you have a cmdline.txt file in FAT partition with the
  following content:
  # cat /boot/efi/cmdline.txt
  root=/dev/mmcblk0p3 rootwait rw console=tty ignore_loglevel earlycon 
  console=ttyAMA10,115200
- if you experience random SD issues during boot, try to set
  initial_turbo=0 in config.txt.

Changes in V2:

- the patchshet has been considerably simplified, both in terms of dts and
  driver code. Notably, the pinctrl/pinmux driver (and associated binding)
  was not strictly needed to use the SD card so it has been dropped.
- dropped the optional SD express support patch
- the patches order has been revisited
- pass all checks (binding, dtb, checkpatch)

Many thanks,
Andrea

References:
- Link to V1: https://lore.kernel.org/all/cover.1713036964.git.andrea.porta@suse.com/

Andrea della Porta (4):
  dt-bindings: arm: bcm: Add BCM2712 SoC support
  dt-bindings: mmc: Add support for BCM2712 SD host controller
  mmc: sdhci-brcmstb: Add BCM2712 support
  arm64: dts: broadcom: Add support for BCM2712

 .../devicetree/bindings/arm/bcm/bcm2835.yaml  |   6 +
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |  23 ++
 arch/arm64/boot/dts/broadcom/Makefile         |   1 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |  62 ++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     | 302 ++++++++++++++++++
 drivers/mmc/host/sdhci-brcmstb.c              |  81 +++++
 6 files changed, 475 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712.dtsi

-- 
2.35.3

