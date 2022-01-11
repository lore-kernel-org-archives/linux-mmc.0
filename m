Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23D4C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Jan 2022 20:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiAKUxV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Jan 2022 15:53:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38746 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbiAKUxF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jan 2022 15:53:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4F0B616AF;
        Tue, 11 Jan 2022 20:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53D21C36AE3;
        Tue, 11 Jan 2022 20:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641934384;
        bh=8mt+t//9rXJuVWeitw+BuRBoI1zf/b8vOc0N1N1IaRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MT/FJIL6P4Ln/hBmek38k/gxQydmE+QdPMg7QSpU1R+tijvxapIH0lmPthFMDGbCr
         HBHjPT1ENfYN7UpZj00eHKiyXhCL1CzyeLkp1qhaxqrz0lhckWPJF3kOaquPyP6OeN
         xI0OP++KZ8iCCnowuh1T8+fc8c7imETQ+1ULSipMQkC946CT/TmuuHklYbOGvLCt49
         AMiRJmkoDKX/4cv+dlxIOCfOaC4/XnNB3ADoMPDp9qeApSl1hGL44rvYaTTqDr8Ghb
         3jHbhDL4xVdEGrmnRNzRUFPICQKxaTmmpez99MMmuCtAFHR9OfJnSEqflFFbEykpR5
         FFpwiPIaKrFgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41028F6078C;
        Tue, 11 Jan 2022 20:53:04 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220111142909.27773-1-ulf.hansson@linaro.org>
References: <20220111142909.27773-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220111142909.27773-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17
X-PR-Tracked-Commit-Id: 356f3f2c5756bbb67a515760966a40fc7043cdda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1151e3cd5a7375ebc839ad3e6c51d87700fe019e
Message-Id: <164193438426.11435.10249200980991477507.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 20:53:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Tue, 11 Jan 2022 15:29:09 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1151e3cd5a7375ebc839ad3e6c51d87700fe019e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
