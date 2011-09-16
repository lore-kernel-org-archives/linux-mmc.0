From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: add a short delay in mmc_power_off
Date: Fri, 16 Sep 2011 19:47:54 +0300
Message-ID: <CAK=WgbbdbLbt0+hdafk2jMNtwF3dWo0nNxy2VCScovJjC2v7HQ@mail.gmail.com>
References: <20110907092209.A52409D401C@zog.reactivated.net>
 <CAK=WgbYYXAVEnOsO1qwteJwPcn5Ror3ALLGfGB9Kj2LUVo8isA@mail.gmail.com>
 <CAMLZHHQp3JLT3dAHEF9YZy+rnRhVhftgpx=3dHH+G0gOaaseSQ@mail.gmail.com>
 <CAK=WgbanyR+AuMAhwYfZZMpM=G7Zcpgrd2B-P20Rkfdn3JPDMQ@mail.gmail.com>
 <CAMLZHHT-w5_YA+JbfeeAtJb9jP=AHgzzPxk2ZM2YAbptwcvQ2g@mail.gmail.com>
 <CAK=Wgbb-VitvdrEY0ze691F2BKof7Xt+LWuhLe-Y1PY3MiUbHA@mail.gmail.com>
 <CAMLZHHTT4SR52oq10HwxqskFiTJLD2BFj9AEmyg9+LrHd0Aqwg@mail.gmail.com>
 <CAK=Wgbbo_Y6KCYrcZmaScpxUQN83E0RNBj95gGD+2c2N7Z2dzw@mail.gmail.com> <CAMLZHHS7_6AnepMZwZEY8ReiCR7_LwB82Ar3yfoZQJAwBjs22w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f180.google.com ([74.125.82.180]:65352 "EHLO
	mail-wy0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753405Ab1IPQsP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 12:48:15 -0400
Received: by wyj26 with SMTP id 26so4974274wyj.11
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2011 09:48:14 -0700 (PDT)
In-Reply-To: <CAMLZHHS7_6AnepMZwZEY8ReiCR7_LwB82Ar3yfoZQJAwBjs22w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Fri, Sep 16, 2011 at 6:33 PM, Daniel Drake <dsd@laptop.org> wrote:
> Do you know the source of that info?

No, not more than what the comments say.

It also seems that the first delay was originally 1ms and at some
point it was increased to 2ms (commit
f9996aee36921e8f1d499de1b2ea380855cf6d97 "mmc: increase power up
delay"). Later on both delays were increased to 10ms (commit
79bccc5aefb4e64e651abe04f78c3e6bf8acd6f0 "mmc: increase power up
delay").

> It probably also justifies what we need here.

Maybe. I was wondering why nobody cared so far about putting delays at
the power down path then, but I guess no one was really powering down
their controllers ? I know Marvell did, using some out-of-tree code,
but IIUC Marvell utilizes the sd8686's reset gpios (much like we do
with the 12xx) to ensure hardware sanity. IIRC you guys don't toggle
them at all ?

> If short delays are needed when messing with power in the powerup path
> (i.e. "we just touched power state, give power lines a chance to reach
> that state"), it seems perfectly reasonable for similar (if not the
> exact same) things to apply during power down.

Sounds reasonable. Though I wonder why this is not abstracted in the
regulator code: it only seems reasonable that a power up/down handler
will return after the hardware is ready.

> I have asked our hardware guys about tracing, and they weren't sure
> exactly what I'm asking (and nor am I). Can you be more specific on
> exactly how they should diagnose this issue at the hardware level? I
> am not familiar with such tasks.

I'm interested how does the hardware reacts to the sdio reset command
that is sent at this state. There's no response whatsover ?

> They were also not surprised that a delay is needed when playing with
> power state in this way. Quickly bouncing rails can lead to
> indeterminate hardware behaviour.

I'm fine with your change. Feel free to add my Ack.

Thanks,
Ohad.
