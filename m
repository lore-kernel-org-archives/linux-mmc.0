Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20904C48BE5
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA020613C6
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhFKS1t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhFKS1s (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Jun 2021 14:27:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 71B6E613C6;
        Fri, 11 Jun 2021 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623435950;
        bh=Ys1VwAeLS28L8FGOEGkjS8oXkz09OfohF20m/dsxAN4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U8TEuGFxtsoZ+ObJnq0br12YClu+ruXRaYv7FdkFbBC70BMkGVLVS0wnHmolateKL
         Mj8XaJdVY4bjm6nxvBKObpC3x6K0v6Pnbqs3nP01CHr3ME21Bzjlzw4NgBlepxWyrW
         TGUaHR+NxDCoD+vzBtjelUXipqWeJ9J2K/qvZNMRrq6MwaWTJxUE+yBo4dYtXTgDF9
         w1GX4sz5zqz4dJ0hT6IV+tVt5mTIBNjkAS0Yk0DBAl2Dc3U36mPmACIEo6WvfXR22H
         KD4bZ0zGrmFfFHjqppD9Ou3MLIF7SYnZzBfNfz4yEND0UV/Udwc4bfwRxW49w0jZr1
         ql7MVaosZL7Bw==
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210611075104.153361-1-ulf.hansson@linaro.org>
References: <20210611075104.153361-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210611075104.153361-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc3
X-PR-Tracked-Commit-Id: 6687cd72aa9112a454a4646986e0402dd1b07d0e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f30dc8f94e4ffe0e0524fbf79cb6602f48068b4f
Message-Id: <162343595043.23611.17036879475575875804.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Jun 2021 18:25:50 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 11 Jun 2021 09:51:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f30dc8f94e4ffe0e0524fbf79cb6602f48068b4f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
