From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 15:58:38 +0900
Message-ID: <AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
References: <4C33DF98.10409@renesas.com>
	<20100708144626.2091f6c1.akpm@linux-foundation.org>
	<4C3BBE77.8080000@renesas.com>
	<20100715132552.fcb5791b.akpm@linux-foundation.org>
	<20100825231107.45227d6a@linux-g6p1.site>
	<20100825160722.9c9c38c8.akpm@linux-foundation.org>
	<4C75BB0D.2030202@renesas.com>
	<20100826075320.0538043b@linux-g6p1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:42101 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239Ab0HZG6j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 02:58:39 -0400
Received: by qyk33 with SMTP id 33so1387032qyk.19
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2010 23:58:39 -0700 (PDT)
In-Reply-To: <20100826075320.0538043b@linux-g6p1.site>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, Aug 26, 2010 at 3:53 PM, Matt Fleming <matt@console-pimps.org> =
wrote:
> On Thu, 26 Aug 2010 09:53:33 +0900
> Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
>> Andrew Morton wrote:
>> > On Wed, 25 Aug 2010 23:11:07 +0100
>> > Matt Fleming <matt@console-pimps.org> wrote:
>> >
>> >> On Thu, 15 Jul 2010 13:25:52 -0700
>> >> Andrew Morton <akpm@linux-foundation.org> wrote:
>> >>
>> >>> On Tue, 13 Jul 2010 10:16:39 +0900
>> >>> Yusuke Goda <yusuke.goda.sx@renesas.com> wrote:
>> >>>
>> >>>> Hi Andrew
>> >>>>
>> >>>> Thank you for your comment.
>> >>>>
>> >>>>>> =A0#define ack_mmc_irqs(host, i) \
>> >>>>>> =A0 =A0 =A0 =A0do { \
>> >>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 mask;\
>> >>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0mask =A0=3D sd_ctrl_read32((host=
), CTL_STATUS); \
>> >>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0mask &=3D ~((i) & TMIO_MASK_IRQ)=
; \
>> >>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0sd_ctrl_write32((host), CTL_STAT=
US, mask); \
>> >>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0sd_ctrl_write32((host), CTL_STAT=
US, ~(i)); \
>> >>>>>> =A0 =A0 =A0 =A0} while (0)
>> >>>>> Can we have a better changelog please?
>> >>>>>
>> >>>>> What was wrong with the old code?
>> >>>>>
>> >>>>> How does the patch fix it?
>> >>>>>
>> >>>>> What are the user-visible runtime effects of the bug?
>> >>>>>
>> >>>>> (It looks like that was a pretty gross bug - how did it pass t=
esting??)
>> >>>> Example
>> >>>> =A0- CMD53(Single block read / Received data size : 64Byte)
>> >>>>
>> >>>> =A01) Send CMD53
>> >>>> =A02) Receive "CMD53 response"
>> >>>> =A03) Call tmio_mmc_cmd_irq(host, status);
>> >>>> -- original code ----------------------------------------------=
------
>> >>>> =A0#define ack_mmc_irqs(host, i) \
>> >>>> =A0do { \
>> >>>> =A0 =A0 =A0 =A0 =A0u32 mask;\
>> >>>> =A0 =A0 =A0 =A0 =A0mask =A0=3D sd_ctrl_read32((host), CTL_STATU=
S); \
>> >>>> =A0< case 1 >
>> >>>> =A0 =A0 =A0 =A0 =A0mask &=3D ~((i) & TMIO_MASK_IRQ); \
>> >>>> =A0< case 2 >
>> >>>> =A0 =A0 =A0 =A0 =A0sd_ctrl_write32((host), CTL_STATUS, mask); \
>> >>>> =A0} while (0)
>> >>>> ---------------------------------------------------------------=
------
>> >>>>
>> >>>> TMIO_STAT_RXRDY status will be cleared by "sd_ctrl_write32((hos=
t), CTL_STATUS, mask);"
>> >>>> if TMIO_STAT_RXRDY becomes effective between "< case 1 >" and "=
< case 2 >".
>> >>>>
>> >>>> This causes the phenomenon that a TMIO_STAT_RXRDY interrupt doe=
s not occur.
>> >>>> When received data are small, it rarely occurs.
>> >>>>
>> >>> OK..
>> >>>
>> >>> But with both this patch and "tmio_mmc-revise-limit-on-data-size=
=2Epatch"
>> >>> the changelogs fail to describe the impact of the bug upon our u=
sers.
>> >>> So when I sit here trying to work out whether the patches should=
 be
>> >>> applied to 2.6.35 and whether they should be backported into -st=
able, I
>> >>> don't have enough information.
>> >>>
>> >>> What are your thoughts on this?
>> >> Goda, do you have any more ideas on updating the changelog for th=
is
>> >> patch? It looks to me like this patch is a candidate for stable
>> >> (whereas the "tmio_mmc-revise-limit-on-data-size.patch" is not, s=
orry
>> >> about replying to that one first, I'm reading my mail backwards)
>> >> because, without this patch, it's possible to miss interrupts bec=
ause
>> >> the ack_mmc_irqs() macro clears bit in the CTL_STATUS register th=
at it
>> >> should not do? Is that correct?
>> >>
>> >> If that is the case then would this be a more appropriate changel=
og,
>> >>
>> >> "tmio_mmc: Don't clear unhandled pending interrupts
>> >>
>> >> Previously, it was possible for ack_mmc_irqs() to clear pending
>> >> interrupt bits in the CTL_STATUS register, even though the interr=
upt
>> >> handler had not been called. This was because of a race that exis=
ted
>> >> when doing a read-modify-write sequence on CTL_STATUS. After the
>> >> read step in this sequence, if an interrupt occurred (causing one=
 of the
>> >> bits in CTL_STATUS to be set) the write step would inadvertently =
clear
>> >> it.
>> >>
>> >> This patch eliminates this race by only writing to CTL_STATUS and
>> >> clearing the interrupts that were passed as an argument to
>> >> ack_mmc_irqs()."
>> >
>> > hm, I seem to have secretly dropped this patch as well.
>> >
>> > Oh well. =A0I restored it as
>> > tmio_mmc-dont-clear-unhandled-pending-interrupts.patch and tagged =
it
>> > for a -stable backport. =A0Unless I hear otherwise I'll send it in=
 to
>> > Linus when we return from Brazil a couple of weeks from now.
>>
>> Thank you for your actions.
>> I agree to new changelog.
>>
>> In fact, I contributed the patch which changed changelog.
>> =A0http://www.spinics.net/lists/linux-mmc/msg02623.html
>> =A0http://www.spinics.net/lists/linux-mmc/msg02624.html
>> However, these will not be necessary.
>
> Oh, I missed these. Sorry!
>
> Andrew, this bit of Goda's changelog is worth adding to
> "tmio_mmc-dont-clear-unhandled-pending-interrupts.patch"
>
> "Observed with the TMIO_STAT_RXRDY bit together with CMD53
> on AR6002 and BCM4318 SDIO cards in polled mode."

Hi Matt,

Just FYI, the newer version of these patches also have a whole bunch
of acked-by and tested-by tags, see this email:

http://lkml.org/lkml/2010/8/20/429

Thanks for your help!

Cheers,

/ magnus
