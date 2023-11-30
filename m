Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D159525
	for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2023 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKFSx5mL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA749C433CB;
	Thu, 30 Nov 2023 23:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701386669;
	bh=U6pw7eD5IUkiLweoLxbArAcyN1wlQeOd/aLmgHZOjTE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MKFSx5mLN6zYS+XlJ1G2yMFerG3d1RHiI/XD2XTZfYNNWrhkA4gcYwvAsUbHnMrZn
	 D2CmK7ON2TA4PHJhX1luJqsmlKOQH8QnjIr/pZTnPfEHWSYaWLN0qCWReLSNey5RmK
	 BYGbK8fvac9X+dxrtrS59i9c8ufcSCCNKxIv4nf2zcK5dbvzmNknPw67oRh9Y2mygf
	 mP/jq0gUWDkSPX+X2whh6BthUiyXqAMJdiEjDgTP+u0NISVpnFv6NeGWItKBUnmxhW
	 Uz0BAypl9jGsB1FjCWHPaHjR1Jj9Ti5m1FZdXDcKnAU1nW8+NpFyBJcE35RIt2uyx2
	 SdeDhE9SfwHSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6EA9DFAA86;
	Thu, 30 Nov 2023 23:24:29 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231130104545.62755-1-ulf.hansson@linaro.org>
References: <20231130104545.62755-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231130104545.62755-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc1
X-PR-Tracked-Commit-Id: 477865af60b2117ceaa1d558e03559108c15c78c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 09443a144c1642b302c9bc329eb9475ae95b4304
Message-Id: <170138666967.16887.7822667056554033597.pr-tracker-bot@kernel.org>
Date: Thu, 30 Nov 2023 23:24:29 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 30 Nov 2023 11:45:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/09443a144c1642b302c9bc329eb9475ae95b4304

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
