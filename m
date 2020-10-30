Return-Path: <SRS0=VXdQ=EF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14502C4741F
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6C802071A
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Oct 2020 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604088381;
	bh=iXQjdIh1MiPFSjG4/3gJq09dt6b9c+eC698b1mRyDok=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=1YznBuF3x6xBpahCa4aRB0RMrQRHJ7Oz2OpC1TEaHWwZzHmt2Yrc+RI/PeMC3YAhs
	 5/fe/4z4RvWhH2ImqYiIuTcTZsW7WTx+T53E7Fmxs8EO4o46AYOfbS7x2XO9snorE9
	 MZ7BDXHIBIVxDYgDGHRdg6OiG4HkzMABurgbVcas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgJ3UFu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Oct 2020 16:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726297AbgJ3UFt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 30 Oct 2020 16:05:49 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604088349;
        bh=iXQjdIh1MiPFSjG4/3gJq09dt6b9c+eC698b1mRyDok=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Luh3/T+FvCKnr3qwrfVwfyWOGlxfGnVaj25VBXwWTixcuD3t3S0xNVAcdfpz1jOam
         CqT6ZWcRPsS0aFJMCfhVo2TuxCSarTE88vxnvuxtOOnaHqJnUiDo7Hhx6qy44BijBw
         JQQnGgFSE/uMJyf9uQCPyAswlp7NhYX6U9SBtJHA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201030120752.100388-1-ulf.hansson@linaro.org>
References: <20201030120752.100388-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201030120752.100388-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-2
X-PR-Tracked-Commit-Id: 011fde48394b7dc8dfd6660d1013b26a00157b80
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 88098fd61b7e52e1f78668b6f1f07d39ca67301f
Message-Id: <160408834941.13990.11062361835301766189.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Oct 2020 20:05:49 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 30 Oct 2020 13:07:52 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/88098fd61b7e52e1f78668b6f1f07d39ca67301f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
