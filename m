Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB97143725
	for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2024 20:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734379492; cv=none; b=Uc24J3ymyJmOXmDFpFmwKAm3fOjA67f6dqFjNBrliKH0EimvPTmFm56l+3ySH0fD0maVDgtFSnvqlN9dRkEncoyZjVw9lDY6nZaNcUkziw1y52uq2YuZKK+LvjBqfNnyT3GZUCrtCuXNDakREtUH6UpG0uQHL4VfLuT3lLHa0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734379492; c=relaxed/simple;
	bh=OANFFViJqtMVLCJFVyoujmxWASJaz9o/a7DhJglRvD0=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=f43cbQlUvXGfTOajlYI9xb20IDrJcRft0i3r7/HfO39j/2oodkLFpuV4V7VKFuzLt3etFOuXzaGtn4c1xOzi2cfqhfyjbB021b0YLMeGr7jhwisnHUI42ogLrpLANAEIhD+vLq48GbTJ0XI4EM4vhG4tGpXfgrl0pqaQMgTWYk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQps1AId; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQps1AId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE8C4CED0;
	Mon, 16 Dec 2024 20:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734379491;
	bh=OANFFViJqtMVLCJFVyoujmxWASJaz9o/a7DhJglRvD0=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=mQps1AIdV+xiqVOnjtuUyVFcMe4Kj4ecueXQyqIa35XJYCWcvyRWcOpRUnkyM+Svb
	 n+1s6MtzuiIz+cfaZksehcCvqWOkX0uPaQ0HWR0+NUCXBzPuIk17DAkyIb9FEPVEeO
	 pHnncX9fmEjsitrpYlbVkX1F0zMydD7r0kqdXZF5HCpXC9RANjHUjtLTt2At+ZMjZQ
	 rhjSL2Eo93XAM9FttKiRx6OxrCgImgJrltNd2RNij1Su4j4xOySXSY//vNZTpWzMZ8
	 TjyukEnJ62EQnZTTQEXj70APj4xLTnKshsQb1TdNeFxQ38gSAx/WL2ogIEAEeiIS1g
	 KBDoVgFH0AYJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B32953806656;
	Mon, 16 Dec 2024 20:05:09 +0000 (UTC)
From: GRbit via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 16 Dec 2024 20:05:08 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Message-ID: <20241216-b219284c4-12b5e542519e@bugzilla.kernel.org>
In-Reply-To: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
References: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

GRbit writes via Kernel.org Bugzilla:

I have InfinityBook Pro 14 Gen9 AMD and have troubles with going to sleep and back.

After debugging suspend using this instruction https://www.kernel.org/doc/html/latest/power/s2ram.html I found this logs in dmesg:

[    0.638016] PM:   Magic number: 0:66:178
[    0.638019] PM:   hash matches drivers/base/power/main.c:1272
[    0.638074] acpi PNP0C02:0b: hash matches
[    0.638093] acpi device:0e: hash matches

device:0e points to 
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Phoenix GPP Bridge
04:00.0 SD Host controller: Genesys Logic, Inc GL9767 SD Host Controller (rev 03)

I have no idea which information could be helpful, but I'm willing to provide any needed info.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219284#c4
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

