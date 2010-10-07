From: Steve Sakoman <sakoman@gmail.com>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Thu, 7 Oct 2010 10:56:05 -0700
Message-ID: <AANLkTimujxfjTxV29i0mrESToz6KoZo-70OQMjrGPxSA@mail.gmail.com>
References: <cover.1266847842.git.david.vrabel@csr.com>
	<20100827192248.GJ20407@void.printf.net>
	<4C7CC480.2040903@csr.com>
	<4C7F3E0F.2080402@compulab.co.il>
	<AANLkTi=RvWpuUC3FjwELkM0v57YXZbH_DBiA-4KuOwdN@mail.gmail.com>
	<C903F2608D694655921F553D0D3557E3@am.dhcp.ti.com>
	<AANLkTikskMMFWS+qxD+J=o6OiOa+d5H02DiT1iZ95vkz@mail.gmail.com>
	<CD6B4CE9F7FA427BBD19242F669AD014@am.dhcp.ti.com>
	<AANLkTin-r5Svg1+YrdYq95WA6=sh7+X0Bwogk=h0V6pP@mail.gmail.com>
	<4CAC146D.3040001@compulab.co.il>
	<AANLkTi=kmLuUyD-9k-Xa5vfgvjx2nNUGfyADhoY0HC1i@mail.gmail.com>
	<4CAC7D65.8010705@compulab.co.il>
	<AANLkTikvduxP+gQOs4HvZz2Yw6KCrqHAyim0Ads0Bvj_@mail.gmail.com>
	<56009.192.168.10.88.1286389699.squirrel@dbdmail.itg.ti.com>
	<4CAD739B.4090909@compulab.co.il>
	<AANLkTimvHnLAchE-Ed1Zve-PU6S98Euj=bFaAtkDWWji@mail.gmail.com>
	<B02FD62E0C9F4E70856C21355A0BAB59@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35296 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0JGR4L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Oct 2010 13:56:11 -0400
In-Reply-To: <B02FD62E0C9F4E70856C21355A0BAB59@am.dhcp.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>, David Vrabel <david.vrabel@csr.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>

On Thu, Oct 7, 2010 at 9:52 AM, Madhusudhan <madhu.cr@ti.com> wrote:
>
>> -----Original Message-----
>> From: Steve Sakoman [mailto:sakoman@gmail.com]
>> Sent: Thursday, October 07, 2010 8:57 AM
>> To: Mike Rapoport
>> Cc: Madhusudhan Chikkature; David Vrabel; Chris Ball; linux-
>> mmc@vger.kernel.org; linux-omap@vger.kernel.org; Adrian Hunter
>> Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
>>
>> On Thu, Oct 7, 2010 at 12:15 AM, Mike Rapoport <mike@compulab.co.il>
>> wrote:
>> > Hi Madhu,
>> >
>> > Madhusudhan Chikkature wrote:
>> >>
>> >> <snip>
>> >>
>> >>> You are correct!  The version of the patch in the repo indeed has
>> >>> 'out' in the wrong place and generates a compile error.
>> >>>
>> >>> Could you post the patch you are using and I will try to reproduce
>> >>> what you are seeing on my hardware?  Best we all work from exactly the
>> >>> same patch!
>> >>>
>> >>> Steve
>> >>>
>> >>
>> >> Yes. I think that check breaking the compilation is not needed. How
>> about
>> >> the
>> >> below version? It just removes that check.
>> >>
>> >> This version should apply fine on the latest kernel. I did a sanity
>> test
>> >> of
>> >> MMC/SD cards on OMAP4 SDP.
>> >>
>> >> Steve or Mike can check if SDIO interrupts are working.
>> >
>> > With you patch I get the same:
>> >
>> > libertas_sdio: Libertas SDIO driver
>> > libertas_sdio: Copyright Pierre Ossman
>> > libertas: command 0x0003 timed out
>> > libertas: Timeout submitting command 0x0003
>> > libertas: PREP_CMD: command 0x0003 failed: -110
>> > libertas_sdio: probe of mmc1:0001:1 failed with error -110
>>
>> I can confirm exactly the same behavior on my hardware with this
>> version of the patch.
>>
>
> Steve,
>
> Okay. Did the version you had in your tree worked? I just want to check if I
> messed up something in my patch.

No, it didn't.  Operator error -- I was "testing" a version without
the patch applied :-)  When applied it acts the same as your version.

Steve
