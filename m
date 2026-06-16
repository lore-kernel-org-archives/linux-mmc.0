Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7C3B2FC7;
	Tue, 16 Jun 2026 03:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579438; cv=none; b=MJSiWRD2IIzG2kumirtNv7i09pn5LMhZadfbGW+qX6qriAEQYBOuinyyYWw8y5pQtvpHia3BBsjY0rkTjKuEp6Hhri8zwm0/4wVmNMl8f3dLfB7MIQJJLHGGDLDuuI5UIIaWrGXQNUsJaa4VlV2qOgyIha8mhrx5mx+Rbxg0FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579438; c=relaxed/simple;
	bh=z3yQ9bUD29G43LJDynE5uMN2OvMIHCazSfEaR78oBO4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jyCk77AvUuaKBTy2MhvVx5CHCBZ/owLSzl7TRO4GsZvAXA1isM95+ro/cSCl7jNp6Vh8vi55RLDjBYE1Z7FY/tg5KnBWS4jTLKy5MR4QHeZ0V+rl0QtKcaU0ZpDj+PyaS442vKU/m1+x3+a7MyJTIVfCeB5S/e7pYtv7lLRmOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osCJ0jWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osCJ0jWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF90B1F0155F;
	Tue, 16 Jun 2026 03:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781579433;
	bh=X5GN6zIa2rDr2crK9Ci9ZjbwM3XDVWar8z2pfW4BDsw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=osCJ0jWXTY4LOeMcAQDrrIm7vpCxSIkjuu0mi9r5yMatSAtdvwn2EIsPvKmXv3MyX
	 1r9AqA+vuDxMIYRt1ioH64g0W5JH+CpFL/h0YNDo8qA5vVyBhbK9Pn19qTpz3pB3bG
	 94gV9JftWrD9BwZm4F21r4XDZBneRiea1hpQnnzvhFPuSRDJrPAFponxR6zIRc4hpd
	 J506P+SPEhsUHMpKljwAALaGnqxZXvWI0LanZwDxvty/ZhwGfnIhmvJQSuo/8npDc3
	 nsK+mSr339FYXuMR/M3olGZD8uzc9Dg3MJyIgWCth4RdaNlx+e6EcfqpGlJKiHdlVF
	 8TTIf558l6Jig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0BB68383BF4D;
	Tue, 16 Jun 2026 03:10:30 +0000 (UTC)
Subject: Re: [GIT PULL] MMC/MEMSTICK updates for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615123755.10059-1-ulf.hansson@oss.qualcomm.com>
References: <20260615123755.10059-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615123755.10059-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2
X-PR-Tracked-Commit-Id: 576e40d20e100ba62e21bfda94ad948820c90a23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 464e2f089ecb81139433666496ecaeece421b314
Message-Id: <178157942882.413763.12346007891824394608.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jun 2026 03:10:28 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 14:37:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/464e2f089ecb81139433666496ecaeece421b314

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
