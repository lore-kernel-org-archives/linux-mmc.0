Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA429D1C;
	Fri, 12 Jul 2024 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811561; cv=none; b=CLGB0KRpSBjl1yItZXJU4GQNYVSGS9j4UfpIXVeqSJwPB4VwYKV5BsD19iykDy7cUzQMuMGlrIZNYRvVFzHnoLXqC6jor37abdSSI/d8yvKfYx1ISLevmlqy1o/iCVuNMynsbe8vKvaEpLgAxpmabMpGIwxZwZPbJQsFFUDQdso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811561; c=relaxed/simple;
	bh=6HrSjXeu1/ONauaE0JaLnK/nAkgGdmypVik+25fhvWo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=T0BRYVuz3zVMsbf/pkgbtY3vaY6fvbDgMrx69IW01ZhSoWly5JyeRLM2QRXDillEgUtkd0cDyHwGeUjHSUAyf0iGv5pYWWpd4H7+bz0n3LrhXF6BsjyPWQuNdvOOkf+5ijwzOZnR9626kBU2aDGR1WFZnHF3SNQ/yX0TDHJS6HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H40o4Me8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H40o4Me8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6D2FC4AF09;
	Fri, 12 Jul 2024 19:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720811560;
	bh=6HrSjXeu1/ONauaE0JaLnK/nAkgGdmypVik+25fhvWo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=H40o4Me8G3+3ygzTe/aBsYrnXL77F0mUyiZm1iLAC76NXsIjQz7BMBhWIwnQ/m3GS
	 iUlpbdkoZot/KFo1YTRX6kVY/1Kzke2a6Z9TWuL5OltMeZiVBV9eN3KbQs6PS4Ba77
	 fAzGUdaRFM98OMdEUS4kRAeyS7IVO5y6hzD8E+12hPvkFyMhOUi3uXtvYvpmCGJPNN
	 3qOsM9dTBWcFDpRidpqEAKNs3CQX4rELHP9su0Qo1gHmBO8cGb6quz0pbVNNEAQblL
	 qH8xpundjiEIA+f5NJ2IPv7LAtsLtulms+pSuFUDdAseSn8JI+pNWKxv/oe91jreKp
	 +dYKGdWasJZCQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBB52C43153;
	Fri, 12 Jul 2024 19:12:40 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <20240712144457.169093-1-ulf.hansson@linaro.org>
References: <20240712144457.169093-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20240712144457.169093-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4-2
X-PR-Tracked-Commit-Id: 16198eef11c1929374381d7f6271b4bf6aa44615
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01ec3bb6ea6a9e5cbe18600e8613c717508b0a71
Message-Id: <172081156076.20584.10673710867064842388.pr-tracker-bot@kernel.org>
Date: Fri, 12 Jul 2024 19:12:40 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 12 Jul 2024 16:44:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.10-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01ec3bb6ea6a9e5cbe18600e8613c717508b0a71

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
