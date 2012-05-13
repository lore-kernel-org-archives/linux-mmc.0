From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 08/10] mmc: mxs-mmc: add device tree support
Date: Sun, 13 May 2012 08:21:23 +0800
Message-ID: <CAAQ0ZWQ5jhp8WYmOy96U23d9byvWLwthoZ-Empfgm7zykEBPcQ@mail.gmail.com>
References: <1336401793-13753-1-git-send-email-shawn.guo@linaro.org>
	<1336401793-13753-9-git-send-email-shawn.guo@linaro.org>
	<87k40h1msl.fsf@laptop.org>
	<20120513000302.GJ17875@S2101-09.ap.freescale.net>
	<871ump0wjf.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53168 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751942Ab2EMAVZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 12 May 2012 20:21:25 -0400
Received: by lahd3 with SMTP id d3so2636567lah.19
        for <linux-mmc@vger.kernel.org>; Sat, 12 May 2012 17:21:24 -0700 (PDT)
In-Reply-To: <871ump0wjf.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Dong Aisheng <dong.aisheng@linaro.org>, Marek Vasut <marex@denx.de>, Arnd Bergmann <arnd@arndb.de>

On 13 May 2012 08:11, Chris Ball <cjb@laptop.org> wrote:
> Hi, adding Arnd,
>
> On Sat, May 12 2012, Shawn Guo wrote:
>>> > diff --git a/Documentation/devicetree/bindings/mmc/mxs-mmc.txt b/=
Documentation/devicetree/bindings/mmc/mxs-mmc.txt
>>> > new file mode 100644
>>> > index 0000000..d7c2a40
>>> > --- /dev/null
>>> > +++ b/Documentation/devicetree/bindings/mmc/mxs-mmc.txt
>>> > @@ -0,0 +1,26 @@
>>> > +* Freescale MXS MMC controller
>>> > +
>>> > +The Freescale MXS Synchronous Serial Ports (SSP) can act as a MM=
C controller
>>> > +to support MMC, SD, and SDIO types of memory cards.
>>> > +
>>> > +Required properties:
>>> > +- compatible: Should be "fsl,<chip>-mmc". =A0The supported chips=
 include
>>> > + =A0imx23 and imx28.
>>> > +- reg: Should contain registers location and length
>>> > +- interrupts: Should contain ERROR and DMA interrupts
>>> > +- fsl,ssp-dma-channel: APBH DMA channel for the SSP
>>> > +- fsl,bus-width: Number of data lines, can be <1>, <4>, or <8>
>>>
>>> Please don't use a prefix on "bus-width" -- see Arnd's proposed bin=
dings:
>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/09=
1993.html
>>>
>> Yes, I've been keeping my eyes on the discussion. =A0Before that gen=
eric
>> bindings get landed, the vendor prefix can be treated as a marker th=
at
>> this is something should use generic binding.
>
> Sorry, I don't understand this explanation. =A0As soon as Arnd's patc=
h
> lands (possibly even for 3.5), we will be making sure that all of the
> bindings are consistently using "bus-width" with no prefix -- that's
> what Arnd's patch does to the existing .dts files. =A0Why introduce a=
n
> inconsistent binding now that we have to change later, instead of
> getting it right straight away?
>
> I'd like bindings going into mainline to be as correct as possible fr=
om
> the moment that they're merged into mainline, because they describe a=
n
> API with the kernel. =A0The fact that we have some bindings currently=
 in
> the tree that we'll have to change to use the consistent naming schem=
e
> Arnd proposes is regrettable, not intentional, so we shouldn't be
> planning on doing more of it. =A0Does that make sense?
>
> I'll take a look at merging Arnd's bindings patch and fixing up the
> review comments on it now; it sounds like we really need to get it
> merged and adopted very soon.
>
In that case, ok, I will remove the prefix right away.

Regards,
Shawn
