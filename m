From: Ido Yariv <ido@wizery.com>
Subject: Re: [PATCH 2/5] arm: davinci: Allow EVENTQ_0 as a default queue
Date: Fri, 8 Jul 2011 17:27:17 +0300
Message-ID: <20110708142717.GG2176@WorkStation>
References: <1310074390-4277-1-git-send-email-ido@wizery.com>
 <1310074390-4277-3-git-send-email-ido@wizery.com>
 <4E16DB13.90806@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39431 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218Ab1GHO1Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 10:27:25 -0400
Received: by wwe5 with SMTP id 5so2027716wwe.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2011 07:27:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E16DB13.90806@mvista.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-mmc@vger.kernel.org

Hi,

On Fri, Jul 08, 2011 at 02:25:23PM +0400, Sergei Shtylyov wrote:
> On 08-07-2011 1:33, Ido Yariv wrote:
> 
> >Davinci platforms may define a default queue for each channel
> >controller. If one is not defined, the default queue is set to EVENTQ_1.
> >However, there's no way to distinguish between an unset default queue to
> >one that is set to EVENTQ_0, as EVENTQ_0 = 0.
> 
> >In order to keep existing behaviour on platforms which don't specify a
> >default_queue member, the default_queue member was modified to be a
> >pointer to enum dma_event_q. A NULL value means that this member was not
> >specified.
> 
>    Mmm, perhaps it's better to drop the default EVENTQ_1 concept and
> explicitly initilaize that field for every SoC. It's also possible
> to offset the event queue number by 1. I don't like the pointer
> solution.

Dropping the default EVENTQ_1 is probably the best solution, but doing
so has the potential of breaking some Davinci platforms (not currently
in mainline) which don't specify this member.

The second option was also considered - modifying the dma_event_q enum,
incrementing all EVENTQ_X constants, and decrementing the value back in
map_dmach_queue. This approach has two minor drawbacks:

* There are other users of this enum, besides the default queue.
  However, AFAIK, there's only one function (map_dmach_queue) that
  actually cares about the numerical values.
* If someone currently defines a queue numerically, this code could
  break. Obviously, defining a queue numerically is not something that
  should be done.

If there aren't any objections, we could go for the first option.

Thanks for your review,
Ido.
