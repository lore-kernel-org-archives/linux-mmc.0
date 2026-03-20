Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2A3D1CA8;
	Fri, 20 Mar 2026 17:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026840; cv=none; b=keKjVQyn1oOe5O3A2ySX8A5kzRgTWiNycaNQybHSLy5HS/4oDs12qPRqkDdZsQ+zNUiGwbMgMHj7Wq3/MJOl63hWCCrBTcvlhw8N9jCAwjQrI+likyuxJ8rkrHr0ChUHZq2LfJIiVuZIzGXm8GuzFGcg3pCQDzA+mGfhaDgyQpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026840; c=relaxed/simple;
	bh=0mYvGchEwHl5fKeu3IBZYuhqBMZ+7AWCm+gO4qlUL2o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=R4CaZLZhj3Q5H3GqkFYINj0HF0XzCuHs7R2YAMe7aNMyIjssuKd1uWI1JQ/zhwrBLTEwHf1UShq1K9KQoHgHbP+RSLSktakRJ7RZ7n4JT0Q3n5GkSCYZus6ikSy0ebPBMUuAYey+HDpg7hTDsLNZ0xOMB7lZyfmfRdpP1psAL/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR8HBBQ8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR8HBBQ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8231FC19425;
	Fri, 20 Mar 2026 17:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774026840;
	bh=0mYvGchEwHl5fKeu3IBZYuhqBMZ+7AWCm+gO4qlUL2o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mR8HBBQ8qZMtVEZtJeDntHl8J6lSnhzjVOJevb/gP0ISz+VucrIRef48W8L/JaZ1k
	 W9MVoDa21og/Yti2qBf6CMeW1Xhvt4mr8iEB1i6/KHz6A6iCe7hFaOYkbntD7BkxCr
	 Tuzcc/mEKmRl01PHQyvn/s5kGzsGo4CWBrMOrr2vGdMsq0rc3v1kJy0QM5EgH1n2F0
	 CVi4ybx56vdkRpRZwzWPyKSGnag0ZNytLi9tETIyiF8gCPtKvzax1efCx31eHt7tPR
	 +qyWOqtrUOaVLPogYOiCDBxCJyXI92GABcoXY79R6QgSaZPxyizBkJxt80nuii4SqW
	 l72UaVI1nWR2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB1380820D;
	Fri, 20 Mar 2026 17:13:52 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v7.0-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260320104725.2043499-1-ulf.hansson@linaro.org>
References: <20260320104725.2043499-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260320104725.2043499-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1-2
X-PR-Tracked-Commit-Id: 5e3486e64094c28a526543f1e8aa0d5964b7f02d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d07252736a6e946ca0cf4e7ce456eab5c3fd73e2
Message-Id: <177402683065.2580860.7866923066242892383.pr-tracker-bot@kernel.org>
Date: Fri, 20 Mar 2026 17:13:50 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Mar 2026 11:47:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.0-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d07252736a6e946ca0cf4e7ce456eab5c3fd73e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
