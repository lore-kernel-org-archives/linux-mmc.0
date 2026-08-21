Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3933F823D;
	Fri, 21 Aug 2026 19:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787339488; cv=none; b=ejRecKGXmUyaAUkB+rrdtGMXmWWuHdvKRxP5dGaUVdkbPPRvPFDxA8YD3JpX/0szlC5chdw4N2sSzNmOFHMI9SHV+0W0+ecT9xdJamBu3orpb20zAlh++GxV6OGRZQamfzz9PPPLLcfMa7GkWMGkFvclVGjTkdXZAmXUXfrHwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787339488; c=relaxed/simple;
	bh=DqIX4vgsRZShwXIdhvJ3Ar/cHlmRhmxrxaaNDtwmFcQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=GBPOad6YDTMNhMJHiHkfzThRb4RbOJWgEyXozE0B62cTpZD2N87Yq8iAKfMY3UiwZpLZ8zIYJ36xumpMGzNIdCJtbJnE6sVH24SJL64DuYoAP+7cAaE0M+dM7HdZqmbsyWYcq9qWKY+27dDthO2mVet141X89JF6koxyOE+ds64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ+RXele; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ+RXele"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410E21F0157D;
	Fri, 21 Aug 2026 19:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787339467;
	bh=M7lsBj8agxSQwW5HYllwEAHexXZVSPAKNOXbKDFCddA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=jJ+RXeleOTctdcWnsxPlZfHKW7kt0+87unW3T4nczSNXDEu1SqJ77Ql88QZmv6MX2
	 uYuHQANsWuBMNvKFDdJGguvXeAgWlpKVwB5ENNKR9CfNdqsSvBqoGDMwl5jOIWTIuB
	 w0Ji8+mQqCfP+v20j+7HJGTy6To9OC6Q10wEquvvzr99adAEL6pJcNNHwa03hSz+vi
	 dGEFevb0Z2qZl+mHZZXT55pCj4PR0OtxtFTadjf0JCqlBHyQZLjbSTRdsCkg8I6yRR
	 o75VISAxnqCOWYYDqgYULep9S3MEWAEEAE7dghnFOdzZnCYgw4zRBKxknBm5M3F8uB
	 +jc24XdtpmIBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 06416380CEC4;
	Fri, 21 Aug 2026 19:10:18 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260821124449.30450-1-ulf.hansson@oss.qualcomm.com>
References: <20260821124449.30450-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260821124449.30450-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3
X-PR-Tracked-Commit-Id: 35e689fb79dcbaa8d69cc4a58a7ad4d0d7346e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f96718fc1f6142038a3f836b83b12e5062576a2f
Message-Id: <178733941677.1438271.13729838209860314717.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 19:10:16 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Aug 2026 14:44:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f96718fc1f6142038a3f836b83b12e5062576a2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
