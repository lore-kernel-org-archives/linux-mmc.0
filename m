From: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez@opensuse.org>
Subject: PCI rescan needed for MMC reader to become usable
Date: Thu, 03 Jan 2013 14:02:05 -0300
Message-ID: <50E5B98D.1000904@opensuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:65178 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab3ACRCa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Jan 2013 12:02:30 -0500
Received: by mail-ob0-f182.google.com with SMTP id 16so13897326obc.27
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jan 2013 09:02:29 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi:

My laptop's card reader (dell xps 15z uses driver jmb38x_ms, kernel 
3.8-rc2 or older no difference) does nothing unless:

a) An SD card is plugged into the slot before powering the machine on.

b) I plug the card and run  echo 1 > /sys/bus/pci/rescan

then the device appears

[ 2154.277991] jmb38x_ms 0000:05:00.3: enabling device (0000 -> 0002)
[ 2154.280299] sdhci: Secure Digital Host Controller Interface driver
[ 2154.280301] sdhci: Copyright(c) Pierre Ossman
[ 2154.281171] sdhci-pci 0000:05:00.0: SDHCI controller found 
[197b:2392] (rev 30)
[ 2154.281184] sdhci-pci 0000:05:00.0: enabling device (0000 -> 0002)
[ 2154.303986] mmc0: SDHCI controller on PCI [0000:05:00.0] using DMA
[ 2154.304025] sdhci-pci 0000:05:00.2: SDHCI controller found 
[197b:2391] (rev 30)
[ 2154.304038] sdhci-pci 0000:05:00.2: enabling device (0000 -> 0002)
[ 2154.304050] sdhci-pci 0000:05:00.2: Refusing to bind to secondary 
interface.
[ 2154.573690] mmc0: new SDHC card at address e624
[ 2154.576527] mmcblk0: mmc0:e624 SU04G 3.69 GiB
[ 2154.586277]  mmcblk0: p1

After that there is no problem.

Can anyone point to a possible cause of this problem ?
(cc your replies please)

