Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103A1D040C;
	Fri, 11 Oct 2024 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675229; cv=none; b=Xjr2QYgB5r7hg7DG0qw4kQ5bd9qNPE5c6zaL77vl1X1JVUgVEimtQneEpdc3ajWXpUFCEri+3takoI8hK0M3W3vhbA8KfoIA8v6M1YzSh/Xyr3ve2xUTcJgHuGzGj+w/nL84apa1Z+k+nIh3VfBKetAgeveNzQQhA0pX5NvbySQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675229; c=relaxed/simple;
	bh=xJ37platbkcxBTX091NPTak5iJC64da4gDrFcXVv3eo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IZMnhHbcyxYW5jS/LAJGhK4jQzr8+61cQ0hA3GhOZLsMGPw+o3ZhoVw3SfHdGtGIBsf4JodP2txhQG124o/E6sZ83TZ2IXDi2eVaACD7Lpa4+3M9CRHeh6I+0oCiEvNZNqUR8y25i2H3n2SQaTzWW/vJ2cMGFLgf6zxPcBwpWnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHM68CJx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHM68CJx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6807C4CEC3;
	Fri, 11 Oct 2024 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675228;
	bh=xJ37platbkcxBTX091NPTak5iJC64da4gDrFcXVv3eo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QHM68CJxJA8nW/DU/qQ9YSlcYqJ3aDKDb93X1IEZucNSdxmoIuecqZwN6JlA7msGl
	 IV+Iq+sIHHlKlZLKOJpjRFth6zLzWJfodJsokSrvJQG2VEFv1VRl2YGlmy9m6LGb8v
	 /jUeB2sy/o9Hy85PWj/Tv1KY7/6E2Qmevj99YEMPALe4cpApFILkqSgnmhhG5/xgvA
	 +tK+7jjWVqtkSvtzLA62KyAvGmDuuDuowVCjfRoXGZpHbf/uBXVvP8xkjGwvvknOeM
	 36iNLEB6WKruDPfBgh3w0VWXoBAt53P3coKYR9+Pvu12+i1ds8UvQebqf5uiPsUZeZ
	 uA+UFr25RtztQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE2CE38363FB;
	Fri, 11 Oct 2024 19:33:54 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241011101305.476157-1-ulf.hansson@linaro.org>
References: <20241011101305.476157-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241011101305.476157-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc1
X-PR-Tracked-Commit-Id: 27e8fe0da3b75520edfba9cee0030aeb5aef1505
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7351a8793d8dc7e3aca09f2d9ec624ce46c42a0f
Message-Id: <172867523328.2975359.11132739904544367696.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:33:53 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 12:13:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7351a8793d8dc7e3aca09f2d9ec624ce46c42a0f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
