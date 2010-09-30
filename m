From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
Date: Thu, 30 Sep 2010 09:22:17 +0200
Message-ID: <AANLkTikywfU_C4QTQet64aQJgQyyDdTh4xRpaYu6q0di@mail.gmail.com>
References: <4C91BD5A.1040804@samsung.com>
	<20100929233751.GA31473@void.printf.net>
	<alpine.LFD.2.00.1009292334050.1146@xanadu.home>
	<20100930040958.GA3170@void.printf.net>
	<AANLkTin=9KwC0Paa8yAhG-OBXFrfJDKJSYokzLLa6jPN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40179 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927Ab0I3HWS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 03:22:18 -0400
Received: by gwj17 with SMTP id 17so582295gwj.19
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2010 00:22:17 -0700 (PDT)
In-Reply-To: <AANLkTin=9KwC0Paa8yAhG-OBXFrfJDKJSYokzLLa6jPN@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Nicolas Pitre <nico@fluxnic.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Pierre Ossman <pierre-list@ossman.eu>, Kukjin Kim <kgene.kim@samsung.com>

2010/9/30 Kyungmin Park <kyungmin.park@samsung.com>:
> On Thu, Sep 30, 2010 at 1:09 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi,
>>
>> On Wed, Sep 29, 2010 at 11:42:01PM -0400, Nicolas Pitre wrote:
>>> As I already said here:
>>>
>>> =A0 =A0 =A0 http://article.gmane.org/gmane.linux.ports.arm.omap/394=
11
>>>
>>> I find those callbacks rather problematic. =A0Currently,
>>> mmc_host_disable() is called by the host driver (currently OMAP) an=
d
>>> that's wrong. =A0Such decision cannot be made in the controller dri=
ver --
>>> it has to be made higher up the stack.
>>
>> I strongly agree. =A0I hadn't noticed that aspect of this design unt=
il
>> today. =A0It looked like Linus W had a nice core-integrated clocking
>> framework almost ready to go a year ago, but it lost out. =A0(Someth=
ing
>> left to do was to give extra time after a request in case we're on a
>> broken card which requires the card clock to be present during its
>> writeback.)
>
> Do you mean this one?
> http://www.mail-archive.com/linux-embedded@vger.kernel.org/msg01883.h=
tml

That's it. If there is interest I can surely pick it up and wrap the
current enable/disable calls around it or even rewrite all drivers
to use the set_ios() approach as in this patchset I think.

What happened was that I had this iterated a few times as Pierre was
getting increasingly overloaded and it was on the verge of merging
when he resigned as MMC maintainer.

The next week or so the big hammer callbacks from OMAP were
merged as part of their mainline procedure.

> In previous time it used for our kernel and find it's difficult to
> handle and maintain and can't support the SD card.
> So try to find another method and implemente it at SDHCI drivers.

Why? The only difference between this solution and the one
that is inside the kernel now is that this will use set_ios() with
a zero argument to gate off the clock after a timeout instead
of special callbacks. (A features especially requested by Pierre.)

I can move the timeing code to wrap the current callbacks
instead atleast that would make things more according to spec.

=46or MMC cards that is.

=46or SD cards IIRC the spec is the same, but in practice all
SD cards (and especially all MicroSD and eMMCs we see these
days) survive gating the clock off like these current callbacks do.
That I believe is why people have so little trouble with the present
code.

Yours,
Linus Walleij
