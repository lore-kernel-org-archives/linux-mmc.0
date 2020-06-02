Return-Path: <SRS0=LU6H=7P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B599AC433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8800B207D5
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Jun 2020 20:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591130107;
	bh=4Hp52jbeOMDuF3PTu79KmzW6xYMBZC7zQipXzNkht6s=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=oZAy7WCQ1yPvdOAxOzjP0knl9B384Oyuv1Xgf3RalscaqbXm4T1H+Wr4iHTddYcOh
	 3p46g+dqy6hqMdFMbRgGhPAyiIvS77WQEnRxm6BFmUrNrUE6CXi4AZnTtgozCkhwVQ
	 HU3YcSMH/TaD98Mz0vYT9XyMzPkbCyWGw+CsgD0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgFBUfG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbgFBUfF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Jun 2020 16:35:05 -0400
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591130105;
        bh=4Hp52jbeOMDuF3PTu79KmzW6xYMBZC7zQipXzNkht6s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KWlo2qDmsRmEW1ASpCh5PNWmb6IMtYmAK+NICr0j5NGHs8CmYt+GEdnabSdXC7UGo
         YDPYWciBfPxTVW94jjvT+m2RT20Itrrk0S15gNNpGhJwrJpmh74J3CPNogzFaX/rFA
         ASjIJry84fTZvT/BhOk4OISkSf0ye/p4lecZExb8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601082613.4566-1-ulf.hansson@linaro.org>
References: <20200601082613.4566-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601082613.4566-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8
X-PR-Tracked-Commit-Id: ae5c0585dfc2168c589de5878df2e591dfbd4bf0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5d6c13843880ad0112f0513f3eb041b258be66e
Message-Id: <159113010551.19446.11840655469371443898.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Jun 2020 20:35:05 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon,  1 Jun 2020 10:26:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5d6c13843880ad0112f0513f3eb041b258be66e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
