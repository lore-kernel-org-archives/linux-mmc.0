Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD132C001B0
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Aug 2023 17:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbjHGRV1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjHGRVY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Aug 2023 13:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383311FD8;
        Mon,  7 Aug 2023 10:21:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247CB62056;
        Mon,  7 Aug 2023 17:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87549C433C7;
        Mon,  7 Aug 2023 17:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691428820;
        bh=OIy1m4MnfGL4sodemqIlisylOyDsRd55K6Eb9rp+444=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pk7FKdThXP/21J/p+x2a+yq0pndzooLGaPtKk1SXpALG3hzOL2kJMTevarAaRohLS
         nAmCPW1pNlucjUZv9ktPRbDjuJVpqMmpI0y+OXAt2kbnIaOywwI1T9PhQaoEn/B7dY
         KlK+Ve0UkLkA2LoY5yaM6ALhJL/32zlaTt9oOPeF6aayXjlK1lVgZ6ReIqjFLVxFWS
         zALyK7jmmHXLwzhQ5BNoSsYLHIeruS4mbHLedh0Y3SKibhCqJRFkOe5+G3EtJRRh4p
         ui4K8pv/BOhXfB8PcGN7/4oHK5rjOuxSQmwXGwJ3ad5i9lhrtfaBpFlFMHvJqPJpym
         J01fUwJ4DgCAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 735DEC73FE9;
        Mon,  7 Aug 2023 17:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230807112802.7032-1-ulf.hansson@linaro.org>
References: <20230807112802.7032-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230807112802.7032-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1
X-PR-Tracked-Commit-Id: 5def5c1c15bf22934ee227af85c1716762f3829f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 016ce29713a0f276ce73e6e8172b9968e62e9b09
Message-Id: <169142882046.16513.6859006812098047854.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Aug 2023 17:20:20 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon,  7 Aug 2023 13:28:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/016ce29713a0f276ce73e6e8172b9968e62e9b09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
