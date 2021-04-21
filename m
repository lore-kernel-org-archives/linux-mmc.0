Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EDCC433ED
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F7CF61104
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Apr 2021 17:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbhDURiI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Apr 2021 13:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244787AbhDURiI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 21 Apr 2021 13:38:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A0735613D8;
        Wed, 21 Apr 2021 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619026654;
        bh=5+4v3LEA0IcW8kyPvMA7y7BMUzpNkwem4cJS8NDQqgw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IPDAU02ignKnys3aZhkiUG6urz0kS9R5mmF5zFm8aI5hZ0tRhe584DW0ANOQdxcNi
         g79cTQrjmie+zUbgszUOnVWrz0Brt+FL44ozQc2zp2jPJxPl0gzKRvDXUpShSNdhUV
         Rph6fB8O74c/6FrmvCkgJ+z4KxkHrARXvqtIc/uw9ryVf6xw78D1p1Kw35rU1FEmeH
         8v8qxyHXpUFdQqXFPW4yJPFnCAmwy2IU1Unk8SwnR026d82+u096V4otRJqrB6hLnH
         kNU1ErJMexFI20xfzq8uHqNkZ7cK11oUaPkhri3IuYUEAxRA2oJ3kdA7W2kw2PXvZ+
         nHIlIWjQ1uyYQ==
Subject: Re: [GIT PULL] MMC fixes for v5.12-rc9
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210421125649.186054-1-ulf.hansson@linaro.org>
References: <20210421125649.186054-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210421125649.186054-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc5
X-PR-Tracked-Commit-Id: 7412dee9f1fd3e224202b633fdfa6eeaebe0307e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 16fc44d6387e260f4932e9248b985837324705d8
Message-Id: <161902665454.13029.13990139235095475895.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Apr 2021 17:37:34 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed, 21 Apr 2021 14:56:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.12-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/16fc44d6387e260f4932e9248b985837324705d8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
