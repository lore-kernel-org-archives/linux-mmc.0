From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 0/3] sdhci runtime_pm implementation using mmc clock
 gating fw
Date: Sun, 6 Feb 2011 19:54:11 +0100
Message-ID: <AANLkTinzhhZMC=dRhC5PbeK98UH8ZkOKMriEq0cU6g=q@mail.gmail.com>
References: <cover.1297014479.git.pierre.tardy@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:59299 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452Ab1BFSyL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2011 13:54:11 -0500
In-Reply-To: <cover.1297014479.git.pierre.tardy@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Tardy <pierre.tardy@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

2011/2/6 Pierre Tardy <pierre.tardy@intel.com>:

> Please find a simple sdhci runtime_pm implementation
> that uses clock gating fw as a tip to know when
> our chip is idle.

I like this approach, the gated clock hints to rpm that it's time
to idle the device. Great work.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

For all patches.

Thanks,
Linus Walleij
