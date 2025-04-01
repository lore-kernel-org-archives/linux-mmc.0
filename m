Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292191EEA37
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501538; cv=none; b=cfxaGzxuQg+onFrKpWG/PyCMgZXfJ2UgdpPt4jwvSyitLNbgu3NE6l1vCo0gTakrZe72fQB9uYsIYe5WNhPxNPL65UVPYa72swCSYHLuC7m/9AIEbDzX/ioki/YKfIoEQf3mnyBqJshqG1krV4pcLY0UEPfDxSALfPTCYMyUacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501538; c=relaxed/simple;
	bh=VZCB6lMdZgUbeanxDdcuA3GSgG3/yYkWyW0REnD/9wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQgmfpUDs1JKXJg4Jc0hli+6GkBUgiNQ8DYpNpaLT/xniRHXKKKCqzl3+yQ4ts/kE64lf0GYoXjZpOZP9oyP5iDiOHKk5Eem29qVkmv+Y0c+XOoKPm2a8IIatlC/Yh3d2texhx2CwQxNCQKWAuNGAaMXsCQh/Mz3XjX4bvWdqbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=k2MfVGJw; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="k2MfVGJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=Ki1KHWPbKghAO2
	JBCiO5dC3eupe7DQxN/7UlrojsKls=; b=k2MfVGJwz4HcWu/p8dpSDnMSe9ad1I
	ji5U1BAgXwsia+Qk5ckdGBp2kQpP2j1FM78HIZRiEBEeHpgoyqawFGE7bAGZWVaF
	G0Hwws82Rc8O5AEKv6FqHIZ4tAvbiNrVR75isZacrEOzanOcVyUTZ6zEW1LwIq2W
	iMddt7B6cKbSLFza0pfjX8t7hCdTYRRJRa4YLnpNn2F6ZbfD/kANb8dbKIF/2x4Y
	kMdSxm4Xb83OT6n01sofQp9xePT1iLej7cEEvoYdWKzaw7MImhIZyp3twpsjON/Y
	1yJ77EN8TMRDs4HjnDIzdd8MTO8jlyyj8qfcCRLj0N9w3sDZ8dy7Cxbw==
Received: (qmail 1558637 invoked from network); 1 Apr 2025 11:58:51 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:51 +0200
X-UD-Smtp-Session: l3s3148p1@wWFolbQxYq4gAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 00/11] mmc: rename mmc_can_* functions
Date: Tue,  1 Apr 2025 11:58:36 +0200
Message-ID: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned in [1], here is a series which rename mmc_can_* functions
to names which include 'card' or 'host' in the name. I am only an
occasional MMC core hacker, and these namings would have made my life
quite easier in past times. So, here is my proposed change. Have a look
and let me know if you like it. Plain RFC for now. Notes:

* This series is based on [1] which needs changes. My idea would be to
  respin the series on rc1 right after it is out.
* I intentionally left mmc_can_retune() out because it seems more
  consistent with all the other mmc_*_retune() functions
* Builds fine locally, tested on a Renesas Salvator-X with R-Car M3-W.
  buildbots still need to check it, branch is here:
  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/mmc/unbind-power-off

What do you think?


[1] https://lore.kernel.org/r/20250320140040.162416-1-ulf.hansson@linaro.org

Wolfram Sang (11):
  mmc: rename mmc_can_discard() to mmc_card_can_discard()
  mmc: rename mmc_can_erase() to mmc_card_can_erase()
  mmc: rename mmc_can_ext_csd() to mmc_card_can_ext_csd()
  mmc: rename mmc_can_poweroff_notify() to
    mmc_card_can_poweroff_notify()
  mmc: rename mmc_can_reset() to mmc_card_can_reset()
  mmc: rename mmc_can_sanitize() to mmc_card_can_sanitize()
  mmc: rename mmc_can_secure_erase_trim() to
    mmc_card_can_secure_erase_trim()
  mmc: rename mmc_can_sleep() to mmc_card_can_sleep()
  mmc: rename mmc_can_trim() to mmc_card_can_trim()
  mmc: rename mmc_can_gpio_cd() to mmc_host_can_gpio_cd()
  mmc: rename mmc_can_gpio_ro() to mmc_host_can_gpio_ro()

 drivers/mmc/core/block.c             |  6 ++--
 drivers/mmc/core/core.c              | 48 ++++++++++++----------------
 drivers/mmc/core/core.h              | 10 +++---
 drivers/mmc/core/mmc.c               | 30 ++++++++---------
 drivers/mmc/core/mmc_ops.c           |  6 ++--
 drivers/mmc/core/mmc_ops.h           |  2 +-
 drivers/mmc/core/mmc_test.c          | 12 +++----
 drivers/mmc/core/queue.c             |  6 ++--
 drivers/mmc/core/slot-gpio.c         |  8 ++---
 drivers/mmc/host/dw_mmc.c            |  6 ++--
 drivers/mmc/host/mtk-sd.c            |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c |  2 +-
 drivers/mmc/host/sdhci-omap.c        |  2 +-
 drivers/mmc/host/sdhci.c             |  6 ++--
 drivers/mmc/host/sunplus-mmc.c       |  2 +-
 drivers/mmc/host/tmio_mmc_core.c     |  6 ++--
 include/linux/mmc/slot-gpio.h        |  4 +--
 17 files changed, 74 insertions(+), 84 deletions(-)

-- 
2.47.2

