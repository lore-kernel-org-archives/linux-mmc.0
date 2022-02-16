Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E86D6C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Feb 2022 23:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238238AbiBPXX4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:23:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiBPXX4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2022 18:23:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429822AAB34;
        Wed, 16 Feb 2022 15:23:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0B4761BCB;
        Wed, 16 Feb 2022 23:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E52C004E1;
        Wed, 16 Feb 2022 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645053822;
        bh=XExZdz5pl9QjWMM9CBl3plsUR1PcI7ogKu+Fs3YgVi0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jP3uNtddpIHSAi4yg3RDZgNBzXigJoVhBkUtbAXkBmCpXiuqxNe/q/s01UfBa7LMn
         svpD4Q3NabPWCywpNEJJjWxgGAaYkcAWQyY2j0YkNv8jXi0t+QB96+/cNPOtUSGL1g
         Xm3q/V5h7geaNuEkPlO09ZhxPsxnc86k6o4qVSkXydbrY0A4oArOvc4irAYEe0DA2m
         f+wGzSgVaJr3kI4T1KuQV0VRpnnK3ytVYQgcE04EqQvpA1wdIb0EYB5sE2GJ5eex/j
         A9bKln9tpVBF5Wvq/P8h2PS5opTlZZUy1K1y50kW0amYrYxlqzSBEBm3IyiuKeluFW
         o/yROEfgo8yIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36A83E5D07D;
        Wed, 16 Feb 2022 23:23:42 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220216101733.193534-1-ulf.hansson@linaro.org>
References: <20220216101733.193534-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220216101733.193534-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1-2
X-PR-Tracked-Commit-Id: 54309fde1a352ad2674ebba004a79f7d20b9f037
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3
Message-Id: <164505382221.13100.12638078753532183842.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Feb 2022 23:23:42 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Wed, 16 Feb 2022 11:17:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.17-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f71077a4d84bbe8c7b91b7db7c4ef815755ac5e3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
