Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9EF42065;
	Thu, 20 Mar 2025 17:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490115; cv=none; b=R/FPKKXl6kJ5rkSiGQMZDLgW60RU38bb8DN+6QMaJoQttSBSgK6Ih5ucG5Z1ET6ghAl2NtMNu/rEElwPLr1Dll75BUBgzTAVuEVeyclXbbVE6iEmjkTtmNmAbBcvoMatUIyTdQuO8BrBniiWJ3uWB1IVz7evJuqEnfO7w6dzx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490115; c=relaxed/simple;
	bh=QJRZLtCY0LhQxoSraJZhkscJd5nDB+e14n4uefG1DC0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=U6RC1Q4uwaTocpLe3Fi5glKas6qbleOyUVoK/hdtPxZZ6sLol0C7JWbENQhkiwU4cBR+CDIMX+J1dfYzVg7yhZUuPJZuQz01RPB8c/kDTVkFj70YpHl8UHmJbd/IVhMwCw+RiikpD8+/HivPcCoHgJLuyRt/787g4zGfWTKKiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIWmWkIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIWmWkIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C2C4CEDD;
	Thu, 20 Mar 2025 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742490115;
	bh=QJRZLtCY0LhQxoSraJZhkscJd5nDB+e14n4uefG1DC0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=DIWmWkIs+Ay27TxKkqJxhQXo4mu9jLeVyl4/riwjvttZ3+dR4XhY1/EDHicFoEHnV
	 Su12sZ4G40rZAkuxtJgKjCL0b1RJkR6WWE/wc9G7wnxlUmdr6NS0E2i/qVaU+P+2Yz
	 r2ct7vPCxI01GSoy4C+XRtobFbQgRLyRYaern4jKQO0qGVUydE/iqaBKP6AJaQtIM6
	 ESP1M4SCS9G3QBg0MVtSXlo5LQu7aH5anyckwys/syUQB7p9XMB3VC0MHZ/E1OzAL1
	 sFkm+saEOIsmlSb/PiNmN+fmCR573BrHp6s4cEyzatuCNbf/q2q/qN9av6jq+InvfF
	 T972X0ASl3CgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B403806654;
	Thu, 20 Mar 2025 17:02:32 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.14-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250320141621.164515-1-ulf.hansson@linaro.org>
References: <20250320141621.164515-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250320141621.164515-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc4
X-PR-Tracked-Commit-Id: 723ef0e20dbb2aa1b5406d2bb75374fc48187daa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05b880b1dc66641222e8e189844a3cfd229744b6
Message-Id: <174249015105.1840953.854108104410938691.pr-tracker-bot@kernel.org>
Date: Thu, 20 Mar 2025 17:02:31 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 20 Mar 2025 15:16:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.14-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05b880b1dc66641222e8e189844a3cfd229744b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
