Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEF4C49EA6
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 18:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A876613F0
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Jun 2021 18:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXSEP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Jun 2021 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhFXSEP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Jun 2021 14:04:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 90362613EA;
        Thu, 24 Jun 2021 18:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624557715;
        bh=zSq6rLQqR0Touj1muonSExBUPkPjo+uMjoFLLKON1L8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n7uAvQyoiOnptDqfPiHBNnXlnxT/Z2mjVp6shrMoztAL4D4Co1bJsthEGK2NXbIVf
         Ws3FZuamua05rCOH2Flrev5Z1z1kC802wtZm+zMmh33tUEbWuY4444F0zRKhfr/dLJ
         GwD+3tlZjJPFwrH/9TI5+yobjCVGRogFVMaBpAho/Z3SEczuVen9gAhrn6t7InPJNt
         ZO5Bdqww0at4B+5JBy1RviWp4vO+gM0cXai+afLxnunx6Y1nmHmZESWOLErRR/udPh
         9lvyYbVIrZvdh7B8j2MdUsCaUbHVR7DCACX5uJpTowjQxFE62zJ1mq1oeiPMbhiT+n
         4pJiZfBPaTOcA==
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210624123251.191299-1-ulf.hansson@linaro.org>
References: <20210624123251.191299-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210624123251.191299-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc6
X-PR-Tracked-Commit-Id: 103a5348c22c3fca8b96c735a9e353b8a0801842
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a09d388f2ab382f217a764e6a152b3f614246f6
Message-Id: <162455771545.21064.12787242475804884278.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Jun 2021 18:01:55 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Thu, 24 Jun 2021 14:32:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.13-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a09d388f2ab382f217a764e6a152b3f614246f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
