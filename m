Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D580FC433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 22:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC6F23B09
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 22:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbhAVWEb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:04:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbhAVWBT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 22 Jan 2021 17:01:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 782E223B16;
        Fri, 22 Jan 2021 22:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611352839;
        bh=MshnZ3dkBkCc0RmQkUxUoPxMjKXTuXcPitlAd7tDwrY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k9UideLBL79JUA2khQbPWxQSwo0C3bl2DOvEnrAYKRctc/WwSat07wuem0lTJD4i1
         1nVPDk3KOEwiGaQyrwhaXF9bW/6opvazyJLkCD5XitR/Z3ZS9JTTZIDSYeKj9RbGxi
         rU/ykUGOSAedMwr8Jm+8BBaqmLs3L2xHCk9AC3dE2Jch3ELf0vFwvnQi+F2Jljx2UV
         xQ8a0r/uPwUqFxRmEAPjWj1XBEXyzbd2SdpdfNYkOHNbanQ4WdtY7XeevYlDAbszvC
         DyM8pVdJpG4yHEjwJd2rSwfbcpj9ej+/aOEe6jt4pUjYYJBXapTAP047eRO68T176E
         0M0el57YADh7A==
Subject: Re: [GIT PULL] MMC fixes for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210122094413.69488-1-ulf.hansson@linaro.org>
References: <20210122094413.69488-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210122094413.69488-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc3
X-PR-Tracked-Commit-Id: b503087445ce7e45fabdee87ca9e460d5b5b5168
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59a4560e855798f9764b77777aeab796de1a171d
Message-Id: <161135283947.4174.16009474180707090842.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jan 2021 22:00:39 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 22 Jan 2021 10:44:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.11-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59a4560e855798f9764b77777aeab796de1a171d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
