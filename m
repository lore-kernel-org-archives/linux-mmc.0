From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci: fix lockdep error on tunning routine
Date: Mon, 23 Dec 2013 20:23:17 +0800
Message-ID: <20131223122315.GJ26070@S2101-09.ap.freescale.net>
References: <1387797184-18958-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:56587 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751314Ab3LWMVo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Dec 2013 07:21:44 -0500
Content-Disposition: inline
In-Reply-To: <1387797184-18958-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, s.hauer@pengutronix.de, peterz@infradead.org

On Mon, Dec 23, 2013 at 07:13:04PM +0800, Dong Aisheng wrote:
> It's strange that this issue did not happen on kernel 3.10.17 with the same
> code.

Probably just because you did not turn on CONFIG_PROVE_LOCKING on your
3.10.17 kennel.

Shawn

> And looking at the code, before call spin_lock we already disable the mmc
> controller irq, per on my understanding, the deadlock given by lockdep may not
> be able to happen(pls fix me if wrong).
> May the lockdep not track the specific irq disable?
> Copy lockdep guy to comment.
> ---

