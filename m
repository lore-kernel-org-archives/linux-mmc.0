Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31402580CA;
	Tue, 29 Jul 2025 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753818322; cv=none; b=HeXw8VtjyFTnKJqn0Tb1wxETWp716FJHfE7kTajJmWbNWOcZKJ8nD3GjAkcODxxHAbdyUINi5hbNMm/ug975SZnSzmdC8+FlkTwyv/CyHsRsxs3BCX1boDBeM+q6Yq/jimPDSh0OsDypeXiDHzarkvRqkGBApcjY63VMK2lH4GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753818322; c=relaxed/simple;
	bh=tUB2Fhmbh3awAhL9HZxVlPVJJ27Vuoi2kUqofI551kQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UPtLs4zezUeSPSTpLFzNLxvWj71pL4Q1IfD5CoyPnK1Cy7Jc2D7N36q+tfjUzfbiY1j0BNRAIOkNLzPLjNvL/46e0pPv7Kg0kzS2IRSQedefPim59/+Rd3tOOZrnRj0Gaplt2tAmrhvK8Z5mWz8jOsyD+C+gDuO9RKunuW3dmTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNHmDS1A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNHmDS1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32494C4CEF6;
	Tue, 29 Jul 2025 19:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753818322;
	bh=tUB2Fhmbh3awAhL9HZxVlPVJJ27Vuoi2kUqofI551kQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eNHmDS1AkUFVjNHnwSZ3freuLHYH5EN1TxC47J2QePWrXpuBh6iwcqrVwyh6QCH2n
	 KWkT5kreLI4tm/1Qen8eL2jdSyr3MF59JjQV1RQ61uTjhMJmli3et7gKZSRAcXs9qr
	 FYHeRIWgO7U7nfJz2zYggMkQ4sXg+InINqpR/BSEgb5dmVCzqQzbDjihAuCknho+Dj
	 zwbDTb7ACKRUcQrFdKhSKxEhBOed5Q2lN5GIc5ih5YUm5GSqG91bPC56rv/feIbY9H
	 8Lvo4ISjtYF3wHVIttq2khJwVavzvEL6VrcNF60WAKANVl8g0ohk8vUTivXdCxDJZ9
	 osM445fFzP9xQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD6F383BF5F;
	Tue, 29 Jul 2025 19:45:39 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729115630.16917-1-ulf.hansson@linaro.org>
References: <20250729115630.16917-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729115630.16917-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17
X-PR-Tracked-Commit-Id: c3ad4ec3fdaba1f5367dd15b5a2e6dc9a9cde3f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 854ff7923753009189a9e1f80d23ae9d407c2fb2
Message-Id: <175381833821.1616007.3094767557160488133.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 19:45:38 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 13:56:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/854ff7923753009189a9e1f80d23ae9d407c2fb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
