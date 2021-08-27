Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F70BC432BE
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB4B60C40
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Aug 2021 16:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhH0Q5t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232971AbhH0Q5s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 27 Aug 2021 12:57:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 91C3660EE5;
        Fri, 27 Aug 2021 16:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630083419;
        bh=Q8zwkwLqtXiNvZunBJnRbGrIJomhuTUqV5oBqM87gYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jDfGmeDU3+jbAvAwXSZJ/n+ZLsVqBjuxnsuwjhAbXtT/RmPxbc3LFa+b/cd8tqTmR
         O+T1Bw1aOyxepLlsL70i5yS/kUbbqX7ZbBselR5AC1A4u8ykVSls8/Q2oBdtemh1KW
         lK6xM1auqht5CvlvqoZoaD0z9foOKGyecovN8cjdVVJhK8QaG4cx3F3V9tWbLce4+c
         OMOiNGfbHiVtbHy4WgYc39P7P5VTn+Ehnm8onPbzkfv6zgSMUBgiEHg3YEXr6HELJ6
         1hMvAZr+5Fyodk/WvFJD/TYaWYZFtifOFGkMgLYmeQjwNEZRq7cUWNF8mUizTacTdi
         kwnZqwGZgrOmQ==
Subject: Re: [GIT PULL] MMC fixes for v5.14-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210827144404.504978-1-ulf.hansson@linaro.org>
References: <20210827144404.504978-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210827144404.504978-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc7
X-PR-Tracked-Commit-Id: 885814a97f5a1a2daf66bde5f2076f0bf632c174
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a6436f375129a96adcc492013a466b934fcad79
Message-Id: <163008341948.31998.9462933030834600351.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Aug 2021 16:56:59 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 27 Aug 2021 16:44:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.14-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a6436f375129a96adcc492013a466b934fcad79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
