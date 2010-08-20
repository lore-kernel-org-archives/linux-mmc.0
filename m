From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Sat, 21 Aug 2010 08:01:11 +0900
Message-ID: <AANLkTi=SziDSARkgJikGMtfTvyY+K8g+o=QykZGfwmsv@mail.gmail.com>
References: <4C4555DA.40203@renesas.com>
	<4C6E9A0A.6060205@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41690 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0HTXBP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 19:01:15 -0400
In-Reply-To: <4C6E9A0A.6060205@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, ian@mnementh.co.uk, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, Aug 21, 2010 at 12:06 AM, Arnd Hannemann <arnd@arndnet.de> wrote:
> Am 20.07.2010 09:52, schrieb Yusuke Goda:
>> Adjust the tmio_mmc block size check to accept 2-byte requests in
>> 4-bit mode. Tested with the SDHI hardware block included in sh7724.
>>
>> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>
> Tested on AP4EVB (sh7372) with SDHC and MMC cards - no regression.
>
> Tested-by: Arnd Hannemann <arnd@arndnet.de>

Hi Arnd,

With both you, Goda-san and me testing it certainly looks like this
one also is ok on platforms with SDHI.

Thanks a lot!

/ magnus
