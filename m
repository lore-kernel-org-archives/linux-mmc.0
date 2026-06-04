Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393E3C1F3A;
	Thu,  4 Jun 2026 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601504; cv=none; b=meAoecTiZn9DGf36/OmL4YNk/Y4VZXVEY1+TBKisp2G9OE+hWOn1V+qFqlzaTxEl+IZzrgbUbb4N9JgfDCN2AFcjJtTzHxAH0yzHSA233zShWyhOqUIF/HupdYqJE3wu0kAOnoDXtfV9YvxLlFV+V3/Wkq+jiRhAS3g7zazn0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601504; c=relaxed/simple;
	bh=pL9138SqjRVH8bfm1BbweBRizyiBhjn5H2sHPlzVP+A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RI7+Abal2eFSP1nrfWt+Nb/XqL+KV79JuPb+xQNsArxQVJmj1pgy6u/ffcKA7K++56fdbAjDCNyVOMa0nf2EA9PUo0XpIegRGl0ccSLEiA5EdUBSKr96n+CWn2NLEaFfgjDslqw5ptUtMeA12c5k1Dmvum8m7hZXBNd2zpgssXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIJ+6ofX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIJ+6ofX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3A21F00893;
	Thu,  4 Jun 2026 19:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780601503;
	bh=2kH17/ryewrawKeTyY55Vl4qLkF+6ZpE2JSQ3do9quI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bIJ+6ofXt3woXEVD+kakUxBs1Y+7ZCiReSLmNYFu5+2GsKfF0KIdiJmtiAeSPF5kQ
	 Wzmal6FgJc+wKrRTezYdyf0lOb6zhsPMseV9WnfuYjIvE2pH2sW9XMFJCkbosybxNG
	 hs3+XHpHU4rcJq6rV32/1ny40WtHUKIOm1CGjWYm2nkmMouJQHrW+2SiJMI/Abl6GL
	 PBeptvtOWCzDBQddITH9NZ9JcfBRnidbY/ddbEjIdJXfZ/8R/gIEvsF7mjloCg/+QT
	 Aus1KM3Vlz1WVDUgi+HkwUcYY3/cZtYm7nNReJaV+/NHrLnWM+K/42vr+Updf0Sk3h
	 fG7dq/0s8oJHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9398E3930A18;
	Thu,  4 Jun 2026 19:31:45 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v7.1-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260603081750.9423-1-ulf.hansson@oss.qualcomm.com>
References: <20260603081750.9423-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260603081750.9423-1-ulf.hansson@oss.qualcomm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.1-rc3
X-PR-Tracked-Commit-Id: f595e8e77a51eee35e331f69321766593a845ef2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9154c4af7829b6f82712b4d1a2a720adddacdb8d
Message-Id: <178060150402.2990765.6080616698810986855.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jun 2026 19:31:44 +0000
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  3 Jun 2026 10:17:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v7.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9154c4af7829b6f82712b4d1a2a720adddacdb8d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
