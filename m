Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E613C6FA82
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Sep 2022 22:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiIBWHT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Sep 2022 18:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiIBWHS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2022 18:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1CFE054;
        Fri,  2 Sep 2022 15:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF1561E0B;
        Fri,  2 Sep 2022 22:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2868C433D6;
        Fri,  2 Sep 2022 22:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662156436;
        bh=OuOB4qF336Z0pTWQDjueuyIoEnMcKV4j5qiFMCruXbI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cVrFM+IxuPcYkv0NyAnjlhouXWPFJQAOHpPpLWmWUmxPNyFucal9Y07PJ+mnyf/xF
         S9ogL2yF2XFQ72MLkBSGfy9bGyc1wfgaSTeSjNTdd5pA8XK6yOChq/LOHE+BVCLFW3
         xhTBfbazptLR99Duiuvr4pFmmyLBvolSUP3AeEHNklMyy0+aYNwy4Zo/4GUXt0aMFh
         iekJwklCMMyq/XcKDEsNgzZrFZp3KDbSKb5ca/5PubCayRGKk6xd9BPVYXHues9J9g
         tcqP11NnlKJ1ITgfiVEj05R2bpyZUsC7lSFTeyRxJhqRELOxpdi6zxELusYhNK5jwq
         4Gq4ykZxGBPxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E774E924E4;
        Fri,  2 Sep 2022 22:07:16 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220902095113.499331-1-ulf.hansson@linaro.org>
References: <20220902095113.499331-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220902095113.499331-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc2
X-PR-Tracked-Commit-Id: 63f1560930e4e1c4f6279b8ae715c9841fe1a6d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b307e704574bd4187d4f46212e7ea8189b53f9ab
Message-Id: <166215643664.30372.12644831645226908131.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Sep 2022 22:07:16 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  2 Sep 2022 11:51:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b307e704574bd4187d4f46212e7ea8189b53f9ab

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
