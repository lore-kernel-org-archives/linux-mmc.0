From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] drivers/misc: Add realtek card reader core driver
Date: Fri, 3 Aug 2012 14:39:28 +0000
Message-ID: <201208031439.28928.arnd@arndb.de>
References: <1343720536-22077-1-git-send-email-wei_wang@realsil.com.cn> <201208011431.02050.arnd@arndb.de> <501B37F4.80206@realsil.com.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="gb2312"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59899 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075Ab2HCOj6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Aug 2012 10:39:58 -0400
In-Reply-To: <501B37F4.80206@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wwang <wei_wang@realsil.com.cn>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "bp@alien8.de" <bp@alien8.de>

On Friday 03 August 2012, wwang wrote:
> I got your ideas. Bus driver depending on other modules is indeed a bad
> style.
> 
> In our situation, just take pci device for example, pci-common is the
> place to detect card plugged or unplugged, so pci-common is required to
> call and probe sdmmc-pci or memstick-pci. If not using bus driver, I
> need to fulfill my own mechanism, like callback functions and other
> internal data structures, to achieve this goal.

The MFD layer provides some helpers to create "platform" devices for the
child nodes. You can attach all the data you need for those in
the "platform_data" field, including callback pointers if necessary.

> But bus driver can
> easily finish this job. I still prefer to retain bus driver, but detach
> the adapter part from the original bus driver. So the bus driver will
> not depend on other modules any more, and don't need any further
> modification if adding new high-level drivers. I will also move all the
> mmc specific code to sdmmc-pci driver. pci-common only contains the
> generic code related to pci operations. Just like the below diagram:
> 
>    sdmmc-pci      sdmmc-usb        memstick-pci      memstick-usb
>      \   \           /   \             /    \           /   |
>       |   \         /     \           /      \         /    |
>       |    \       /       \___      /        \        |    |
>       \     \ ____/         ___|____/          \_______|    |
>        \     |             /   |                       |    /
>         \____|______      /    |____________      _____|___/
>              |      \    /                  \    /     |   
>              |     pci-common             usb-common   |
>              \              \              /           /
>               \              \            /           /
>                \_____________ \          /___________/
>                              \rtsx-slot-bus/
> 
> 
> And I plan to push sdmmc-pci and sdmmc-usb to drivers/mmc/host, push
> memstick-pci and memstick-usb to drivers/memstick/host, and push
> pci-common, usb-common and rtsx-slot-bus to drivers/mfd/realtek_cr.
> 
> I would like to receive your suggestions. Thank you.

This looks ok, yes. I still don't see the value in having your own
bus_type though, and I believe using a platform device will save
you a significant chunk of code while achieving the same.

In the diagram above, the pci-common and the usb-common modules
each know exactly what their child devices are, so there is little
value creating an device-agnostic abstraction layer beneath it.

Having a module for common stuff in the place of your "rtsx-slot-bus"
is ok to handle stuff like your "ring buffer" that would be needed
by all four devices on the top. But when you introduce infrastructure
like your own bus_type, you should always consider whether that
infrastructure actually does something that is at the same time
common to all of your hardware and different from everything else.
I suspect you will find that your bus_type provide something
specific to realtek card readers and that you can just as well use
the platform bus.

	Arnd
