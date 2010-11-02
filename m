From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: commit mmc: sdhci: add MMC_CAP_8_BIT_DATA in the host
Date: Tue, 2 Nov 2010 12:25:37 +0100
Message-ID: <4CCFF531.1060301@st.com>
References: <16C48D64-3B93-450C-8C92-EFE4D70BD5ED@marvell.com>
 <1288447317.4817.9.camel@maxim-laptop>
 <1288575866.25600.1.camel@maxim-laptop>
 <45311249-8F46-4B20-9525-E66F10C7B44F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:44193 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751509Ab0KBL0U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Nov 2010 07:26:20 -0400
In-Reply-To: <45311249-8F46-4B20-9525-E66F10C7B44F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 11/1/2010 2:52 AM, Philip Rakity wrote:
>
> On Oct 31, 2010, at 6:44 PM, Maxim Levitsky wrote:
>
> > On Sat, 2010-10-30 at 16:01 +0200, Maxim Levitsky wrote:
> >> On Sat, 2010-10-30 at 05:47 -0700, Philip Rakity wrote:
> >>> eMMC unlike SD does not have a field to inside the card data to
> say the bit width of the card. 
> >>> In addition some mmc cards (from Transcend) only support 1 bit
> mode.  The physical pins to support 4 bit data are not there as well
> as no card specific data saying the bus width of the card.
> >>>
> >>> The only solution is to probe the bus by sending a CMD19 and CMD14
> (BUSTEST_W/BUSTEST_R). 
> >>> This procedure is defined in the JEDEC Standard No. 84-A441 spec
> -- Annex A.8.3 and this has been working in our linux 2.6.28/2.6.29
> for quite a while.   I can submit a patch if this makes sense.
> >>> However, it may not work all the time; some controllers do not
> send out the CMD19 sequence.  The  (BUSTEST_W/BUSTEST_R) procedure is
> used in BSD. Also, in SD v3.0 CMD19 is defined for tuning and its
> definition is slightly different then in the JEDEC standard.
> >>>
> >>> One option for the problem you are seeing would be for my patch
> >>> http://permalink.gmane.org/gmane.linux.kernel.mmc/3966
> >>> or something like it to be accepted.   As well as adding the
> bustest procedure.
> >>>
> >>> At least the board specific data can then say 8 bit data lines are
> supported on the physical slot.  The controller can say 8 bit works
> but normally does not have knowledge of the lower level board design.
> >>
> >> I see two solutions to this problem which you proposed above:
> >>
> >> 1. Allow the controller to tell host that it doesn't support 8-bit.
> >> However, what about generic sdhci controllers? These that don't have
> >> quirks in sdhci.c. Are there any desktop sdhci controllers that support
> >> 8-bit. Note that SDHCI controllers are primary for SD/SDHCI cards not
> >> MMC. I don't know if extra pins have same locations on SD and MMC
> cards.
>
> The quirk I defined ENABLES 8 bit mode.  8 bit mode requires 4
> additional data lines be brought out and the chips are normally
> mounted on the board.  I am not aware of any 8 bit  SD/MMC cards that
> plug into a slot.
>
> >>
> >> 2. Test the card for being readable.
> >>
> >> In memstick subsystem I recently had a lot of expirence with
> >> (unfortunately its maintainer isn't easy to work with - probably
> >> underestimation...)
> >>
> >> It should be possible to set bus width and then just test the card for
> >> being readable. While I don't yet know MMC spec and meaning of the
> >> commands, I thing sending an ordinary command like reading card ID,
> >> or something like that would suffiece to see if it accepts the bus
> >> width. If such command fails, 4-bit bus width should be used.
>
> In my testing setting the bus width to 4 bits when the physical card
> only supports 1 bit works.   Need to test the bus width.
>

Hello.
In my testing, setting the bus width to 8, I had seen a performance
improvements on ST STB.
I think it's worth having a new quirk for that as Maxim suggested.
I can also prepare and test the patch if you like.
Let me know

Regards
Peppe

>
> >>
> >> I now assume that above commit broke all MMC cards in sdhci readers.
> >> This has to be fixed somehow.
> > Ping.
> >>
> >>
> >
> >
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
