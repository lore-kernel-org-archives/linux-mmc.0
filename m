Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB3AD48;
	Tue, 16 Jul 2024 00:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091111; cv=none; b=TJd670YoLLhmgFu08KYKXBdgWOxThiwnaD1vcjA0zh7QzHk1S1BnWk2NfhPqOv7aB9Xd9Vv3WsugsbxFamUnsAVG+R/6wTEdoC+CvdwVpdzTCvH4EEVhbND0FMwiLnLMNTH5pwSuViTLC72QrzktxL9Z31dZYqZNRy405s7uOl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091111; c=relaxed/simple;
	bh=LKjxJtEWH7JtbP0KGfRCyAvion52vNsIM9SP4ELECBY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ny/2WgszOaNINthYyQHswGSEnPDmSaiBIF0DVJScJnVG5t8vhHzj6QMAAp1BvCNk9UAqT0G2578f0gjx/z7HhWWxFyvpvpKODeJTFYSVxBZ9jEdPFa20iTtV1rO3gtb9gWlmIfN/ED6xqsGXvTMpnTYTmJp5FoLEcGKyS0tW004=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jy45ihNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jy45ihNd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8B87C32782;
	Tue, 16 Jul 2024 00:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721091111;
	bh=LKjxJtEWH7JtbP0KGfRCyAvion52vNsIM9SP4ELECBY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Jy45ihNdLW03+RiciKU8TLATt2EpO+vktcR1eEnF2Yn2XIeXG5hIY8v8lElYWOJ0V
	 DIlPyEDtXXb8rnP2DdW7Dg5ViEYYaAUbxIjvPD2dhbZJen0DwNRqP0RNs0zJs8kVrP
	 N3Ooc88p2FrBm/tXFksw5fil8SqeZSu2M+l2iJeiOKYHXngiKVbqbAD2qppBQBG7BK
	 xlJb/b7YTFh3dkvxm6nzuMMa+oPCvy4BAkaCUNKSx/d1zATautUzLn+38+ZGiV2qNs
	 x58p1j9Afn2EkqyppWzI/uqn+9wrNN6otKeHNHnWihXCEj+rktXTd1qBqzEyGfsKTv
	 2VT2z/kjYUUdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B09E4C433E9;
	Tue, 16 Jul 2024 00:51:51 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240715104209.177921-1-ulf.hansson@linaro.org>
References: <20240715104209.177921-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240715104209.177921-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11
X-PR-Tracked-Commit-Id: b85e021853976aaebd3788e7e721020570754199
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f32ab146c557f0fd9060b03003d0d4b2815968a
Message-Id: <172109111171.26590.4591833387624605443.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 00:51:51 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 12:42:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f32ab146c557f0fd9060b03003d0d4b2815968a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
