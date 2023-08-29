Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF84CC6FA8F
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Aug 2023 18:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbjH2SIi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Aug 2023 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbjH2SIJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Aug 2023 14:08:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F8AB7;
        Tue, 29 Aug 2023 11:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B16623B4;
        Tue, 29 Aug 2023 18:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A6F7C433CC;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332486;
        bh=yZDrS4gwI7Rt3+89dF3Quz8DOJV+Z8sVRzWJo1gAkYM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pWV4226wwlFLeMJJcwsquhFwx2U0P1xCLJPomuJb6AIPN8ZvxVvy0OxGUqiXMgHbd
         P4ZqjunQvOyhzNQl/lm71GgFQGdem3+a8BbRIJKb6WBPMOrDSE7gG+xzpWih94pRZt
         bQBAm020liFLzChvxYcrvngGPq8hpprWG97L4Q6kee/KG4ab4EAT+uhsFBCc60OFr5
         0+dnoKOV47u6fBa6kIEGKyIID9qQ9FzCBtCRmaFlhPoxqA9BQqhByimOPLfYku+K03
         gkDHm8koPW6wXDBTTxnKIlhlV14AoCE/cNl0Dafr/izNR2LiuRo7JVkJxRhQBXsH9V
         g5iLZNgzV4L0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 583ABC3959E;
        Tue, 29 Aug 2023 18:08:06 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828121549.285925-1-ulf.hansson@linaro.org>
References: <20230828121549.285925-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828121549.285925-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6
X-PR-Tracked-Commit-Id: 98ac9e4fc07f101c435f1ab6b395b6245b096a68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 995cda62100e1f50b0f0c5b793c672f50baa6241
Message-Id: <169333248635.16601.13999942683180786211.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 14:15:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/995cda62100e1f50b0f0c5b793c672f50baa6241

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
