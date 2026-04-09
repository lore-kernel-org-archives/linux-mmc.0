Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39DD34321A;
	Thu,  9 Apr 2026 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775768288; cv=none; b=l+pMVxT4zCYDV8tolO6g2cQtEI7yIgcm991XkjxD1LAVcYudb8ze1imsYPE4bALpBMLnUe/Ael5pWzKuaCOTF0lxFlcj8p/lBFx5n6cEf0GnOJjCbS/EorJOVOrUGU0btEUh0AM9VNYX1aMIO344ItiQBjCgdBwDg4jZBE82AqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775768288; c=relaxed/simple;
	bh=xArcFWuy4pXhsUtgHyAMUTAZM+3jn3i7FomBmrfse0Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=NNdoGnaFETi4/3WC0SY1UwNt3M39ybU0mAPl/3n2CaP1Y5QP0Qek2LNhQG7hexhOEDX/gBHO8rCeN8PsCQi57ELcYwWw8VrhEKC4u4nwpRCye163IMN06vmA51+cY0WPnCLL+3rusPko9AXZpiAgjvDbg02eJUCNd0R+2bvWArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYgTh1RQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYgTh1RQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF0AC4CEF7;
	Thu,  9 Apr 2026 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775768287;
	bh=xArcFWuy4pXhsUtgHyAMUTAZM+3jn3i7FomBmrfse0Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=YYgTh1RQURhHMVgD9FsKHgSuLbtS7SEfa9+pbGL3qED6cC3Pm5oqxHarODtugI57o
	 FIW5aX2ylNhHMYl4vCBZF0UhYWSwdiorHCrximbwodNcElN8zS8cHCudAjqvL42gZN
	 2XCZ0fvOSt0/x/AOlSI12QeGnjrT6Wn1+JD72otRsAtxpBvjDofi2rV1VW8M3hNnnm
	 Fkdegwltw/tAnfW8k3AaQzKebu8QsqGBEmRl4gqXS+8+DQJgwvZtGMpTriTZXvLEp1
	 kqQUNxQYqz1423EfQ5MiR1MpGSRlB5uwhIXy4E6SOQ2v2TUvvcICXGGzP6lkKNGrkf
	 D1SYfMNeiBxfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC9939308B7;
	Thu,  9 Apr 2026 20:57:44 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v7.0-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260409152124.29346-1-ulf.hansson@linaro.org>
References: <20260409152124.29346-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260409152124.29346-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1-3
X-PR-Tracked-Commit-Id: 8f4d20a710225ec7a565f6a0459862d3b1f32330
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e1538b1f166e08e28740ec74fb79f05b8965525
Message-Id: <177576826291.1737704.10503591095672074381.pr-tracker-bot@kernel.org>
Date: Thu, 09 Apr 2026 20:57:42 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  9 Apr 2026 17:21:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e1538b1f166e08e28740ec74fb79f05b8965525

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
