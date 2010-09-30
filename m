From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: Re: [RFC RESEND] sdhci-s3c: support clock enable/disable (clock-gating)
Date: Thu, 30 Sep 2010 13:31:15 +0900
Message-ID: <AANLkTin=9KwC0Paa8yAhG-OBXFrfJDKJSYokzLLa6jPN@mail.gmail.com>
References: <4C91BD5A.1040804@samsung.com>
	<20100929233751.GA31473@void.printf.net>
	<alpine.LFD.2.00.1009292334050.1146@xanadu.home>
	<20100930040958.GA3170@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58248 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab0I3EbR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 00:31:17 -0400
Received: by wyb28 with SMTP id 28so1489542wyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 29 Sep 2010 21:31:15 -0700 (PDT)
In-Reply-To: <20100930040958.GA3170@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Nicolas Pitre <nico@fluxnic.net>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, matt@console-pimps.org, Andrew Morton <akpm@linux-foundation.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Pierre Ossman <pierre-list@ossman.eu>, Kukjin Kim <kgene.kim@samsung.com>

On Thu, Sep 30, 2010 at 1:09 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Sep 29, 2010 at 11:42:01PM -0400, Nicolas Pitre wrote:
>> As I already said here:
>>
>> =A0 =A0 =A0 http://article.gmane.org/gmane.linux.ports.arm.omap/3941=
1
>>
>> I find those callbacks rather problematic. =A0Currently,
>> mmc_host_disable() is called by the host driver (currently OMAP) and
>> that's wrong. =A0Such decision cannot be made in the controller driv=
er --
>> it has to be made higher up the stack.
>
> I strongly agree. =A0I hadn't noticed that aspect of this design unti=
l
> today. =A0It looked like Linus W had a nice core-integrated clocking
> framework almost ready to go a year ago, but it lost out. =A0(Somethi=
ng
> left to do was to give extra time after a request in case we're on a
> broken card which requires the card clock to be present during its
> writeback.)

Do you mean this one?
http://www.mail-archive.com/linux-embedded@vger.kernel.org/msg01883.htm=
l

In previous time it used for our kernel and find it's difficult to
handle and maintain and can't support the SD card.
So try to find another method and implemente it at SDHCI drivers.

>
> I'm not sure where to go from here -- advice welcome. =A0It would
> perhaps be ideal if Linus W and Adrian could work together to make
> the current framework look more like Linus' original intent and then
> move omap_hsmmc to it as painlessly as possible. =A0Of course I would=
n't
> expect this to happen quickly.
>
> In the meantime, I would suggest that we should not accept any more
> users of this framework, which would be a NACK to Jaehoon's patch
> (which appears to my reading not to achieve any power-saving anyway).

No, In our case it deduce the about 10mA. so it's mandatory and basic
functionality to reduce the power.

Thank you,
Kyungmin Park
>
> Adrian, I'm sorry that I'm suggesting reverting -- or at least strong=
ly
> modifying -- a framework after it's already shipped in a release; if
> you think this is unreasonable, I'll consider your argument carefully=
=2E
>
> Thanks,
>
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
