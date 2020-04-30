Return-Path: <SRS0=CLt1=6O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42014C4724C
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16146208DB
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Apr 2020 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588290612;
	bh=JypEDT+bXowxBoNeuugDTapgYrfF5c6kq7f5VUmwqw8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=Ru5RSvDYNA5lbgnYwPI1JBagn3hSrxl0GDGs5/HVciIXtkjMAYd9nGD1zH1ksd8OJ
	 1hbvNK8bENBJBGufj4Lu/S7x9cxgTMcRXgCcSN9ZmP2hoU6owMXqQnc3LVMB1il3fS
	 45tyG2H9Zk4sbjAE6Vttil0mwXenh0/BGHJZI0aM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD3XuL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Apr 2020 19:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgD3XuL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 30 Apr 2020 19:50:11 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.7-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588290611;
        bh=JypEDT+bXowxBoNeuugDTapgYrfF5c6kq7f5VUmwqw8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2iRp81rLgdSVE2ikNDVwLIsYsgqSzz/YvOhB7MnsJiDQUBfBG/Vd4+oK63b3rGF9s
         qfpuZVFDG1Y159dJMGr2gO20iiMkmmCsUKtCGT5QyPXm0KFpClKnKIYDyv3a/rI/cH
         9dRp9GLkPglHiOYEm9TdBCjAaZ7UXKsRGZT8lyDk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200430065743.21952-1-ulf.hansson@linaro.org>
References: <20200430065743.21952-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200430065743.21952-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc2
X-PR-Tracked-Commit-Id: 1a8eb6b373c2af6533c13d1ea11f504e5010ed9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af4a32ad21f83a0d093219c411e5a9f5b344e2ae
Message-Id: <158829061112.2910.9344522246208958614.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Apr 2020 23:50:11 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Thu, 30 Apr 2020 08:57:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af4a32ad21f83a0d093219c411e5a9f5b344e2ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
