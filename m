Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB32EC77B7C
	for <linux-mmc@archiver.kernel.org>; Wed, 24 May 2023 18:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235375AbjEXSsT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 May 2023 14:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbjEXSsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 May 2023 14:48:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8728FC;
        Wed, 24 May 2023 11:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5795A6350C;
        Wed, 24 May 2023 18:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B83D8C433EF;
        Wed, 24 May 2023 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954096;
        bh=epmWzPzjdf0Vic0Q4gyJPQhDLWAK9wxtS2FF5EIjY6E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iKoezlUoDO4/TrHEs6q4RcRpmMCFF19a4rM/gtwRoRAeX9o73lNv9MzdT3VZbXkRi
         rOT9z9mOQmFvnWt3wfVvVJZSeOFMCo1Eh7ZCaiqBlmtpD2mba+meLsGjcF50XGeDqb
         bpxqHDyDaX+oJQc9ZkDP6qGOsW6smnttjb85hJGEM6oxrg1e5bUJIOHp2IiWnwyxkI
         uD/9T7TaDkSditcXwfWzW+b9bfQssqZ3LMWASj+ygBSc8cRmYPw2xttW240kmFZSKK
         xc0rBdo3yb9B47dn8hDOZozWQVFPQXEBh62TT5SN2A2F/eSUYu8FEe/9MqN+3mOQhI
         SQAY1LEh4U8IA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2171E22AE9;
        Wed, 24 May 2023 18:48:16 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230524085533.124092-1-ulf.hansson@linaro.org>
References: <20230524085533.124092-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230524085533.124092-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1
X-PR-Tracked-Commit-Id: 81dce1490e28439c3cd8a8650b862a712f3061ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 203fc3177dd7427a1f87ec33de201c6d67b5c5cb
Message-Id: <168495409665.10364.17771934925654379095.pr-tracker-bot@kernel.org>
Date:   Wed, 24 May 2023 18:48:16 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed, 24 May 2023 10:55:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/203fc3177dd7427a1f87ec33de201c6d67b5c5cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
