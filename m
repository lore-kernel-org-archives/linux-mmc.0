Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AEB206289;
	Fri,  6 Dec 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515455; cv=none; b=l/tYvzniFUvK7fSnNkw3jKDrdhIjEZgdcgkrL02GPNdDkuVMbqsP5lSJBT3NwdU9vc3ZTrpMvYpgbr65fNd2eQQyDs5Nj63haT/K4/CQh33xR1vDclsICHoaPkEtEef3epqSpK0PDpf8vPBR0ovU7CDBm6oVH0hLNt72JPxd4Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515455; c=relaxed/simple;
	bh=N0FjkOuP6bDUmeliU1YKXdGmwNklKuhXFmCJ7hR0Ndc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A1soFGYWeJ9600ekry5C7rFtEjr9kQuETiDvvNMwAnPGxwgvSJD2zyWjOkXtmwclfslEEOYdpehA7379x1AZ231DgQ1TghOkcr5A9+e4mg+S8b6HbLkjgFMRsAGmQIO+n7zPEz5CzSRLgMjYBGpNQmZDJD7KAQOBxXuY44ernxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKt0CHQ+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKt0CHQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F49CC4CED1;
	Fri,  6 Dec 2024 20:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733515455;
	bh=N0FjkOuP6bDUmeliU1YKXdGmwNklKuhXFmCJ7hR0Ndc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aKt0CHQ+9485LuahDRzgSguNyDIuICIx+cmw7UMwp1Yvv4ZxEme25XPSpz9Mz8lst
	 ex3UKnJ9f+wHj1IyLXn1d742OpKOGFM/Vdx4cOXt/ufRwDyyb49tz2qdTX0hQO5NLI
	 OOt0E4Xo7u14HtxjE+WNGB522kmZQNp6iz13md17ZCxqFrOlITX3xSgVTfiY406b03
	 l8QvGd48i8ydATkLsY9z932V6MqQ62rVviw/FRU07eUCJpitekHJtIjWuFFraoqQ+R
	 q1L3cnwFHEYMbowXxKL1lkTRTWQVF3G0OKGQMSDWbnTAE9Mv2dLXVqpLB9l2ATyvOM
	 ZdRPzmtKeizpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4E75E380A95C;
	Fri,  6 Dec 2024 20:04:31 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.13-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241206084852.119710-1-ulf.hansson@linaro.org>
References: <20241206084852.119710-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241206084852.119710-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc1
X-PR-Tracked-Commit-Id: 87a0d90fcd31c0f36da0332428c9e1a1e0f97432
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35b7b337ffad0bb708faaa24d8a18ab908565f5e
Message-Id: <173351547008.2778953.6441253511888687539.pr-tracker-bot@kernel.org>
Date: Fri, 06 Dec 2024 20:04:30 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  6 Dec 2024 09:48:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35b7b337ffad0bb708faaa24d8a18ab908565f5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
