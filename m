Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC34301141;
	Wed,  2 Jul 2025 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475991; cv=none; b=EOm/0aFUgC6cP5Kbm8HKv6DEG4WE4DY30wHZnng71+uRCbP0DRt/5Q+YQJdl9ghvnVX8Dx7+IIVHW2vX4vuokyvregMfREu2dXXCKxJjYdXrVyTKZg3bD+F1b/B2Un5/vQ8wXDTE3CATi9Aar15TqJF82f5orSZCC6RprUjfx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475991; c=relaxed/simple;
	bh=2G6AdAb2VAMePy4KpTNaoyeQx3dI03WTiWFazdDOgXw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Xp2vrDPHDCdCkNWvroXj1CjB8RzER2MyjPX9RnAs8m8+5BhnFiTmowxwjlL6mn4c2MlV5Te8XqDxA2nUvBOVspTyqL38x8Fcc5f0M+1ndxUDx8VtXgC4jCDiOxKT02/TOhIPW2tfR8liRq+4lN8Nj2YZ/eyBKiG67fd7v/ZX1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfHQRHZ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfHQRHZ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288C6C4CEED;
	Wed,  2 Jul 2025 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475991;
	bh=2G6AdAb2VAMePy4KpTNaoyeQx3dI03WTiWFazdDOgXw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LfHQRHZ0i9N8vFZeDPX0tHx9VBFRuaNPqIB6MvMYpRM5K15kgq63Uz7K20mMCvnQb
	 xAywA41q8vVq14MTANtyZs8LYqyKA1Ai/sphICLN7wRhRmyR1KUgpGgafeudWW23Og
	 pmbQ0NRcT+p2/d5U9Kom/8HUv1wlX0NuLYw73A05xhLwv8c7w8c/f/xVmPTJPv2auA
	 6Tb3MypA3H+u5mLYCGOFN+Zt0lMImyvB2QnGxHgNDoMMrun46xUKnMMsnS7XQS1WPY
	 ppuPPddPLMZtZh7CvwADje7KiAdVfUr9kg1OVv67eSKRHE0wmZjYAR6CVk/3PLDHrX
	 WiA2xVMZe3EHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFED383B273;
	Wed,  2 Jul 2025 17:06:56 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.16-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250702144058.29486-1-ulf.hansson@linaro.org>
References: <20250702144058.29486-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250702144058.29486-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16-rc1
X-PR-Tracked-Commit-Id: ec54c0a20709ed6e56f40a8d59eee725c31a916b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b4911fb0b060899e4eebca0151eb56deb86921ec
Message-Id: <175147601561.796050.8403803200042423646.pr-tracker-bot@kernel.org>
Date: Wed, 02 Jul 2025 17:06:55 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  2 Jul 2025 16:40:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b4911fb0b060899e4eebca0151eb56deb86921ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
