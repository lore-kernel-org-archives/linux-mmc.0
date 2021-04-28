Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFA2C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 23:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFA7613EA
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Apr 2021 23:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhD1XNz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhD1XNx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 28 Apr 2021 19:13:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E05686144B;
        Wed, 28 Apr 2021 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619651587;
        bh=udMy40ledJM+547WKcZOxJlb2KlhdU0OlbnagIchKqc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vFPhdFviyDXvNgaK2dCzQi5hsJps85rdnQf94qFPCgHb+Wz77rbWIkjCwXxwS69Lu
         HiAGwzxaYp3fgSXQG6LQyUQatAnZjJWSQBNrFMlDdjs45K4Md2SXGz0c3hJIXH3USP
         3BTYTF7IHV1cBFAx1jbpBjCjVyBfS/SrtVBjAY45bi0UovK9YembwEc7jQ5GfX6UCM
         DeHDF55ySZiAK1hxihCdOanqctzT//rCeDVEMudQQWZEr93/Q6/Kk9M72B7zG0/Mhc
         EXrNf4T8hqwPRYlXRNhyqYP1IoS/26ixneKLv4JXkKoLCPhgmKdAnzKAcd/KhjVzcN
         p1fjPjj4AfKQQ==
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.13
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210428084833.72831-1-ulf.hansson@linaro.org>
References: <20210428084833.72831-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210428084833.72831-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13
X-PR-Tracked-Commit-Id: 97fce126e279690105ee15be652b465fd96f9997
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be18cd1fcae2ed7db58d92d20733dfa8aa0a5173
Message-Id: <161965158788.11634.13615151012436325079.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Apr 2021 23:13:07 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed, 28 Apr 2021 10:48:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be18cd1fcae2ed7db58d92d20733dfa8aa0a5173

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
