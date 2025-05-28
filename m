Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD078F54;
	Wed, 28 May 2025 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392188; cv=none; b=SZmtNh6KgbU+PGEMOuF77JaO/jBeESt32L7bu769296BP4v3dyjjMA+ZPzonD9b7AsQ00C4ehAt75B1x+pzOxnX+v3tu5b0vObR45whJNXkeK4+VFlOIKzMcfYurpfa1BViVgxC+GJTrAR8cib2S9Ndp+YayGhsC1HgXVpme/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392188; c=relaxed/simple;
	bh=OOzw/9gLBVWa3L5a2EoeiGi1y++Ll4vl8Nha9XSA/c0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=JwdToS/DdM0R4PZFMDJFM6OH9X3dpeAwwHiUOrGbLLPhx5NQAXTtsbOuJFYprQcv62cE6/EZGcwmpivCzs1PtqrPGP0ay/JussqvFcQtIbgcX37/2Xh2a8dss0/I8mabkdn2tqVYFQ0zOhYkdr5clzNcKa9EHd0Oz0+/ZefIP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhPHc6ns; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhPHc6ns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54688C4CEE9;
	Wed, 28 May 2025 00:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748392188;
	bh=OOzw/9gLBVWa3L5a2EoeiGi1y++Ll4vl8Nha9XSA/c0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=KhPHc6nszMV7Id0eXJXtrFexr9SGSNan4blxqfogpeJG0iMoIZ20UA/c1+Lrztc7c
	 Q0PX8N2nd7vx/yZAW+BucrNriHc8YJTQYYOxaTeG5sqOtIw8Ic68eeEJfDHD+ooz0A
	 sQ7fniXBEV9pS6iJZ5xYUtnHY+qIzgU5TS/RqwY9hdobue3Qm47GUqig1F63y443AN
	 hm+GcEoCQhlwGdqVnQxfUDbaQmqT0SsrZjYftDnAcv2LlasfVby+vEBtsfULlLCA5V
	 X/BHVRrVDY3WHPcXFCXzk4D3wj87JlBWBJJq7h/bGwSgyIVD1rtEVTXwYxrFfqhNtg
	 g652S277f/PUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE084380AAE2;
	Wed, 28 May 2025 00:30:23 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250527113353.209435-1-ulf.hansson@linaro.org>
References: <20250527113353.209435-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250527113353.209435-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16
X-PR-Tracked-Commit-Id: d2c6acff6386f43ed307822454b970c831c48f1b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 35a8b02e071a83dd2d42a8446a00a56f6147dc06
Message-Id: <174839222228.1837144.18311807369660071021.pr-tracker-bot@kernel.org>
Date: Wed, 28 May 2025 00:30:22 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 27 May 2025 13:33:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/35a8b02e071a83dd2d42a8446a00a56f6147dc06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
