Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88184EB64D7
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Jun 2023 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjF1VKD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Jun 2023 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjF1VJb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jun 2023 17:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337492113;
        Wed, 28 Jun 2023 14:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC5EE61475;
        Wed, 28 Jun 2023 21:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30B9FC433C9;
        Wed, 28 Jun 2023 21:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986566;
        bh=AZxHpfSQrF/DjSXXFhyZoc08Kmf0zJ5ctxfyoxyeHNY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Kt2sJHRvJpOZcMQrAUlwEh4dE6o7rBJuXAsuqIF1kDtx7X8EbQ2D9cqStbvDViPVl
         hw+zfgWnuRi5NfLAjcA4/0EBoApMuUMKSvG52vDvgMAMZRFUPYUVPHWM/YjIyLUiaC
         oscPoVne0vMywm1J8b8mhcLh7yJbyoAoCx7gNqoMG76mpBauIKYcXnLih4uTFyq5YI
         roKPXth3mYmooX0E7lT44bf92FO/j/GoK3FSM23LSOjWHTeQQdOD/MKVjNDR2+Novk
         aKx8nuOlE6hEYoEm8qya8pFpGfZwmZfyHip1zIa+mayIU6A+4R2DKdhPiF2mMRPxqo
         UYUHq9HxLcEvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EF7DC0C40E;
        Wed, 28 Jun 2023 21:09:26 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626140215.83367-1-ulf.hansson@linaro.org>
References: <20230626140215.83367-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626140215.83367-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5
X-PR-Tracked-Commit-Id: 06b5d4fea89cd699408af12c14b6915d77ceffb0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89181f544ffa4da682b0145738342f9b78b9e8dc
Message-Id: <168798656612.29247.16007283910329563208.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 21:09:26 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 16:02:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89181f544ffa4da682b0145738342f9b78b9e8dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
