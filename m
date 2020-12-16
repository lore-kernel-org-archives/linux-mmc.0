Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BECC4361B
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 01:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640F122DD6
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Dec 2020 01:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgLPBAp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Dec 2020 20:00:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgLPBAp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Dec 2020 20:00:45 -0500
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608080404;
        bh=M5s9pmb6icGPfBMy2mjZO6llh2/6FTrkl/m6/D0gf2I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=k1pSljwg4ZxX3IDL7PJKY6jEsXdjI93C9QNK90aJj7ybBOWjdFGlMKXj5baKUA653
         RnuvKeqjgbb04qVrBZYYooovc/Ok+SuLYV4dzuK12Ns58owYxkG5VaES8Qh1wT0CoE
         l+6ViNml2K9ZgBdDVJi24xTJKgH0KmK/lXv+SL94VQ2LZ4PoDWPRcrB3dznKu32ASH
         818HvhZt9Ic8eHqaK6vRIwAAnS52opC6sxMljLP0ShdjzpRURFDI2I4CGeqzVHvKam
         dvEADl2y6g9i3J6wQSz3ElB7LQJrz1YE+v4jMNrIx8Pj2G3vVglssRiUM7mQ7bOxbF
         L0cFOEduxuX5g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214132822.248987-1-ulf.hansson@linaro.org>
References: <20201214132822.248987-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214132822.248987-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11
X-PR-Tracked-Commit-Id: 72b248cfbf3fd308807afe7cc30d05fefeff7fb1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce51c2b7ceb23a23eb0dc523c80879d8f35e4f38
Message-Id: <160808040473.29502.5339164487867468311.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 01:00:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 14:28:22 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce51c2b7ceb23a23eb0dc523c80879d8f35e4f38

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
