Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5F9C6FD1D
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Mar 2023 17:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCQRjE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Mar 2023 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjCQRjD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Mar 2023 13:39:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA867C1BCE;
        Fri, 17 Mar 2023 10:38:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C077B8265C;
        Fri, 17 Mar 2023 17:38:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23D6EC433D2;
        Fri, 17 Mar 2023 17:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074733;
        bh=V1ANQfWidlpMWF1us3ofwKTkxFINmrQInMA5jQizvJY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VFYQb7PzoS5ciOx9EiKMOda+h0nFMJgxVOwdmWJtO8AXTY14Cs71YpNNXMOKMd8jb
         IuTzrj9bu5Ce9Jw6x+QPLcR3KVv9qkQwM75TNSglgrN4LtR3QSmMPB86MIoI1qa5Wj
         sRrRFAd/d+QBZSuHMYHutlS4ZBvl2YNYizH642Ybtr8Z6/oKfoZuRWOhB9k2Vz+q6Z
         UznJyg153maOZWsLRUa1eP1r+P5gHqlGJfoHafLC8mHDqs/RRp6CyCh43MWAaW7SYQ
         FDSLX0f06LjUpbNM5dDKHWXmOqSAV2JU8U8jgK0vQQauO5l/YxhA9CySlvn8PoyJfc
         /EgtBe0qQUbsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 133F2C43161;
        Fri, 17 Mar 2023 17:38:53 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230317092451.1616451-1-ulf.hansson@linaro.org>
References: <20230317092451.1616451-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230317092451.1616451-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc1
X-PR-Tracked-Commit-Id: 92771cdd90de64b15e65f3c88d6c6199bd5f33f5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c50b0ca9082a2b92c8afdf6c2e1637d7d6185c8
Message-Id: <167907473307.9394.6580491642058572883.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:38:53 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 10:24:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c50b0ca9082a2b92c8afdf6c2e1637d7d6185c8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
