Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95A216391;
	Wed, 22 Jan 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572768; cv=none; b=hmy7olZB5oK4IhHaE0ugp1Q9ijBsFHk6nEZXnHCvz5Mfj91nrL/1uaLN2lfmulyyr8/FvdEGrAA6cJdZutywldv9U7F/QKuU8+m3v2rBAQXvHfkGECyrMCYvS7wUP0F1vD3S1l8W5ANGk4AlZnjDcgTNqYwRkZVE8vCYHCSVqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572768; c=relaxed/simple;
	bh=uDcyu3iB8YI3bMQfQrGs1rI3Ib747CIZyqsYvURQoE4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GSdvHHMskhyjG4HKTCtDJJu27YitzmVXPFTXFNFzGMqqMu031Rlu+/B+7ysm3OiagmGxBusoLQ7x9qffUikGTJeyCcorDTjbPxbKaRE/wjqvaJHfMiWqeJib5jQXqgcRm8PYR+2tiIb16skBofTPLzIDYkotzOsj+gDO1PAKyZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/5dYbhL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/5dYbhL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B219AC4CED2;
	Wed, 22 Jan 2025 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572768;
	bh=uDcyu3iB8YI3bMQfQrGs1rI3Ib747CIZyqsYvURQoE4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=j/5dYbhLj0P5lKqaJqgJJuol09qKsgEMZwfwEjj08oBdR/W4GkIKgEKDFta1wi1Bs
	 W/wnOdxGSd7xhybPm5edxgpHdn8uw2kOqJPVQd8pMNZYtoNmjh/6Ec70tof3e9GVyR
	 AE61T7EER5TxlnwXBIFBmrzrPs8YM3YrtbifMxfSV65/+7YKJ8JXZp+joo8rRewevh
	 qHj4ywz3zORdiCn8oMi+nZj/Ie1fXCTfvAcLBkRegdIKihkPnqsN8DQvEoYfYM7bPQ
	 xnfXSrbPZVJZsRm9FHIU1zGA1DPQhnWv/u/hnknqpzMEeid3Ai4+N58jMmmN5QaNbu
	 aGwgr9ziFODwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71084380AA62;
	Wed, 22 Jan 2025 19:06:34 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250120145009.175499-1-ulf.hansson@linaro.org>
References: <20250120145009.175499-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250120145009.175499-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14
X-PR-Tracked-Commit-Id: 20a0c37e44063997391430c4ae09973e9cbc3911
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2bf717b07969b6d9e9ba5bccd3ac778e9aeaab18
Message-Id: <173757279306.783272.6915691369409290067.pr-tracker-bot@kernel.org>
Date: Wed, 22 Jan 2025 19:06:33 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Jan 2025 15:50:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2bf717b07969b6d9e9ba5bccd3ac778e9aeaab18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
