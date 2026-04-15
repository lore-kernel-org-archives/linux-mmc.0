Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC92386C1F;
	Wed, 15 Apr 2026 22:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290495; cv=none; b=n6pHyPfgoUJSSPIkYz3Tveac74LEqshBe+PUwJE8nBm8mHWKsxpQZ6dGiyenZqvr0YkGjBCd0lkAUI7OWxHj9GPe7KEqo0UbxFVEz8W+8Uyj5fMx6VJKoDmw1Tt82zmVwBfmkYJzHwFLVAIv9dmO9GifKUCtqZ5N+b3pYdieCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290495; c=relaxed/simple;
	bh=fFzj34F07wfedPMM5CeINuaS20KVBEq6aijJJHdflp8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oeEzl3gQyyA1IpOpQ/+8hNX6LbkwuTonWq1tVOyYTpJlCmPMPXiQuG5WHDbL1lJQLQpsshdRYeVXOGvfq0jkmbPTuG1xFOAOKB8jJ13t+CRKpTeKT1XwEhwp/rlMadlwrnFsRxDEaczQ+sWrAS9HKDinJ+N2yVfxK2lglQk1mV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtTkUinR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtTkUinR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54886C2BCB5;
	Wed, 15 Apr 2026 22:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776290495;
	bh=fFzj34F07wfedPMM5CeINuaS20KVBEq6aijJJHdflp8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AtTkUinRnLvlY0K1Uawm1JsoHlzzaWIm87BVPm+7mDawDmVB9gxzizZF6gUHuiDZU
	 SKHai4fj1QAqlNrJkJR5Gp6pkGQ3x3/rtVLdRv5OiWDXmyPJgpmmGLXOwKJBNs9OOi
	 Clh0Eur/xnjY77ow+o6GIdMJJsQ1BxVf4U8q1x64gVRXSdzgPsXvgP6fFPvbB51f/w
	 JvelsLUrm6qDpNBG2qydGkvKeKdJuFpuDQjFj2JPbhCwpM1KhvdMGtiONQlCzT70rb
	 5ymUBLYIJwk+8cuEA2TigWzdv8X/3SBTYmWT+25aPE8ekZBpHQQUB5bmbagobpRepp
	 KjPYQT7RkMucw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D4A74380A964;
	Wed, 15 Apr 2026 22:01:05 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260413115921.108815-1-ulf.hansson@linaro.org>
References: <20260413115921.108815-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260413115921.108815-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.1
X-PR-Tracked-Commit-Id: 52957cdad30f8011da1f4ef1338ba0339ca4c158
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ddd4f0651a710f33dfbb9dadd94f2bb0aa31aa8
Message-Id: <177629046472.2457809.14870292363022809043.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 22:01:04 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 Apr 2026 13:59:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ddd4f0651a710f33dfbb9dadd94f2bb0aa31aa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
