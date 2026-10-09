Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25696318B9B;
	Fri,  9 Oct 2026 23:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791588594; cv=none; b=J1S0uyPuNQRd7V3Qo046IMqBGFDVD7rMMyCRqbLCIM1C5kaOha0Ab6dZTe14g2ERulEq8Fi3Vf+qHZWMoP6DaDfNReQcc5ikbSzubECiUygns1F28VaULCbFFP7L+JzsKoGVHSG0zb2AckFhlA0vOopqswzgOuPYNdwEi/NQRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791588594; c=relaxed/simple;
	bh=sNsnxJ5nerspRvGMRb2d4gtHNlvXJDk1Jd+KI7exKPw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oo39EkytN/3PGvhnAKWzauZEUALXBwr9OegkrLQxmVfNqsb/YFn0lI/eup/A2UarTbeLYza/l7i1ydnceFxyoU4+xqD2D0yywJTb4Xi070NRIv4v4OAbCzsWJJfC5m3NEQEEt0wFQUk3MJ9qCBxshYkqtzoCIhYPkjqqqvuDY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RiTgGY2K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RiTgGY2K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3E81F000FF;
	Fri,  9 Oct 2026 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791588592;
	bh=gJDZMYrKsEER88oY46DR3FSH8BTfPx2jRJf4K+PUCgg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=RiTgGY2KpQ5oNECUhoEcDLlTTJANPgYx6BWKvjl7GUW/tukKRK1n9G3Xwpv7NAq+j
	 juDp9MXqVosjm+BG9JRAPy6JJhMfGhzGGDtc+FfV114LstogvWiz/WLBwyfPE0odEu
	 I89EEzsDEt50z91uskbUnV8RpNmm/YGVlkiDmxy1v87SCi0urNVXYAcHS9DIEYHaNQ
	 ma5o0weeJVFERVpRnG85QQg640XbUt4PeRg0EBzhUUa+VL5JHY2jME+PgzzR1pb3YE
	 mtvJSLjga5Dxq8lopRYB4uEU+IB28WjqQXF6i5oOhScCcCwkWXgkGW9M1sEvGqGytp
	 1z8HIJukvyVTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B456F39263A7;
	Fri,  9 Oct 2026 23:29:52 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK fixes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261009134935.20982-1-ulf.hansson@oss.qualcomm.com>
References: <20261009134935.20982-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261009134935.20982-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3-rc1-2
X-PR-Tracked-Commit-Id: c96ca94425b076dc398d929366e378d1e22ec794
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b71ccf604fbdf78450d3b17b5d69365caba29061
Message-Id: <179158859126.1045673.3240390296011629785.pr-tracker-bot@kernel.org>
Date: Fri, 09 Oct 2026 23:29:51 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  9 Oct 2026 15:49:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b71ccf604fbdf78450d3b17b5d69365caba29061

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
