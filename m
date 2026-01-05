Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C23FCC;
	Mon,  5 Jan 2026 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592970; cv=none; b=cfxagQl44HlUDmEROxJGtNZuZeCEDg0eKKhFbBUSs4BLu5sytTCPsGGs/pZk/duTSjrauUbBmdQF6ndBf40JPVrBQP+TmLgcGJB10ao3g49VckwDIoPoPTz+HE7kzIeoR3nZ4XsSZwIOecwCJbMfSJfGO4Xqyvb1y5O4FMN7E+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592970; c=relaxed/simple;
	bh=3l/yyh/PvEVILY3NZSFeWczjxdA8MDh16VgECAfJTbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rTQEziPn7HFPDjogtZrhNMorP6mpu54Nera6eUbO4Mv17vthGuNniUE3deMlY+YMsLIaV+9dI81vpOWBvuQauoYE2CYPvXPrlayg2IslERE7nLle1xDq7KZSVfEqdkKzOt9HlAKwb7ztG6Y0gxPESdcp89MUFxRc6rLbGM7D5oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OMsdQFhX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OMsdQFhX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767592965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d6klY0qLutRwiBhleIgbSDiI3UwM2eraMrChgfRPbxc=;
	b=OMsdQFhXIeA0N2qFnZRaVwVtlWockk+q4cojX80ff+R7+Cd7RHcoXublh5v7uAaB9JK4+w
	KVynevPRu3ll6PHcXuDFtQKzIKkFJrbKW746K07nZZOTMk7x5aY70YiDbcvpv6BFCU6Qno
	gZVicoeYWhLRtPJFheBY0ZN6C0n1QHs=
From: Matthew Schwartz <matthew.schwartz@linux.dev>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ricky Wu <ricky_wu@realtek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [PATCH 0/2] mmc: rtsx: card stuck busy fixes for Realtek PCI SD card readers
Date: Sun,  4 Jan 2026 22:02:34 -0800
Message-ID: <20260105060236.400366-1-matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series fixes some SD card timeout errors that occur after suspend and
resume ops on systems with Realtek PCI card readers. These issues occur on
my 2 RTS525A card readers and my RTS5261 card reader.

As a stress test, I ran the amd-s2idle script from amd-debug-tools to 
automate s2idle cycles and I launched a visual novel, WITCH ON THE HOLY
NIGHT, from the SD card. Visual novels are basically just slideshows, and
waiting for 10 seconds without advancing the text is an easy way to
trigger rtsx_pci_runtime_suspend/rtsx_pci_runtime_resume. I set amd-s2idle
to test with a 10 second long s2idle length with 13 seconds between runs.

The main symptom that always shows up is "mmc0: Card stuck being busy!"
followed by timeouts and filesystem errors. This can occur during both
runtime resume and s2idle resume:

[  260.638214] mmc0: error -110 doing runtime resume
[  261.054214] mmc0: card d555 removed
[  261.054382] Aborting journal on device mmcblk0p1-8.
[  261.054386] JBD2: I/O error when updating journal superblock for mmcblk0p1-8.
[  261.067729] EXT4-fs (mmcblk0p1): shut down requested (2)

Patch 1 adds a power_off callback so rtsx_pcr can notify the sdmmc driver
during suspend, allowing it to reset prev_power_state. This ensures
sd_power_on properly reinitializes the card on resume. It reduces the
failure rate of "mmc0: Card stuck being busy!" after resume from 20% down
to 4%.

Patch 2 increases the post-power-on settling delay from 1ms to 5ms. The
shorter delay seems insufficient for reliable reinitialization after the
hardware has been powered off during suspend. Increasing this reduces the
failure rate from 4% down to 0%, tested with over 300 s2idle cycles.

Matthew Schwartz (2):
  mmc: rtsx: reset power state on suspend
  mmc: rtsx_pci_sdmmc: increase power-on settling delay to 5ms

 drivers/misc/cardreader/rtsx_pcr.c |  9 +++++++++
 drivers/mmc/host/rtsx_pci_sdmmc.c  | 24 +++++++++++++++++++++++-
 include/linux/rtsx_common.h        |  1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.52.0

