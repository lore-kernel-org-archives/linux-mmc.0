Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116921E104C;
	Fri, 15 Nov 2024 18:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731697137; cv=none; b=NHDDrEr99nvBdGfh6juUiXvXdz3BBVPhGSGfg9BibUVIItuq3qmPZCQxGtAZRME0QnlBojnYoyj5l51ciYvJIocmpmz7wWY9lTgK0vfIZKKlJS9qKtILuT3XjSHCmWpO4/QLEdYf9PnBQvGnCj/KQebulS5yRC6/f5BcJZPQpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731697137; c=relaxed/simple;
	bh=pa4psrOB72GXabTf1VOuGpMl56JuKHkYX+w/5lD1Inc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FZE3GxYVooZm+QXm8VE6m1j6wF7ijnwxTONRVuNNWXBdefM8MAODSUgR0JjJttTR1vW5mUwvdw8Yh0VQT4u/DAZrk2isB+0r6rPufFkGTZbA9dEo3meb17JsaogjxgfkSvKRTYmGuXgTmGZSGhVJDPjliTM+zz20/9rw/p/p9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlzbyquB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlzbyquB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C49C4CED0;
	Fri, 15 Nov 2024 18:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731697136;
	bh=pa4psrOB72GXabTf1VOuGpMl56JuKHkYX+w/5lD1Inc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IlzbyquB0sv7xMAAWgPp2VM0Iy9JVI26X79UzZupT+RHY74AoLBXJjyv/XtbT97Hf
	 PAXoz47isIo1PdWb0ICpIArgPX0Dhp8YHSqqMckgWN17nd+p/wsG1spVlMSFB1Ztlk
	 hwVpFwyiJaSRY1GEq64KK6thaiU/t+aJsnH/Ne3lXJfXUe3JhdQbhDitN7WXU3McTK
	 xWRi7qdlOJLaw+7JVVCVa2AH3nopRtDct5WFpEV/mdnNmu3zytwLtlOhPee1b9dPSN
	 H3vT4wrC0/GHnpkY4xgKGz2m1GpsRAwXHvaiRb175TnGMX+u5tUvzvu5X8yby+HITK
	 2h+9qM6re9H0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED03809A80;
	Fri, 15 Nov 2024 18:59:08 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.12-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241115100042.116738-1-ulf.hansson@linaro.org>
References: <20241115100042.116738-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241115100042.116738-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3-2
X-PR-Tracked-Commit-Id: 1635e407a4a64d08a8517ac59ca14ad4fc785e75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa35f5446fac73c96f4c282e333b119deba2d82e
Message-Id: <173169714750.2685462.3545904452565304077.pr-tracker-bot@kernel.org>
Date: Fri, 15 Nov 2024 18:59:07 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 15 Nov 2024 11:00:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa35f5446fac73c96f4c282e333b119deba2d82e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
