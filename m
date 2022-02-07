Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869AC433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  7 Feb 2022 20:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbiBGUUk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Feb 2022 15:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiBGUOp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Feb 2022 15:14:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E29C0401E2;
        Mon,  7 Feb 2022 12:14:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A72361460;
        Mon,  7 Feb 2022 20:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86371C004E1;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644264884;
        bh=vKsG/uWUXHsAh6WfbSKrv7geN+bm6kyGW2sX2wduaHk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ooAddBWVEWxEcID4bcrIu3Q2BB1KeBVccs5tkcBCwmfh3+bKNdT6VXsSvLzFjryE8
         pPmSa3DvLZ0XuGKkMy1H4HnU5Yf6/F8z/N0MoIqyWY3GpicbSQ5p8gkTipuNeDK/ca
         DhbaH65DSYy4Xo6f/us4XGcah52VQEBN9HXzjL8ZyQ2WJO+8q8+VlUgKzxUe9MgloA
         HRpumgyC61snW9Blf2NI8wbPmA8j8/mKcw5t8CFhH7EE1APDURMNdC9RQWeY7lmfO9
         XpaPP2IIrF+zn4X0yKQxfdr2CuowHlAOPiIiD1qXafoJhaozJydpA40uaPBNGT4kho
         sIP7ZX7hNINlg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 76596E5D09D;
        Mon,  7 Feb 2022 20:14:44 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220207112605.246647-1-ulf.hansson@linaro.org>
References: <20220207112605.246647-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220207112605.246647-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1
X-PR-Tracked-Commit-Id: bd2db32e7c3e35bd4d9b8bbff689434a50893546
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 51f7ea914d79aa44156dd63fe9e1cc75708d781d
Message-Id: <164426488448.18191.15469163597693131085.pr-tracker-bot@kernel.org>
Date:   Mon, 07 Feb 2022 20:14:44 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon,  7 Feb 2022 12:26:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/51f7ea914d79aa44156dd63fe9e1cc75708d781d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
