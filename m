Return-Path: <SRS0=lJwf=46=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEA8C2BB1D
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 20:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810F420751
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Mar 2020 20:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584131108;
	bh=qh59NKk5b/UE7bO+HoSw6wEWZNyF+IwN4tPCJCBfzf8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=FULU7LYHOmkinNcmyqcZWtTGtbae5r69YgLi8+RSi5WJUsC3Qj9drXUSwSr+wWrkC
	 9/Gfqc4H+f6layvoLiULI4MJNUNErwPobQ0hjwmH3u8EfWkq4p/GKsTTg5oe+JhsBn
	 sMUUIsHVFLS5er1i4TySTAO0kiiyyBtnjPjG0FLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCMUZI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Mar 2020 16:25:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgCMUZH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 13 Mar 2020 16:25:07 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.6-rc6 take2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584131107;
        bh=qh59NKk5b/UE7bO+HoSw6wEWZNyF+IwN4tPCJCBfzf8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AQhS98z7eejlitvHDOnM6dvQ4tzkobq8tXXd7qAY6ikVPBuJ/Ad9kVFjNcKVgYFNO
         ePzZAiklxTeOZlQ13OMg3vt41IUcmqq/oVp51AydNhmpU9nu6At1K7goRQNq2ZfOXv
         5jy5KitdtiSkd8mApRc/E5XBZttkbhuoU03y87mE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200313123202.23685-1-ulf.hansson@linaro.org>
References: <20200313123202.23685-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200313123202.23685-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
 tags/mmc-v5.6-rc1-2
X-PR-Tracked-Commit-Id: 18d200460cd73636d4f20674085c39e32b4e0097
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d36561296bb510bf339750ea22efaa660277642e
Message-Id: <158413110734.9951.15489734490072348773.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Mar 2020 20:25:07 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 13 Mar 2020 13:32:02 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d36561296bb510bf339750ea22efaa660277642e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
