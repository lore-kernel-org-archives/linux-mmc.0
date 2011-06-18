From: Daniel Drake <dsd@laptop.org>
Subject: Re: SD8686 fast power-cycle problems
Date: Sat, 18 Jun 2011 10:37:10 +0100
Message-ID: <BANLkTim1rai5pv+hW3mMxXieq5289oYJSg@mail.gmail.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58274 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab1FRJhL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 18 Jun 2011 05:37:11 -0400
Received: by pzk9 with SMTP id 9so2366592pzk.19
        for <linux-mmc@vger.kernel.org>; Sat, 18 Jun 2011 02:37:10 -0700 (PDT)
In-Reply-To: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei.gao@marvell.com, bzhao@marvell.com, bchau@marvell.com
Cc: linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

On 17 June 2011 17:39, Daniel Drake <dsd@laptop.org> wrote:
> If we power down the card, and then *immediately* power it on again
> (and performing the CMD5,5,3,7 init sequence), the card fails to
> respond to the first CMD5.
>
> We have identified two workarounds to this problem:
> 1. If we wait 300ms after powering off the card before turning it on
> again, it works fine.
>
> 2. If we perform a SDIO I/O reset after powering on, before starting
> the 5,5,3,7 sequence, it works fine.

I would still be interested in any comments you have on this issue,
but actually it appears that it is probably related to the way that
the SD8686 power line is wired up on our motherboard.

OLPC's hardware team apologetically says "There are no turn-off clamps
on the WLAN power. What that means is that when you turn off the power
there isn't anything that will quickly pull the voltage down to zero
or near zero.  So when you turn off the power it takes time for the
voltage to decay. With the amount of capacitance on that rail 300ms
decay time doesn't sound unreasonable. You will have to delay or use
the SDIO reset method."

Thanks,
Daniel
