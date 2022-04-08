Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45CFC433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Apr 2022 16:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbiDHQvT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 Apr 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiDHQvT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2022 12:51:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2531D35275;
        Fri,  8 Apr 2022 09:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5D516211A;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2626DC385A3;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649436554;
        bh=asfFPVE4GWVSvyU3lTGK4Jym4ERe1Og4JwpM9nhJNYw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KCIoz4n4lbpwuQyeDN5EJijjJtmO5qjkpK2sxosLjApIBraw8w/YB8E6i+WYgtncE
         JPfkEBHq79Gqn0dtVu9785wZ9VVHE5A/z2CRCRRLGUyENxuOGnqYZVGN5WDGoLUgMy
         keFsxhjdXz4fyOAxp9G5JyIGqkqSvSA0ZjKT/kX37Rl591Nodzp6AwsW4UvBfhztIt
         g0/N48DbpfShExSC8N5Tgl6/anU/g1qJHVKrbAzEQf6ru1rwJRFFfsIHubV9Dhrivq
         3PQtSDArcTatnS+IYiwXiTJsmjN+I4pbzcV9hmZ+R1JJasMCyBDC/HJjL7DPy1YCiO
         y7PtmBJLIngKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07212E8DBDA;
        Fri,  8 Apr 2022 16:49:14 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220408140654.119255-1-ulf.hansson@linaro.org>
References: <20220408140654.119255-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220408140654.119255-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc1
X-PR-Tracked-Commit-Id: b71597edfaade119157ded98991bac7160be80c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ccab01401c89cc846913fcba6130f76034624c0
Message-Id: <164943655402.24432.9494439471398652257.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 16:49:14 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  8 Apr 2022 16:06:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ccab01401c89cc846913fcba6130f76034624c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
