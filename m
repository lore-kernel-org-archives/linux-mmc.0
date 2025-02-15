Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45C6151995;
	Sat, 15 Feb 2025 00:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580812; cv=none; b=MietQTknFrm5stnsXLNSrfBMjlRh2sWVEadubp2rSFZX6m0ZdavPYpHXflQ2nKZ8GkGhk/pOfoTf6omjBujMVpbL3cggoQIYrgR5I+uaENpksFbhfjLnxftFQHuNK6nY0FRT0REj9uP/t0DrSznfRVNuwvYEEKpKB3OJpRsxglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580812; c=relaxed/simple;
	bh=0VqjP6ITOgdQxanapolyY7fmseV1JENuWr100pB+Slw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=WnAtqS9oLvQiV0X17LHey95hHF5ethGqgZIDrfcvHcQKaFoYsqLNL7/TSuMeYMliKsMkFL/cnO8rtoBogcdWEM89M70Ha9re1A3NyRcTE+i4A190IauELuoEnhFh+7Sx3KJVnRDNA8ra25DZQOckko4xtJIOQ8rtLWeKH8TJDw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fyOwwu1q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fyOwwu1q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC43C4CED1;
	Sat, 15 Feb 2025 00:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739580812;
	bh=0VqjP6ITOgdQxanapolyY7fmseV1JENuWr100pB+Slw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fyOwwu1qO0QFFkUvjfWG5Y6FOOWk5qo+BWbwQlJ4BBVcOgb2tFl6ceC6w0VKOFq49
	 FgNtxZ8ZIG2jbq2jEXLd51qaGsF0hfXF1ywfi+e/9gHA/U7Xi5pfI9RNI/2g0AJk/3
	 bo2LRThVpMqcvuYS8QwRlzI+OagTgKBAiZ4FT/qC5C9yy8CGStUl9amY2PlOdCBr+K
	 nTjNKecYeZzY4n9Xt7HhFjUnZdPMTcFnkxqH6qmKQm3F2gx7jw2UE4x/S+TgBSWKxJ
	 WBxwvtZuWGYPTxB6clCA8CvS4Orta5/PfscU07jke2EM232c2toIFkqWBKn4w4Pbwo
	 1E6UeMQTGwS3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB011380CEE8;
	Sat, 15 Feb 2025 00:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.14-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250214121820.100545-1-ulf.hansson@linaro.org>
References: <20250214121820.100545-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250214121820.100545-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc1
X-PR-Tracked-Commit-Id: 3e68abf2b9cebe76c6cd4b1aca8e95cd671035a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f92a80bdb445e4e73e810ea7e94bebb10717f40a
Message-Id: <173958084149.2153475.5815790920037026768.pr-tracker-bot@kernel.org>
Date: Sat, 15 Feb 2025 00:54:01 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Feb 2025 13:18:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f92a80bdb445e4e73e810ea7e94bebb10717f40a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
