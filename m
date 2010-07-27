From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH] tmio_mmc: Allow 2 byte requests in 4-bit mode
Date: Tue, 27 Jul 2010 08:57:40 +0100
Message-ID: <AANLkTinCoSi4s1oNpxptqjA_HEf5Fk92=N_VYNnLR=wF@mail.gmail.com>
References: <4C4555DA.40203@renesas.com> <AANLkTikVm-GWq6vun-AjqLJ1L7Y+s28CdDJqmCEX4+2R@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikVm-GWq6vun-AjqLJ1L7Y+s28CdDJqmCEX4+2R@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, damm@opensource.se, sameo@linux.intel.com, Paul Mundt <lethal@linux-sh.org>, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-mmc@vger.kernel.org

This change needs to be modified to test what hardware is present.
this wont work on my hardware TTBOMK.

-- 
Ian Molton
Linux, Automotive, and other hacking:
http://www.mnementh.co.uk/



On 23 July 2010 12:05, Magnus Damm <magnus.damm@gmail.com> wrote:
> 2010/7/20 Yusuke Goda <yusuke.goda.sx@renesas.com>:
>> Adjust the tmio_mmc block size check to accept 2-byte requests in 4-bit mode.
>> Tested with the SDHI hardware block included in sh7724.
>>
>> Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>
> With this patch applied I can use SDIO cards in polling mode with the
> tmio-mmc driver. Tested with the SDHI hardware block on sh7372 using
> the b43 driver and BCM4318 hardware and the unfortunately out-of-tree
> AR6002 "android" driver.
>
> Acked-by: Magnus Damm <damm@opensource.se>
>
