Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43221EE498D
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Aug 2023 17:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379203AbjHRRtF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Aug 2023 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379251AbjHRRsl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Aug 2023 13:48:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0683C16;
        Fri, 18 Aug 2023 10:48:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10F9663836;
        Fri, 18 Aug 2023 17:48:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 790CDC43395;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692380919;
        bh=uImbYaovy5d7UgtYme5C4o0jRBq5yLYnSLDLLPC0yK4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kSvjKKbBOafjwvvMs0rGLK4dTkeAWzqYZ1tegMZ5nGKZoiTKwOenDlfdQk69wNk7C
         tfDpY0KeZPVV4fqKIAT56Y3sdbQxXnjAFGUhvO4ao0lDe3m7X5YHeerRChhnPnRKQY
         iQarKOOlwQ4FeZSyFjnL+3lAnKT88LAhiBn1iQknA8lFGb5QreDMRclGmH/b6TSD2i
         G71FjL0/tGeyktl1ujaHZ17OLYL6HKug4RCUwnYLbOVbczkVnsBopwY6OwZNElT8ew
         I/L227ICxanV/NjzTZTD/p8mXfqnstWw6Q+bNwKYcr1d8wfiZbZVj5H+9E5PNZGDIf
         TQzpPbnTuFCSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 679D9E26D33;
        Fri, 18 Aug 2023 17:48:39 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.5-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230818092916.38330-1-ulf.hansson@linaro.org>
References: <20230818092916.38330-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230818092916.38330-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1-2
X-PR-Tracked-Commit-Id: 58abdd80b93b09023ca03007b608685c41e3a289
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88d4a1643afca63a3832eefad5c00775ea20c117
Message-Id: <169238091942.10816.6747598920892994833.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Aug 2023 17:48:39 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 18 Aug 2023 11:29:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.5-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88d4a1643afca63a3832eefad5c00775ea20c117

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
