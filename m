Received: from mail-m1973172.qiye.163.com (mail-m1973172.qiye.163.com [220.197.31.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD86BA45;
	Wed, 30 Sep 2026 04:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790743083; cv=none; b=q01WprbB+xdqE4RomUtuTtLFnnvmD3HCty2NS4zfNapDAAb0J1qPTIyiu7X+p/I+WLtZwT6lr+5wQRzl0T/12RuL2K68CYxeVsB6euDeo0Ux0Nl9Yli7VdJ3EdBlVcQtkvEL4XSOtTA2epZT1lzglAMaKXH2dMZBaZ1vybo9pFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790743083; c=relaxed/simple;
	bh=QIC5YEItCpJt1NRkKclgpSaif3VzT6PXguhIXjHQHC4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oKJIgGikTxKeWSj9xGhBm1vVQpdRcfKRC2dmGJZSc0Cl0vIYG1tOc6kKBzFm6wdFcii+oO1gtbGOelynhv1HHQeNRwMVZfAzws+2xm4M6CJNLZ/jeEGD88bPulYKDLsYXZa072eCD2cI7Dds2aJvM6KHYgbcdriux6m97BbuHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=T0yWNHTD; arc=none smtp.client-ip=220.197.31.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="T0yWNHTD"
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f96815d0;
	Wed, 30 Sep 2026 12:32:44 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 0/2] Let mmc_regulator_set_vqmmc() use ios->vdd to set vqmmc
Date: Wed, 30 Sep 2026 12:32:29 +0800
Message-Id: <1790742751-245571-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0aa0f09619db03a4kunm0766139d8bc998
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZQh4ZQlYdTh0fGUhLH0
	NKThhWFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
	tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=T0yWNHTDhtw1cgwKHI0SvNtqwb1epQMKSuWjt5ZEWd/BNK9+A7Idn+LlhIcK18CzXLlA51TzJQpGhhO7TO9AvuM/W/XSO3DRZ5MqdH406FXuSRIqtsqSGk5nyDiDMJRxO0YvZ41OtxQvPG51Nab98vjQCaSoCSgjK7SfJud7DZs=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=hiyg5Eu9HbgPFjmXMlOPg8lf2Bz4HzdnNvg1EUr8yJU=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>


mmc_regulator_set_vqmmc() derives the vqmmc voltage range from
mmc->ios.vdd, which can be stale with respect to the ios passed by the
caller. patch 2 uses ios->vdd instead; patch 1 prepares sdhci-msm,
which passes a local ios with an uninitialized vdd.



Shawn Lin (2):
  mmc: sdhci-msm: Initialize the local ios in msm_toggle_vqmmc()
  mmc: core: Use the ios vdd when calculating vqmmc for 3.3V signaling

 drivers/mmc/core/regulator.c | 2 +-
 drivers/mmc/host/sdhci-msm.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

