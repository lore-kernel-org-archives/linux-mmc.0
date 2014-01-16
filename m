From: Olof Johansson <olof@lixom.net>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Thu, 16 Jan 2014 12:00:47 -0800
Message-ID: <CAOesGMjZzwuOvt3iV+CDXZr5-hWvay_xaO-RH5syB1D-zGVu+A@mail.gmail.com>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk>
	<3215037.8HVCjAeS8g@wuerfel>
	<CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com>
	<20140116195819.GY15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:40002 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaAPUAs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 15:00:48 -0500
Received: by mail-qc0-f178.google.com with SMTP id m20so2742057qcx.37
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2014 12:00:47 -0800 (PST)
In-Reply-To: <20140116195819.GY15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Jan 16, 2014 at 11:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jan 16, 2014 at 09:15:17AM -0800, Olof Johansson wrote:
>> We've dealt with it with local code in our tree for Chrome OS, and I
>> suspect everyone else has too. It's definitely time to solve
>> generically.
>
> As there's no code for any Cubox-i or Hummingboard (they're both purely
> DT), what this means is that the answer to Wifi/BT support in mainline is
> that this is "impossible at the moment"...
>
> I guess this is becoming a higher priority issue which really needs to be
> solved somehow. :)

I'm looking at it right now actually, might as well sort it out while
people are paying attention. Patches a little later today unless I get
distrac^Winterrupted. :)


-Olof
