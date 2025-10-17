Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34E1946C8;
	Fri, 17 Oct 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715214; cv=none; b=r7Urm6yk/Ia17S/zV4S5f1seelJcDebtSI9wnV5ZJ2HkRM+Bp6rnPXSYlb9gA9piju2/JcIOqloNAPB8CNEZtVh2YdQTjWpyTmUEDqCiQxdt8dnem81JKNX+MzWswsBLXU4AdHGzagqGWA/hUTVMhF+Y5x6r+AR01tN/JMO6uoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715214; c=relaxed/simple;
	bh=iftt+y+aCD4w6z7xfWpwahxTvipUyBnuKM0rRRgctR0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jJbMugSErhoQZwIhfn16S9EnNaFj3wpZ1RW3vB1k8FowKZdrBtBLMim8/A2TaelXNp7yzN/mDeT6LqTqRYL7mCKmIFMvyYg0hoaQ+9U/N+yqi0ud2uoKi9H5v575rUbIbyEEPC7kPEbxbptq61PjkmsOseWEBekb4TW6AI7+XBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tquhiNgc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tquhiNgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFA4C4CEFE;
	Fri, 17 Oct 2025 15:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760715213;
	bh=iftt+y+aCD4w6z7xfWpwahxTvipUyBnuKM0rRRgctR0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tquhiNgcaCnwV8SfiVmmCYC3R1Fv+jyO5pFYfByRrkBuvrBViJC45lP54p4u9Wgnn
	 raqGzSLLSdJNaxJSMUQIh6cwizTxRRN0ppsucslSaMpMpRR4yc3pay7fkmmzRUw6cz
	 iTFNticQQLN5v1Vk8+KAkgbtJO3dvRPROkbBCzys7dD+RBknaouuZ4ywsbsDmJ92il
	 n6ZIZEbXg5h4I0g1El2I09pYL+2AXQ+cvquT7bsE/kaLAxGf8thJXVbpXgEfNfBf9W
	 /cqV15ZZrWrCQTOio+bY7vO0LX6Yjj3kCEUna0gfPYYOoJgbxv8+ZCj8VJyCoEdS2/
	 Io7JWPYx3VJHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE53F39EF978;
	Fri, 17 Oct 2025 15:33:18 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251017090508.78726-1-ulf.hansson@linaro.org>
References: <20251017090508.78726-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251017090508.78726-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc1
X-PR-Tracked-Commit-Id: 7e8242405b94ceac6db820de7d4fd9318cbc1219
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cf1ea8854e4fb1341c08f66e6c91da97d038ab6a
Message-Id: <176071519716.2672335.17854172781562681899.pr-tracker-bot@kernel.org>
Date: Fri, 17 Oct 2025 15:33:17 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 17 Oct 2025 11:05:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cf1ea8854e4fb1341c08f66e6c91da97d038ab6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
