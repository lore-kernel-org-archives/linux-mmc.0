From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: SDIO runtime crash on resume
Date: Thu, 28 Oct 2010 16:39:34 +0200
Message-ID: <AANLkTinjXQy9Hcu68DmQ-Xq59P=PNq==m1FYKviz1Pe3@mail.gmail.com>
References: <AANLkTikVuQx+hUX8onLVdHW1mhfbH7MZJqsHt0s-baiA@mail.gmail.com> <AANLkTi=0oL38cmbGJ3sfE876ZxJUfrKK+wTs5+JBTR_r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44644 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333Ab0J1OkG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2010 10:40:06 -0400
Received: by iwn10 with SMTP id 10so2435270iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2010 07:40:06 -0700 (PDT)
In-Reply-To: <AANLkTi=0oL38cmbGJ3sfE876ZxJUfrKK+wTs5+JBTR_r@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Hi Daniel,

On Wed, Oct 27, 2010 at 10:37 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
...
> can you please tell me if you can reproduce this with mmc-next ?
>
> Can you please also send full logs (from boot to crash preferably) + .config ?

Please 'echo 8 > /proc/sys/kernel/printk' before generating the logs.

Some additional questions (some of them will be answered by the
logs+config you will send, but in case you're not in front of the
setup you can just answer those directly):

- What is your mmc host ? sdhci-pci presumably ? I might be able to
get such hardware.. But not before next week (LPC).. Hey any chance
you or Chris plan to attend LPC with this setup ? I'm going to be
there and if I had your setup with a reproducible bug that would make
this very easy to fix...

- During boot, was you card identified and added (i assume yes) ?

- After boot, was your card powered down (i assume yes) ?
  check this out by:
  mount -t debugfs none /sys/kernel/debug
  cat /sys/kernel/debug/mmc1/ios

- Just for general knowledge - as soon as you load your driver
(libertas, right ?) - was your card powered up and correctly
configured (sdio clock/voltage/bus width. again check with
/sys/kernel/debug/mmc2/ios) ?

> mmc1: error -110 during resume (card was removed?)

I assume there are no failures before it ? the system was correctly suspended ?

Anyway this timeout (-110) shouldn't happen. The device might still be
powered off for some reason. I guess the timeout is coming from
mmc_sdio_init_card(). I just wonder whether it's coming already from
mmc_send_io_op_cond(), or whether it's a side effect of 9b966aae64 and
thus it's coming from a later stage of mmc_sdio_init_card. If you can
please put some pr_info("%s %d: ret %d\n", __func__, __LINE__, ret)
lines throughout that function that could be great.

>> mmc1: card 0001 removed

care to put a dump_stack() in the beginning of mmc_remove_card() ?

>> IP: [<b05e9d95>] __pm_runtime_idle+0x15/0x53

That can be all sort of badness.

I'll wait for the logs+more info (+chance to have this setup in LPC ;)
and we'll continue from there.

Thanks,
Ohad.
