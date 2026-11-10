Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333019;
	b=w8xpO4kiPaUFA4hkHlaOE4fZrSkHpvFJGVDNHfZXaQlj/79stQfH97vFmKECLOCLR77A
	 Eqo/b86xezi7GNh1idQDFukEtH2uVUJXt1fI1doTZjKscuE85ClKmuai4dmGTSCozzTOw
	 f+XQ5QDrE7Qn3Efxav5tZhwaP47VE3v4pBNFrcciaphYidbKq3JJcvmSrOqhUVgR0Sv89
	 j+9JEQBEX/tVcXILelfG8UHXWD2QiOVxVjlkFdrBVEf8LVcTp91QCcbYq+a2TfRmTTFE8
	 MvyO+vcbuUUTGJnk9r7/W1Z4uFLPeIbLLpL2JKny+HjSHxbn/QuVpWj16bGZpT7QIqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333019;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=KL79tYy91V/mkUV3vaDJ7M95UkrcwPbuPOae+TiwwK4=;
	b=sLy2t1SQGWlS/cWLL5qPYh+ns2KGA2odRa6K9yeAluhbYwoefsR/xDz+bOH07cKsowli
	 Xb3E9aNQJ62m8MQwFH8dmKcKcG2dRblSaKiDT2FAOWlkRgVbRdhsgE718KnP4o9uXIST/
	 w1JVui1nuV1f4k7ZM/5w+Wl2xzabA+9ffAeQmL61fLyGU0GCf0kpoftkZMbBU9YdWOLuE
	 O5JYYcKvTYo93HprAsTRstOtZYiaAnZ5iNNSXsqZlY+vLgc0kLl8/3qUerQzEqAyJHUdY
	 9yFbmQV9DG4O2chL+/uQT0L+hGiJ6oJEU/TKMIazuwWhO9L1UlQQMzkGqMuL/0S95iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2CYsRrE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC7B606A323;
	Tue, 10 Nov 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2CYsRrE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F8C1F008A1;
	Tue, 10 Nov 2026 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333019;
	bh=KL79tYy91V/mkUV3vaDJ7M95UkrcwPbuPOae+TiwwK4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=a2CYsRrEHB1eb3gJuanp3rplC9tqMT7fq/rrbb6ciwIokz6BaXgPOJ64WEmeL1TMO
	 uc6yz3J+Hj5tAz/4AKgNUg9y8csAypAKPKHdGZcr+EMd2xh+hSKUqhaPQNFdsdb4gN
	 yMvzT//5mXBflI5u+QHy4SzqQTgcv/cPWZuid3yD00p6OHfmpn4htSTmhtpwILy880
	 ehwDJ/mau3xoENkJHbqSJiIoGGqw7Mkq/vHTWyhmHWxRJ4XGMii4M2SfxB9cYMgG00
	 3s24mgWCFYauKRoOyZoMan2Olur2BVkUgaYl91HAEogUtqOFcPjSksQpA4Dc3rWPXT
	 lK8xPmrnrY5Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2CA9639D608B;
	Tue, 10 Nov 2026 17:50:19 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK fixes for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20261110112121.44583-1-ulf.hansson@oss.qualcomm.com>
References: <20261110112121.44583-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20261110112121.44583-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.4-rc1
X-PR-Tracked-Commit-Id: 6b8b1e8827837bf4cf1f87219038fddae9e81b0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7c68e9d5d050301548d93ccbccd644151ced269
Message-Id: <179433301786.4118775.11467957462618910056.pr-tracker-bot@kernel.org>
Date: Tue, 10 Nov 2026 17:50:17 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Tue, 10 Nov 2026 12:21:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7c68e9d5d050301548d93ccbccd644151ced269

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
