Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EB2C235B;
	Sat, 20 Dec 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766265006; cv=none; b=l7yp2BfZUU0+8hhHsd3zcZMn9oXWBeQBEM7UqjpRRxj2YgnYvlTaA+S8l2h/UXD5AOXJ2kybaxtlpeHN+NuKfYhjPBEENF3z+O5uA3+6Tk4X5aw+vHW41miTtGzbnedDn3m0ZXq8fbQWoq7f9aWtQ6nlaLYin0mkbdHgKXnVHPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766265006; c=relaxed/simple;
	bh=YjWCInUKbck8R2MH4kUKtM9lrYAuycS0wPD3kWLwF+c=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VzYU3iqonLkVE2ZuRf0aIFJT9ixUxu93KM5/Hw6hkySJgEeJDqXbN3b29dCa5F6RCyGPD72OEIlnUasCfgsxPttm4VhZOGkdbBM+mW+7qE1e+Gp1OBW6jZ6nC4osQpa6qGHUgI2eeTLqdVs1AWwv9qa80qlhmH5ewJELkRz50B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPqOinPO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPqOinPO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFC6C4CEF5;
	Sat, 20 Dec 2025 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766265006;
	bh=YjWCInUKbck8R2MH4kUKtM9lrYAuycS0wPD3kWLwF+c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tPqOinPOJ3puAqOkmnrLZ9y5vMHVVbnfCRjcKfHM6WM+wp7xxPEEqKbMBqSwtNBaT
	 3svwOwLxNlhhAOTEUM6olvIlIBfpfGst91eDxpgGHNXq6izOMLr6latZs327qyP/CZ
	 icY0rqT10sCx8TSXwQ4MfoyNE7ogjqvzRBDKokMPvnb79kDs9u6bbcz/fIiI8AVv+8
	 ipSnp55zE7M1ZfmsHsV6iz5K3rWvZLuOdI1F3uiLHVswoyqD7wYFqyrBIeuzlhysWN
	 PYqG0B2d9bs608kJso3/hAO8G1ok2LMxHkKPFJMjKlRabNlWHkiR8F0wEx5zQWiP+6
	 6Bo2fDtnI8HwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3D80D3809A05;
	Sat, 20 Dec 2025 21:06:55 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251219110852.55175-1-ulf.hansson@linaro.org>
References: <20251219110852.55175-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251219110852.55175-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19-rc1
X-PR-Tracked-Commit-Id: d3ecb12e2e04ce53c95f933c462f2d8b150b965b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ed22a356c107767bf8d5a6a22ac79a293e65956
Message-Id: <176626481391.137737.10174520625399701699.pr-tracker-bot@kernel.org>
Date: Sat, 20 Dec 2025 21:06:53 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Dec 2025 12:08:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ed22a356c107767bf8d5a6a22ac79a293e65956

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
