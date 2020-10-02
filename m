Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD11C4363C
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 17:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F569208C7
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 17:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601658916;
	bh=CPa7mnHhiax78ShmzvGMp54G7tJtrbpYTsGY1+eRZ6w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=uBP1mKd5CQHpy5VVS6RojmUkj5vOvg1Vqwei7lropepukeDPHw1f5pZ7SFgvTn3+I
	 8dkzGRYp8A+eUQHY1WP5KVBcqj/rdCO+nnIEKNuBv22BYxvRE7beQq3832co1kvyW3
	 DkN/JZ3n31YVw5DnKPYMnqZ2rlY+Opx1MhZVrCaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgJBRPP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 13:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbgJBRPP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Oct 2020 13:15:15 -0400
Subject: Re: [GIT PULL] MMC/MEMSTICK fixes for v5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601658914;
        bh=CPa7mnHhiax78ShmzvGMp54G7tJtrbpYTsGY1+eRZ6w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=P1u6k5sl68EaJXOUCb8WaLGjsdUcOFHXW2/ROR5tzJPuJP6EHX7pdX/SdwIErQuzM
         UEdb6969ICjKUpXQZP8kvXTrgzTALSJpZlOxTPePqT9XoQ+kGVigHskaWR7QEO4/8i
         WyAvaALqa1MxZtctqw3+/6obg57NwmF7p7FME9VA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201002075502.130199-1-ulf.hansson@linaro.org>
References: <20201002075502.130199-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201002075502.130199-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-3
X-PR-Tracked-Commit-Id: afd7f30886b0b445a4240a99020458a9772f2b89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2270b890bc295c6de2f4e4e3a770025b76657699
Message-Id: <160165891490.31225.16184233335075494974.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 17:15:14 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri,  2 Oct 2020 09:55:02 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2270b890bc295c6de2f4e4e3a770025b76657699

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
