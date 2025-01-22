Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96162139C8
	for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560739; cv=none; b=N68PEoPPbQOkSooTLPCfpTCDCdc59gwSlaVxmVjago+ZAes6tVAkqGfEMmubCLLk9mev4LwJZgigQnEJkW2jNFkVInk/gvphmG644Gb10Jt0vDFjA/gAISyJyRwnC/8uMUnrBYSuxda54hMc4MrRl4fhkIVsIv6aTeqkBe4tOeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560739; c=relaxed/simple;
	bh=w+vnBfMenEv5ysER2euSd4rxuLq9uqDoRch/yeM67CI=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=HOvTaVyF6NEIV+LS2UvZ6eWeCNzpkJnkhfxiIIqaXbHNjdoVT554G2NeyA8jueq7+v2wHoSnW79T6Gy1YIoG8TQKm6g5/W4pIt2pGcX8bwNudOyokfzyV3GYNxqTeo4vlT9vbcUrmTCJx7Y8MqYtlDZs45pKNLJ9EKPwv71W6o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2Vmod1j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2Vmod1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB46BC4CED2;
	Wed, 22 Jan 2025 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737560739;
	bh=w+vnBfMenEv5ysER2euSd4rxuLq9uqDoRch/yeM67CI=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=O2Vmod1jsJnE0Gg3NyGg1v+IclhMvhrB16td3XGQyTL5sGxjg3xojByks2Uwn19pk
	 rdnHi9rU2l9XnduE/njddxUYnrrqTcRRY+s5ZXn+QuuwXSPD2dL9GUcfBJV6cgLPBG
	 z7FqDZNEYggZwlXKfX6qTUV4J0umLWTdUPhHX++0ZkDI+RXW6C9+a8p2/OTjhTPd09
	 5Qd1PThQHg2WlExZLozolUgE3Fi6/gaYMlqA69xDOJtm/I3n42mf5YD45MBbzR8LCd
	 xUTROkz81Dbteu+CIjdRpGzWXDwzdAX5TjAkCTgV8QZAAghQbwyTzJBwT8fLoB2C1M
	 SbX/FNKhZ9KRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710B3380AA62;
	Wed, 22 Jan 2025 15:46:05 +0000 (UTC)
From: Michael Garofalo via Bugspray Bot <bugbot@kernel.org>
Date: Wed, 22 Jan 2025 15:45:34 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20250122-b204003c28-c6290ac0f887@bugzilla.kernel.org>
In-Reply-To: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
References: <20250122-b204003c0-5776b9acf361@bugzilla.kernel.org>
Subject: Re: RTS5229 built in card reader not detected after Linux 5.0.x
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

Michael Garofalo writes via Kernel.org Bugzilla:

I can still confirm this issue of the device not being detected, on Linux 6.12.10-arch1-1 from Arch Linux, on my ThinkPad T14 Gen 1 AMD, with a similar model card reader that utilizes the same 'rtsx_pci_sdmmc' driver, the RTS522A.
My card is not detected until I unload and reload the 'rtsx_pci_sdmmc' driver.  After doing so, I get the same 'cannot verify voltage switch' message, though my card is then detected.
It then remains detected as inserted forever, even if the card is removed, until the drivers are unloaded and reloaded once again.

My logs, if useful (187 is when I reloaded the module):
$ sudo dmesg -w | grep -iE 'mmc|rtsx'
[    1.144983] rtsx_pci 0000:04:00.0: enabling device (0000 -> 0002)
[  187.573380] mmc0: cannot verify signal voltage switch
[  187.690136] mmc0: new ultra high speed SDR50 SDHC card at address aaaa
[  187.720150] mmcblk0: mmc0:aaaa SU04G 3.69 GiB
[  187.735364]  mmcblk0: p1

My PCI device id:
04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS522A PCI Express Card Reader (rev 01)

I'd be happy to provide more info on this if useful.

Appologies if I've done something wrong here, this is my first attempt at trying to use this Bugzilla.

View: https://bugzilla.kernel.org/show_bug.cgi?id=204003#c28
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

