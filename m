Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAC4C4321E
	for <linux-mmc@archiver.kernel.org>; Sat,  3 Dec 2022 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiLCAKr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 19:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiLCAKl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 19:10:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08541E5A95;
        Fri,  2 Dec 2022 16:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98E0462444;
        Sat,  3 Dec 2022 00:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D8E5C433C1;
        Sat,  3 Dec 2022 00:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670026240;
        bh=hb2BkYSv1mgd0Ayr7pCnUPQnFfEY1gfc1QGUMfV0LLs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A7KvQ0muglL9LW6mmxsk0ScC5mLvZp6qrBYEhuN8rxpnma8a57zNUGWWYmyQxg+Gh
         Nt/o14+BIz8ovf1RtAAInvPI+Ig45tQrLXH68712jsl/4y49J/Z7QVMMP9tfgGAHrE
         pe4HT3FmtWwDUoHFqEPX59i1OE2KQEH4DeouQM1pIVmLKLLiEWQkZrEv8KrWhExqqR
         lrO0iypoHimKH//RVKQ65OoJfQ07mfacWSDJAFLLAwfV4uqn9OiGHFK305vFmt0Hz9
         JIbVdkubiGRW9omNHcECq1ydK0uEJ2H/9+Y3EboZxz2BUQ7+Xyoq3GZFH91yN+f1Om
         ptORiZzhUWNRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0B7AC395EC;
        Sat,  3 Dec 2022 00:10:39 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221202083310.136427-1-ulf.hansson@linaro.org>
References: <20221202083310.136427-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221202083310.136427-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5-2
X-PR-Tracked-Commit-Id: dd30dcfa7a74a06f8dcdab260d8d5adf32f17333
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2df2adc3e69d32751eb534ed55c591854260c4a3
Message-Id: <167002623998.23477.4811013471866866486.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Dec 2022 00:10:39 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  2 Dec 2022 09:33:10 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2df2adc3e69d32751eb534ed55c591854260c4a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
