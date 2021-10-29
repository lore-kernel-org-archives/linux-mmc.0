Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C78FC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 18:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC7060FF2
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 18:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2SwC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhJ2SwB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 29 Oct 2021 14:52:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 6E16560F22;
        Fri, 29 Oct 2021 18:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635533372;
        bh=f3/4EqHGSsk3TtqlVP4HxqygawJ1WcmFIM19Vj4u5N4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HAG45e3vJNhcJJ1Xp/qVpUiyt1nJAMvTPrswegoBaN1OCn+k1VQi7mlUGMC/22Ask
         v5xHMvn1Gztuu7gVIyFceoGrihybwfoWgvNevcDBzz4pJOJpKaUqujB6X78dAqSGW7
         K54//9yAF+ipv93fA7ZtRcjlUBVaDcWbwikHJ5Soxg/oZbY8G4GtfD3Fr2UTVUk2oJ
         jUh4SaA6gjbYc+JbMqwuDmfBTliMIrm5tnQiGk6hWOgeBhYsW6OKOd0uJQ3jphZ4qw
         wTti+tuCossOYfg1yLP68VlbKrKkx9ELzX1L9zfSP9bWItQZmTeE2OYlxbtnJDU0XJ
         ddSPE2mpQFOeQ==
Subject: Re: [GIT PULL] MMC fixes for v5.15-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211029120709.79366-1-ulf.hansson@linaro.org>
References: <20211029120709.79366-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211029120709.79366-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc5
X-PR-Tracked-Commit-Id: 90935eb303e0d12f3d3d0383262e65290321f5f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17d50f89410c5f71142657d9a012cbabcaadb134
Message-Id: <163553337232.6387.13815310289182455885.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Oct 2021 18:49:32 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 29 Oct 2021 14:07:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17d50f89410c5f71142657d9a012cbabcaadb134

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
