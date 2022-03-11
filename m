Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042AC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Mar 2022 20:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiCKUpw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Mar 2022 15:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiCKUpv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Mar 2022 15:45:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760A41EC987;
        Fri, 11 Mar 2022 12:44:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7350CCE2A41;
        Fri, 11 Mar 2022 20:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B56EDC340F3;
        Fri, 11 Mar 2022 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647031482;
        bh=PBjxc7AY//1jYO0ePlYxH9SVc1xDQ5rz80p7KeCHlUY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MSkNFAGOpWTgAku4C5dF9yjjPo6wHXUilUiNk4pGo98tUopFKbGtBrv0i/RXgOgM7
         pG3cUwvEO5P97apMpEK7lxQET0dYAYgUoaboU38V5earJd5luoFO669/ysjsu0wDp4
         oBBD5F3oocIhnqYTz6XGHAUhRT5lvQrOHaBWY7ykiRxNZg0rlw91E70naY0ET1o2DL
         MAxJSEXtk95JNFnG08Ixefe7HRJ9xdxKChyRmaUaqYXpsbdz5Z8c4FRJ8kP3dEz7BF
         5MXL2y5Nf2AXpY+RMkZlADuFI2MNHOq1YgwNJWajUj2WJuIkX9x+E05OVHK8WmXcuB
         2r2I036JOPrPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A379FEAC095;
        Fri, 11 Mar 2022 20:44:42 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220311150945.84262-1-ulf.hansson@linaro.org>
References: <20220311150945.84262-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220311150945.84262-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc6
X-PR-Tracked-Commit-Id: 1760fdb6fe9f796fbdb9b4106b3e0bbacc16b55c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3977a3fb67703273fb3d6f8647bbca43b3471d4e
Message-Id: <164703148266.12993.7303672109443671368.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 20:44:42 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 11 Mar 2022 16:09:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3977a3fb67703273fb3d6f8647bbca43b3471d4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
