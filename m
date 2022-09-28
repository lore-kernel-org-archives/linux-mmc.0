Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1138EC32771
	for <linux-mmc@archiver.kernel.org>; Wed, 28 Sep 2022 19:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiI1TNk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 28 Sep 2022 15:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI1TNh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2022 15:13:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A33A9C3E;
        Wed, 28 Sep 2022 12:13:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25ABB60DCF;
        Wed, 28 Sep 2022 19:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA6E0C43142;
        Wed, 28 Sep 2022 19:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664392416;
        bh=iODXTS3YNHswtIJ6Zy10HaYKhazXFCVhuPdoiaFBs9w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QeOugG8h42uRJVAPXnutxH3PPGBdQHuqB3ytQZXL9prTa7T0rlR0QDw6sdo1/43bC
         hhB9aWMIdNky+B7iVM7XE+nEnjEUguFAGAqQU5cLEFPpMSwKhiqAT6o47CKGQbdBQC
         +7t7TuQvvNnZRTZEmAL1vn/TQgyxmk3nZzxHR04he5aY96D1nyHpJrAHtC95tDUlFj
         43wXxAwdjZAb/7A3g/lYf1Z4T+K/WTU3mvOoSbq+i3bFULE1ON6LXDKV0aJDwDlvcy
         p/Id2aqtVDJ+PnutEzoCOZYLdF1Jv8ZoP8sEmwW6EA1imDY6g327pCDYLTy+FqI3uD
         DdIK8g9GvL5iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9887E21EC0;
        Wed, 28 Sep 2022 19:13:35 +0000 (UTC)
Subject: Re: [GIT PULL] MMC + ARM_SCMI fixes for v6.0-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220928084152.245040-1-ulf.hansson@linaro.org>
References: <20220928084152.245040-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220928084152.245040-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc5
X-PR-Tracked-Commit-Id: e7afa79a3b35a27a046a2139f8b20bd6b98155c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e817c070fd9f813774defd8ef5e0349108e924e0
Message-Id: <166439241587.10768.7170633342360846436.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Sep 2022 19:13:35 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed, 28 Sep 2022 10:41:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e817c070fd9f813774defd8ef5e0349108e924e0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
