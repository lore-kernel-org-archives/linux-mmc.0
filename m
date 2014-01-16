From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: How to support SDIO wifi/bt in DT
Date: Thu, 16 Jan 2014 14:14:49 -0800
Message-ID: <6139CA16-83C6-41D8-ADD2-B9590DE0911F@holtmann.org>
References: <20140116133649.GV15937@n2100.arm.linux.org.uk> <3215037.8HVCjAeS8g@wuerfel> <CAOesGMgzi5Buduo2pd0PP8CvKVir69yZ-jjX0Gbda871GiD8rg@mail.gmail.com> <74872027.r5ouCtzAgs@wuerfel>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:36534 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaAPWPk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2014 17:15:40 -0500
In-Reply-To: <74872027.r5ouCtzAgs@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Arnd,

>>> b) We need to add a way to attach a device_node to an sdio_func,
>>> so that a function driver can find additional DT properties.
>>> This part should be relatively simple once (a) is done and
>>> should only need a little code but no new binding. The code
>>> would be similar to what we do for amba, i2c or spi devices.
>> 
>> This isn't actually needed for this functionality, but might be needed
>> for other things...
>> 
> 
> There is at least one sdio driver (cw1200) that needs to get
> a MAC address from DT and has the same kind of hack that
> you mention to work around it at the moment (actually worse,
> it's not even using auxdata). The MAC address is certainly
> a property of the device, not the host. This is of course
> the same problem that we have on various development boards
> with USB ethernet controllers lacking an EEPROM.

there are plenty of these devices. It is not just Ethernet or WiFi. You can add Bluetooth devices addresses to this as well. The Nokia N900 drivers for example. Even the Nexus 4 devices are in this boat as well.

The addresses are either stored in some magic place or plain simple on the host filesystem. Maybe this whole magic persistent IEEE addresses thing need its own subsystem. So drivers needing an address can just request it from the subsystem and the subsystem deals with the nasty storage details on how to get the addresses into the kernel in the first place. Currently it is a big mess.

I have seen nasty workaround with delayed initialization from probe or other crazy sysfs settings to just make this work.

Regards

Marcel

