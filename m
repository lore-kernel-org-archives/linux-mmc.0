Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DAD14EC6F;
	Thu, 16 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876630; cv=none; b=jYSk4xoIYO7GeJFilBuHHEC/EevB3AVmu6RwFUD8CHRBd2JCgz7v5sr/Tsc2Esmdo74cWzT8HQkXK+sR2AvRpaXRxXPKoosHo6cDkd/sRTUZlBGKEyJBb7soKRUM0riwf4zeHXs44X1W0BcMg88SQ+fI4v3MTLB5G4GzKIFJ/7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876630; c=relaxed/simple;
	bh=6wx9TT5qJlGAXBwfJiOGgUpLZiAXL+P+zjmxdAOWe94=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rrZ/MVkAdjSJntpPNNJa3SDHi41AIO9rcBfsDVzt+TKEw03uwb7kOLEtyhHruHw4pmlfDuhMVD+XUeun4f+Q6HMjyydLpXLE/cLaq7Oi5Anm2doELKmTYeKPL/si71QhRSYTmqIjTtSx2rjol/GJL1Zh4QyhKKaSJSUBhdq5Q1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+wejWm5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+wejWm5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 654EEC4AF0A;
	Thu, 16 May 2024 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715876630;
	bh=6wx9TT5qJlGAXBwfJiOGgUpLZiAXL+P+zjmxdAOWe94=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Z+wejWm5hye8G1ILLYV+3EXD46M05dAUHq7wrCVzH5mh+mIGed/jZhi/x1A2yZmrl
	 H7FMxaImdeu+Dkai1Wk7OaDeUefz0DFl8V30SGin8HZuiaA/ldrpWMjv/j/6T6pyOF
	 mGEfvM2Epuh//ZhlQPI5fJynM8YrdFTetuCwK19tPR5pIglUJGLONXwl2vEI1OCcMS
	 VzGRAjmcSTKZjBnGzTq+Gw9D4l9nXajUaEsnfJjuVPq/9Pm6QKHoFeTJPuZHGLLhgu
	 4bVSa2ZYmoi5r6qKhUMtmKjTqUiZbNJUqtPpkFdrXRu7HE7JZEtNKXz5Md3SfNzk1H
	 s2o/nCYzig1tA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D064C43339;
	Thu, 16 May 2024 16:23:50 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.10
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240516152012.30550-1-ulf.hansson@linaro.org>
References: <20240516152012.30550-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240516152012.30550-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10
X-PR-Tracked-Commit-Id: 35eea0defb6e46b26e286066e0e77ac5d53e7fba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b06f7538a1bb6ad15969114e31be7a99420125b
Message-Id: <171587663037.28916.6045100576015693084.pr-tracker-bot@kernel.org>
Date: Thu, 16 May 2024 16:23:50 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 16 May 2024 17:20:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b06f7538a1bb6ad15969114e31be7a99420125b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
