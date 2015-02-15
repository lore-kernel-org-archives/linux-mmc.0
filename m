From: John Tobias <john.tobias.ph@gmail.com>
Subject: Re: SDIO - High Speed - iMX6
Date: Sat, 14 Feb 2015 22:54:10 -0800
Message-ID: <CACUGKYMJm7qTLHBJwH=58mhpcJBePPgOKt96cw1XECX2ozPwuQ@mail.gmail.com>
References: <CACUGKYNPE1zAHt4Hx4c5ufuHNchVXnUOC1znCa7dT9povD_CWQ@mail.gmail.com>
	<CAOMZO5DR2nnoChgC2PbXkrDCAfF0WG_Vf+iXR3UsfFGxQxagmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:35298 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbBOGyL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Feb 2015 01:54:11 -0500
Received: by labgm9 with SMTP id gm9so23325015lab.2
        for <linux-mmc@vger.kernel.org>; Sat, 14 Feb 2015 22:54:10 -0800 (PST)
In-Reply-To: <CAOMZO5DR2nnoChgC2PbXkrDCAfF0WG_Vf+iXR3UsfFGxQxagmA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Fabio,

I was able to work it.

Regards,

John

On Sat, Feb 14, 2015 at 10:48 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi John,
>
> On Wed, Feb 11, 2015 at 10:24 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hello All,
>>
>> We interface the WiLink8 (http://www.ti.com/lit/gpn/wl1807mod) in iMX6
>> custom board. The VIO is 1.8v and the kernel detect the chip in high
>> speed mode with a signal voltage of 3.3v.
>>
>> Is there a way to force the kernel to use a 1.8v signal voltage?.
>
> In drivers/mmc/core/sdio.c, function mmc_sdio_init_card() has:
>
>     /*
>      * If the host and card support UHS-I mode request the card
>      * to switch to 1.8V signaling level.  No 1.8v signalling if
>      * UHS mode is not enabled to maintain compatibility and some
>      * systems that claim 1.8v signalling in fact do not support
>      * it.
>      */
>     if (!powered_resume && (rocr & ocr & R4_18V_PRESENT)) {
>         err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180,
>                     ocr);
>
> Can you add a printk to check if mmc_set_signal_voltage() is getting called?
