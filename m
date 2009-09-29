From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: tmio-mmc driver update
Date: Tue, 29 Sep 2009 04:09:06 +0100
Message-ID: <c09aa50a0909282009t27d28774ra4aef12e3c98f36d@mail.gmail.com>
References: <c09aa50a0909251721r6cea65a4q49f0963dba9c9902@mail.gmail.com>
	<c09aa50a0909251735w18f825efx38bdcdf95c6fb388@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:33442 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbZI2DJX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 23:09:23 -0400
Received: by bwz6 with SMTP id 6so1719348bwz.37
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 20:09:27 -0700 (PDT)
In-Reply-To: <c09aa50a0909251735w18f825efx38bdcdf95c6fb388@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, sameo@openedhand.com, pb@handhelds.org

*prod*

After all the fuss about this, no-ones going to comment?

I just found the last tmio-related bug I want to squash before I
consider this patchset 'good to go' so people actually updatinng their
drivers / sending me code would be much appreciated. I'd prefer this
went in with all the affected drivers tested and ASIC3 I _do not have
one of_ to test.

Its only a few lines - can we get it finished please?

-Ian

2009/9/26 Ian Molton <ian@mnementh.co.uk>:
> 2009/9/26 Ian Molton <ian@mnementh.co.uk>:
> Hi guys,
> This is the tmio based part of the tmio-mmc driver update that removes the
> CNF area (clock and power control) from the driver and abstracts it so that
> more users can share the MMC driver itself.
>
> Its compilable, runs on my hardware, and is checkpatch clean.
>
> I havent updated ASIC3 as I cannot test it here - please could someone with
> hardware do this. It should only require a few lines of code similar to that
> in the other drivers. I expect it can share the code in tmio-core.c
>
> Magnus, please base your driver on this patchset, since its tested and shows
> no regressions on my hardware (something else seems to have stopped my
> tc6393xb device reading some cards, but this must have happened prior to
> this patch (from a quick bisect). It will read other cards, and so I dont
> think this patch is related. I'll look into this when I get time, but dont
> want to delay other peoples drivers getting updated / merged.
>
> Once someone sends me a patch for ASIC3 I will prepare this patchset for
> submission upstream.
>
> --
> Ian Molton
> Linux, Automotive, and other hacking:
> http://www.mnementh.co.uk/
>



-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/
