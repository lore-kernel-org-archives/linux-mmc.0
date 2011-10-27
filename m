From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Fri, 28 Oct 2011 00:25:12 +0200
Message-ID: <CAAgDR1OaF1uGnZ7=Uxc2NXRsHKmJwdFTWWKOL+Q-AgrDkr554g@mail.gmail.com>
References: <4EA93C08.9030009@samsung.com>
	<loom.20111027T202726-264@post.gmane.org>
	<CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
	<CAFEEs1kJ91ye-CGGFZ0C9E6cEE_7eNOi-H5tC=TNiLz3pv_mdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62783 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab1J0WZN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 18:25:13 -0400
Received: by ywm3 with SMTP id 3so3090920ywm.19
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2011 15:25:12 -0700 (PDT)
In-Reply-To: <CAFEEs1kJ91ye-CGGFZ0C9E6cEE_7eNOi-H5tC=TNiLz3pv_mdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org

Hi!

>> Well, you kind of need both.
> Periodical check is a complement, not a replacement.

Then we are indeed in agreement.

> Must BKOPS always be deferred until performance is impacted?

No, of course not. As you say doing BKOPS too late is not good, but
also doing them too often is probably not wise either (will cause
latency for interrupting BKOPS for too many requests in that case).

> About starvation.
> What happens if the BKOPS never have time to finish because new writes
> are coming in all the time. Is it possible to starve the
> BKOPS-operation?
> Will it come to a point when BKOPS must run without interruption?

The 4.5 spec says that if the level is at critical then some
operations may extend beyond their original timeouts due to
undelayable maintenance operations. So I can not forsee that an eMMC
might stop working because the level reached critical and the host did
not start BKOPS periodically. So as far as I understand it you may HPI
interrupt BKOPS at critical level in order to issue CMD25
(WRITE_MULTIPLE_BLOCK), but there is a good chance that this write
will take a long time to complete.

> One question is:
> Is it worth running BKOPS if the BKOPS_STATUS is only 1? I could run
> some tests comparing write performance when status is 0,1,2.

The spec is likely intentionally arbitrary about what these levels
mean in order to allow vendors to implement those differently.

> I don't know what the best place would be for a BKOPS_STATUS check.
> What comes to my mind is to use the same credentials that are used for
> power save.

That seems like a good option, yes.

> Suspend? if suspend is requested one might check BKOPS_STATUS and
> return -EBUSY if BKOPS needs to be started.

Maybe, one could also choose to do this based on the level of course.

However now that I'm thinking about it, I don't think Jaehoon has
taken care of the case where suspend happens while BKOPS are running
in the background. I guess one has to issue HPI in that case to stop
the BKOPS before going in to suspend, otherwise one risks cutting
power to the card while BKOPS are running.

 / Sebastian
