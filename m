Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF77C433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 02:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834D460EBC
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Nov 2021 02:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKBCWd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Nov 2021 22:22:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhKBCWd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Nov 2021 22:22:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 16E2E60EE3;
        Tue,  2 Nov 2021 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635819599;
        bh=LiPeMK13Gg5Gs9CeZV7paLrLngGCLRAHuMMobHbzXh8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HF4Cb0coAqaDq0JvZ0jW1odY40QOZRCx7xcni/7yzQU0DxWtigJR9E9KSDX9Vhuhf
         JBPYvAMlIRqlYJrYp9rqknI0xqTkiKZ/fksDXWNnScQvj9ZgBqyJM7S7HDfvXxkvnn
         dYG904JOIUbpza4iifXKXE00ri2A6RlIxGcrl9qW5Hmfnjwrygl4Y5vhueSNRHvWVl
         tY9D6e99wNA+Y2Yo93oYVlWQaX8EeIHbX1fumZGWaXyd3ca3tIhs+0+s0TnW4z6LsS
         D2c/BZ8TnFAq8kmuoqxhHzVWTJt0HkLMJXDDtImx42S+1plrzji0jqsGE8t+uAwL0p
         picW8GDds7SFA==
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v5.16
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20211101112734.9239-1-ulf.hansson@linaro.org>
References: <20211101112734.9239-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20211101112734.9239-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16
X-PR-Tracked-Commit-Id: 348ecd61770f6aca0d060fea2bb538e749775638
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a73c77c809a7342497b78a2b4555aa40506af94
Message-Id: <163581959898.22843.14600598455644954804.pr-tracker-bot@kernel.org>
Date:   Tue, 02 Nov 2021 02:19:58 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The pull request you sent on Mon,  1 Nov 2021 12:27:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a73c77c809a7342497b78a2b4555aa40506af94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
