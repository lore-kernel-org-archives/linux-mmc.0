Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5B2E8DFC;
	Fri, 18 Jul 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752864588; cv=none; b=T8qlRKgraXrIixWct9ogxVhQngu0TXWoQ8LvAPhA5vQ8fN1LSVCsLNo48jh4Q0Pu/WEQuD4R/IIAAnv4bocVa1yjFPY06UUi5+8ri+6k2Dcfn8HVXc3oiYoZ/IeoRjD2le2LzWPB9+dWgQSrZeo/2nPagPDyNcejU9hWGmkxC6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752864588; c=relaxed/simple;
	bh=7femQTNZpyQ5EA7oULoaTn2gmixlWWUxBzcNXu/sQa0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Iye1oocwDaaNiUE0aBHsjjgY5yU9v8zNu6TMvByn4MWzTos0xncff3lZf3Nvi30OjVx9lu3UH6C4ADrGjBrJJ6XI52CuUxEwJchRewH2I08SInLUyyQpn/ftPYySuAHCN0+pOR7frmM00SBRlyqAeCkx/7kVioyGJmTOOj4/ioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajv5+6TZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajv5+6TZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBE4C4CEEB;
	Fri, 18 Jul 2025 18:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752864588;
	bh=7femQTNZpyQ5EA7oULoaTn2gmixlWWUxBzcNXu/sQa0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ajv5+6TZqb/TE+cZ+IqqXQYn4r+q4BrVGTbw3ZEnKeQ+Mtlv8igxwuWKDXbBFp518
	 uKvKGyC8uOs2XsxPLJurUp5Qy2aGcgyVXXb9jtVTyT3xygJ8cEzYjHYHDIJWf4u6Fp
	 y9pCdnGxQp7IrdUuKX37HwbULDvYXQc/IUUDP2Tc2gWqHo+/oEjbCbPVAtzS61zA2P
	 8kR29yfX+NZt96BspA61zz9irYkKuyPiL6igwppOg5mpstGUwL63kE7fZFRBldrX8L
	 /pOTMjBnxR6b3Uy2VoVOLlwoIUcpFyoO8evYM6quDVIW+oCJDCTFMydgLeH8fF5w4B
	 np6lck3mvB2QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 011B4383BA3C;
	Fri, 18 Jul 2025 18:50:09 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK fixes for v6.16-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250718114731.81879-1-ulf.hansson@linaro.org>
References: <20250718114731.81879-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250718114731.81879-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16-rc1-2
X-PR-Tracked-Commit-Id: 21b34a3a204ed616373a12ec17dc127ebe51eab3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a4e3703088546abca27e7319e2fb95569ccd59fd
Message-Id: <175286460860.2758816.13033166442229156778.pr-tracker-bot@kernel.org>
Date: Fri, 18 Jul 2025 18:50:08 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Jul 2025 13:47:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.16-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a4e3703088546abca27e7319e2fb95569ccd59fd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
