Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B949CC433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABFC61029
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Oct 2021 17:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhJHRWV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233600AbhJHRWV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 8 Oct 2021 13:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DDA7F60FA0;
        Fri,  8 Oct 2021 17:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633713625;
        bh=F7KYL0gGrl9IhTuyfazM+S2URCm30NR8DVxxDwJlB3o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HdUg1q/0vLpP8l9YFRwwRbAQ0TjToCkGL7Kdoe4o6pMb0YBQEzG0pBN0leHvIRsaO
         LSkLF1IvT81h5zT3UrF+2QDng57Nq9rihpgXa6MLPjldfc5QGEYRiTwW4y55zU0Xrh
         oxh/Um8ZaYCmrYW8/vatg4ooSlD44cTxOma4tUD1uS40iIK4OfQe3z+BbxIjj6AtZw
         eI7GslJ53EWyXloGYYzrcjPI0y8CUwWMLXXgifLu1eV7cAyRigjgFGhw44ACFdiBye
         a5LbKdcNygET+7tIyRRRRPphnXKsaj7wixCx7fiDyczJcPMrp3VAHwIBuMkZ2ePJUZ
         CEcwE0ltbMsHw==
Subject: Re: [GIT PULL] MMC fixes for v5.15-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211008084458.30104-1-ulf.hansson@linaro.org>
References: <20211008084458.30104-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211008084458.30104-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc4
X-PR-Tracked-Commit-Id: 8a38a4d51c5055d0201542e5ea3c0cb287f6e223
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c7e7050f876904e632cc57f7e842ae3874121df
Message-Id: <163371362586.20952.16548054462521378399.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Oct 2021 17:20:25 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  8 Oct 2021 10:44:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c7e7050f876904e632cc57f7e842ae3874121df

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
