Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832435B14E;
	Fri, 18 Sep 2026 18:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755117; cv=none; b=FrJENQKmEjKEjS9XhzBbF2Ey00SPNytzD+03DG2i4zzlJw/p5k0Ilp09gSCXgQrFEdsSwdzansVIG4c5bzMUy16TT8tgykqL8ebvWn/mECw7XnCjzmPeaVwic2Gddh6DzKSG2PZ74ZE/vAkf6MNal0WBS+HKOZ2oY1YTrV2ZE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755117; c=relaxed/simple;
	bh=MISxAlnKmYRQA4x3YjzAVVbb2Ur+MQSOOeFb9ebJA9A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=r/GWTrly5eHY1508oLK3mvNVpxMnptG5IVvgEf/brMQSOoIzFZJk/CwV4QV6eucHDUtIKXlH9BVH8m0GHqrLgu57IEwDFnSvqoMW6zTez/77sYKZO7XdfFdFUSqsZT0Ok1cNc3YnyVwtVP54PKbwONhXxAVMxOOZ0cKEQNX5ktY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSIEVJmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSIEVJmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A721F00898;
	Fri, 18 Sep 2026 18:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755116;
	bh=ZCRafYAIhwLXhuLoApl5Tphni0ZqjAg85SMgJcRLc3s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dSIEVJmDjWDfNcI+u69BTLttQyDS0VnGOmW29vYr1sq6lNAluB5mneP+0GlVScEB0
	 6uE1r7eRMMkBNBLno4WpZriWGpIxJCWlCGyuiUo+NxAntRLzZJOQv4EnE8t9AL+6fH
	 LLrSqe7uNZdbcqV4J6JRXftoSEYtxK8U1GlJev8sCTt9neEavZO1N8bF7eWjQn5F4b
	 dI7x46cEmz3QBvw+2gBJ92pHyTMep3ezmJNRZEoUkSeAtV/Sj71Fq17AiVWBOoghwl
	 xizDWSoSk7LmKpx/0U07GmoJPgtfA7qzvmt5/ALwpIzEL0yvpAkKB1fzKyD934dpPS
	 nsTbAmqR2kvAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 60F86380DBEC;
	Fri, 18 Sep 2026 18:10:50 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK fixes for v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260918114646.74669-1-ulf.hansson@oss.qualcomm.com>
References: <20260918114646.74669-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260918114646.74669-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3-rc1
X-PR-Tracked-Commit-Id: 4396d70bb7fec531bcf934fed016b2f3300c670b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cb0606271a9102f1ccac34e9fc9ee76f350a2ab
Message-Id: <178975504926.1083250.4911800354342228468.pr-tracker-bot@kernel.org>
Date: Fri, 18 Sep 2026 18:10:49 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Sep 2026 13:46:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cb0606271a9102f1ccac34e9fc9ee76f350a2ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
