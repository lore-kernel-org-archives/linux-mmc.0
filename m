Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1885179958;
	Mon,  4 Nov 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730743831; cv=none; b=fw1Tm8L85Wb6qyn7IwLQolzE1hTSZpmmYH6qjXvP/m64+Bx27F1pKA7gnJcucx6Ms3jp1GP3ITD3Ni+atjzdtFTSZvaua2r8GqUeA97L/uUQn+eEEEEaUNt3pzCrU1e+jv14o+QBeXXQwQWYWLouQALyBCKeSTHXcN77nX8ruTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730743831; c=relaxed/simple;
	bh=7Ma/1yc4JZtz7Y46Y/V22X3YKFdSP/qTqxQRxfByGOY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bc3xRUoIwy88oCpl+/e2eoGtkgmezoz3lZBA8wND0mH+g5PgTw9+B/GnX6rF3gpkkX6Mif7bcBL6eGyNocJYz3qCF92ECl2+9Ah9YWFHZ7lsvzmAJpE43CjMbZd7hz3mJi6sEfJvdwIhQO1TC/PO9amyLNjbKIJ6r7EoIFI1GwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai6vpFIz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai6vpFIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9271DC4CECE;
	Mon,  4 Nov 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730743831;
	bh=7Ma/1yc4JZtz7Y46Y/V22X3YKFdSP/qTqxQRxfByGOY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Ai6vpFIz0JHwGq28ILLlg1JHCTRH+g9vn6EZwuIvdmHDBCMOFRaD2suLaVeoFEGJa
	 PAh3sUlV+XOUAfxycDDUJ/XfCBxgA8EnsahP/WI49P8Gf6jncKuOOxrr0vPNPbmB/8
	 VyTQOzl5t5UnJMmjS4JAbYoTKm8eMl84PpYeLcor7p9+hm4hRtDR//gjEfeKh2t2du
	 WfkHBI/BStTMs44GqIU22RNLKiYTi1vuEcRcNPccUGZUXEflKMiFChe6WA1qUbEd4Q
	 qOEKQevYfhWb6HxcIC8Qrm52WZQcNP+wRBsJ6qqJjFMgjBsDuZu9sKvDPhqO1eVStz
	 rEejmp1PFf1lg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E583805CC0;
	Mon,  4 Nov 2024 18:10:41 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.12-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241104112416.51129-1-ulf.hansson@linaro.org>
References: <20241104112416.51129-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241104112416.51129-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3
X-PR-Tracked-Commit-Id: c4dedaaeb3f78d3718e9c1b1e4d972a6b99073cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 557329bcecc2f55e134db8974953b32b69db9d15
Message-Id: <173074384011.4157726.13115878784950291237.pr-tracker-bot@kernel.org>
Date: Mon, 04 Nov 2024 18:10:40 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  4 Nov 2024 12:24:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/557329bcecc2f55e134db8974953b32b69db9d15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
