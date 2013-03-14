From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc: block: fix the host's claim-release in special request
Date: Thu, 14 Mar 2013 12:56:15 +0100
Message-ID: <CA+20K0DxMmq67gWR4igtdOMdO+h19JqbEMH1=Wsp1v9cKPKkZQ@mail.gmail.com>
References: <001101ce207b$91e60440$b5b20cc0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:39250 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756768Ab3CNL4Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 07:56:16 -0400
Received: by mail-qa0-f46.google.com with SMTP id o13so2791927qaj.12
        for <linux-mmc@vger.kernel.org>; Thu, 14 Mar 2013 04:56:16 -0700 (PDT)
In-Reply-To: <001101ce207b$91e60440$b5b20cc0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Konstantin Dorfman <kdorfman@codeaurora.org>

Hi Seungwon,

2013/3/14 Seungwon Jeon <tgih.jun@samsung.com>:
> For normal request mmc_blk_issue_rq is called twice with asynchronous
> transfer(cur and prev). Host's claim and release can be done in each
> mmc_blk_issue_rq. However, Special request is currently excluded in
> asynchronous transfer. After special request is finished, if there is
> no new request, mmc_release_host won't be called in mmc_blk_issue_rq.
> The problem is founded during mmc_suspend.
>
> [<c0541124>] (__schedule+0x0/0x78c) from [<c05419e8>] (schedule+0x38/0x78)
> [<c05419b0>] (schedule+0x0/0x78) from [<c03a843c>] (__mmc_claim_host+0xac/0x1b4)
> [<c03a8390>] (__mmc_claim_host+0x0/0x1b4) from [<c03ac98c>] (mmc_suspend+0x28/0x9c)
> [<c03ac964>] (mmc_suspend+0x0/0x9c) from [<c03aad24>] (mmc_suspend_host+0xb4/0x194)
> ...
>
> Reported-by: Johan Rudholm <jrudholm@gmail.com>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>

Thank you for the quick response and fix! This fixes the problem. So
please include my

Tested-by: Johan Rudholm <johan.rudholm@stericsson.com>

Kind regards, Johan
