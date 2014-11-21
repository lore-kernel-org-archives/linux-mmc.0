From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for
 vqmmc
Date: Fri, 21 Nov 2014 21:29:58 +0900
Message-ID: <546F3046.30209@samsung.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
 <CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
 <5464152E.7040209@rock-chips.com>
 <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37936 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753877AbaKUMaC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Nov 2014 07:30:02 -0500
In-reply-to: <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, addy ke <addy.ke@rock-chips.com>
Cc: Doug Anderson <dianders@chromium.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, Alexandru Stan <amstan@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>linu

On 11/21/2014 09:06 PM, Ulf Hansson wrote:
> [...]
> 
>> Sure
>> If the first card is sd2.0 since startup, dw_mci_switch_voltage will not be called,
> 
> That can't be right. mmc_power_up() should trigger
> dw_mci_switch_voltage() to be invoked.

Since dw_mci_switch_voltage() is invoked, voltage is changed from 1.8v to 2.7v (minimum value 2.7-3.6v), isn't?

> 
>> and card can be identified. But if UHS card is pulgged in first, the vqmmc will be down to 1.8v.
>>
>> when sd2.0 card is pulgged in, mmc core will call dw_mci_switch_voltage to change vqmmc to 3.3v
>> (MMC_SINGLE_VOTAGE_330). So vqmmc will be set 2.7v, if we request 2.7-3.6v.
>>
>> But vmmc is always 3.3v,becuase it be set min_volt = max_volt = 3.3v in dt tables.

vmmc is fixed voltage?

>>
>> So the result:
>> vmmc = 3.3v and vqmmc = 2.7v, and sd2.0 card is failed to identify in my test.
> 
> Hmm. I wonder why it works the first time? Could it be that your
> regulator have voltage ramp up time that isn't properly considered?

if oscilloscope can use, can we know more exactly?

Best Regards,
Jaehoon Chung
> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

