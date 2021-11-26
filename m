Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC41C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Nov 2021 18:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbhKZSqu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Nov 2021 13:46:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50848 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242379AbhKZSou (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Nov 2021 13:44:50 -0500
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 13:44:49 EST
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3EDAB8285E;
        Fri, 26 Nov 2021 18:35:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPS id 4B3B0601FA;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637951715;
        bh=nHvLSDsMSum4XIzaG0wnvFxuR3N7HkPRnHuGHl7mECA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N4FxuhSZEKpuypLASqAv53tj9a1n4JYqhhv70/SM7UwXnErKlo2cPrn+pTV6N9oLE
         MI77vaBkCFvzY0PineMJldztlQxcnpePUYp1QunEshHLNTcd7jSzBNaukhHB+Nf8FB
         iwVLDd6X48GWnomULrot1V06eyXPvJ2kuQMqu1IzDloqiQwWoo6WtzRmlc6QhpWl4/
         CpzKJp1+csRpKkR9mwB86dIcyinPNr2CbIhE4q4p0SXL31OHbRo082Q7YlpAnRQ+7u
         oDUzaxe9DM5ZHpWpZrIOfHB6PZRiKCEDQWEQTyAQEPlfqDod6+nIK8gnfs8tldTDxQ
         i05Y91p514obQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 459FC609D5;
        Fri, 26 Nov 2021 18:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.16-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211126133055.27138-1-ulf.hansson@linaro.org>
References: <20211126133055.27138-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211126133055.27138-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc1
X-PR-Tracked-Commit-Id: 5f719948b5d43eb39356e94e8d0b462568915381
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d3e647926c0dd120612b2f9e698ee38d6156d17d
Message-Id: <163795171527.22939.439907213482730919.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Nov 2021 18:35:15 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 26 Nov 2021 14:30:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d3e647926c0dd120612b2f9e698ee38d6156d17d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
