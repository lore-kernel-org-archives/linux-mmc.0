Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7E615CD55;
	Wed, 26 Mar 2025 03:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961566; cv=none; b=VVpzEcSffGex68szGpj3WNstZDqjOJGSszMIUf8v/0zzzjB4+xpgzYrW3ba1Ysb14BqFb7GDN0q9tPkM/+uQEclzrgIL7t9WrnF6Q8uSj+o7x9S2CgLDAnjBUoyJtqVEtTfKkLW7JAK2Ob+U7mbJioDAD7sguIADhTxhCYn8LE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961566; c=relaxed/simple;
	bh=nZ1OzTKBGiiQgBCoJrJzCYaG0PlMP1aVR8mLEqH4h6Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LRYvf07GeENs+FFtep7mZD+ZA9X+F+/H72irmKm9QMpoAamj1Uq0j62qqd9tL3c5hRTfyESD91/cb+A0IFD9+qbb7LYTAssMvdpJFpz8fRPYBV7l5pyv/kq97iMoujvA5hEetdUXB/1MjnBiMPFixQgavu+H34VBT5TjPFlkSoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaRcs3cs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaRcs3cs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD9AC4CEEE;
	Wed, 26 Mar 2025 03:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742961565;
	bh=nZ1OzTKBGiiQgBCoJrJzCYaG0PlMP1aVR8mLEqH4h6Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LaRcs3csfd+ZFn149IumWgcc+YADU1f1ONAJCN3vAVO9YgPUGpZAAWlTjBVJiwzYz
	 iIkdnCURAclyUO5n+XPDCdXUeEviPK60QxMifQixodJSE4nhZJVkII3B6AcsZ4E5jm
	 lOrwUPzzGpYdtASQzCMOWSG8IpRvE1/5p0TpxgBWIGBr8/tzWSZcqzTVCqDqqE9MZW
	 Q/3/fu8YZS9Tse27MySEyPAUUusgyAVqmaNoR7JEBbdlCLPnNjtARjUkvuN8/jkwDC
	 f2fyxEuyX1aIU7enfGh3yvpACq5tlnrGvQCBQYZiA6YI93K9Rjt+IbDliCf6dj1YKe
	 AEZR31/9j94iA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7100E380DBFD;
	Wed, 26 Mar 2025 04:00:03 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250325101551.26387-1-ulf.hansson@linaro.org>
References: <20250325101551.26387-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250325101551.26387-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15
X-PR-Tracked-Commit-Id: c48e13e83513bd7eb4efffeeb562df9e4e1452d0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0163c8864bee0df6459fdb18ef9c0944368639e3
Message-Id: <174296160213.837738.8600253655342727990.pr-tracker-bot@kernel.org>
Date: Wed, 26 Mar 2025 04:00:02 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 25 Mar 2025 11:15:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0163c8864bee0df6459fdb18ef9c0944368639e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
