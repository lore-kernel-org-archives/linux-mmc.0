From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Tue, 28 Jun 2011 08:55:41 +0300
Message-ID: <BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
 <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com> <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
 <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:64286 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755614Ab1F1F4D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 01:56:03 -0400
Received: by wwg11 with SMTP id 11so2677154wwg.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2011 22:56:01 -0700 (PDT)
In-Reply-To: <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi Daniel,

On Sun, Jun 5, 2011 at 3:31 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 5 June 2011 00:08, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> We can stop checking the return value of pm_runtime_get_sync in
>> sdio_bus_remove, like pci_device_remove is doing, but I don't think
>> that's enough: I guess libertas' if_sdio_remove won't be so happy
>> dealing with a powered off card.
>>
>> Can you try the following please (untested):
>
> Thanks, that seems to be working.

That patch had two hunks.

The first one, in mmc_sdio_remove, made sure libertas' ->remove()
handler will be called powered on, even if the chip was powered off
beforehand.

The second one, in sdio_bus_remove, directly took care of the problem
you saw by ignoring rumtime PM's return value (which is a valid error
in your scenario).

Obviously the second hunk is necessary, but I'd like to know whether
the first one really is too or not. Can you please retest this without
that hunk (try to suspend/resume while the chip is powered off, and
again while it is powered on, but wol isn't used) ?

If the second hunk is sufficient (everything works as expected + no
scary error messages coming from libertas), I would like to avoid the
first one. I'm not sure at all there's any reason to power up the card
if it is being removed, and a quick glance shows libertas_sdio has
this 'user_rmmod' flag which should prevent scary error messages in
this exact scenario.

Thanks,
Ohad.
