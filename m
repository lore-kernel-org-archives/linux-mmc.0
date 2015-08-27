From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Initial signal voltage ?
Date: Thu, 27 Aug 2015 16:44:34 +0200
Message-ID: <CAPDyKFrVNoyeHdcBbTJ3AFhU2EeWZsXqBkCqHNswWzCKxUOs=A@mail.gmail.com>
References: <1439225438.3120.94.camel@transmode.se>
	<CAPDyKFpDzBV9zXAZH_KddZVdUQ_t2W3Qb3yG70ceagv4+oy7cQ@mail.gmail.com>
	<1440505201.3349.59.camel@transmode.se>
	<CAPDyKFpv3HyZSvGXWb-dzD1nec0173TyzegxRiWuhTdm9GdXAg@mail.gmail.com>
	<1440686001.3349.115.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:34675 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753060AbbH0Oof (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2015 10:44:35 -0400
Received: by widdq5 with SMTP id dq5so80366828wid.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Aug 2015 07:44:34 -0700 (PDT)
In-Reply-To: <1440686001.3349.115.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

[...]

>>
>> Currently drivers return error codes according to when they can't set
>> the requested voltage level, so that's all fine - right?
>
> Yes, they should. Hovever it seems like my fsl controller cannot.
> There is VS18,VS30 and VS33 bits in hostcap register but theses are
> always set :(

If there are set in the *hostcap* register, doesn't that indicates
that they are supported? Not what's currently used!?

What controller/driver are you using here?

>
>>
>> Moreover, the above code snippet is modified by you (or someone else)
>> locally, since in the upstream version of the code, the prints are
>
> ahh, yes a did that while debugging.
>
>> done a debug level. That's also okay, I think.
>> Perhaps changing the last print to warn level instead, since reaching
>> that point would mean all attempts have failed.
>
> Since not all controllers can tell what VS is you have to specify that, in my case I
> do it in my device tree as there is a way to do that already.
>
> So I think mmc_power_up() should mask away VS not supported and then try the remaining.
> The exact way to do this escapes me as I am not familiar with this area yet.

Okay, I think we could potentially look at the host caps and figure
out what IO voltage level the host supports before trying to set them.

Although it does complicates things, so before going there I just want
to be sure that we really have an issue here.

I haven't yet really understood why your driver is unable to return
error codes when failing to set an unsupported voltage level, you need
to convince me on that.

Kind regards
Uffe
