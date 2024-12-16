Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F551CEADD
	for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384290; cv=none; b=nMRupYkfWdokdgTJkBCvNL7VjTsMcPfX6EV/OSTVgX6Sx8bU458qtIPp42OVHOQYf+oadeGxoHisKyOqPGDWBe1tTwTWNCQ3xmd/T9SvgdrmcDwpzVhwdQzUi6g+Igb9bWjd1N+pbW55HLaZOipWKWtAYhMdxkXdi8532hz6YkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384290; c=relaxed/simple;
	bh=DkRwYwAwlhjs9TTYnKIXFyiamlM5bZAZ0CRIy37HwIs=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=MkLh52AdOwV13EXzZkzl4atm+Wkf9Ee2zeFS4BjW/PeI+9+xZR7G55/RjvZR0twEbC+wVPmkdNWk6SMsJRn2xUSGj0KDZM5fCrWhXTTE0K1s1vxgTqaMj9EpjvACLx2NUPG+SAOlXEVyjZ1jihe4bZ/pcQjmSKliLHBCvG2zkrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJufh/yn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJufh/yn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399AAC4CED0;
	Mon, 16 Dec 2024 21:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734384290;
	bh=DkRwYwAwlhjs9TTYnKIXFyiamlM5bZAZ0CRIy37HwIs=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=CJufh/ynaYE/UBVLKpZyPRHeeo7VATzwkxUgf4i6VjwkFgWHCCRL4E8GS1Vs2dHdN
	 37Wcr4UUanho+/ZrBE8VGuPitBaSEWsqsx6yahNuZZaMx+hIk526PhIJ0MujtxWtGM
	 ZjJdWnw/o99lcGzl0U1fGu2dXnnocHLnqKxWpThv61uWsSovS3zhN789LK3Eeovspx
	 DMO9+U14mASVRAFa/D4PB0hfXnjFwT1/BHSSF7DZhzJcYFBayuRI5PxQAQnFiC0/Ib
	 0d/p64+Bipxb7bDSdipvSYY/3/qwP//GYtGYB+CkcHx+20woOx2991oJlZnbVgGq3u
	 GWc1QmWa46Ddg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 782443806656;
	Mon, 16 Dec 2024 21:25:08 +0000 (UTC)
From: GRbit via Bugspray Bot <bugbot@kernel.org>
Date: Mon, 16 Dec 2024 21:25:09 +0000
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Message-ID: <20241216-b219284c5-9047f521e8d9@bugzilla.kernel.org>
In-Reply-To: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
References: <20240918-b219284c0-db72da0a4ac7@bugzilla.kernel.org>
Subject: Re: sdhci_pci module is blocking low power s0ix sleep with GL9767
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: MMC/SD
X-Mailer: bugspray 0.1-dev

GRbit writes via Kernel.org Bugzilla:

I'm sorry, I didn't provide the exact description of "troubles" I mentioned. For me, after going to sleep, I can not resume. The laptop just boots starting from grub menu.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219284#c5
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)

