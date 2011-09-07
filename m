From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mmc: add a short delay in mmc_power_off
Date: Wed, 7 Sep 2011 22:12:34 +0300
Message-ID: <CAK=Wgbbo_Y6KCYrcZmaScpxUQN83E0RNBj95gGD+2c2N7Z2dzw@mail.gmail.com>
References: <20110907092209.A52409D401C@zog.reactivated.net>
 <CAK=WgbYYXAVEnOsO1qwteJwPcn5Ror3ALLGfGB9Kj2LUVo8isA@mail.gmail.com>
 <CAMLZHHQp3JLT3dAHEF9YZy+rnRhVhftgpx=3dHH+G0gOaaseSQ@mail.gmail.com>
 <CAK=WgbanyR+AuMAhwYfZZMpM=G7Zcpgrd2B-P20Rkfdn3JPDMQ@mail.gmail.com>
 <CAMLZHHT-w5_YA+JbfeeAtJb9jP=AHgzzPxk2ZM2YAbptwcvQ2g@mail.gmail.com>
 <CAK=Wgbb-VitvdrEY0ze691F2BKof7Xt+LWuhLe-Y1PY3MiUbHA@mail.gmail.com> <CAMLZHHTT4SR52oq10HwxqskFiTJLD2BFj9AEmyg9+LrHd0Aqwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43371 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337Ab1IGTMz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2011 15:12:55 -0400
Received: by wyh22 with SMTP id 22so5631477wyh.19
        for <linux-mmc@vger.kernel.org>; Wed, 07 Sep 2011 12:12:54 -0700 (PDT)
In-Reply-To: <CAMLZHHTT4SR52oq10HwxqskFiTJLD2BFj9AEmyg9+LrHd0Aqwg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

On Wed, Sep 7, 2011 at 10:03 PM, Daniel Drake <dsd@laptop.org> wrote:
>> Adding random sleeps without understanding what exactly do they solve
>> generally feels wrong...
>
> Well, if you remove the existing sleeps from mmc_power_up do things
> keep working for you?

I wouldn't call them random - they're pretty much explained.

OTOH, the delay you're suggesting to add isn't: we don't know what is
it solving exactly and why is it needed.

IMHO mainline kernel code should be well explained, otherwise it'd
become impossible to maintain.
