From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] mmc: omap_hsmmc: Enable HSPE bit for high speed cards
Date: Thu, 27 Sep 2012 13:01:14 +0200
Message-ID: <EB6E7671-3A54-45BE-A6B6-0E59D27E4CE3@dominion.thruhere.net>
References: <1346764151-21323-1-git-send-email-gururaja.hebbar@ti.com> <CANfBPZ-Wb7HE45DTmwsMt-hpJRUevjbjm9-aCR61B4JFULb8Mw@mail.gmail.com>  <1BAFE6F6C881BF42822005164F1491C33EA8FF90@DBDE01.ent.ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.1 \(1498\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39221 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468Ab2I0LBI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Sep 2012 07:01:08 -0400
Received: by wgbdr13 with SMTP id dr13so1299134wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 27 Sep 2012 04:01:07 -0700 (PDT)
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA8FF90@DBDE01.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: "S, Venkatraman" <svenkatr@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "cjb@laptop.org" <cjb@laptop.org>, "Nori, Sekhar" <nsekhar@ti.com>, "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>


Op 26 sep. 2012, om 13:37 heeft "Hebbar, Gururaja" <gururaja.hebbar@ti.com> het volgende geschreven:

> On Wed, Sep 12, 2012 at 17:32:38, Hebbar, Gururaja wrote:
>> On Wed, Sep 12, 2012 at 14:19:51, S, Venkatraman wrote:
>>> On Tue, Sep 4, 2012 at 6:39 PM, Hebbar, Gururaja <gururaja.hebbar@ti.com> wrote:
>>>> HSMMC IP on AM33xx need a special setting to handle High-speed cards.
>>>> Other platforms like TI81xx, OMAP4 may need this as-well. This depends
>>>> on the HSMMC IP timing closure done for the high speed cards.
>>>> 
>>>> From AM335x TRM (SPRUH73F - 18.3.12 Output Signals Generation)
>>>> 
>>>> The MMC/SD/SDIO output signals can be driven on either falling edge or
>>>> rising edge depending on the SD_HCTL[2] HSPE bit. This feature allows
>>>> to reach better timing performance, and thus to increase data transfer
>>>> frequency.
>>>> 
>>>> There are few pre-requisites for enabling the HSPE bit
>>>> - Controller should support High-Speed-Enable Bit and
>>>> - Controller should not be using DDR Mode and
>>>> - Controller should advertise that it supports High Speed in
>>>>  capabilities register and
>>>> - MMC/SD clock coming out of controller > 25MHz
>>>> 
>>> 
>>> The patch is well written. But then, I don't see a need for a DT
>>> binding for this feature.
>> 
>> My reasons for DT Binding
>> 1. Not all platforms using this driver has this bit (OMAP2)
>> 2. Not all platforms using this driver needs this bit to be enabled (OMAP4)
>> 3. Platforms which require this bit this to be set needs a method to inform 
>> driver.
>> 
>> In order to not disturb old/unsupported platforms, I chose this DT method.
>> 
>>> By definition, HS implies 25MHz or above, so that check seems to be
>>> redundant as well.
>> 
>> There are chances that the platform Max Clock output from HSMMC IP is < than 
>> 25 MHz even if the card is High Speed. In such cases it would be better to
>> Confirm that the Clock output is actually > 25 MHz
>> 
>> Kindly correct me if I am wrong.
>> 
>>> Meanwhile, I'll check with HSPE enabled on OMAP.
>>> 
> 
> Gentle Ping. 
> 
> Matt Poter recently submitted EDMA related patches as RFC. He confirmed that
> basic mmc is working on AM335x with his edma patches. 
> 
> Above patch is required to get High-speed cards working on AM335x.
> 
> I haven't seen any review comments for this. Can this be pulled in for 3.7?

I had trouble applying this to 3.6-rc7, is that a known problem and should I try linux-next?

regards,

Koen