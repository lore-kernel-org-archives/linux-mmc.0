From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V2] mmc: core: Clean up after mmc_pre_req if card was removed
Date: Thu, 08 Mar 2012 23:40:28 -0500
Message-ID: <m2y5rapetf.fsf@bob.laptop.org>
References: <1330959163-21796-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42721 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586Ab2CIEkd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 8 Mar 2012 23:40:33 -0500
In-Reply-To: <1330959163-21796-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Mon, 5 Mar 2012 15:52:43 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf,

On Mon, Mar 05 2012, Ulf Hansson wrote:
> Make sure mmc_start_req cancel the prepared job, if the request
> was prevented to be started due to the card has been removed.
>
> This bug was introduced in commit:
> mmc: allow upper layers to know immediately if card has been removed
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> Reviewed-by: Per Forlin <per.forlin@stericsson.com>

Thanks, pushed to mmc-next for 3.4 with Jaehoon's Tested-by.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
