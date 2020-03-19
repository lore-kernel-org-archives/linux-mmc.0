Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E77BC4332D
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 19:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FB82072D
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584647408;
	bh=OkC2gr/8Q7KCXYy428Zc1GIymS+WvTDBBkkQTP+Z8U8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=pRi8ugq6L4hOvQsr0LIebMvaXy5FaUmzgWk9nAR9Jh3wlNSg6qsYLHDBIDXgA4cPp
	 N5vPSyb7k4AVk28DM378r1qsN9wUWJIIyrUOgs73iHtELenlZdKX+mTalXkYzTzagJ
	 SEv/GqURXuRGtkwO7ZCq9+4BsCNG1l3oNJH30uQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCSTuH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:50:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSTuH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Mar 2020 15:50:07 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.6-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584647406;
        bh=OkC2gr/8Q7KCXYy428Zc1GIymS+WvTDBBkkQTP+Z8U8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CoixHqPkkvv8gEcedf0ii5jfmQHd5coj+BaF43DA746JAYlUtm+r5uNUn5St2qIZr
         FAeqTsret8WeQq2M8HXoq7b/NgzMcOEnpGCpdSondK30hpnzIf+bCLdsYwqG3fOgCb
         m6dKq+rTlrKjBY5vZRS90GrmVi0CjJKQwYqBKZkI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200319193925.19656-1-ulf.hansson@linaro.org>
References: <20200319193925.19656-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200319193925.19656-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc6
X-PR-Tracked-Commit-Id: 4686392c32361c97e8434adf9cc77ad7991bfa81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c90b86a745a446717fdf408c4a8a4631a5e8ee3
Message-Id: <158464740676.23356.14515670613847007769.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Mar 2020 19:50:06 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Thu, 19 Mar 2020 20:39:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c90b86a745a446717fdf408c4a8a4631a5e8ee3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
