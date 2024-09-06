Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C88F1D7E53;
	Fri,  6 Sep 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649961; cv=none; b=rHW/zv10TfQs4BZCWRn7NZGP51yo2FSfEoo8J+Hy8tX1wEmiCQ7LwfmO1fkF6vxA3brfqUTwWBwWix2//C6mxwhMn33IN7IzDtPzRTALTW4ryRN8niKj9VACIJ2U3CPYg9PCYGThOMel2lKc/iFO0zjffpe2YU412dVFZ2X64iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649961; c=relaxed/simple;
	bh=szmDR7S0Un0/8RGo+4PXlfuzN6lriqZDzI4be7YgroQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CyYh0dHyIt38Celd1//x+4uSMPPF9PQmV/eKeh1TNfAaWsfh/qnKFDveNOCa38M4QlxN7kzeCNsM2anJsesfphZVPYzHdQvbxsA2WVu3n1PMPooYG7VcNvLPOuKIWUjIBAyoRXJJzXd81KuFnC+lYaMfEJFWABGrHfV/0Ya/7+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kfv0/719; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kfv0/719"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C76EC4CEC7;
	Fri,  6 Sep 2024 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725649961;
	bh=szmDR7S0Un0/8RGo+4PXlfuzN6lriqZDzI4be7YgroQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Kfv0/7199D17M7JIPV5wCJHRe4x7RKd/zfhmghSlUkSEB48EXNZxBgAX7dH5JN7N8
	 R3moBHhK+cOe+TyEynJo4iPd0pLf57NahUseBitmNkh+r/pcXdj5uzVU9Jgy7bHeWK
	 1UYU6ZB+WI9tJnQ/kMHrND50TRT86oDcAI+ns7KqvgbiygTyRKof/QqpRkD5pjd/eo
	 87hrqQD2EcsUoFLJRvSnkEywWaigOQCP8DS8SAlg8vmc7BLZiY4ykO+Khles+WVy97
	 dIG2VqfFqD99DdjPwMypGD3ceFmh++JVPG2zizXE5P/jwjt0rGbU5mA2vCRMFTZSL+
	 itZKVN3a2rNUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD93806644;
	Fri,  6 Sep 2024 19:12:43 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.11-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240906101456.198887-1-ulf.hansson@linaro.org>
References: <20240906101456.198887-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240906101456.198887-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc5
X-PR-Tracked-Commit-Id: aea62c744a9ae2a8247c54ec42138405216414da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3af2256adda212e3c3ff4773623a19a972eaf39
Message-Id: <172564996193.2497610.9264208111525615856.pr-tracker-bot@kernel.org>
Date: Fri, 06 Sep 2024 19:12:41 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Sep 2024 12:14:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3af2256adda212e3c3ff4773623a19a972eaf39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
