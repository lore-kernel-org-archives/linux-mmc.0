Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E425264A77;
	Fri, 19 Sep 2025 19:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309070; cv=none; b=Fk7fpsOBw3/yTXdWoTAs9Gaon1xXkrlc+jIB0cmi/2Mcb7KvqThd3o9PUXGyfjskZwF73gRhTO/UOHv3y1JGw88HsevHp6zU5aQbV2LlFuZ0M4BeYYIAuK3FSbMtF3h65hkO77aP6O60gt4G9U0syrI9M918mfGwECZe7yky7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309070; c=relaxed/simple;
	bh=Rh7IHKpMt/9sWFrKE7pmSlw2jayweqCqtPQdopF0wls=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=d9d2MGf3TPnfdf2xTb0oFqxMwZVNhFtaUmaZdGYD6k04AcqMXUcAfnU5rkfAChvNKm4Q379EZQTpwA5Q2P1NTfmf9mvx8nl+WRQU1vbQYGis5m52z9Rw9P2Ws68oc1EYY7/9e7C5MppifzRcamzOxbZmIjcRH7pZRNfPt5dcRuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agZDBSR6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agZDBSR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E45AC4CEF7;
	Fri, 19 Sep 2025 19:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758309070;
	bh=Rh7IHKpMt/9sWFrKE7pmSlw2jayweqCqtPQdopF0wls=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=agZDBSR6lEGIgGGGi801w6XROoC2WMargyxHmSQSDbM5FteUI3B1ulXCx02OM6Te+
	 hfZjP/P6AbTaiEwFEEzfKfelbOICJ6K553row+gKSByM7fLD7su3+X+3Mvoecn7b0t
	 byQanSLQe5Hqh8UTqCAaASZLtvBt0YcoNGLjKkDdmMl0HED3PaXVeA3C4RFXH6q+Rb
	 g7hgSTT+87FAeaPohebBFojkRQAI4gT3nGdQejgzUyZ+8ab40yOvWEKhbcNukU9U75
	 cdjtEqs8prMvP5DLP940DF5mN0wZsIg2z2XSREVDXMBosNEqFqUswdX90sOvN7flqe
	 82QhJqMeRAOqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE06039D0C20;
	Fri, 19 Sep 2025 19:11:10 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.17-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250919104057.152796-1-ulf.hansson@linaro.org>
References: <20250919104057.152796-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250919104057.152796-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2-2
X-PR-Tracked-Commit-Id: 77a436c93d10d68201bfd4941d1ca3230dfd1f40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffa7119cd1294dc1814e582dc07ffeb953ae7b26
Message-Id: <175830906923.3669786.18174875098601188675.pr-tracker-bot@kernel.org>
Date: Fri, 19 Sep 2025 19:11:09 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Sep 2025 12:40:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffa7119cd1294dc1814e582dc07ffeb953ae7b26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
