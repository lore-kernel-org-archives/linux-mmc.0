From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: core: move ->request() call from atomic context
Date: Mon, 10 Oct 2011 18:05:30 -0400
Message-ID: <m2wrcclcyd.fsf@bob.laptop.org>
References: <1317645214-12316-1-git-send-email-adrian.hunter@intel.com>
	<1317645214-12316-2-git-send-email-adrian.hunter@intel.com>
	<4E8C6229.6010302@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38725 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752546Ab1JJWFp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Oct 2011 18:05:45 -0400
In-Reply-To: <4E8C6229.6010302@stericsson.com> (Ulf Hansson's message of "Wed,
	5 Oct 2011 15:56:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Wed, Oct 05 2011, Ulf Hansson wrote:
> Adrian Hunter wrote:
>> mmc_request_done() is sometimes called from interrupt
>> or other atomic context.  Mostly all mmc_request_done()
>> does is complete(), however it contains code to retry
>> on error, which uses ->request().  As the error path
>> is certainly not performance critical, this may be
>> moved to the waiting function mmc_wait_for_req_done().
>>
>> This allows ->request() to use runtime PM get_sync()
>> and guarantee it is never in an atomic context.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Calling back into the host driver directly from mmc_request_done when
> doing error handling were just plain wrong.
>
> This patch is really great, not just for pm_runtime issues!
>
> Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>

Pushed to mmc-next for 3.2.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
