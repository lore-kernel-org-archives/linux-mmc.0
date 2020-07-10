Return-Path: <SRS0=hS93=AV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF2AC433F7
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0332080D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Jul 2020 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594400135;
	bh=lup3G2Zv1bViC8syBK8NKScLFpdnQGZ+QAlzRP14P+o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=ZKBDEH1CM6Smbw74yneZpNMV6vEKg8gzZzsHg9aFlYr5l6bQ2GzGF+30BBCHgUINR
	 Jv07zTGC30WRP/yQTiJRjCON1vFKlqciOm2VAl8MCzT/3hxIVGL2ZAdnK2O7ralr1z
	 lw+VaezbbYW1EfMhvaK1tTUVwwBCIowDFrXvj73Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgGJQzF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728249AbgGJQzE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Jul 2020 12:55:04 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594400104;
        bh=lup3G2Zv1bViC8syBK8NKScLFpdnQGZ+QAlzRP14P+o=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LV43mZYQxPL26PCjYwNSFUKvqv5dnEbt+Eu/ys0VAFop8aND0jUikVg0W3EzVdSvq
         J3vSfYUP7gClddbPBUhpTwU/MtbNlDSDxjHXXlGfpZX8mp8SfFBQIX+sdCf3vqz0Zm
         sux8Fh7MNLb2rPecACMPxJ6JBPYRWn0YrmbvqdZM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200710075234.24987-1-ulf.hansson@linaro.org>
References: <20200710075234.24987-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200710075234.24987-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc1
X-PR-Tracked-Commit-Id: 3ec2d5113ea5e182b759b613dc1f7108ba7aac9e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d45f47a46854b304ebda238b6121f95370b195ec
Message-Id: <159440010452.18761.2008001668438382664.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Jul 2020 16:55:04 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Fri, 10 Jul 2020 09:52:34 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.8-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d45f47a46854b304ebda238b6121f95370b195ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
