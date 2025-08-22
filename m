Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8530AAB4;
	Fri, 22 Aug 2025 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869786; cv=none; b=P+2nBYlWFJkkkjyAatQCxSbJPlB79V+D5GyLtoDpTYSy+j6psZRQX3wouGjYrl+MGamAhiDooIETUnu9cWmT+FwzktfNv8SQyNhprblEHaH1tJyRENufaWaC7649Sx8tgrz0wp5Ic1CKTExbfiE6ScIyGhCfWy+KQTopajLn8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869786; c=relaxed/simple;
	bh=R6inOe+4m5U9pX9dImLEsbCnInt5INllWItUC2cBANs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tHWOLp+wFcSLZFUQdXR41MHpP+w2Z29IoOKd2AMdLK+f3y+sjTmhcsigdeFXLeRk/PGyy0eIBafhb/VWm8bzPQBpKGL2EQZ0q0lQX3BATcUypRlKdPS1A2aLYERFQG/BqSzXB2G5cebr10SJZXrR+vTa8bR0qbfWdUsdjQU2M8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAMSXnZA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAMSXnZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3148EC113CF;
	Fri, 22 Aug 2025 13:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755869786;
	bh=R6inOe+4m5U9pX9dImLEsbCnInt5INllWItUC2cBANs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MAMSXnZANfDJ4fBNB6jrOmE7aeV6StPtPR6WR33zYoePaRLJv3h/Qhq8Yq3jVAL60
	 Iz9zfWQ/E8zzGCzmTH5Y4qwecA+WTV0ypqgjZA39civaf4y0fbvWfbTnYjrKJmqx7A
	 2WmWKxH5pOZ1zDQIKnXJf6xaA9hFCI8PFUKmm4AL/Bh6TXP90GSvFpoKiMNummj+Yl
	 kD2eE9VDNkNa4KC55syhmsLOFnbmjKmI9WQTTdxaK9UVPSESRxjM0tNtO2vt6FkPSI
	 VnbwfndmLEjnYR96phD/Z/7tyLL24jR/jNHCKLxz4RymwyrSdG1B4JKugY+llUYX0n
	 pyVz9kvYLtT7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E39383BF6A;
	Fri, 22 Aug 2025 13:36:36 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250822103241.233113-1-ulf.hansson@linaro.org>
References: <20250822103241.233113-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250822103241.233113-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2
X-PR-Tracked-Commit-Id: d2d7a96b29ea6ab093973a1a37d26126db70c79f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afd58777de7f87c5f6a430c281907f0a66fd08ab
Message-Id: <175586979512.1831455.15177164173252086070.pr-tracker-bot@kernel.org>
Date: Fri, 22 Aug 2025 13:36:35 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Aug 2025 12:32:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afd58777de7f87c5f6a430c281907f0a66fd08ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
