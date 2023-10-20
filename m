Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0938EC001DF
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Oct 2023 20:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjJTU1L (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 Oct 2023 16:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjJTU1K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2023 16:27:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0D81A4;
        Fri, 20 Oct 2023 13:27:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B70FBC433C7;
        Fri, 20 Oct 2023 20:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697833628;
        bh=KnUZm/R2IyuO65TDWeBweRiGTQ+zEVOGuGEFW68zwrE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=khE/qLJSYMlExwS2rezUDw9GG+qjU2bV1Gn2FXXDLPZEYFS4nvf2D0v/STPgo0a3y
         f8e40i5ULbq8Gish0hpOyi8En926gb6yb3KTkmqucLToiAdrNJxpbMK8JgcJMifUSK
         A2/mbJXTNaHOlXyo9ChGe9/UxQxeFrPrIrPuiNuqF126Yuw6q6ftJ73GUOYTJGIdPV
         Ylc3tGte5WaI20dYnkrg9Z9xgbl1tGX7G4UeizJwSfTbewPCkVeq8AbP2oXJNVnYd+
         wlPEQwzHWT6gRNphi9wAqmoN3ScOfrWfndZ985hlU9rfVs3aMqRNx91uJd4gSmcY8l
         gmurLB0Lvyo6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6DC3C595CE;
        Fri, 20 Oct 2023 20:27:08 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231020115657.153077-1-ulf.hansson@linaro.org>
References: <20231020115657.153077-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231020115657.153077-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6-rc3
X-PR-Tracked-Commit-Id: 84ee19bffc9306128cd0f1c650e89767079efeff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7da6c042ca0da545682713f3452eecaa18221af4
Message-Id: <169783362867.7501.5420166695389782199.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Oct 2023 20:27:08 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 20 Oct 2023 13:56:57 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7da6c042ca0da545682713f3452eecaa18221af4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
