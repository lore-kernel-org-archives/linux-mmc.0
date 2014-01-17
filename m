From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Fri, 17 Jan 2014 10:38:09 +0100
Message-ID: <52D8FA01.9020609@atmel.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk> <3215037.8HVCjAeS8g@wuerfel> <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com> <20140117090214.GA2348@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:36388 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbaAQJiO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jan 2014 04:38:14 -0500
In-Reply-To: <20140117090214.GA2348@piout.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Ludovic Desroches <ludovic.desroches@atmel.com>

On 17/01/2014 10:02, Alexandre Belloni :
> On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote :
>> "for SDIO slots" is somewhat misleading; nearly all controllers only
>> do one slot/device per controller. The designware controller can do
>> multiple slots, and that adds a bit of driver and binding complexity
>> for something that seemingly not a single vendor has actually
>> implemented.
>>
>> So we can likely assume to keep these reset/power/clock lines per host
>> controller, no need to add a slot construct.
>>
> 
> Actually, the atmel chips have two slots per controller so it would
> probably be better to think about that now.

Moreover, we have DT description for this.
Cf. Documentation/devicetree/bindings/mmc/atmel-hsmci.txt

Best regards,
-- 
Nicolas Ferre
