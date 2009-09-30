From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: TMIO MMC: full patchset.
Date: Wed, 30 Sep 2009 21:15:22 +0100
Message-ID: <c09aa50a0909301315o683322e4k4b85e21ab473341e@mail.gmail.com>
References: <c09aa50a0909290552j1c371ddfpc7444d5d87e66f76@mail.gmail.com>
	<aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:57967 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbZI3UPj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Sep 2009 16:15:39 -0400
Received: by bwz6 with SMTP id 6so3111946bwz.37
        for <linux-mmc@vger.kernel.org>; Wed, 30 Sep 2009 13:15:42 -0700 (PDT)
In-Reply-To: <aec7e5c30909300441w6ca07dd9o889590c6100b846b@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, sameo@openedhand.com, pb@handhelds.org, philipp.zabel@gmail.com, akpm@linux-foundation.org

No, sorry, this is not the way to do it. Please actually use the
platform hooks I provided, thats *why* I spent all this time rewriting
the driver for you. All you've done is add the same hook I added but
in a broken way.

Passing struct clk pointers about is _not the right way_ its not the
way the clk api was designed to be used. clocks are _got and _put by
name and device references, and the pointers should not be getting
passed from platform code to modular drivers.

Doing it from the platform code via the hooks I provided is not a
workaround - its the proper way to do it until such time as the clk
API is merged into the core kernel and divorced from its CPU
dependency (so that MFD drivers can use it to provide clocks and the
tmio_mmc driver can lose the platform hooks for clocking).

Some constructive advice follows:

Does your clock rate vary dynamically, or is it on a per platform
basis? If the latter then thats fine. If the former, you will need to
do a lot more work as tmio-mmc was not written to support the clock
rate getting changed under its feet, and you could fry peoples
hardware.

Also I would recommend that you merge all the platform data patches
along with the kconfig patch as a single changeset in git or a single
patch if you arent using git (you should use git). There is no reason
to seperate them, and the platform data patches are useless without
the kconfig patch (and vice-versa).

Since you will be then submitting the platform patches all at once,
then I suggest you factor out all the identical MMC related structs
into a seperate file (pxa has devices.c - superh may have something
similar?) and then you can simply add the devices to a list of devices
or have a single function call in each of the platform files, rather
than duplicating the code all over the place. My guess is these wont
be the only superH boards to use this driver. If the name of the MMC
clock differs on each board, you can solve this by using a clock alias
on each board (you may need to copy the clock alias support I wrote
for SA1100/PXA - not sure if it went in to the generic code or just
ARM stuff)

Also you should consider adding updated defconfigs for each of the
affected platforms to that patchset when you submit it - if you dont
you will break them because they will lose their spi MMC access. That
might be a bit serious if thats where their root fs is...

As a bonus of using the tmio-mmc platform hooks properly, you also get
to submit everything via the superH tree. You may consider the Kconfig
patch acked-by me but I think it should be merged as part of a
patchset containing all the platform patches too.

I'd like to see the updated version when you're done.

HTH!

-Ian

2009/9/30 Magnus Damm <magnus.damm@gmail.com>:
> Hey Ian,
>
> [CC akpm]
>
> On Tue, Sep 29, 2009 at 9:52 PM, Ian Molton <ian@mnementh.co.uk> wrote:
>> Hi guys,
>>
>> This is the full TMIO MMC patchset, compiled, tested, checkpatch passed.
>>
>> Please base all tmio based code on top of this patchset.
>
> I just took patch 0001->0005 for a spin on SuperH and they seem fine.
> Feel free to add an acked-by from me for the first patch. I know too
> little about the other parts to say anything useful.
>
> To get SuperH working I also need to update the kconfig. And to detect
> the clock rate dynamically I needed another minor patch. If you
> dislike the clock patch then I can also work around it in the board
> code for now.
>
> I plan on submitting the platform data patches to the SuperH mailing
> list in the near future, but I may need to rework them somehow if you
> dislike the clock patch approach.
>
> Cheers,
>
> / magnus
>



-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
