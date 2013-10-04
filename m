From: Joel Fernandes <joelf@ti.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: DT data for OMAP platforms for v3.13
Date: Fri, 4 Oct 2013 09:50:37 -0500
Message-ID: <524ED5BD.2060504@ti.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com> <524D7038.9070303@baylibre.com> <524E213B.6030306@ti.com> <524ECC63.3050303@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39179 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab3JDOvG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Oct 2013 10:51:06 -0400
In-Reply-To: <524ECC63.3050303@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>

On 10/04/2013 09:10 AM, Benoit Cousson wrote:
> On 04/10/2013 04:00, Joel Fernandes wrote:
>> On 10/03/2013 08:25 AM, Benoit Cousson wrote:
>>> + DT list and DT maintainers.
>>>
>>> Hi Joel,
>>>
>>> Thanks for the update. It looks good to me.
>>>
>>> For the new bindings added below;
>>>
>>>>    .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
>>>>    .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
>>>
>>> I will need the acked-by from one of the DT maintainers.
>>
>> Sure. To help with giving Ack for this, I'd like to also mention these patches
>> were due for long time and reposted. The supporting code is already in the
>> kernel.
>>
>> Also bindings were reviewed by Mark Rutland comments in the following thread
>> were addressed:
>> http://www.spinics.net/lists/arm-kernel/msg269006.html
> 
> OK, that's good news, at least it was already reviewed by Mark.
> 
> I'm fixing and pulling the series, and will add Mark's Acked-by as soon as he
> will send it.
> 
> Meanwhile some nits, I'm fixing myself this time :-)
> 
> None of your subjects is following the same guideline and the repertory
> guideline...
> 
>   omap4: dts: Add node for AES
>   omap4: dts: Add node for DES3DES module
>   am33xx: dts: Fix AES interrupt number
>   ARM: am437x: dts: Add AES node for am437x
>   ARM: am437x: dts: Add DES node for am437x
> 
> It should be ARM: dts: OMAPXXX or AMXXX...
> 
> Regards,
> Benoit
> 
On 10/04/2013 09:10 AM, Benoit Cousson wrote:> On 04/10/2013 04:00, Joel
Fernandes wrote:
>> On 10/03/2013 08:25 AM, Benoit Cousson wrote:
>>> + DT list and DT maintainers.
>>>
>>> Hi Joel,
>>>
>>> Thanks for the update. It looks good to me.
>>>
>>> For the new bindings added below;
>>>
>>>>    .../devicetree/bindings/crypto/omap-aes.txt        | 34 ++++++++++
>>>>    .../devicetree/bindings/crypto/omap-sham.txt       | 31 +++++++++
>>>
>>> I will need the acked-by from one of the DT maintainers.
>>
>> Sure. To help with giving Ack for this, I'd like to also mention these patches
>> were due for long time and reposted. The supporting code is already in the
>> kernel.
>>
>> Also bindings were reviewed by Mark Rutland comments in the following thread
>> were addressed:
>> http://www.spinics.net/lists/arm-kernel/msg269006.html
>
> OK, that's good news, at least it was already reviewed by Mark.
>
> I'm fixing and pulling the series, and will add Mark's Acked-by as soon as he
> will send it.
>
> Meanwhile some nits, I'm fixing myself this time :-)
>
> None of your subjects is following the same guideline and the repertory
> guideline...
>
>   omap4: dts: Add node for AES
>   omap4: dts: Add node for DES3DES module
>   am33xx: dts: Fix AES interrupt number
>   ARM: am437x: dts: Add AES node for am437x
>   ARM: am437x: dts: Add DES node for am437x
>
> It should be ARM: dts: OMAPXXX or AMXXX...

Thanks & sorry about that.
I think Mark came back with some more comments on 2 of those patches. I will
work on those and repost.

-Joel

