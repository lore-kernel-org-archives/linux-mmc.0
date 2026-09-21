Received: from mail-m11867.qiye.163.com (mail-m11867.qiye.163.com [115.236.118.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B3145519A;
	Mon, 21 Sep 2026 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.118.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979662; cv=none; b=bSyB8gXxaJxQzqhg4Uom/MPwaEoC2Iu7UGV6NxRlCjLTafe6lDTUGf056/zehmWl+LpAFprOlwYVlFwV14W0VoyIhirQXZK0U5nAWhuDH5o8gTN2tene2L9lVuks1uNqlAwjG5FX5NdY745YbDIuUxQztX1hs97jLRw27HN4tVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979662; c=relaxed/simple;
	bh=csbji0AM0kULkpjajyHXb/OGoYxrhenXLE742n5Wr7g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=JSeXuNNKX84Tp5/E6b2PfCaLQxp+Nh/7jxpSta1gKEOxyhy6jvuNyEVFIUX5+ThH/MCVPgEn6jjG9TirsJcxpdFy9J6cVK167q3711SmjerPq0DNzZf5rrX9amuXNYABdu93OxIp3OExsWX1bdMzS2/7N9ki4sVxiHXRm7cC9Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=fD2nnMrH; arc=none smtp.client-ip=115.236.118.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="fD2nnMrH"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e89bec58;
	Mon, 21 Sep 2026 15:18:29 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@linux.dev>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 0/3] Add SDIO userspace passthrough support
Date: Mon, 21 Sep 2026 15:18:16 +0800
Message-Id: <1789975099-157594-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0c2d49c1403a4kunm73dcdfcc310915
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUxPSlYdGU4aSB5PHk
	pNHk9WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=fD2nnMrHAAhYAQ0xtGHcWgxCwME7DPtZ51AQYKQ759guhr7nOw+I92tw2YJ+Jlu7IsiaSb14ZsqkkJYk1F9cpgnWZJOMuEskvJoBUErBwWcKDBq6tc92m0JkIk6nClX/v/fTtGvu/H3u20N7UuFw1fDkiUfBGAdxhhmpcMm4W50=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7rdtTWnmmeB2ukmMkSFMGLI0SlyKO6Vy1To4o+dFke8=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


SDIO cards are normally driven by function drivers (brcmfmac,
mwifiex, rtw88_8723bs, ...), but bring-up, debugging and factory
test frequently need to poke the SDIO register space directly:
CCCR/FBR in function 0, or vendor registers before any function
driver is bound, and some deployments, notably lightweight IoT
boards, want to handle the SDIO function entirely from userspace.
Today the only way is to write a tiny kernel driver per device.

So this series adds raw userspace access to the SDIO register
space as well a small reference client. Meanwhile, adding a new
documentation about how to write a proper SDIO function driver,
because I have recently been working on SDIO function drivers
and kept referring to the existing drivers for guidance. It turns
out that the knowledge is scattered and there is no unified document
describing how an SDIO function driver is supposed to be written,
despite the MMC core having clear expectations about how the APIs
are used.

In particular, the interrupt model has many pitfalls:
sdio_claim_irq()/sdio_release_irq() must be called with the host
claimed, the handler runs with the host already claimed and must
not sleep or claim the bus itself, and sdio_release_irq() must be
called from ->remove() because it is the last chance before the
core removes the function devices from mmc_remove_host(). Recent
fixes around the SDIO IRQ work and host removal and the discussions
on the mailing list showed how easily these contracts get broken.

Also worth documenting is the buffer requirement of the CMD53 based
helpers: the core builds a scatterlist directly from the caller's
buffer and the host driver maps it for DMA, so vmalloc() or stack
allocated buffers are not acceptable, while the CMD52 byte accessors
are safe with stack buffers.

Changes-in-v2:
- drop RFC as I don't include mmc-utils to be sdio usersapce tool
- add sdio doc

Shawn Lin (3):
  mmc: core: Add SDIO userspace passthrough character device
  tools/sdio: add sdio-raw userspace client
  docs: mmc: add introduction to writing SDIO function drivers

 Documentation/driver-api/mmc/index.rst             |   1 +
 .../driver-api/mmc/sdio-function-drivers.rst       | 211 ++++++
 MAINTAINERS                                        |   2 +
 drivers/mmc/Kconfig                                |  11 +
 drivers/mmc/core/Makefile                          |   1 +
 drivers/mmc/core/sdio_bus.c                        |  12 +-
 drivers/mmc/core/sdio_cdev.c                       | 189 ++++++
 drivers/mmc/core/sdio_cdev.h                       |  21 +
 include/linux/mmc/sdio_func.h                      |   4 +
 include/uapi/linux/mmc/sdio_ioctl.h                |  48 ++
 tools/Makefile                                     |  14 +-
 tools/sdio/Build                                   |   1 +
 tools/sdio/Makefile                                |  66 ++
 tools/sdio/gen-sdio-ids.sh                         |  59 ++
 tools/sdio/sdio-raw.c                              | 714 +++++++++++++++++++++
 15 files changed, 1346 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/driver-api/mmc/sdio-function-drivers.rst
 create mode 100644 drivers/mmc/core/sdio_cdev.c
 create mode 100644 drivers/mmc/core/sdio_cdev.h
 create mode 100644 include/uapi/linux/mmc/sdio_ioctl.h
 create mode 100644 tools/sdio/Build
 create mode 100644 tools/sdio/Makefile
 create mode 100644 tools/sdio/gen-sdio-ids.sh
 create mode 100644 tools/sdio/sdio-raw.c

-- 
2.7.4

