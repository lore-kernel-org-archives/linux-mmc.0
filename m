From: Chao Xu <caesarxuchao@gmail.com>
Subject: Re: wl1271: sdio: is fine-grained runtime_pm possible?
Date: Mon, 13 Jan 2014 22:46:01 -0600
Message-ID: <CAKZq+rf8HAhtjNw3CHPp2C0a2mv0d-zgN6VgdqC5rt4ysOkcpQ@mail.gmail.com>
References: <CAKZq+rdaCivZTFSTGt9_Q+3KFE9Ft0XfmWZ=1Vr7QcDDs9=Muw@mail.gmail.com>
	<867ga39raz.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:63850 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbaANEqC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 23:46:02 -0500
Received: by mail-qa0-f52.google.com with SMTP id j15so6571260qaq.25
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 20:46:01 -0800 (PST)
In-Reply-To: <867ga39raz.fsf@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: Luciano Coelho <luciano.coelho@intel.com>, Ohad Ben-Cohen <ohad@wizery.com>, linux-mmc@vger.kernel.org

Hi Chris,

Thank you for your comments!

I'm only familiar with OMAP4 chip. I can't speak for other devices.
AFAIK, if configured properly, even after pm_runtiem_put() is called,
sdio on OMAP4 can generate wake-up events when interrupts occur, so
that CPU _will_ receive the interrupts. So everything should work as
long as the driver calls pm_runtime_get() before handling the IRQ,
which involves reading/writing registers.

I'm not an expert about WLAN devices. But my understanding is wl1271
merely uses sdio as the way to talk to cpu. So turning off sdio
doesn't mean turning off the entire WLAN device, am I right? What I'm
suggesting here is turning off sdio when it's not used, not the entire
WLAN device.

Thanks again.

On Mon, Jan 13, 2014 at 9:27 PM, Chris Ball <chris@printf.net> wrote:
> Hi,
>
> On Tue, Jan 14 2014, Chao Xu wrote:
>> The patch "SDIO Runtime PM Support" implements the pm for wl12xx
>> driver this way: the power for sdio is on whenever the WLAN interface
>> is on, and the power is down only when the interface is down.
>> Is it possible to do pm in a more fine-grained way, such as only
>> turning on the power when reading/writing through sdio? An example is
>> the mmc_blk_issue_rq() in drivers/mmc/card/block.c, where the host is
>> released when there are no more requests. And in turn the host driver,
>> such as omap_hsmmc.c, calls pm_runtime_put_autosuspend().
>> Is there any fundamental argument against doing fine-grained runtime
>> pm for sdio? Or is it just too much trouble for too little power
>> saved?
>> Thank you!
>
> I feel like I must be missing something, but:
>
> Network devices generate interrupts when you have new network activity
> to process, and to generate an interrupt they need to be turned on.
>
> How would you avoid having the WLAN device be unpowered while someone
> is trying to talk to you?
>
> - Chris.
> --
> Chris Ball   <chris@printf.net>   <http://printf.net/>



-- 
Regards,
Chao Xu
