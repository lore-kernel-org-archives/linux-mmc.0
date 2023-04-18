Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC03C77B75
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Apr 2023 18:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjDRSKM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjDRSKM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2023 14:10:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573B468C;
        Tue, 18 Apr 2023 11:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D98066377A;
        Tue, 18 Apr 2023 18:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 497E7C4339B;
        Tue, 18 Apr 2023 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681841406;
        bh=qECPssaKOdA1Rfaall6QNi0ar+2KTfHq/RDwO0gDHIY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n7y0dSVuCKwJ6AdEjcW/1qaan1ZYJWiT4vdYzRXyuW2umCWHM9D83Cj6LJdCIqH18
         2jmbnkvjkdM7Rz2mEObVLnn78mjZR7rg83TigPVVMYiAV5hX9q1p3GWfgMjwSnYuTa
         IhJ8X3Uu5rwdfRrU2ZO+ho+rcRkgvBI0srud3CDZTgjPxX6CcZThZnY100OuAhmzSC
         gL+ROK+HVIMQ3VVvkAU0+seHCYUaMmd+aEVKl85KUoYmjsp1DtcCtAUg9XXthorLan
         somXltBbQVgsy5mlQMN/xEq/cn6Vh04WSjSiKcEisMq+hiiKq8cScuhUEg85OyO3j5
         BIdIiB4LqZIoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F215C4167B;
        Tue, 18 Apr 2023 18:10:06 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK fixes for v6.3-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230418084329.12066-1-ulf.hansson@linaro.org>
References: <20230418084329.12066-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230418084329.12066-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc3
X-PR-Tracked-Commit-Id: 4b6d621c9d859ff89e68cebf6178652592676013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af67688dca57999fd848f051eeea1d375ba546b2
Message-Id: <168184140604.21228.5799260324654292808.pr-tracker-bot@kernel.org>
Date:   Tue, 18 Apr 2023 18:10:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Tue, 18 Apr 2023 10:43:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af67688dca57999fd848f051eeea1d375ba546b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
