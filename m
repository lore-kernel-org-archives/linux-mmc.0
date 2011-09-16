From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: add a short delay in mmc_power_off
Date: Fri, 16 Sep 2011 16:33:05 +0100
Message-ID: <CAMLZHHS7_6AnepMZwZEY8ReiCR7_LwB82Ar3yfoZQJAwBjs22w@mail.gmail.com>
References: <20110907092209.A52409D401C@zog.reactivated.net>
	<CAK=WgbYYXAVEnOsO1qwteJwPcn5Ror3ALLGfGB9Kj2LUVo8isA@mail.gmail.com>
	<CAMLZHHQp3JLT3dAHEF9YZy+rnRhVhftgpx=3dHH+G0gOaaseSQ@mail.gmail.com>
	<CAK=WgbanyR+AuMAhwYfZZMpM=G7Zcpgrd2B-P20Rkfdn3JPDMQ@mail.gmail.com>
	<CAMLZHHT-w5_YA+JbfeeAtJb9jP=AHgzzPxk2ZM2YAbptwcvQ2g@mail.gmail.com>
	<CAK=Wgbb-VitvdrEY0ze691F2BKof7Xt+LWuhLe-Y1PY3MiUbHA@mail.gmail.com>
	<CAMLZHHTT4SR52oq10HwxqskFiTJLD2BFj9AEmyg9+LrHd0Aqwg@mail.gmail.com>
	<CAK=Wgbbo_Y6KCYrcZmaScpxUQN83E0RNBj95gGD+2c2N7Z2dzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42483 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645Ab1IPPdH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 11:33:07 -0400
Received: by yxm8 with SMTP id 8so2986583yxm.19
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2011 08:33:05 -0700 (PDT)
In-Reply-To: <CAK=Wgbbo_Y6KCYrcZmaScpxUQN83E0RNBj95gGD+2c2N7Z2dzw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Wed, Sep 7, 2011 at 8:12 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> I wouldn't call them random - they're pretty much explained.

Do you know the source of that info? It probably also justifies what
we need here.

If short delays are needed when messing with power in the powerup path
(i.e. "we just touched power state, give power lines a chance to reach
that state"), it seems perfectly reasonable for similar (if not the
exact same) things to apply during power down.

I have asked our hardware guys about tracing, and they weren't sure
exactly what I'm asking (and nor am I). Can you be more specific on
exactly how they should diagnose this issue at the hardware level? I
am not familiar with such tasks.

They were also not surprised that a delay is needed when playing with
power state in this way. Quickly bouncing rails can lead to
indeterminate hardware behaviour.

Thanks,
Daniel
