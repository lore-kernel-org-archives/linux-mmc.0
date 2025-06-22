Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D712347D5
	for <linux-mmc@vger.kernel.org>; Sun, 22 Jun 2025 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750574380; cv=none; b=QJzbd8YNDiYrR8hvuph9n2uLxF6tv1p04WFH27ueBb3KisWzqQARqIsP2Wue0ECMIihjiYdjEYACRlnOly/u2toHuyEZNTyjchhELqzlZTbqVItyEe/4mQDxYeNTQdYSFZdB/5GRfx20hNxx/GnsVT1GZ63D2B+1XAQvqO+8mMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750574380; c=relaxed/simple;
	bh=Jk0n+63VIFUZyvMd38ya/LeV+W90ZaISWPQHDrEqBQA=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=TnUCJh7hjyslPQKSHqfRUfDv7/jC8CL4EMfsZMUfxeBooymOZqr7UAthRm8R0efibVDIHiR4uVQ4PTgbe0/+CN9lqym+xLkzUAEq5RKZmzMn3HG8O6SaJ7ikV1Tyol9kvmXPq4C30Z00NpJuZpV2IHdJtkEa94xm/cq5qNglZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3HEEcN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3HEEcN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C116C4CEE3;
	Sun, 22 Jun 2025 06:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750574380;
	bh=Jk0n+63VIFUZyvMd38ya/LeV+W90ZaISWPQHDrEqBQA=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=V3HEEcN2AgJEFwZgc1bBqZ6xNrFhKGmGhylxXb1Qn9X0h3wOHqRmLgH02oQN8cDU/
	 tcEQKr61yOVX9G/paayPMn5UB1gV7wDY7qRCuSjXzvN0B34Lo1jyiG+EBvJb5BSy1e
	 dqqopL5md7GCTNUR+MHNzxTSWt9TrdxR/8H7tYWmgg+PYAq2KfONZC9RXEwCXbnxWB
	 7VzHCpBNOIfV3mVaHKjoF3/N4ZlP0FVec5w/61SwkrgaxfIGOIzw7FXn0jWXSWQ9t3
	 nRAq1NlibPbojEqPlHYwInHFRnrQ7PYEBXotAOhKtOsBlD9WHEf6s+k0XLt8NDU0zr
	 SFNlY9Yq94oag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B319239FEB77;
	Sun, 22 Jun 2025 06:40:08 +0000 (UTC)
From: raoul via Bugspray Bot <bugbot@kernel.org>
Date: Sun, 22 Jun 2025 06:40:06 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: ulf.hansson@linaro.org, ben.chuang@genesyslogic.com.tw, 
 victor.shih@genesyslogic.com.tw, linux-mmc@vger.kernel.org, 
 adrian.hunter@intel.com
Message-ID: <20250622-b220103c2-e5b82e240db0@bugzilla.kernel.org>
In-Reply-To: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
References: <20250510-b220103c0-216fec070bba@bugzilla.kernel.org>
Subject: Re: UHS2 init fail
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

raoul writes via Kernel.org Bugzilla:

With kernel 6.15.3 and the latest linux-firmware (20250613), same sd card, I'm seeing this now:

[  396.669202] mmc0: UHS2 Lane sync fail in 150ms.
[  396.669209] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[  396.669211] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
[  396.669215] mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[  396.669218] mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[  396.669222] mmc0: sdhci: Present:   0x230f00f0 | Host ctl: 0x00000000
[  396.669225] mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x00000000
[  396.669228] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000002f
[  396.669231] mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x00000000
[  396.669233] mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
[  396.669236] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[  396.669239] mmc0: sdhci: Caps:      0x39783281 | Caps_1:   0x1803257f
[  396.669242] mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x000000c8
[  396.669245] mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[  396.669248] mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[  396.669251] mmc0: sdhci: Host ctl2: 0x00009117
[  396.669253] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
[  396.669258] mmc0: sdhci_uhs2: ==================== UHS2 ==================
[  396.669259] mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:  0x00000000
[  396.669262] mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode: 0x00000000
[  396.669265] mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel : 0x00000000
[  396.669268] mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
[  396.669269] mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:    0x000000a7
[  396.669272] mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn: 0x00030000
[  396.669275] mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
[  396.669277] mmc0: sdhci: ============================================
[  396.669277] mmc0: cannot detect UHS2 interface.
[  396.669278] mmc0: failed to initial phy for UHS-II!
[  396.679710] mmc0: SDHCI_UHS2_CAPS_PTR(65535) is wrong.
[  396.679711] mmc0: UHS2 init fail.
[  396.679712] mmc0: failed to initial phy for UHS-II!
[  396.925968] mmc0: new UHS-I speed SDR104 SDXC card at address 59b4
[  396.947290] mmcblk0: mmc0:59b4 ED2S5 119 GiB
[  396.948374]  mmcblk0: p1

View: https://bugzilla.kernel.org/show_bug.cgi?id=220103#c2
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

