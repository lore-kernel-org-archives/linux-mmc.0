Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B484C43463
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C77206EB
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595626835;
	bh=K1z+HZg/XZvGVqNYfPR7utgZFfiAHX7DRG2c1sG9geM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=vQqvU1ujbCYA9SmWHo2H6ub5f6g8ucEXZbAk9qoA+GemitnRnbS7L1vY+NAGWrI6j
	 YWmdGRoKrviJ9FnIWwDLI5XBM0Szz3kvZXfLZFq0NuBKnGVLHziwdDFOH1TpMMR0zm
	 j9j50A48OvtuK/8rPpqgVQZqBRi1dTxX8NXP7BRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgGXVkb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgGXVkD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Jul 2020 17:40:03 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595626803;
        bh=K1z+HZg/XZvGVqNYfPR7utgZFfiAHX7DRG2c1sG9geM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lvcHKnzGaiACKDlv/6pAyOCWYrBLyZs/j2tKrYvJs5uQO4JHFJtTMejjzuN2aZs3C
         5kl9vaR8mJ8mdtX7QfpNFXs1i5ZDYJ+sJELBB9R1Zdp0nLhCjc2DNKxuWUsCGtnoix
         9zVepfpEg/4reJQVxdd/32osG6HbHYQvDB/NRZlI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200724110939.8934-1-ulf.hansson@linaro.org>
References: <20200724110939.8934-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200724110939.8934-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc5
X-PR-Tracked-Commit-Id: ebd4050c6144b38098d8eed34df461e5e3fa82a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b85bcb784fd84ef854f6a6d03a0c48c207d0b0ec
Message-Id: <159562680364.3064.6202479855336429042.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Jul 2020 21:40:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 13:09:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b85bcb784fd84ef854f6a6d03a0c48c207d0b0ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
