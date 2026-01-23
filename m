Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2B52EBB8C;
	Fri, 23 Jan 2026 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769203505; cv=none; b=Wl3ruu7QuVXsRotMOR7XUeyoa6orTPC1TWeszEqnWjqwW0Scpr7BMs5hxgj/7xtWD0i7eDCWUcbX6T8KTaTbfM5ChP/FKsNJtifAZo6inY48gG7qvqXg0ngjwJ588lENE3kJQVuIPopMoXNsOQ0htQinNffzlFUGHCZl2rWD94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769203505; c=relaxed/simple;
	bh=pN6r67huTH7QCj7hehbc1Cr+M4ntExShxAUwJ46t/NU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=AoXCOHPTOZmDehtB5QvanXdCWOyjz+wsH7FQiP8nUWDc4ynCQcz9dKO/hdDs1z0JyxVq6Xa74I7rDRYO3yVqM0BxeafAYwo6OX2vp7PQE85im9lYBO4x69mxpfMt7JyqnHq6RJINrBTfyX2qhqQ2+DSBtmd/7NX+HCzf6Yovdtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdIU5TJf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdIU5TJf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE9FC116D0;
	Fri, 23 Jan 2026 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769203504;
	bh=pN6r67huTH7QCj7hehbc1Cr+M4ntExShxAUwJ46t/NU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tdIU5TJf+mRpWV45hptwtmbR+Qru14kVteT/EmIm0MTXgWRxnalT1qsX7XHg8qnbv
	 SSlFFeufPk3ZXxiV7GHq1BP8VJAipnYhObEh/FpeHvlqArTA/nrxVtMXBT3SWU4cq+
	 C0W5VPnbzVRCncKH8IrVf/Tjifpn/qJ1qBdFCxdvhlpmWOtYawjGnkgeu9J1DbnAyu
	 bf+lN8iuOz5HdHrqGqODEUlkL1ZdcYujrt0MImtKZsyMLkxz6Wo4FNoIMR3YJ18IBm
	 aFV/IXGzO6E47T3IznJtctswo0QE6r/8FXdiABfGoGdLxEcw/hHZFpe+K3aV8hcehP
	 NqpmTJ99Sou4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C88FB3808200;
	Fri, 23 Jan 2026 21:25:01 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260123120454.244414-1-ulf.hansson@linaro.org>
References: <20260123120454.244414-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260123120454.244414-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19-rc3
X-PR-Tracked-Commit-Id: 5cfc828502cbd0c827113bdb5694c2658af2c37c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4be90cce60e60cf99c419b74105d217eec194c1
Message-Id: <176920350037.2720183.7047825118387582966.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 21:25:00 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 23 Jan 2026 13:04:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4be90cce60e60cf99c419b74105d217eec194c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
