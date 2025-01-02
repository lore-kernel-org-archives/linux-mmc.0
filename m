Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CB917BB32;
	Thu,  2 Jan 2025 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843582; cv=none; b=hSvkEvm0IqBtVA7PYqhVWDrzgn2BACPUsiqOHbZbA4fC0wxPYx+aKaiDONkZGarow3/csWNxCickaOc2z7AVO4FKjIT4yxWbieQji1PMSBf25Ep5ErzqwOMQS9fLjy07MBjnFh97SIQ0BtBEdbjsHTNIkcC5afawD48iwSVG0Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843582; c=relaxed/simple;
	bh=/Sd/cU88+j19ifuJEz2A+pTId8QI65pd+3Q1cqya6Ow=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gvNmeddwmnqwLyat8AehZDt8Wou5pBeu5wUspFbhVQJ2gMCO0MsBmwjzM4uxzJaYWLCrU76k3+pz+sqnWkyybZNTBJC9QEX5qlQ0JeyoJWufl3byv9bYGVPlSBIIszVqfwnsrmEQOpIUv5gyOzYASJ9txUcTctu+DvQLHqGjP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rlvIF2LZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rlvIF2LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A6AC4CED0;
	Thu,  2 Jan 2025 18:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735843581;
	bh=/Sd/cU88+j19ifuJEz2A+pTId8QI65pd+3Q1cqya6Ow=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=rlvIF2LZPkziJ7m2ftOMtTu1CUHA0V5e3albpUs7hpSkYO2cbBic60U8GNL/l4BCU
	 Rs8OogHOKwfh0CMKTv0gzhd9NNEC16TUxngkwYlPeuOyCeK9BY0Oheazx8DJ9lijwn
	 ij0nwUq+9PDj+w7cnTibEAmAS/j3kt/UobaqRfnL6H2WytlO09V6MfS6Q2rV+HGJfz
	 ySWb/9OXv1K4GmfR/BAC/T6YJG6xdM42FgalWdJrDDt4Rmpj5pxY5kjjJtnnm+6ogt
	 NxGas/99pWxMPERYo2hfV0HA7lwixWJJC2bIlB1mMlzd8ueF0cINQD+y/8KS3F7jxV
	 we6YwIzVOArLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713C9380A964;
	Thu,  2 Jan 2025 18:46:43 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.13-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250102123712.49642-1-ulf.hansson@linaro.org>
References: <20250102123712.49642-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250102123712.49642-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc2-2
X-PR-Tracked-Commit-Id: 8d90a86ed053226a297ce062f4d9f4f521e05c4c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c2d370154bab85f7f6a7dbaa9ec11e052e042d3
Message-Id: <173584360192.2004976.12330369779356877602.pr-tracker-bot@kernel.org>
Date: Thu, 02 Jan 2025 18:46:41 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  2 Jan 2025 13:37:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.13-rc2-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c2d370154bab85f7f6a7dbaa9ec11e052e042d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
