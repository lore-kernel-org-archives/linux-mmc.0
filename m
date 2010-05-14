From: "Charles D. Krebs" <ckrebs@therealtimegroup.com>
Subject: Re: Status of tmio_mmc DMA support for SDIO
Date: Fri, 14 May 2010 14:43:09 -0500
Message-ID: <1B215080664E44FE81F6BA1DCFA65A38@RSI45>
References: <A0C4AD4CC48F4CAAA4C9CB027472149D@RSI45> <Pine.LNX.4.64.1005140843320.6147@axis700.grange> <AANLkTikKmiRe0f9UXQo3bkwxjCVPzivTrTEYyzY3DcMB@mail.gmail.com> <Pine.LNX.4.64.1005141953160.6147@axis700.grange>
Reply-To: "Charles D. Krebs" <ckrebs@therealtimegroup.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1005141953160.6147@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>
Cc: linux-sh@vger.kernel.org, sailaja.sdn@redpinesignals.com, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

>> Just saw this - am I right in thinking someone has written SDIO
>> support for TMIO ? Im afraid I dont appear to have the preceeding
>> emails.
>
> This is the first email regarding TMIO SDIO that I'm aware of - from
> Charles, he's sent it tothe sh ML and to me and I've added you and the mmc
> list to CC.

To clarify - I didn't write that code.  It was developed by some of the 
Kernel guys over at Renesas Japan specifically for my request to support 
SDIO under their BSP for 2.6.33.  The code in tmio and sh_mobile_sdhi 
replaces a previously closed source module for SD support on the hardware 
due to licensing restrictions of the SD consortium.  Apparently those issues 
were resolved and now the complete SD stack is integrated into the Kernel 
directly.  However, the transition didn't include support for SDIO, so the 
patch to tmio was provided in the interim.

Magnus - Do you know the author for the SDIO patch?

Charles Krebs, Embedded Solutions Developer
The Realtime Group

--------------------------------------------------
From: "Guennadi Liakhovetski" <g.liakhovetski@gmx.de>
Sent: Friday, May 14, 2010 12:54 PM
To: "Ian Molton" <ian@mnementh.co.uk>
Cc: "Charles D. Krebs" <ckrebs@therealtimegroup.com>; 
<linux-sh@vger.kernel.org>; <sailaja.sdn@redpinesignals.com>; "Magnus Damm" 
<magnus.damm@gmail.com>; <linux-mmc@vger.kernel.org>
Subject: Re: Status of tmio_mmc DMA support for SDIO

> On Fri, 14 May 2010, Ian Molton wrote:
>
>> Just saw this - am I right in thinking someone has written SDIO
>> support for TMIO ? Im afraid I dont appear to have the preceeding
>> emails.
>
> This is the first email regarding TMIO SDIO that I'm aware of - from
> Charles, he's sent it tothe sh ML and to me and I've added you and the mmc
> list to CC.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 

