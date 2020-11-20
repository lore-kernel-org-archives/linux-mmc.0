Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1409C6379D
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4FD24124
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Nov 2020 18:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3zf11Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731695AbgKTSln (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgKTSkL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:11 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897611;
        bh=02B3k6QjexeQA2cIKw9XCRvE4Hpb8lq480hhNevpsJw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c3zf11FzpcaBdGMpSkNrn0iD0f+cm8IQ0cleuzZpC0a68l1zrS6EucYYs5P7mwU/R
         t+lY2MA7cVysZF8+U6EibMBpt3p5BAgk5K2zILrrdGYxUVZ99dBeQxMZxVJSeSQkrY
         Cf+o0Sv8DF+NPTVMdPHNbmIvGNjZspwlF0fCpen8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201120105007.8184-1-ulf.hansson@linaro.org>
References: <20201120105007.8184-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201120105007.8184-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4
X-PR-Tracked-Commit-Id: d06d60d52ec0b0eef702dd3e7b4699f0b589ad0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5de18678da02d893d2c1eb149583fca23c96584a
Message-Id: <160589761120.4306.20063113139135083.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Nov 2020 18:40:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 20 Nov 2020 11:50:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5de18678da02d893d2c1eb149583fca23c96584a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
