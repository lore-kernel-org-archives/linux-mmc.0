Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E91C10F31
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Dec 2022 21:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiLMV4D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Dec 2022 16:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237650AbiLMVze (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2022 16:55:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036E725C67;
        Tue, 13 Dec 2022 13:53:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 930EC61744;
        Tue, 13 Dec 2022 21:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0722DC433F1;
        Tue, 13 Dec 2022 21:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968435;
        bh=fcHL+Xbp6bIVKzFVTHveJnDAY7a8Hhnzk9+oLCqFx3w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WnxChA8iwnks9IjjfLdXlMlk9DV0j8q9+j4flSdHvLfc/7UoiUcc5e6/jlyjE0K+k
         fLqpHvdXEXAheIcq0dOBUq89cuUzJv4bUTFcOWz96C4Thf9p6Jy19gnCCZFdcPqyU7
         SzN71WSDiV86KTLt0EJ1Ly1j4TDn6MdaP7LCSPNZgLVki4SL9SXzx+RMx6It6jhb+Y
         Nut7M5b8iPCSZPeB4l/UsfUPGCbWHbY8xYXM8Q6FMidmpmY2cg+gAMQKjDA7np2O1p
         MHrP3xCFg+vsi0Y+g7enk2jLdXHcSUxXfSiPRiKHAD4UX36fDLhSG7zhd/cafJihzt
         Pv4g06E/fUpUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA967C41612;
        Tue, 13 Dec 2022 21:53:54 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213103750.107606-1-ulf.hansson@linaro.org>
References: <20221213103750.107606-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213103750.107606-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2
X-PR-Tracked-Commit-Id: ff874dbc4f868af128b412a9bd92637103cf11d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 71946a25f357a51dcce849367501d7fb04c0465b
Message-Id: <167096843495.13204.1621559274438712810.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:53:54 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 11:37:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/71946a25f357a51dcce849367501d7fb04c0465b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
