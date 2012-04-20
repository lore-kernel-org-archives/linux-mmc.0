From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Do not pre-claim host in suspend
Date: Fri, 20 Apr 2012 09:41:58 -0400
Message-ID: <878vhqikpl.fsf@laptop.org>
References: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38419 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752569Ab2DTNls (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Apr 2012 09:41:48 -0400
In-Reply-To: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Thu, 19 Apr 2012 11:55:25 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Daniel Drake <dsd@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf,

On Thu, Apr 19 2012, Ulf Hansson wrote:
> Since SDIO drivers may want to do some SDIO operations
> in their suspend callback functions, we must not keep
> the host claimed when calling them.
>
> Daniel Drake reported that libertas_sdio encountered
> a deadlock in it's suspend function.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Thanks for taking a look at this, pushed to mmc-next for 3.4
with Dan's Tested-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
