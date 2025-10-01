Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE801213E89;
	Wed,  1 Oct 2025 19:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345451; cv=none; b=DpVe/OxEDUOecvZIUxxjkkX3RDFcpj3yH2cpWqSzvjNcct1MmLH4C4JrPb1FKbAO/5ky1nikohBv7E10lvGRCdeDPjXZ/JBfIiFnrPs/kEM72yjbLd4GWUnWJRmu29qOPeGaWJwxV2FEoKr83aXzJI5oGzWF4gqXQi0byEsHNgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345451; c=relaxed/simple;
	bh=XXVT/vVi9sfmOVve424Cs39V5+6vwd1qec161mg06CA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=H0mz5HfkmZKGnzHEMpzqwRfhG523+OZ2jufrpXeJTO4f8grV1AubbCLYt2TwW2Ms0W4EzCbKUApHTq27jZhIvu3dQFtUuYwcTyMJ2X4O7xQgrveiWzVFuTH3955D4NUAB0Fa9EmhTxTYf2OVbC/sm4u7WNhrdFmdQI+oFpXKIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poNwEUaG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poNwEUaG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A13C4CEF1;
	Wed,  1 Oct 2025 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759345450;
	bh=XXVT/vVi9sfmOVve424Cs39V5+6vwd1qec161mg06CA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=poNwEUaGfXwePAWCDIjyWqunVRV41eso3VDEwahOd+qLKjfFgMsREIXVKDAnSpDwB
	 MLDQ8TiUys2nE/XMhQ/sg+lUW5ayXq1HBSFuLIs1BMeQs1OwAlwrk3D6lx9XYZOFcM
	 kfFvR66PUKaab2yDiNIjLKORT8SGqpHfC1LqD4gmVywFwtDrEdVEdiWcLktX7NYI69
	 mH63Pl0fcw5croT+Hnpqnk53uEFs6SmhVkhKHhbHbltDmbP8gu2olcUYP2zLtaxYTn
	 aJTvSQNT5+ovq5u8VkNqkxzzT0P3FrY95clrZpg+hUCtPK6QBSzA2YzGGy+Hyumo1I
	 aCv9qWv0dxREA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7119739D0C3F;
	Wed,  1 Oct 2025 19:04:04 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250929124221.229605-1-ulf.hansson@linaro.org>
References: <20250929124221.229605-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250929124221.229605-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18
X-PR-Tracked-Commit-Id: 7aada81cd75ad844c84fb1dcdce2d67ec41763f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2d274536245b58a43753a23d84dfadc9df1df489
Message-Id: <175934544293.2583066.318912955221184702.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:04:02 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 14:42:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2d274536245b58a43753a23d84dfadc9df1df489

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
