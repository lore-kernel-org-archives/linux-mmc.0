Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8262ECD23
	for <linux-mmc@vger.kernel.org>; Wed, 23 Jul 2025 13:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276191; cv=none; b=OM1r4JI5mZ42NVAk6p3iJd8X4rDGeyTHPUKa1rZyKWFaZkAsGCX+FLKciApz3WH361okimHxhid5XCZ1C5buPF0IXQgXkgS00hIMw2GYp37FWDF80gu//YQA+LH+2DH2fHF+e0rWfRyf7Xdf4t5HkFLtiW2EyvqTJtTcDuAUttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276191; c=relaxed/simple;
	bh=eYw4xntZ3gDxO78D/ZDHuoCN7uLjRQwsQ9dV47ANl20=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:Subject; b=eCyHgCE/6jxR4nuIkb0fq/rdWjSUPIH77uNfzpS+esrNJ6dqrKxo7aqR2SdlJSTa0ndlbH1/Cz1pW+ttg9cu8mvU/SEeghLd398wKxvAND0JQNz5bH57N8/ia46bF1lxswUvrrZfvWtsgt3uT04K6Hyj0SC52coTrKHGdquggtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQV3fwyo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQV3fwyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C6CC4CEF5;
	Wed, 23 Jul 2025 13:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753276190;
	bh=eYw4xntZ3gDxO78D/ZDHuoCN7uLjRQwsQ9dV47ANl20=;
	h=From:Date:To:Subject:From;
	b=pQV3fwyoOKuNLFbU4OWtQX9RlrUYzYrLl9nxOwxThppim2RzJtzx3HBPr7IX0Inrj
	 EnpOJ/Ae4L82HdhFAUljab5BV9oP2hD4jtdKy048EmHZyHKhSrZwBKRb+dlLHhoJma
	 4ckYeliw2yy+iRppMEPTd1A5B5u4pYPxWPxIq5OwzzmEkqxQFftVdG0OO01XAwtmjW
	 XgyU4GQ1VDMMO+T2Wvu14mnmz49lyO77piPWBl4eCDd13AJVjlAkPVjtOYzbZrkKDt
	 hDxQgzkxDW3UER0K8YKqFwhlpF7gb2mNxGi3kotj3swHuWnLx27d6u5NSxuRcBVFRl
	 47hGBBwdWPz+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 37B01383BF4E;
	Wed, 23 Jul 2025 13:10:10 +0000 (UTC)
From: Laurent Bigonville via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 23 Jul 2025 13:10:05 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250723-b220362c0-fd0fdb0c86b1@bugzilla.kernel.org>
Subject: rtsx_pci driver is blocking s2idle
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Laurent Bigonville added an attachment on Kernel.org Bugzilla:

Created attachment 308404
s0ix-selftest-tool -s output

Hello,

I've a Dell latitude 5530 that has no S3 suspend, it only has s2idle

I initially opened bug #218500 regarding the lack of support for S3. While trying to debug this, I start using s0ix-selftest-tool and I realized that the driver for Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader was blocking the suspend (rtsx_pci(_sdmmc) is then not loaded)

If I disable the SD card reader in the Bios, the script is more happy (it also complains about the Raid/intel RST thing, but I guess that's an other issue)

Is there a bug in rtsx_pci(_sdmmc)?

File: 20250722-16-27-s0ix-output.log (text/plain)
Size: 1.85 KiB
Link: https://bugzilla.kernel.org/attachment.cgi?id=308404
---
s0ix-selftest-tool -s output

You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

