Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522432949E0;
	Fri, 17 Jul 2026 16:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306017; cv=none; b=ZvgeZZQ1v6jcO1T3w54suP6PnWdU2o8JywJ8ewBlbBfO2vc7mZ8Ybr2eSL36xvuU6hOqlyEtWji+EeCCkL28OxUJt6jmB7XJuNRmLwFu2Bv2GiGxKI1uV6buxCJJm5ulLHg4rkMITkaa6CffvhEZRe/iCYDLUULAsE0EfXRGAx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306017; c=relaxed/simple;
	bh=dVn3WdoxsQm0W1yOThPeSl2OtbhnuKOg3QSksA/c8sc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=grB/Zp+0Rm9XsVIMihv5zFRmaHHp0/5MKb3nDWFTtdF/p6/X+pM7PCWISGfowwD1BurrsRkcdpvr+lQQ+sCLRVJUoGBBuYsn8SLpI0XuyPemdtiKa6LE9pnZrl58tOW2siWychhUvS3RxKs0qBcCSfT7tnk2/Btz2QD+R5o/Ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESyf8Mfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESyf8Mfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B981F000E9;
	Fri, 17 Jul 2026 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306016;
	bh=qRmCnxlr5uGfD54gj2ewF30zLXDDVphakyUd/a4RtKc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ESyf8MfnPCQFiJJU/Xa6zU23PiYz+tk0qyuTFMUa94A53UGpA6zozhesCuFC10twB
	 5qXP1lWJuI/Wqq3soMnB+RcRQ7uCQyICyReA5PMDWarOZxee69eL6hBMlgHYE99rzH
	 AoJHOLopcX/NHOsrIZPLsSubB29oYtXY6u09ZFrjaarteczrue6t1VBgmJwnJi8/fS
	 n4o5c1i5NySYYsLTT0ggeMOmQ1pTxfsVTqgmtrYdgOJBh67TCR2dpEkdNRuE2AaZDY
	 streE2P67X2CB+7r50SoCYp0ubCU+SFpvAWkkz9xfnWXDsuoYHPitzE6iiWpvGgQRt
	 poQcQpK7W2/NA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A6C380CEFB;
	Fri, 17 Jul 2026 16:33:09 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK fixes for v7.2-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260717115728.70883-1-ulf.hansson@oss.qualcomm.com>
References: <20260717115728.70883-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260717115728.70883-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2-rc2
X-PR-Tracked-Commit-Id: e27c946b589c53520409a0956b33d52ef7a0898f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 45419d06c943246229ecbc392f5d1038551e9b9b
Message-Id: <178430598809.1791299.4613031928583146440.pr-tracker-bot@kernel.org>
Date: Fri, 17 Jul 2026 16:33:08 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Jul 2026 13:57:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/45419d06c943246229ecbc392f5d1038551e9b9b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
