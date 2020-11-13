Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADEECC55ABD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 18:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564582068E
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 18:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="15h/UCiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgKMSME (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Nov 2020 13:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKMSMD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Nov 2020 13:12:03 -0500
Subject: Re: [GIT PULL] MMC fixes for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605291123;
        bh=yuJSfNTs6esETguebxguGXBlsktboDKpYUNASooKEOM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=15h/UCiJ6Yc0h7igkUWu5pyGoEiqA4q0xylS1f7bi1W5x9gM4YJ1Wg48moNfyxZHB
         fWsWBy9HYhz9kl/2SPa43bk6nkamhERsVx6mjIeFfpojlLLB4IlCcNI4wYTd7Zp/Re
         j87Ywf95HmUHFPogJHOpy/d+Bjhieql7aG4x4RwE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201113112901.292826-1-ulf.hansson@linaro.org>
References: <20201113112901.292826-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201113112901.292826-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc3
X-PR-Tracked-Commit-Id: 03d80e042a8e3248163a38f74b43809f8079d652
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 673cb932b688ad3b03de89dc2b0b97c75ad47112
Message-Id: <160529112340.14692.11927333842693898863.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Nov 2020 18:12:03 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 12:29:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/673cb932b688ad3b03de89dc2b0b97c75ad47112

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
