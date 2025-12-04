Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3E327C01;
	Thu,  4 Dec 2025 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764886477; cv=none; b=q0QCQTMYKWOnwXUx32XM3L1be74mPz8i6RETMNuxBsYOlNFfB36heGbxY8cYGch56tgfeRrpSC1nyppmRdBwUoXYmP3JuHxZEI+Hf4QIh49WQ4Bx1VIY5nUdzNd99+Ek2Acn8sqALL8IBZcIhmch6cjmBA1jljQxOiLyy2yPGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764886477; c=relaxed/simple;
	bh=j4QIX4ouTiQPWENVFxNnHxCHGbzve/eYd5z13np5CLQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TUFYUqwcAmVNBUbZ+NtNy3wtmmnfFQCYk8yCRAIgeYtw6wbrOoHea9DkZHXFE44CJlbfmc7E5r53LARrsccSb/8i52aSIJaW7j+QmQTtE4EN1dB+EVPuBwXsZKOI4MuCo3jjpvpoAwtU8Bvtq8a5tdWY2BltbdmfvmxIoJJVqJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNkmbPPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNkmbPPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39417C4CEFB;
	Thu,  4 Dec 2025 22:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764886476;
	bh=j4QIX4ouTiQPWENVFxNnHxCHGbzve/eYd5z13np5CLQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dNkmbPPi93QG+ubwnKY5JpfU6S2i0IVjeSvhzrE/0B3BLjs2oaRF7xt5ZhusWSGSI
	 HD46x3Gns22hf2URVM5+CHAI1Cu6hZQl35YVNtuJ2fjRRxfytZTWZxWzR9+RZJFncv
	 vnS4Riud5XB3kERRy64ey6Xx30kBliic/g76JAinXR2hHR3x8HeyN1wXgRkRNQAOLI
	 yJHp9ZPodnAPxNto7xunq80ZcsgTYPv5D1gNskEW69twurCdkUoTdM3XDaMq+AHTC9
	 pchs8eBtnlt+dZhWxMeONQb35wX/It9DaHdULN7i7llaP+JRAKW4P2cKUNqSfTZJq9
	 6rzCswYWMBdwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 799463AA9A85;
	Thu,  4 Dec 2025 22:11:35 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.19
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251202095609.42463-1-ulf.hansson@linaro.org>
References: <20251202095609.42463-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251202095609.42463-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19
X-PR-Tracked-Commit-Id: 79cf71c0b177c0e23d411e2469435e2c2f83f563
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd463c51a327d341d3ece63dd50e1a0f8f09c468
Message-Id: <176488629405.998761.9193457182914386064.pr-tracker-bot@kernel.org>
Date: Thu, 04 Dec 2025 22:11:34 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  2 Dec 2025 10:56:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd463c51a327d341d3ece63dd50e1a0f8f09c468

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
