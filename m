Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B24CCDF3
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743271; cv=none; b=DUbpHvuEOsm7v7OokT4YjxR79QAix6TxhZ+k4ncqQcKn942dvvGr/+WfQljmGIbS9+BG4AZXKlfceL0Y7eZv9+SCGYIO4bTHNZxkbL8JTIvDeTBQyDyI4sjngsknVRbKLp2i6e+s7LHjA6OlqCw81x6CNXrRXKsJbFvgMmyuN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743271; c=relaxed/simple;
	bh=SKbsY51bu6o3XTAcOOLg24k/uElZxcoOWVroge2v+50=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Bt2ZQznWjvdE8EhvI7YjUS6opfovhnwbVGN+I30i39BgKjyauLQ2ku72sVR68tqXy9lDRWL4coo+kS6Gizh/b6cZlypmsG2F8fDpsT6lvx9MXDq8ELrf6ZyLkSNbmm7sp4egeZGjXfqcF68791vXgKDOXwRUAiJ3yLuSGmvVSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Zs8ia0/1; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Zs8ia0/1"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4cb8dbf90;
	Mon, 7 Sep 2026 09:02:30 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v2 0/2] mmc-utils: Add eMMC health command
Date: Mon,  7 Sep 2026 09:02:22 +0800
Message-Id: <1788742944-94637-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa079635d7e03a4kunm8383fd3f2cecf7
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGUNKGlZCSR1KQk5LHk
	8fHRlWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Zs8ia0/1/xWJ6UhgXzECQjKdeOmqN3LwGg5Coz0DM3vMKotjsizgPHP+UHlslKI+z+dP2OfJk23f9a5q7SUCW7/SZ7LShMi0ipIhRyFYh3G3M9HKwTm6PrysZOETrgDvlOpxgCPk7Hn3rInzuCAEzjno5FA6OzQYXhVTANQjTPE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=fewx9op119VKebCHnOVwpY9S4YTzABYQK7VY/Mm5zJA=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Hi Ulf, Avri,

This series adds a "mmc health <device>" command that prints a health
summary of an eMMC device: Pre EOL info, device life time estimates
(type A and B) and BKOPS status, each with a human readable decode of
the field, plus a final verdict line. The verdict is an mmc-utils
derived indicator - the eMMC spec does not define such an aggregated
health measure. The command is eMMC only, as SD cards do not report
any standardized health data.

This addresses the review of v1:

 - Patch 1 is preparatory: the extended CSD revision to version
   string mapping open coded in do_read_extcsd() is factored out into
   a helper, so that it can be shared.

 - Patch 2 adds the command, reusing the helper. Per the review, the
   BKOPS status is now read from the correct field (EXT_CSD[246] and
   not [33]), the commit log clarifies that the verdict is an
   mmc-utils derived indicator, and mentions the vendor proprietary
   health report (EXT_CSD [301:270], read via CMD56), which is not
   covered by this command.

Execution effect on an eMMC 5.1 device:

  # mmc health /dev/block/mmcblk0
  =============================================
    eMMC Health Report: /dev/block/mmcblk0
  =============================================
  Extended CSD rev: 1.8 (MMC 5.1)
  Pre EOL info:     0x01 [Normal]
  Life time type A: 0x01 [0%-10% of device life time used]
  Life time type B: 0x01 [0%-10% of device life time used]
  BKOPS status:     0x00 [No background operation required]
  Result: HEALTHY

Shawn Lin (2):
  mmc-utils: Factor out extcsd revision to string helper
  mmc-utils: Add health command for eMMC health reporting

 mmc.c      |  11 +++
 mmc.h      |   1 +
 mmc_cmds.c | 199 +++++++++++++++++++++++++++++++++++++++++++++--------
 mmc_cmds.h |   1 +
 4 files changed, 183 insertions(+), 29 deletions(-)

-- 
2.25.1

