From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Tue, 27 Jul 2010 17:05:33 +0900
Message-ID: <AANLkTin69UwXC3igcLnA9o0P==N2oV55Nj0vJt6WbSDS@mail.gmail.com>
References: <4C4555DA.40203@renesas.com>
	<AANLkTikVm-GWq6vun-AjqLJ1L7Y+s28CdDJqmCEX4+2R@mail.gmail.com>
	<AANLkTinCoSi4s1oNpxptqjA_HEf5Fk92=N_VYNnLR=wF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:35352 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab0G0IFd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Jul 2010 04:05:33 -0400
In-Reply-To: <AANLkTinCoSi4s1oNpxptqjA_HEf5Fk92=N_VYNnLR=wF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

> On 23 July 2010 12:05, Magnus Damm <magnus.damm@gmail.com> wrote:
>> 2010/7/20 Yusuke Goda <yusuke.goda.sx@renesas.com>:
>>> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit mode.
>>> Tested with the SDHI hardware block included in sh7724.
>>>
>>> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>>
>> With this patch applied I can use SDIO cards in polling mode with the
>> tmio-mmc driver. Tested with the SDHI hardware block on sh7372 using
>> the b43 driver and BCM4318 hardware and the unfortunately out-of-tree
>> AR6002 "android" driver.
>>
>> Acked-by: Magnus Damm <damm@opensource.se>
>>

Hi Ian,

Thanks for your feedback!

On Tue, Jul 27, 2010 at 4:57 PM, Ian Molton <ian@mnementh.co.uk> wrote:
> This change needs to be modified to test what hardware is present.
> this wont work on my hardware TTBOMK.

Ok, just curious, on which platform did you test it?

On SDHI hardware the 2-byte access works just fine in 4-bit mode.

Thanks,

/ magnus
