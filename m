Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81427C43214
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D1260F25
	for <linux-mmc@archiver.kernel.org>; Tue, 31 Aug 2021 21:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbhHaVtf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 31 Aug 2021 17:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhHaVte (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 31 Aug 2021 17:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6B4A60200;
        Tue, 31 Aug 2021 21:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630446517;
        bh=Ko/P9GbxpuZgs4rSJ6mM6VxsFME888QczXjXrK2/i10=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pA0siQSQx54t4w6jcw8X/z5yCRCJ22DCQEmbtpR33ZG+p1cVxK6D4RSqkRjwk76V8
         /q3N2aS8KHYDuQzpwD62npNtWt6SNuQhpMAFzBizcVzdY7vaUxh026TywQIA5lpXT/
         Gd9TNdBY0NUTbs254P63HNqPq8MPnZY+t+nF/DB92btgUqQH5WlQaFFiKFdFwM1GCL
         72OTLBD+ReNhwv5fCmYIKqgpBkp22uInPZt2QnA8kNwCHdxrc4rbpwruXI/JMZVxEF
         RBsbKPXhlC7N0MnGR8wXYz1nfd9JcEsL3fom/SqDaoMhYuSCmK24xiGYSLIO4It0ca
         wGFYTqiuKfguw==
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.15
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210830100856.512711-1-ulf.hansson@linaro.org>
References: <20210830100856.512711-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210830100856.512711-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15
X-PR-Tracked-Commit-Id: a75c956162978097c0a60d95971c97ae486a68d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 359f3d743f3a762cc2cc7ddb7c6fb4c57b9a06cc
Message-Id: <163044651767.1462.2797514515885449194.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 21:48:37 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 30 Aug 2021 12:08:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/359f3d743f3a762cc2cc7ddb7c6fb4c57b9a06cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
