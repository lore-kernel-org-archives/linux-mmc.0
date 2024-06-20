Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01941B0100
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897999; cv=none; b=empArxnZ8Sh2SZu4rivVm5cWmzot6Vf/OT5E/KaJrT3gYnRk5JXNykVcy4MgnVJiOo7KZVIv4AEDeNGqtteZh4oBgdNWOHc1e7y6/isqHLe5y+SAy9M7km6x49AW8Q8qKBJN8Ma1AMasUZncBflEPFVUz3eMjAf86hKnSCaebO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897999; c=relaxed/simple;
	bh=EGan0DPRyj1iH/qlzBQ+qSQPs0ak1SMhLvLNyPKTR4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o3jwfCr6jHc2VS//WudkRV1m4gSRG3I5Gmiq8MWEsmMqf92yAEehJbut/PBrUhvoC1eQz1Xal5kkcQwjvyrwTyaSRIUNh+lv4fwPcc24kjGhz1dW7qiDKxaG3trBRRMFYnJ2SgoGB2qP6YEkm62nwom4DjSbdmw1n0RTtWKu54k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:260f:cd5c:91b1:523c])
	by laurent.telenet-ops.be with bizsmtp
	id drfo2C00R0Y0hZi01rfocP; Thu, 20 Jun 2024 17:39:49 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sKJt6-0005LW-Oa;
	Thu, 20 Jun 2024 17:39:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sKJt6-000LnR-Le;
	Thu, 20 Jun 2024 17:39:48 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] mmc: tmio: Remove obsolete callbacks
Date: Thu, 20 Jun 2024 17:39:44 +0200
Message-Id: <cover.1718897545.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series removes two unused callbacks from the tmio_mmc_data
structure, and related infrastructure code.
  - The first patch touches only the MFD subsystem.
  - The second patch touches both the MMC and MFD subsystems, and has a
    contextual dependency on the first patch.  If really needed, it can
    be split in an MMC and MFD part, but the MFD part depends on the MMC
    part anyway.

Thanks for your comments!

Geert Uytterhoeven (2):
  mfd: tmio: Remove obsolete .set_clk_div() callback
  mmc: tmio: Remove obsolete .set_pwr() callback()

 drivers/mmc/host/tmio_mmc.h      | 3 ---
 drivers/mmc/host/tmio_mmc_core.c | 8 --------
 include/linux/mfd/tmio.h         | 2 --
 3 files changed, 13 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
