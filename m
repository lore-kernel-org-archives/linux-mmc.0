From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: add a short delay in mmc_power_off
Date: Fri, 16 Sep 2011 19:03:39 +0100
Message-ID: <CAMLZHHQ73JZnmVD++X4=qab+5Y=utaFC+44-sSxN+j_T4nGV7w@mail.gmail.com>
References: <20110907092209.A52409D401C@zog.reactivated.net>
	<CAK=WgbYYXAVEnOsO1qwteJwPcn5Ror3ALLGfGB9Kj2LUVo8isA@mail.gmail.com>
	<CAMLZHHQp3JLT3dAHEF9YZy+rnRhVhftgpx=3dHH+G0gOaaseSQ@mail.gmail.com>
	<CAK=WgbanyR+AuMAhwYfZZMpM=G7Zcpgrd2B-P20Rkfdn3JPDMQ@mail.gmail.com>
	<CAMLZHHT-w5_YA+JbfeeAtJb9jP=AHgzzPxk2ZM2YAbptwcvQ2g@mail.gmail.com>
	<CAK=Wgbb-VitvdrEY0ze691F2BKof7Xt+LWuhLe-Y1PY3MiUbHA@mail.gmail.com>
	<CAMLZHHTT4SR52oq10HwxqskFiTJLD2BFj9AEmyg9+LrHd0Aqwg@mail.gmail.com>
	<CAK=Wgbbo_Y6KCYrcZmaScpxUQN83E0RNBj95gGD+2c2N7Z2dzw@mail.gmail.com>
	<CAMLZHHS7_6AnepMZwZEY8ReiCR7_LwB82Ar3yfoZQJAwBjs22w@mail.gmail.com>
	<CAK=WgbbdbLbt0+hdafk2jMNtwF3dWo0nNxy2VCScovJjC2v7HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f42.google.com ([74.125.83.42]:46148 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab1IPSDk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2011 14:03:40 -0400
Received: by gwb17 with SMTP id 17so4778838gwb.1
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2011 11:03:39 -0700 (PDT)
In-Reply-To: <CAK=WgbbdbLbt0+hdafk2jMNtwF3dWo0nNxy2VCScovJjC2v7HQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Fri, Sep 16, 2011 at 5:47 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Maybe. I was wondering why nobody cared so far about putting delays at
> the power down path then, but I guess no one was really powering down
> their controllers ? I know Marvell did, using some out-of-tree code,
> but IIUC Marvell utilizes the sd8686's reset gpios (much like we do
> with the 12xx) to ensure hardware sanity. IIRC you guys don't toggle
> them at all ?

Yes, I think the power down/up paths are not really tested that much
as they are new. I note that even doing fast power cycles as happen
automatically during boot, and also by doing ifup/ifdown in a loop are
not quite quick enough to trigger this, so it is a bit of a corner
case. I could only trigger it in a modprobe/rmmod cycle which is
somehow quicker than the other mechanisms. (thats why I didn't realise
before we merged the earlier patches, which at first seemed to be
working perfectly)

We also don't use the GPIOs, as you mention. We could, perhaps via a
regulator, but it would be hard to tell if they made a difference. I
found that a 1ms sleep here is far more than is needed, even short
udelays appear to solve the problem. So if any code were to execute
here at all it would probably cause enough of a delay to avoid this
problem, effective or not.

> I'm interested how does the hardware reacts to the sdio reset command
> that is sent at this state. There's no response whatsover ?

Thats right, its all -ETIMEDOUT. Including mmc_wait_for_idle(). Its as
if the stuff in mmc_power_up() never happened.

> I'm fine with your change. Feel free to add my Ack.

Great, thanks for being thorough!

Daniel
