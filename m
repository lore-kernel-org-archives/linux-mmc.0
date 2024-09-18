Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E13185E7B;
	Wed, 18 Sep 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726649855; cv=none; b=B5KwLpYF73Nc3ei5Y4UEi5mmLywfI/Rl9v5XaIjIOWEGSEA/4IAOvKxw4jNrreDbSypzD78TJNp5eLNNyd7/+GDh62lzDr0l6uffiUjWdIYJ6PZ7rc+DbqSCFv+FkaTgZeU8TceEljzXiJ/si/J62tkj4WLzNwG6iL4NXZ7gPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726649855; c=relaxed/simple;
	bh=cs08fxo7QpyloclDJlpHPtOK4WVGhVpPkIeJW+MhTjE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eEFvigCbGsHRKds/FcjF2+XksOODfPs4BvOpvaiEMbzp3aESop8lKr9o0EhDqF1WZbRZBQukvIWmZKRNmj/fKhSXn9Ta6x3cmgOmTPf8pkeEFd3RtkvDHyjExRlzjlcuV7QJNeL3k9eCMEQTl8AeuCf91fw5ViJkoEOgvGrekqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qS6E6ad5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qS6E6ad5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365DBC4CECD;
	Wed, 18 Sep 2024 08:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726649855;
	bh=cs08fxo7QpyloclDJlpHPtOK4WVGhVpPkIeJW+MhTjE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qS6E6ad5+6i/7Z9KGboeGRB3Afmq4++AcIH0KQtGYxOaK5XVSG6PRBROMAjZ0Brq5
	 e5M6KaW3yi5MP9gdKs8pAHfNEzp1BWCf+jh5cqT8WZjifJy9HUUrbwxyFFLR2ICCM+
	 yXiDA5HBRX85X6sCpeboNHOM1/IXEZdW0UKr22ZPNV9jwAITLqB1OO1q4oqTpqbMgi
	 rGx0v2PUK6oEQW3a4QP6GWq1PEPJBTCAMEunpnn75ypvbjk7PYsCXUDQrOTQfvWs5K
	 Y9wv/oRkuMe2N8EuJi/WlimbRZt+b8XSBVVlSdYDxUUSZjqpVhzerD1/sMNFgX1DgA
	 n2bEqNxb7Lknw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A893806655;
	Wed, 18 Sep 2024 08:57:38 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240916145352.388340-1-ulf.hansson@linaro.org>
References: <20240916145352.388340-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240916145352.388340-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12
X-PR-Tracked-Commit-Id: cd3689b6772fbc1a4513934a5204fd2fa5b4426b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7fced2a78a26630a01f872abe21bb3366acacc82
Message-Id: <172664985667.725883.16991730870952307472.pr-tracker-bot@kernel.org>
Date: Wed, 18 Sep 2024 08:57:36 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 16 Sep 2024 16:53:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7fced2a78a26630a01f872abe21bb3366acacc82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
