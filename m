Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A0A1CB329;
	Fri, 23 Aug 2024 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724456726; cv=none; b=Ez0eqN5e/XqGB+RzSgXYK/QQbSaOCV0DK6GpE9YC/em0fWz6Dcfhojd7CWMl/qWqmOOYacVnv5M34rRb3VIEkCShEuwmAvYhKmxArumtpy4y4lpOYWUuBtKg74+yQTRayyabp2o0Nduf7Zz5DXkiyqB3rZBjxRQdXe29is6ttaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724456726; c=relaxed/simple;
	bh=aqetwvMPxsppA79yW5pO+jugqfen6qteLEhxn6keNrg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N8IazYZwJs5LxLyTDVG4mHFT+fUBZLGYHcwqKmQ9WCb2NWV86abnADQmoffI3eXDSJowAFMLAqJjUlO1a8B48LfMZO27zlblXD9XibQ7vzSDXIP2z4Acu04+BYUPMx/RsL834JMsFZVNr7856jlLTAlDG5/ogXnsFlqYi7CMFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyxhfEKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyxhfEKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADBBC4AF0F;
	Fri, 23 Aug 2024 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724456725;
	bh=aqetwvMPxsppA79yW5pO+jugqfen6qteLEhxn6keNrg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cyxhfEKgp8viG8jV3w3HwtgC8L3Aoux8AwdQOoHTQQjCC1Vc8nuqlQg4uBjLVqQUZ
	 Aft03UzwjLnMy8qHcXgSUW8849AuBMEuzzcB5Lk6/Eyrf8HTiId8c9+rTxpTLAhtu0
	 hvGS6ujBGA112KoLl5OSFwZafcsNnw0r9wm63+yJsmhX+88NKzqqbG4+bljMW3kT+D
	 2mf9mPNoovqRmg0arbFzYNrEh5Iw2FlgxW0DUFzl4Aa7ZvBVq/eA5jytv5lhCE8QSY
	 wtKP2qIF8+dY1D1kFTPdLleiWPc2LshFv+QW41zkfIH/OGObaZKMQp8nQ/3YkxFXzP
	 miokicNAMOPiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE33804C87;
	Fri, 23 Aug 2024 23:45:26 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.11-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240823105301.397397-1-ulf.hansson@linaro.org>
References: <20240823105301.397397-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240823105301.397397-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc1
X-PR-Tracked-Commit-Id: a1e627af32ed60713941cbfc8075d44cad07f6dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f76a30a96cb855e025c5f15f3ed939950828c136
Message-Id: <172445672533.3112782.4595013481264635611.pr-tracker-bot@kernel.org>
Date: Fri, 23 Aug 2024 23:45:25 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Aug 2024 12:53:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f76a30a96cb855e025c5f15f3ed939950828c136

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
