From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v6 3/7] regulator: add pbias regulator support
Date: Fri, 20 Dec 2013 22:14:44 +0530
Message-ID: <52B473FC.7000404@ti.com>
References: <1386670577-3530-1-git-send-email-balajitk@ti.com> <1387456720-7202-1-git-send-email-balajitk@ti.com> <1387456720-7202-4-git-send-email-balajitk@ti.com> <20131219163300.GK27438@atomide.com> <52B4124F.8010903@ti.com> <20131220155721.GX27438@atomide.com> <20131220160917.GY31886@sirena.org.uk> <20131220161307.GB27438@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52162 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab3LTQox (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Dec 2013 11:44:53 -0500
In-Reply-To: <20131220161307.GB27438@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org

On Friday 20 December 2013 09:43 PM, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [131220 08:10]:
>> On Fri, Dec 20, 2013 at 07:57:21AM -0800, Tony Lindgren wrote:
>>> * Balaji T K <balajitk@ti.com> [131220 01:49]:
>>
>>>> But interrupt was never used/tested AFAIK, there is some settling time
>>>> before the generated interrupt status is truely valid, so pbias interrupt is not
>>>> reliable.
>>
>>> OK. Do we need the standard regulator property startup-delay-us for the
>>> PBIAS regulator then? Or if it's always fixed, I guess it could be done
>>> in the pbias_regulator_enable()?
>>
>> That delay is supposed to be the time for the startup of the supply
>> rather than any detection code.  It should be set using enable_time in
>> the driver if it's not system dependent - the property is there for
>> cases where the delay depends on system configuration (eg, due to the
>> capacitor values).
>
> OK thanks. Let's try enable_time first then as we've had a fixed value
> for years for it. If there's some difference based on the card
> capacitance etc that can be added if needed.

I used regulator-enable-ramp-delay to set constraints->enable_time based on SoC.
Since it is not board dependent, I will drop regulator-enable-ramp-delay from dt and
pass the value via driver_data.

Thanks and Regards,
Balaji T K
