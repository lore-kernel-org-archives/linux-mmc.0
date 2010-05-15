From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: Status of tmio_mmc DMA support for SDIO
Date: Sat, 15 May 2010 11:26:41 +0100
Message-ID: <AANLkTiky1H2rJLoJVa_iDVKyGKLsVKGS7_bb4NctJ1nL@mail.gmail.com>
References: <A0C4AD4CC48F4CAAA4C9CB027472149D@RSI45> <Pine.LNX.4.64.1005140843320.6147@axis700.grange>
	<AANLkTikKmiRe0f9UXQo3bkwxjCVPzivTrTEYyzY3DcMB@mail.gmail.com>
	<Pine.LNX.4.64.1005141953160.6147@axis700.grange> <1B215080664E44FE81F6BA1DCFA65A38@RSI45>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53407 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab0EOK1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 May 2010 06:27:07 -0400
In-Reply-To: <1B215080664E44FE81F6BA1DCFA65A38@RSI45>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Charles D. Krebs" <ckrebs@therealtimegroup.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, sailaja.sdn@redpinesignals.com, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org

Could someone send me a copy of the patch to tmio ?

--=20
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 14 May 2010 20:43, Charles D. Krebs <ckrebs@therealtimegroup.com> wr=
ote:
>>> Just saw this - am I right in thinking someone has written SDIO
>>> support for TMIO ? Im afraid I dont appear to have the preceeding
>>> emails.
>>
>> This is the first email regarding TMIO SDIO that I'm aware of - from
>> Charles, he's sent it tothe sh ML and to me and I've added you and t=
he mmc
>> list to CC.
>
> To clarify - I didn't write that code. =A0It was developed by some of=
 the
> Kernel guys over at Renesas Japan specifically for my request to supp=
ort
> SDIO under their BSP for 2.6.33. =A0The code in tmio and sh_mobile_sd=
hi
> replaces a previously closed source module for SD support on the hard=
ware
> due to licensing restrictions of the SD consortium. =A0Apparently tho=
se issues
> were resolved and now the complete SD stack is integrated into the Ke=
rnel
> directly. =A0However, the transition didn't include support for SDIO,=
 so the
> patch to tmio was provided in the interim.
>
> Magnus - Do you know the author for the SDIO patch?
>
> Charles Krebs, Embedded Solutions Developer
> The Realtime Group
>
> --------------------------------------------------
> From: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
> Sent: Friday, May 14, 2010 12:54 PM
> To: "Ian Molton" <ian@mnementh.co.uk>
> Cc: "Charles D. Krebs" <ckrebs@therealtimegroup.com>;
> <linux-sh@vger.kernel.org>; <sailaja.sdn@redpinesignals.com>; "Magnus=
 Damm"
> <magnus.damm@gmail.com>; <linux-mmc@vger.kernel.org>
> Subject: Re: Status of tmio_mmc DMA support for SDIO
>
>> On Fri, 14 May 2010, Ian Molton wrote:
>>
>>> Just saw this - am I right in thinking someone has written SDIO
>>> support for TMIO ? Im afraid I dont appear to have the preceeding
>>> emails.
>>
>> This is the first email regarding TMIO SDIO that I'm aware of - from
>> Charles, he's sent it tothe sh ML and to me and I've added you and t=
he mmc
>> list to CC.
>>
>> Thanks
>> Guennadi
>> ---
>> Guennadi Liakhovetski, Ph.D.
>> Freelance Open-Source Software Developer
>> http://www.open-technology.de/
>>
>
>
