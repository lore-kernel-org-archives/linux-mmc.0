Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694335;
	b=m2fTbkue18CTUtDi/RmE6NoB3xHdYrnKLIDQSKPnJkllCnrPqELtfJG/CgAjRwQynfbY
	 r41bmBgJROgKfK1RvNu5G0xFKFJgIX0UOyySKBlX/h7TvaoUdGWF8dIrCc2oaPqNNOeTJ
	 fYFGsE2J5cJL3AgRlW6Z3BMfIf+H6wKfbsIw/TAZCp1iBP31pgKiqf/gYDPe8uCIxHZnQ
	 sC+A+H4MfqoDM5nD6Wagx2oisX/YOfnmkjv7sIFImWsb7PEQe+i2gPR8d0+PSj73VA8wV
	 UwxnDs+RHDG8muyOLw4lfZbGY1lLXvYdWsUr/2dwNhyx4M234eH9VPEnu5C8B6MxweQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694335;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=WQkgINckB0fJmUZDzqNLDWr3Ngk7UmXxI0iHqdXJBJ0=;
	b=2iBJhYqJzf7VA6kdqpGo4oMGoJpPKJExzfuD+sAUCgb+psoUIBUl2MUbC3TyrTx3s+iP
	 JbFWpHHVAdAxjNni6u5DopqsYsh6/cIsgY+YXYlBMNuNMoGM+1gMYF+nA2KoL8X/KO99+
	 JEgTKr+XxklNIQWP59Wcw48wi1M39t1LncQkjS1UBqlv9DVXNZDV/mzKsyEIYoyoWhkau
	 0S3dRqkc7arfzoXHZtymdiyxXsHPYZFEM9x4Ghs6AonkjnaVSmbhIabu/vVXBaOrhR/Fk
	 RlmT6NPZuIjnJDFgnda1huBP7BTp+PfPBdLCWRwZ6WZQW91ZY3PW+uxfMhR5ENZ0xYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv2ykQJR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36676606A327;
	Thu, 22 Oct 2026 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lv2ykQJR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B451F01828;
	Thu, 22 Oct 2026 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694335;
	bh=WQkgINckB0fJmUZDzqNLDWr3Ngk7UmXxI0iHqdXJBJ0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lv2ykQJRsZoLr5RA21HGxRidd9t+6UnzCfr2EMXy/D6o2naXY4tU+1Zku1TvyQWsD
	 hUClgY5lPf7yaFTm4OmJpZLuytXxYCyi4biQmTL+lmfcrXbcG+C4ROyv/HXaaIP84o
	 VlpcE9Mc6M/D4HvB0g/fPjNXI8lub1PWTk7Dpp/51Zgkl8k7fJUBf4u2lDoY0ifXbw
	 IclOnsGs3CngWk43Un98jiZxoKpE+cNakVyC6cc0NZ53Dyf4O7iN13F+O2g16GIU9H
	 EvUP0RTBrFvZ1E7HP+DCC7tEZ/AD4tE9z7q5d66hL4PAhKBOmeRZH+WSab/zdFUdkD
	 AULkbRjqmd+QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 075593808222;
	Thu, 22 Oct 2026 18:38:55 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261019113417.27994-1-ulf.hansson@oss.qualcomm.com>
References: <20261019113417.27994-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261019113417.27994-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.4
X-PR-Tracked-Commit-Id: fd9af27f6c2319713bb23832066585f8a59a1771
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03480653ddfd1b004dc622acb4fa913b05c3edaa
Message-Id: <179269433356.110555.1773604341913042998.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 18:38:53 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 19 Oct 2026 13:34:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03480653ddfd1b004dc622acb4fa913b05c3edaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
