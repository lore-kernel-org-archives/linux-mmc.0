Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD2AC4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  2 Nov 2023 00:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjKBAB0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Nov 2023 20:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjKBABY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Nov 2023 20:01:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B1F120;
        Wed,  1 Nov 2023 17:01:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70E1C433CA;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698883280;
        bh=hk+JptQnsi3+CLAj91MWgAhCkNlKk1I1hUdBp4uw6Xc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=crInoIQQcxb2FOAnyjwJf8iovNlaoHiUDR9R8DuLBKKARCRWH0gmqKRXF4Rrgl9/H
         c2khX3OgXPJQItNiFtPZ5yqlgOSJM9zjRvkyJWc5OjcsZpFKveOlceLKKfQI9i5qlX
         sqAH2SUgh49zYwqmNmQcWcYDM60ZZhoSf5+Y1xq2g0VWMHy+r5piBjYzpJNFjt2rbh
         XdzPnunF1M4NrZzZVVDnncXe18yy/bbd5CnjCTSWJL7RmP7KTi/q/7ot1pSMIK9RoP
         TMbp6eIUt4XYXSJV09eibDZu3xNZtkXUSHevVlJpazEsLmTx+AD+FmERiiMaoGl9k4
         7X+VhlVH7rYyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2918C4316B;
        Thu,  2 Nov 2023 00:01:20 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231101102636.5155-1-ulf.hansson@linaro.org>
References: <20231101102636.5155-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231101102636.5155-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7
X-PR-Tracked-Commit-Id: 5428a40a308f220dbbffda66cb01b212f88e9a06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40aa597c4a53f7269367d1b5298bd44afcdcf473
Message-Id: <169888328066.31464.3283208532679720508.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 00:01:20 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed,  1 Nov 2023 11:26:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40aa597c4a53f7269367d1b5298bd44afcdcf473

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
