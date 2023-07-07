Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D42EB64D9
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Jul 2023 23:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGGXEB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjGGXEA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jul 2023 19:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530C6FC;
        Fri,  7 Jul 2023 16:04:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E49A361ABC;
        Fri,  7 Jul 2023 23:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5404CC433C7;
        Fri,  7 Jul 2023 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688771039;
        bh=d6uyKBJm/UdmGYNJS3Exe9YM9xrC+d9g5viBtVDTsBg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ACGSXjEQVHAx2NdElpTYNnth4Yb/0NDuf9th9AZHaEY++3HE7VTY4+FUZE7iq5QTL
         /ei6vUmDzcEUyYGURBqezPmZ2Sm50CPjjJQLMFuQ25tU64fp+GkxFtOmk8f2/Nfh9E
         VYlSJX8IIhLrw5CD4YDCKcMuxpr1++dL4MX363hRKZOTDRPFIxkLWHEXGZAjrVle0d
         gnIxoUyhjujwBgO2bvn4aGnWbhhi8yOb/5MUAnsxKoHSiqGvy7EgxHbf84F9cRozUX
         rk3k7mngADLQznYVemSybu+qaJ2sDGAy8Qor/Pgkj/ZFbSfhAV8No28XQCCmuekqBZ
         hgBsXSeL5NRqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FA61C4167B;
        Fri,  7 Jul 2023 23:03:59 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230707150919.724185-1-ulf.hansson@linaro.org>
References: <20230707150919.724185-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230707150919.724185-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-2
X-PR-Tracked-Commit-Id: fa700d73494abbd343c47c6f54837c9874c61bbe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8689f4f2ea561dd080118eeb05c0255ac9542905
Message-Id: <168877103925.13958.5768751739594201614.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 23:03:59 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  7 Jul 2023 17:09:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8689f4f2ea561dd080118eeb05c0255ac9542905

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
