Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3A1EB2C;
	Sat, 29 Jun 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719678663; cv=none; b=WQBYDWggSHGTLY0fdGEN1gUO63c4PLHmjBpSuJzuIVuiwLbzKLIkWMyZ08SyOxQ7rsBSm7r8sVRx7DLC3kKPLWOCy3VWJfIY2/zSxksRXBU1no5YtOpFw3a7rZ1nBBkz+SvVsCJlGaChgpRVDLZGZbBG+ZYeCkOhcaLYUb9wzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719678663; c=relaxed/simple;
	bh=1bx0Gd6tLvtGTVGndqLPE9DkNcQ85hggMZPDdcDq4Ag=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=l6TRRmH0UvMZMKFBlqGKHbmi2MPIj0PcymKRm4sEs1dXIF2300SbIYmXD+ANwUZni0D6NYdMslCdRKPAMbOpSaLxwIhe6/LncY2VfwVX6/qoeH0DC0YNUOZ9Ce0q8GEKrJNkzGGv4Hbcb2P38AQi6WC3V0Zg15GocJwyryu7cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeHrv/7L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeHrv/7L"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C2FFC2BD10;
	Sat, 29 Jun 2024 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719678663;
	bh=1bx0Gd6tLvtGTVGndqLPE9DkNcQ85hggMZPDdcDq4Ag=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aeHrv/7LJ4eLTZICOZ9jFLS54laqVk8Mj8PM6teMt+H+pMe8c/+VLZytcNt8knd7l
	 pjTZptw4XbhAOfzH/ZBJAtFvpkNfX3oAGh++AgV3iB2Ykl4CH0dNl0fq4OppO7o6/v
	 8R8to+IDDMZhLScmjxTYUEZdn2xkMMHzhAd7nggB4V4Ne6HbI1pNFDa2Esauniymqc
	 ptYTw+s94XPAJoxdY4CE6T/zZUPf8H+wzE/xAVRUtK34rPSSB0tqAVVo25HNU+LgJa
	 ujHhGAWu9CH1ga8d7yb2PeO/6bbS8qBukvuEtKX4QacYqA+2U01nkXvcANkPF52+QM
	 425aPklccyWEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F393CC433E9;
	Sat, 29 Jun 2024 16:31:02 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.10-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240629092348.8191-1-ulf.hansson@linaro.org>
References: <20240629092348.8191-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240629092348.8191-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4
X-PR-Tracked-Commit-Id: ab069ce125965a5e282f7b53b86aee76ab32975c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a89385800edd98f06c6e36c043167b873671c1c9
Message-Id: <171967866298.13026.9545290367465242324.pr-tracker-bot@kernel.org>
Date: Sat, 29 Jun 2024 16:31:02 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 29 Jun 2024 11:23:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a89385800edd98f06c6e36c043167b873671c1c9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
