From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 4/5 v3] mmc: add a function to get a regulator,
 supplying card's Vdd
Date: Mon, 11 Jun 2012 07:36:16 -0700
Message-ID: <15DF5528-1451-4121-A572-C293B5DCA8B4@marvell.com>
References: <Pine.LNX.4.64.1205251045490.13353@axis700.grange>
 <Pine.LNX.4.64.1205251208440.13353@axis700.grange>
 <Pine.LNX.4.64.1205251230540.13353@axis700.grange>
 <CAPDyKFrrxyk-JpLFge5+0xbYjJ=-24avWn8Optfg88-i006-Ng@mail.gmail.com>
 <1925406B-D680-40BB-890A-78447EEB4583@marvell.com>
 <4FC33362.4010806@intel.com>
 <20120528144317.GF4032@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1206111321120.29799@axis700.grange>
 <20120611142332.GR11439@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45977 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754871Ab2FKOgm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jun 2012 10:36:42 -0400
In-Reply-To: <20120611142332.GR11439@opensource.wolfsonmicro.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>


On Jun 11, 2012, at 7:23 AM, Mark Brown wrote:

> On Mon, Jun 11, 2012 at 02:39:29PM +0200, Guennadi Liakhovetski wrote:
>> On Mon, 28 May 2012, Mark Brown wrote:
> 
>>> Even if the supply is always on you can easily provide an always on
>>> regulator.  From the point of view of the consumer if there are two
>>> physical supplies needed it's much clearer and easier to just code that
>>> and deal with the fact that we might have no control over them
>>> externally, there's nothing device specific about that process.
> 
>> Mark, I'm not sure I understand your above comment correctly. The 
>> function, that I add in this patch doesn't do much now, that we removed 
> 
>> IIUC, to satisfy Philip's requirement for a second regulator it would 
>> suffice to just issue one more devm_regulator_get() and let the caller 
>> deal with any errors. Is this what you're suggesting or are you against 
>> adding the second regulator? We could of course also add it later, but 
>> that would change the function prototype (unless we add regulator pointers 
>> to struct mmc_host itself). Whith existing users such changes are a bit 
>> messy...
> 
> Yes, that's what I'm suggesting.  I guess you could wrap the two
> regulators up in a small struct without it being too invasive?


Some background notes:
Historically SD cards operated with the same vccq (signaling for dat and clk pins)
and vcc (core) voltage.
usually 3.3v --> we would use one regulator to supply both.  The power (regulator)
was always on and as far as the SD code was concerned never exposed
(eg regulator_get (vmmc) returned an error).

Now enter UHS cards.  They allow (require) the vccq voltage change from
3.3v to 1.8v when operating in UHS mode (DDR50, SDR50, SDR104).
They also note that when a voltage switch is done to move the card 
into UHS mode (3.3V to 1.8V) the switch may fail.  In this case vcc
needs to turned off and then back on to cause the card to reinitialize.

This led me to the conclusion two regulators are required.
vccq must be switchable between 3.3 and 1.8
vcc must be able to be turned off/on and may be switchable to a lower voltage.

Note: embedded MMC is different (eMMC).  Since it is embedded it is
assumed by the spec that the board designed knows that they are doing
and the correct voltages are supplied. 



