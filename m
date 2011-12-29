From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: hsmmc: add max_freq field
Date: Thu, 29 Dec 2011 14:22:26 +0100
Message-ID: <4EFC6992.4020501@gmail.com>
References: <1323868927-3738-1-git-send-email-zonque@gmail.com> <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56820 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1L2NWa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2011 08:22:30 -0500
In-Reply-To: <CANrkHUY3Zf4a2K5769Z=7Wng339zB6+z_Tgd4mOPChZ1RvZ=Kw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On 12/23/2011 04:40 PM, T Krishnamoorthy, Balaji wrote:
> On Wed, Dec 14, 2011 at 6:52 PM, Daniel Mack <zonque@gmail.com> wrote:
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 101cd31..8215ef9 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -1927,8 +1927,12 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>>        if (mmc_slot(host).vcc_aux_disable_is_sleep)
>>                mmc_slot(host).no_off = 1;
>>
>> -       mmc->f_min      = OMAP_MMC_MIN_CLOCK;
>> -       mmc->f_max      = OMAP_MMC_MAX_CLOCK;
>> +       mmc->f_min = OMAP_MMC_MIN_CLOCK;
> 
> Stray change for f_min ?

No, this was intended. The indentation doesn't make sense anymore when
not grouped with the f_max assignment.

Other than that, what is necessary to get this picked? Tony? :)


Thanks,
Daniel
