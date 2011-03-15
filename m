From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH 0/6] mmc: split the tmio driver into several modules
Date: Tue, 15 Mar 2011 21:25:03 +0000
Message-ID: <AANLkTi=EBDnRtjqN3eckpt32p-tG8VkcsktLartOEgBp@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61470 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758688Ab1COVZY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 17:25:24 -0400
In-Reply-To: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Sounds like a good idea... Its possible that I could implement DMA on
the toshiba stuff too, can your code handle this?

(I havent had time to read this yet)

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 11 March 2011 07:51, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi all
>
> The tmio_mmc SD/SDIO driver is serving very different hardware
> configurations: on the one hand multi-function style chips from Toshiba,
> Compaq, on the other hand SDHI units in ARM- and SuperH-based sh-mobile
> SoCs. Apart from the different native APIs: MFD for the former and
> platform-device in the latter, sh-mobile implementations also have a
> number of features, exclusive to them, which, if implemented in the common
> driver, clutter it needlessly and make its maintenance more difficult.
> This patch series simplifies the situation by splitting the driver up into
> 3 modules: the core, consisting of the main part and, on sh-mobile, of the
> DMA part; the mfd glue; and the platform glue. This way also (imaginary)
> sh-mobile systems with additional tmio mfd chips on them can be supported.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
