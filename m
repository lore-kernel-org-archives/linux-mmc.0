From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 2/2] ARM: mmp2: support sdio device 8787
Date: Wed, 27 Jul 2011 21:23:18 -0700
Message-ID: <B6C7F083-E557-418D-9136-A37189F2770D@marvell.com>
References: <1654B53E-123B-43F5-B526-49D19D39D1F0@marvell.com>
 <1EA87C4D-1B63-40E4-AA86-20D2A02A17B7@marvell.com>
 <CAMj5BkgEWb4ejChy6NCdxLse9maG25Pr6JmTS3pt0HJk2ee1Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:38757 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750696Ab1G1EXX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jul 2011 00:23:23 -0400
In-Reply-To: <CAMj5BkgEWb4ejChy6NCdxLse9maG25Pr6JmTS3pt0HJk2ee1Eg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bing Zhao <bzhao@marvell.com>, Frank Huang <frankh@marvell.com>


On Jul 27, 2011, at 7:44 PM, zhangfei gao wrote:

>>> +
>>> +static struct fixed_voltage_config sdio_power = {
>>> +     .supply_name            = "vmmc",
>>> +     .microvolts             = 3000000,
>>> +     .gpio                   = mfp_to_gpio(MFP_PIN_GPIO57),
>>> +     .enable_high            = 1,
>>> +     .enabled_at_boot        = 0,
>>> +     .init_data              = &sdio_power_data,
>>> +};
>>> +
>> 
>> ldo7 is the power source.   The 8787 is the consumer and the code should reflect this.
>> GPIO57 is an on/off switch to the 8787.
>> 
>> 
> Instead of LDO7, 8787 is powered with V_SD2, V_BATT, and VLDO12 on brownstone.
> Use PDn to control 8787 power is recommended method.
> 1. Some LDO is shared and can not be cut down.
> 2. Control LDO is much slower, some time is needed for voltage to
> decay, and the time is not accurate to control.
> 3. With LDO powered, 8787 is under control and 8787 could put itself
> to the lowest state.


LDO is dedicated to 8787 and can be left on.    The power picture is ldo (as regulator)
and 8787 as consumer.  Code does not show this relationship.  The 8787 in deep sleep
draws very little power but since even this small power usage is a concern the disabling
the ldo can reduce power further.