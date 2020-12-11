Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7C7C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 23:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B2862312B
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Dec 2020 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436615AbgLKWgD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Dec 2020 17:36:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436617AbgLKWfv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Dec 2020 17:35:51 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.10-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726110;
        bh=I+b6H3ztr/C7QIZ76TJNdcmY0i4oLSsod3bA1QMJ4uw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oCYefyOT5glWBgtHSgA8Ig0ckvYe75ZIUF2nsQ9aKWP/WQoB68WC8dedM3r74FjD5
         Bhf0BFU0bq00G7FkoIS0E3LoQRVCQbzvjzj5ggFpjUdlNtRJY9d+qaDNpmGXLO9/tk
         3m2QsC+7PALy3YAoAif9FLNDYmZX27rnBCGlilzKrZsgU+uAo8bexay/+DowDSqgp+
         UbuOKkcvTEc0g15ozvZdKOYFUGN7KjW2y7A0tj6M7DTbkvMxTIpuqGmP+knbYrZkC3
         bqXkhZniwrU+Sm/j7r4xNPo4MnqI7YJ9qegt08+cP6s8qAB8o3gfXkGhqa2Kd+NPBu
         1fCNH+FRXFPPA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201211085640.234657-1-ulf.hansson@linaro.org>
References: <20201211085640.234657-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201211085640.234657-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4-2
X-PR-Tracked-Commit-Id: c0d638a03bc5dfdb08fb95d0a79ecada25f40da8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1de5d12b769017f7354e7151ce1c26eb1d9ba2e4
Message-Id: <160772611051.9549.6561815923583066128.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 22:35:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 09:56:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1de5d12b769017f7354e7151ce1c26eb1d9ba2e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
