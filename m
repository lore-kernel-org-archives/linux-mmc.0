Return-Path: <SRS0=/Wn+=DB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C171C4363D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0C02396D
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Sep 2020 16:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600964852;
	bh=8yuak9p/oTqR2yyHjmDjY1H6YWR9+hUWPxTZA38yHpU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:List-ID:From;
	b=I2fAPwmoU+8cRO7zr/yOcgw3Eowk/WTt1J/0UnFTWm0mAqHMjxK2Ss7ZfY4kdh786
	 pU1vXkkrDXa5vDFgHG6jh+RlFw75UK9ZX54wIDVQKtCPAeIG5vCavIqJ8k2eHeoOEe
	 frbSgn1aCR+qNUo/EiwDzuglXVSlXmFeiGsmVDfc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgIXQ1c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgIXQ1b (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Sep 2020 12:27:31 -0400
Subject: Re: [GIT PULL] MMC fixes for v5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600964851;
        bh=8yuak9p/oTqR2yyHjmDjY1H6YWR9+hUWPxTZA38yHpU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BXH6MRcURcLZ+F/UOPsje8ptGG4f9+L8JsGw9hJJk8fMm17wfIq+11cW27+LwptiJ
         Gplbzu84CWtSHniUp+mxwqSOGwyz/q9Wcm0oby3jxZugD1gpUh3LGKt7sA9O6Sfbl9
         eZ6bk7lFT/oLheONe8AtohqkQnPB6ezKb050OV6g=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200924124730.331517-1-ulf.hansson@linaro.org>
References: <20200924124730.331517-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200924124730.331517-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-2
X-PR-Tracked-Commit-Id: 14801c624066a55139c2c57963eb1b859d0a316a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 171d4ff79f965c1f164705ef0aaea102a6ad238b
Message-Id: <160096485121.7937.14566396826299636599.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Sep 2020 16:27:31 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Thu, 24 Sep 2020 14:47:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/171d4ff79f965c1f164705ef0aaea102a6ad238b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
