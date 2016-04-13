From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to enable
 LED code
Date: Wed, 13 Apr 2016 18:09:17 +0900
Message-ID: <CAK7LNATKxZdfKyaKeNAoN7ozT7LhAqTav5TwORVaPC-wZ1-nDg@mail.gmail.com>
References: <1460537730-23430-1-git-send-email-yamada.masahiro@socionext.com>
	<570E0A7F.8070200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-06.nifty.com ([210.131.2.91]:32374 "EHLO
	conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759723AbcDMJJc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 05:09:32 -0400
In-Reply-To: <570E0A7F.8070200@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

2016-04-13 17:59 GMT+09:00 Adrian Hunter <adrian.hunter@intel.com>:
> On 13/04/16 11:55, Masahiro Yamada wrote:
>> defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>>     defined(CONFIG_MMC_SDHCI_MODULE))
>>
>> is equivalent to:
>>
>> defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>>     defined(MODULE))
>>
>> and it can also be written shortly as:
>>
>> IS_REACHABLE(CONFIG_LEDS_CLASS)
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I recently sent a change to the LEDS code:
>
>         http://marc.info/?l=linux-mmc&m=146046055330711
>
> So, if that is accepted, this will need to be changed - there will be only
> one place CONFIG_LEDS_CLASS is used then.
>

OK.

If yours is accepted, i will rebase this patch on top of yours.



-- 
Best Regards
Masahiro Yamada
