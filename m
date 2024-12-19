Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC819995D;
	Thu, 19 Dec 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627804; cv=none; b=GQhsWfRaaD+ys7fCGOpICjB8wnLX6BthwxjVsnidlOcBg9Wo2UZUKrxVNN5dP76dDFbavUsx/USwlcX+SX8gAj2HKWCQSLFSknEkg0e+BQ7wvOblNScY9szfqyy+LhtrvjC9NQJj3oSJNaOIkr3ZI/xZFZV3pKWqzTGKmicbcns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627804; c=relaxed/simple;
	bh=/CEQyw3xw53Wil1ESpXJ374YCzQ8F8GYx/Lzeu/dGdY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Oe9f58s4ARsa1MU2k46cnCcvfozEs+roeLYDP+f6rRQFJBysejLpVr0PfEJJqyAY2mHRvMjh/VL0czMn5oW5fqhj1buQZh8FMf6+HeBdR1mYQ+51VB099l6bKToMOjgNmpQRfRGfZrPZhJmMlpqRgU0N9YfhJ6Zte+jEKvQ/Isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwxSKT8y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwxSKT8y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2023C4CEDE;
	Thu, 19 Dec 2024 17:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627804;
	bh=/CEQyw3xw53Wil1ESpXJ374YCzQ8F8GYx/Lzeu/dGdY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=PwxSKT8ysYT/kRxGmGf+uTWL+rprWVveO9JO6VIDYJJq6SAbY7MEx/wVs0g1W6dQP
	 3O+OiRhk+hNOZSby0r87z2ebR5wLqkoKFbfMhfEMSDyHbjmz41KNl40dWvx3hXl/dP
	 V/V8xZ/LIfY7N53uu0PP3dWAgvAhfxHmYwfzxFb6IcOeCpvcSSVLvzAAq0/e+FJtYv
	 eGxHXAkFHltdAVkOGD2bxytw7NndmPOasEay6KhKHKVXU1m5GTILKAJ6t//S7QEGur
	 zCMJrwbX5D5TsTPQVOKrwbmANc/QO9TCoM7cKCByt6DkPbNh9S4Uoe8cCwxnk2CV+J
	 lJ9p247Ao3hwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7122C3806656;
	Thu, 19 Dec 2024 17:03:43 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241219134142.48554-1-ulf.hansson@linaro.org>
References: <20241219134142.48554-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241219134142.48554-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc2
X-PR-Tracked-Commit-Id: f3d87abe11ed04d1b23a474a212f0e5deeb50892
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: baaa2567a712d449bbaabc7e923c4d972f67cae1
Message-Id: <173462782215.2314669.6102889245755070222.pr-tracker-bot@kernel.org>
Date: Thu, 19 Dec 2024 17:03:42 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 19 Dec 2024 14:41:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/baaa2567a712d449bbaabc7e923c4d972f67cae1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
