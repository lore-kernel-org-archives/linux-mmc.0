Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com [101.71.155.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122A3B2AA
	for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2026 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828997; cv=none; b=EynH1xjZkeZy8UcEJyJEQmZwFwz47FzubG3CmTGy6K3ysjNvRt3OksKZNafRxTY/c73PDCA1F03N++iKxx+zgUClwGno/XAQo1jmo71jwcrcjAQlz/4ZFhJXC+GnJXPngUJv4R/7m0tLMvsPQUkZD1hFcOUYJhflodFTya3EGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828997; c=relaxed/simple;
	bh=le2YWaEwYbWlem9nFkFdjL7kTdqbOMKvWveIoRxQ/HY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CWYHqzQbIKqeAmTMSRHb1ZdQPxZr+uAnTedHVLAZvDVTn4V++NDYAxus4OcHq8EtIPAa+AVzyRYNiZtNpobNl66sTdtVpGUklPksXlWnvdmWltAakDAa53a4XbScpGPgtW7DkrkRIec0A3xFkjn6Ki+0epBi5Ok3lhzsAomEYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JuU3sc7i; arc=none smtp.client-ip=101.71.155.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JuU3sc7i"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ce1549dc;
	Tue, 8 Sep 2026 08:21:04 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Shawn Lin <shawn.lin@linux.dev>
Subject: [PATCH v3 0/2] mmc-utils: Add eMMC health command
Date: Tue,  8 Sep 2026 08:20:58 +0800
Message-Id: <1788826860-153971-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa07e63cb3a03a4kunm951c40383859f4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQx4eTVZITktJTUofSE
	MfT0xWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=JuU3sc7ivL+zfjBwiL2L5FikkcTH22/pI+HpqTDCvFeFrykPH1Pz06mosGPMRktWu0KOQu+K0AMN16S+D60Sl4eHu/uoaKP2ZqPWAU2WBY16+2zSnQRF3qw2T00IeWoERlCWdvosRUkSYndnTnar04gbWaE00mwWGpFxAujyd8o=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wIvuKL+DVm8zqJN84p4PCeSlDseoThBuFn9m16lnmh0=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

From: Shawn Lin <shawn.lin@linux.dev>

Hi Ulf, Avri,

This series adds a "mmc health <device>" command that prints a health
summary of an eMMC device: the background operations status (available
since eMMC 4.41) and the Pre EOL info plus device life time estimates
(available since eMMC 5.0), each with a human readable decode of the
field. eMMC only, as SD cards do not report any standardized health
data.

Changes since v2, per Avri's review:

 - Dropped the invented verdict and exit codes entirely - the printing
   suffices; the command exits 0 on success and 1 on failure, like the
   other commands.

 - The fields are now gated individually: the BKOPS status is printed
   for eMMC >= 4.41, the Pre EOL info and device life time estimates
   for eMMC >= 5.0, instead of gating the whole report after the
   fields have already been printed.

 - Documented the command in the man page and in the readthedocs
   HOWTO.


Shawn Lin (2):
  mmc-utils: Factor out extcsd revision to string helper
  mmc-utils: Add health command for eMMC health reporting

 docs/HOWTO.rst |  18 +++++
 man/mmc.1      |   5 ++
 mmc.c          |   6 ++
 mmc.h          |   1 +
 mmc_cmds.c     | 183 +++++++++++++++++++++++++++++++++++++++++--------
 mmc_cmds.h     |   1 +
 6 files changed, 185 insertions(+), 29 deletions(-)

-- 
2.25.1

