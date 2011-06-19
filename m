From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: SD8686 fast power-cycle problems
Date: Sun, 19 Jun 2011 21:10:07 +0800
Message-ID: <BANLkTimoOXZvNt_GR4EHcSX_YecOubLPbw@mail.gmail.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
	<BANLkTim1rai5pv+hW3mMxXieq5289oYJSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42531 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab1FSNKI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 19 Jun 2011 09:10:08 -0400
Received: by vxb39 with SMTP id 39so394758vxb.19
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jun 2011 06:10:07 -0700 (PDT)
In-Reply-To: <BANLkTim1rai5pv+hW3mMxXieq5289oYJSg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: zhangfei.gao@marvell.com, bzhao@marvell.com, bchau@marvell.com, linux-mmc@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>

On Sat, Jun 18, 2011 at 5:37 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 17 June 2011 17:39, Daniel Drake <dsd@laptop.org> wrote:
>> If we power down the card, and then *immediately* power it on again
>> (and performing the CMD5,5,3,7 init sequence), the card fails to
>> respond to the first CMD5.
>>
>> We have identified two workarounds to this problem:
>> 1. If we wait 300ms after powering off the card before turning it on
>> again, it works fine.
>>
>> 2. If we perform a SDIO I/O reset after powering on, before starting
>> the 5,5,3,7 sequence, it works fine.
>
> I would still be interested in any comments you have on this issue,
> but actually it appears that it is probably related to the way that
> the SD8686 power line is wired up on our motherboard.
>
> OLPC's hardware team apologetically says "There are no turn-off clamp=
s
> on the WLAN power. What that means is that when you turn off the powe=
r
> there isn't anything that will quickly pull the voltage down to zero
> or near zero. =A0So when you turn off the power it takes time for the
> voltage to decay. With the amount of capacitance on that rail 300ms
> decay time doesn't sound unreasonable. You will have to delay or use
> the SDIO reset method."
>
> Thanks,
> Daniel

Hi, Daniel

How do you power off 8686 now?
Use RESETn, PDn, or directly control regulator?
Assume RESETn is kept high as Ohad mentioned before, do you control PDn=
?
If directly control regulator, the decay time is needed.

It seems 8686 is not power off, so I/O reset is needed for init
sequence (CMD5, 5, 3, 7).

Thanks

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
