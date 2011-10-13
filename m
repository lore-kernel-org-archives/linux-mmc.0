From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: mmci: Do not release spinlock in request_end
Date: Thu, 13 Oct 2011 15:29:14 +0100
Message-ID: <20111013142914.GZ21648@n2100.arm.linux.org.uk>
References: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42426 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab1JMO3W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2011 10:29:22 -0400
Content-Disposition: inline
In-Reply-To: <1318342001-26955-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>

On Tue, Oct 11, 2011 at 04:06:41PM +0200, Ulf Hansson wrote:
> The patch "mmc: core: move ->request() call from atomic context",
> is the reason to why this change is possible. This simplifies the
> error handling code execution path quite a lot and potentially also
> fixes some error handling hang problems.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

This doesn't look right:

void mmc_request_done(struct mmc_host *host, struct mmc_request *mrq)
{
        if (err && cmd->retries) {
                host->ops->request(host, mrq);

So, not dropping the spinlock results in calling the request function
with the spinlock held - and as the request function then goes on to
lock the spinlock, we will deadlock.

I don't see anything in current mainline which addresses this, so I'm
not able to queue this patch.
