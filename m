Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41B3A27E
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uv6ogq/e"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9B9C433C7;
	Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699646739;
	bh=/jl6i8srD7waf9oj8kIBuYntX4MMxg67ik6LqMlQt4o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uv6ogq/ep7kvaTAkjmLYG31miH+TwSz11LAq7kzHhtgXjQDqy3W4EFq1xve6foHvM
	 GYP4V1s9w+/8BT2zNNauBXvElC2EsmCCF/ZQ2OPUtG3nWBCSHtNoNBR5LO4I5qDizV
	 l2JW61l3xyg8lram8RahyIc5+T4IbXJVTpbfQrXsxP1ZCqg/8KK5t7Mt3Ju3kxbPax
	 W6N9Mn0ntLj19u5QAwTxx0N68eqL7T6Nbc+3oX6HUngv1DH11b9WfxUHbhUHIOjbkq
	 d7IzagE/l+IE8Ck8sJ7F9KLIdVE6W3Dc1fJVvp+FL2ihrZEo6hxiQvKHa9waDZjH6i
	 0hacM5KgHOPWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CAB9C43158;
	Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20231110122638.21897-1-ulf.hansson@linaro.org>
References: <20231110122638.21897-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231110122638.21897-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-2
X-PR-Tracked-Commit-Id: 015c9cbcf0ad709079117d27c2094a46e0eadcdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b456259e1544daa337fa00cda8bd3bea04c8d914
Message-Id: <169964673963.27739.1534219333572049881.pr-tracker-bot@kernel.org>
Date: Fri, 10 Nov 2023 20:05:39 +0000
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Nov 2023 13:26:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b456259e1544daa337fa00cda8bd3bea04c8d914

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
