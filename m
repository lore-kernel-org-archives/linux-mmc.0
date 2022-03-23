Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D8EC433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Mar 2022 23:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345720AbiCWXjW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Mar 2022 19:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241532AbiCWXhx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Mar 2022 19:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165070047;
        Wed, 23 Mar 2022 16:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78485B8217F;
        Wed, 23 Mar 2022 23:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42206C36AE2;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648078580;
        bh=r0t/LWSTRy50EZPGEgy6dJ6vuSnBZ2yGfwlmCVG7TBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VwqWK7uQgNX2u+t8F9/DB1V8UCIaMjgaxw+IX0qwohv2jUUhXdDcEVxaQaKffp2NQ
         BHCDoL2UILVQn4janvojeaIJef4G7e/ortwczdFRpjNSXBSM2LLqRTCRMw1DLXCUSX
         utSZCvhnxUXkajaMF+mIxjm6F/trSHFc1YmSQidop8FvNZ8krxTSMrGIFoXU66LWs2
         B6PQuPojAjiP6/E7DyIsPpwBQ/ICrxDkDFo44aN/20K1K9RaMrEkl5xyflLhKVm6br
         iO/8o84XDs8+kOBKyaDKngtTj1msGu3RCRE7tdAFDDoeUWuUkYuPK9EHy436ItbHwQ
         RsfJAp6xMOVsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E6CBE6D402;
        Wed, 23 Mar 2022 23:36:20 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220322114159.358997-1-ulf.hansson@linaro.org>
References: <20220322114159.358997-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220322114159.358997-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18
X-PR-Tracked-Commit-Id: dc3d879c6ffa25e90875237265898e49b2cabb7e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5bebe2c9ae0e0d3c6b25b8e1048bf66b1a3df621
Message-Id: <164807858018.14397.12936198691051486429.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Mar 2022 23:36:20 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Tue, 22 Mar 2022 12:41:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5bebe2c9ae0e0d3c6b25b8e1048bf66b1a3df621

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
