From: Raphael Pereira <raphaelpereira@gmail.com>
Subject: SDIO over USB for USB264x chips
Date: Tue, 19 Jan 2016 10:20:45 -0200
Message-ID: <CAAN9NveZcxJPa4G4aaHEsZCgBs--gZupaG=EypQbLu3nYqogrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:34774 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875AbcASMUp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2016 07:20:45 -0500
Received: by mail-io0-f181.google.com with SMTP id 1so531663107ion.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2016 04:20:45 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I developed a hardware that has a Microchip USB2642 (USB Hub with MMC
interface, former SMSC, former ChipIdea), which is kernel supported by
chipidea IP (ci_hdrc) driver.

I connected a Bluegiga WF111-A WiFi module to the MMC interface of the
USB2642. So, in a hardware sense, everything is fine.

This USB2642 chip is dual-role USB Hub with a SD card interface and
compatible with USB Mass Storage spec.

The problem is that the only driver available from BlueGiga uses linux
MMC stack. So although usb-storage detects the module as a SCSI disk
interface (/dev/sda), the driver doesn't work, as it searches the MMC
stack for the module, and finds nothing.

The document at
http://ww1.microchip.com/downloads/en/DeviceDoc/50002277A.pdf
specifies a SCSI command set to passthrough SDIO communication on top
of Mass Storage interface.

I see myself with 2 options: rewrite the driver or implementing
something in linux to "link" the Mass Storage interface and SDIO.

I started a thread at linux-usb asking for guidance in using
usb-storage layer and got a much better approach, which would be
implementing a "custom" sdio_bus that actually uses SCSI as client to
send the commands.

Taking a look at sdio implementation it seems this is not easily
doable without changing how sdio_bus works (it seems tight up with mmc
stack, no "multiple" sdio_buses possible right now).

Taking a look at sdio implementation, I think that to allow a MMC
driver to attach to the MMC stack (using sdio_register_driver) and
also use the USB Mass Storage bridge provided by the chip, I could
write a MMC host that is actually a SCSI client and sends the commands
through the SCSI layer as specified by the referenced document.

In this case, I would be able to achieve the goal of using the
existing BlueGiga driver (which register itself using
sdio_register_driver) and don't mess around the mmc core
implementation.

Can someone with better experience on MMC stack tell me this is the
right approach?

Thanks in advance!
-- 
Raphael Derosso Pereira
