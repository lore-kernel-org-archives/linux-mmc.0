Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948118C2D;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOTIQgzz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5E0CC43609;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705098029;
	bh=Tl7xxbPNs+Dv6M6mJp5Th3iQlW/Zzx9ev8/BbTpOm1Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mOTIQgzz85P5ygfkAWTWQa5d6cexzdS3jcDAZQVbo91NzekoKW5zdnPxvw9zCPH3w
	 QdDHf8FeAU+nN9z/06bIq8K377oFAy0jbtj+jA5G/BzBNcS1w3oXCCu+NTS0x4buU4
	 xcVZKayz/ThS9+LBZzD5j+UPl2GlX5VkhcTYad/6cxycm2FI/ujI4Th38ldf3/tgFH
	 o7eTi9Jqa5jVXg/e+sIudpGMzHZW3gXQOPU9jQDHLBcpUsPxfMJVU4CWyOP+rh63cx
	 +2LvbvbJbhWMwGotKXHZvudRFHMwB8clh011tOeA8934SC5vwDIH6ks4+krZBZhm+h
	 3sBPr1esB8P6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2E7CD8C96D;
	Fri, 12 Jan 2024 22:20:29 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240112121235.48296-1-ulf.hansson@linaro.org>
References: <20240112121235.48296-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240112121235.48296-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8
X-PR-Tracked-Commit-Id: 5d40213347480e3ab903d5438dbd0d6b0110e6b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20077583ccdd4db8aa626eae442e030d217901db
Message-Id: <170509802966.4331.12984215294426901707.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jan 2024 22:20:29 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jan 2024 13:12:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20077583ccdd4db8aa626eae442e030d217901db

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
