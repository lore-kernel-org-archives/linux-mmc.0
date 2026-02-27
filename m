Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3F73ACA40;
	Fri, 27 Feb 2026 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772218778; cv=none; b=UfRspCtjqfIkICBVzLE5hLrocvgWRmCSaCGBg2xr0T2FFyEDrfew/J5p+LNbG2Sr7rHcbWDOFPIKoonzlOLCj/TXX0hw8PKkMWM6bqxE0HAryEYwZg5DCjiosm38qgya9CWK3dJk5H6uJUFTDO+PTtCucC+jREp3EzxQAnK7xEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772218778; c=relaxed/simple;
	bh=rT7djSU5FKdbmOsrHo2aUoftmNe3r1okDuUaHxE++jg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FlGX9pNaQ8TOEas/z3TU6oxm0T8HMmtKtmIVdv0FHkhfbyfwVkvYuEFD0yG3u8BS0Sht7S1kNzIGTLPtDwFPTdeO+tokPgxjSFpuhR7ud3ZimD3oEgtQc6qfLGW/SsDy1kWYfH1GO1dbwRyc/PQs6D2hAYR+t2J0ZULqqEkk38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LF8xvA7X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LF8xvA7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C21EFC116C6;
	Fri, 27 Feb 2026 18:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772218778;
	bh=rT7djSU5FKdbmOsrHo2aUoftmNe3r1okDuUaHxE++jg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LF8xvA7XAwfMrZWsTq2HT/O3IanR9ms1iZgWgYNPze8VIrVDWhRpZKmgTytN0Ef1G
	 B7xxhLRJBr65FGqUejn3QHNHIz9tylucwoQcesDhx9cte+Gqf27nvZ+/GUcMlietqL
	 v5SVwdFKyFI8j/+vQUT9fA5ix8q91l26j4tkSRZj6yIyP+xzf9+ht5I7k0TPtnY5ws
	 bI6816zcsBOz913KMdUnyK9jJnmo1cDccdBiwakw0Z/4GtqZc1Xdk5B+1GRXGMDMOp
	 zv8oMNNgqD1dgUWUAzVbacgVVL0cFPKMNj9eK5PMixXYrKHXYk5T4NUftTtlQC8EhP
	 2Tq+qWf7Jnxng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA09D39E9614;
	Fri, 27 Feb 2026 18:59:43 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260227165825.236709-1-ulf.hansson@linaro.org>
References: <20260227165825.236709-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260227165825.236709-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1
X-PR-Tracked-Commit-Id: 901084c51a0a8fb42a3f37d2e9c62083c495f824
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 962336b9ff822e6b3288465106892bdcd2d577e1
Message-Id: <177221878242.2713791.13651057800587907873.pr-tracker-bot@kernel.org>
Date: Fri, 27 Feb 2026 18:59:42 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Feb 2026 17:58:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/962336b9ff822e6b3288465106892bdcd2d577e1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
