Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2173EC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 14:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0493261213
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 14:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbhI1Ocx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 10:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241289AbhI1Ocx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 28 Sep 2021 10:32:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C4CEF61206;
        Tue, 28 Sep 2021 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632839473;
        bh=qPiKAu2AM3OFxYI94VV8CTi9/boRfGv5S+dSwa8efyI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U6c+ELuJmgrtrYADO7dH/hipDU+477SayaIXvdMGXCjgUA7iR9jVlt2qUJgMFkqf4
         BV8i40scVOG30es/Z6661wHXyy5e/Pt3DezFtAYGW6oQQoAuZ0n1XFhNcvNhFljVdI
         4RxjvJfBOpcNRHd8o5VhzHdUMf7NIDshE6gqELrATpFeVHq4lwqXtHaMjeP/kOrMKr
         nSJOc15SCmLq56MjHNksBkhmdymJRtATqx6w9cItmRNG/RsDQFnmJ5zexbnyMnv7uo
         oEoyVlx6acb/YzXU/bqfbyFsF6gHTXAP2Xxcori6bRi5XM6l5gfvlcjpw0SXgdzBTX
         MJsrmL9Ot6drQ==
Subject: Re: [GIT PULL] MMC fixes for v5.15-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210927211352.21266-1-ulf.hansson@linaro.org>
References: <20210927211352.21266-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210927211352.21266-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-2
X-PR-Tracked-Commit-Id: b81bede4d138ce62f7342e27bf55ac93c8071818
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c72b292de0b2865f21e5ffc9bed2b36b8c8e693
Message-Id: <163283947375.32258.4142840560346560882.pr-tracker-bot@kernel.org>
Date:   Tue, 28 Sep 2021 14:31:13 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 27 Sep 2021 23:13:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c72b292de0b2865f21e5ffc9bed2b36b8c8e693

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
