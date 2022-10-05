Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA69C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Oct 2022 18:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiJESmR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiJESlv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Oct 2022 14:41:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC8281694;
        Wed,  5 Oct 2022 11:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CB57617A5;
        Wed,  5 Oct 2022 18:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1889C43470;
        Wed,  5 Oct 2022 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664995219;
        bh=ZFZcw5D4f/3qwsmQKPeXj7C1TcEWE9IFpljav05yzjs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JCpvQ/YgAvNPapYFUSb5qxjayoFaG996eV5oy0DkwF3olflTmylwadUAzd1ylIwmB
         KAmKx6hRjg//2M+vnK3iy+tuqeRSKB8R0PtAkffInckmH1pCqvy65nalBR5B2ojplr
         N4VZO3d6ShX2eKaWsHYZ6Ol9IEfAyuUwp+UKVVH3Qr4vb3JeEvczbqsHxgg7lrweAk
         Aty+8xespjpi+t8geYLBc8IvkaQFpptbhO7jabLyM7RpRlQHW5sg6IKrMgvryKpn1k
         hJav2KuOICyRBOs2S3VIhjNsUHkmuN3+3ggtleE7LtKyV0RTDsyqNGlnX03BapAGEM
         AluvQqHTrYscA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD527E21EC2;
        Wed,  5 Oct 2022 18:40:19 +0000 (UTC)
Subject: Re: [GIT PULL] MMC updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221004141843.6607-1-ulf.hansson@linaro.org>
References: <20221004141843.6607-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221004141843.6607-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1
X-PR-Tracked-Commit-Id: 178422c27badb8eee5edfae3f6cc3048cc140364
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3f13bbfc2f0240743a4d03a8a890d03730f5a6d
Message-Id: <166499521975.1673.7032005564046436395.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 18:40:19 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Tue,  4 Oct 2022 16:18:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3f13bbfc2f0240743a4d03a8a890d03730f5a6d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
