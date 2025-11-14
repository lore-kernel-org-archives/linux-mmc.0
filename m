Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDE435E525;
	Fri, 14 Nov 2025 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156585; cv=none; b=Lhj3Au8ymEtPnz/DfSaxxTJzIkWrSyxfLYmfd9xd1g9LfaC64QbKswTT+kGxejqDdTWtbLYuk3MhUmo4bU+SgQgc4tEvNdvbQ5TZq/pOUnaIkZcjpU16wWfOI3zIVcu6ziaQcijJZNYgUQ6fdelFoUFvDG70vasImnZYGRgaeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156585; c=relaxed/simple;
	bh=JWzEnrgsNHKcOQSKggZmvaPEjqXJxlhfS/Mbp08oHpo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MI+XQUMsnViVK8cL3RLMd0ZGAq5hUVAtll+j2YcC35Ml1YoBBiZ2tnaliFi3/4kZd2TwJ4eA3kdFrp9+Mvg5mHBu/usa8sgesdk0El0zvyjDz1lCtAYH7CkKO3XrDt4Euu0h0ussGK7ViCPT8Ia7LDAlpY8KEOm0WE3OhCiKsYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2w1hf/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2w1hf/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E05C4CEF1;
	Fri, 14 Nov 2025 21:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763156585;
	bh=JWzEnrgsNHKcOQSKggZmvaPEjqXJxlhfS/Mbp08oHpo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K2w1hf/PixtYmxPwRyd6shwKu3kgoaD+SFL9KpZ+p6ITrbL1mKFbZzjtAywT36T4w
	 DuXO1WTpg+DAgELqXYwiQEEYxrGgXtdxexEet9adNJ6bWwM+Eq2wshwm8orWbn5K1V
	 7tQK/nSBHQ2ZdzICQQaUMYO5l2digv/4WK+FD2hoLgfRUq6oKEso6ObKjxNIUErZgb
	 OTiqSMU3r0Eip3RM6Kcx6peS0Br0+fclbh5ZA/ooL3Zkq/Vl0BG4W0abx917vueWAv
	 A0UWgTiTHw3RnSmp6M3UssVx+4yzw3supb8T6qWini4ArIoIOS4b0oiSYsuJ3tQrGH
	 LIwidmHy+F/8Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD613A78A5E;
	Fri, 14 Nov 2025 21:42:34 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.18-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251114162415.93883-1-ulf.hansson@linaro.org>
References: <20251114162415.93883-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251114162415.93883-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc2
X-PR-Tracked-Commit-Id: 739f04f4a46237536aff07ff223c231da53ed8ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ccc0011804d406493da6d97f913c43de842f1abb
Message-Id: <176315655336.1846194.3264795607521862760.pr-tracker-bot@kernel.org>
Date: Fri, 14 Nov 2025 21:42:33 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Nov 2025 17:24:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ccc0011804d406493da6d97f913c43de842f1abb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
