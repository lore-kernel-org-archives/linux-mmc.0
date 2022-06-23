Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10AC43334
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Jun 2022 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiFWO1Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiFWO1O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2022 10:27:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC67943390;
        Thu, 23 Jun 2022 07:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 621F7B823F1;
        Thu, 23 Jun 2022 14:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DEF5C341C6;
        Thu, 23 Jun 2022 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655994431;
        bh=wXp4b/fdsI8fouQID9fsgJBAuJKNHquWmIaZNRase/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fknNj4TcB3l9d5bSvBMwgbNPzVMW1ml5BWRnMxNSFo2CFZOA8A4M4uFDdbevUo1Qb
         ml9AvW1e4KF+Pmg/OK7YzfwSq934is38dzW1KNNU2PUC6RqXYXhSc3nqAkv2B3bVpt
         V+7v6jK+IFYWCDFMePTf3ikq9QtLc8Y9Z9keYz1MaW7NrvWZHw92F52jzUvbj8YmCJ
         JxBJZkHXMQ/qn55ZlA9q5WMZuQvhQAWaBKttl1HNKE2Fnk0N6FyUotYFiLhbWC2LiV
         Og2cqKLioDekJMZK8eKSy948RK3xTCsfY9k6nDD+Z+l+p0Yy/8GT3d4+IRmcYUji2W
         v8oF21X/7F/TA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1553EE73875;
        Thu, 23 Jun 2022 14:27:11 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220623115720.44690-1-ulf.hansson@linaro.org>
References: <20220623115720.44690-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220623115720.44690-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-rc2
X-PR-Tracked-Commit-Id: 89bcd9a64b849380ef57e3032b307574e48db524
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f410c3e000a3ced328b2c4c8bb6d121ff5572dde
Message-Id: <165599443108.515.2649624135065269135.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jun 2022 14:27:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Thu, 23 Jun 2022 13:57:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f410c3e000a3ced328b2c4c8bb6d121ff5572dde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
