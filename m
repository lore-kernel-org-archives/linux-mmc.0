From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Fix hangs related to insert/remove of cards
Date: Wed, 21 Sep 2011 14:10:05 -0400
Message-ID: <m2d3et4via.fsf@bob.laptop.org>
References: <1315918957-11491-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:53214 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab1IUSKK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 21 Sep 2011 14:10:10 -0400
In-Reply-To: <1315918957-11491-1-git-send-email-ulf.hansson@stericsson.com>
	(Ulf Hansson's message of "Tue, 13 Sep 2011 15:02:37 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Ulf,

On Tue, Sep 13 2011, Ulf Hansson wrote:
> During a rescan operation mmc_attach(sd|mmc|sdio) functions are
> called. The error handling in these function can trigger a detach
> of the bus, which also meant a power off. This is not notified by
> the rescan operation which then continues to the next attach function.
>
> If a power off has been done, the framework must never send any
> new commands to the host driver, without first doing a new power up.
> This will most likely trigger any host driver to hang.
>
> Moving power off out of detach and instead handle power off
> separately when it is actually needed, solves the issue.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>

Thanks very much, merged to mmc-next with Linus W's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
