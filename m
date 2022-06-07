Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ED1CCA47F
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 01:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiFHBJq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1583025AbiFGXqB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 19:46:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9852E4391;
        Tue,  7 Jun 2022 15:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C5FAB82456;
        Tue,  7 Jun 2022 22:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF913C385A2;
        Tue,  7 Jun 2022 22:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654639570;
        bh=RRlJzCWCZfZMbkpaSDZsgTcnf8hYwEfy32E7RVLd1wk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pZEPOuC7ua4P3ml30W9JhWc1wxyA3JBUazUt7jNeKwXYg6k6abOcxyyE9E37Z4Qlh
         VAoX7E7Se8l3QlK330ZjS+wNn12E51teQZe9FN7MgTSzOrR7EOqnCrRZogSuaXYMLu
         5DngjxZuXnxLgjaULMeOWDOMrCEqDgyQlmaBfqQPDZecKNqxoKOdDNLEgrEftkA6Mq
         ZM2ay4YSkichat+z6U240i45OGoZ+fZONZmgKI/fFTfEKMkqKpCDPch1dJz8lbqivp
         Rrcnr7hwlbHMN4QAYyW2tIetKlMNnnf52822K5mee1OlrWp7lnVGpGokR4Jl1FxyYZ
         trfwaABDkTPRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA93CE737E8;
        Tue,  7 Jun 2022 22:06:10 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.19-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220607094743.204021-1-ulf.hansson@linaro.org>
References: <20220607094743.204021-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220607094743.204021-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-2
X-PR-Tracked-Commit-Id: 479260419fa4cb30e3e5d935a857fbdf0ffdd854
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f7a447eda2120ab8988b0f8c708c1fd3bd4d3729
Message-Id: <165463957075.23279.17574785845775017961.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Jun 2022 22:06:10 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Tue,  7 Jun 2022 11:47:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f7a447eda2120ab8988b0f8c708c1fd3bd4d3729

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
