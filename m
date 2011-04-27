From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/2] Race fixes in sdhci
Date: Wed, 27 Apr 2011 16:41:27 -0400
Message-ID: <m3y62vl954.fsf@pullcord.laptop.org>
References: <20110427132329.GA21499@opensource.wolfsonmicro.com>
	<BANLkTint2cr6vFwBGX1RCTYyvrTc0if=yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58272 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759093Ab1D0UiE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2011 16:38:04 -0400
In-Reply-To: <BANLkTint2cr6vFwBGX1RCTYyvrTc0if=yA@mail.gmail.com> (Andrei
	Warkentin's message of "Wed, 27 Apr 2011 14:33:13 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Hi,

On Wed, Apr 27 2011, Andrei Warkentin wrote:
> On Wed, Apr 27, 2011 at 8:23 AM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:
>> I've had this pair of patches sitting in my tree for a while now (I
>> believe they were previously posted) providing stability improvements in
>> sdhci on my systems.  Having looked through the code I believe but have
>> not confirmed that the issue is that the timeout is racing with an
>> actual completion of a pending task - both paths will trigger the
>> tasklet, and if you trigger a tasklet while it is running this causes it
>> to be rescheduled.  The result will be that the tasklet gets run a
>> second time with no work pending for it.
>>
>> I'm not convinced that these are the best fixes (it feels like we should
>> instead be closing the races down) but I don't really have time to come
>> up with something better myself right now so I'm pushing them out as-is
>> for comment.
>
> So the timeout interrupt occurs after even though the command
> succeeds? Am I interpreting that correctly?

No, I think Mark's saying there's a race of:

* the successful completion interrupt fires, and

* the host timer fires to signify timeout due to *lack* of an interrupt
  (via sdhci_timeout_timer()).  i.e., the completion interrupt fires
  very close to the timeout period.

Both cases call tasklet_schedule(&host->finish_tasklet), and if you
manage to schedule a tasklet while it's already running, it runs again
after it completes -- but during the first run we set host->mrq->cmd to
NULL, so then it oopses on the second run.

We could consider taking Mark's first patch and also adding to the top:

        /*
         * If we get scheduled twice concurrently, this tasklet will
         * be run again afterwards but without any active request.
         */
        if (!host->mrq)
                return;

.. and pushing to .39 with a stable@ tag.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
