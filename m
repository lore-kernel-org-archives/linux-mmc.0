From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1]mmc: fix division by zero when calculate mmc erase time
Date: Thu, 24 Feb 2011 13:35:46 +0100
Message-ID: <AANLkTik8B0c0Bfv2O2-vcNUGGitywRjUXrGE44kP1cq4@mail.gmail.com>
References: <20110224111801.GA7169@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58512 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab1BXMfq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 07:35:46 -0500
In-Reply-To: <20110224111801.GA7169@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, adrian.hunter@nokia.com, linux-kernel@vger.kernel.org

2011/2/24 Chuanxiao Dong <chuanxiao.dong@intel.com>:
> Since if clock gating feature is enabled, the clock frequency may be zero when
> host clock is gated. In such scenario, mmc_set_mmc_erase_timeout() may have a
> division by zero bug.
>
> So this patch used mmc_host_clk_rate() to fix this.
>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Actually I think these divide-by zero bugs were there before since clock
0 is perfectly legal, we just didn't trigger them before.

Yours,
Linus Walleij
