Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDA2882A8;
	Fri, 28 Nov 2025 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764347746; cv=none; b=XwdfrWxBvMOyYBv5QaqFNMN8RQvngiWELByFhS+z+cg+Fl+0Zj8dMipzsy2iZhmVkFziKfJsuNxpPIDTlY4iJM2AVnoBvVFwZxcGemkiNoqccPbA8PRQU0A7cV92CF12+BBkK5d5SNXQbQYXUIJ2MmqHoVQCOIMbixHETnVlSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764347746; c=relaxed/simple;
	bh=cnkRoqyEVxhP/jSiwqbry1gsoel+mhO4OcVeC6w933o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PeA9Tn9hAf8j1XheTox2PFgPfPQMNxTKPXO5z7N6Xmq74Wu4EKPkcJa2hjtQo3fPb9Yo5o0FGiQjZQLlHV56cWA3esDQKrl3SC9ZhCHt+2gpDNBFDxrwyqWQJD7vCQgZ3uaWJ0or3fA7y6yQGk0UXVmePIcvFrzQunGm5J98ZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cfw/cTWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cfw/cTWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51ACDC4CEFB;
	Fri, 28 Nov 2025 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764347746;
	bh=cnkRoqyEVxhP/jSiwqbry1gsoel+mhO4OcVeC6w933o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Cfw/cTWub6XHcJ73bgjAJVGxXw8t/ls5/3tmIGhnldLr6W9U0tO56ML9ZJin6ALE0
	 yoYJdxZFOJKzoCI4S08TwDDvBINiv9hupCmr5UI45v8O8V/x92QMPrH3akwmYqNsmT
	 uWXPSsuKWejcNem37ZG0c9Tb2BSM7v92xiJ51ra3DnWOvgcbx6EXfGEyEyP04EwC9F
	 EvwtyISL2CcmVWrIs0W3rE7ztO52QQaKZ4QGAgbRPCMQAOgyALOgakr40PTDrGjEwO
	 /MDSW8mQgNdnjCEcxJRk0hS53RFAwfGcPsPRFJdRQn3F5sg7c5gTDuSjll52N1uCOH
	 K5XXKu8nSt4IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 786693806929;
	Fri, 28 Nov 2025 16:32:49 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.18-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251128131739.8150-1-ulf.hansson@linaro.org>
References: <20251128131739.8150-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251128131739.8150-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc2-2
X-PR-Tracked-Commit-Id: 747528729c9b6733839f9c95f300d5bef95ee52c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4331989728da4e868fcda75bde872d032f5ce6ac
Message-Id: <176434756816.719139.8426441221663826591.pr-tracker-bot@kernel.org>
Date: Fri, 28 Nov 2025 16:32:48 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Nov 2025 14:17:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4331989728da4e868fcda75bde872d032f5ce6ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
