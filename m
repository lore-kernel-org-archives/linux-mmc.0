From: Dmitriy Alekseev <deathonfuneral@gmail.com>
Subject: MMC with at91rm9200 board. Errors
Date: Sat, 12 May 2012 18:28:30 +0400
Message-ID: <CAMMxdh1KGMoce6SNy0UcfM2_=zMNgf4Lt72Wdp=pm0A=XbDpSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42225 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab2ELO2b convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 May 2012 10:28:31 -0400
Received: by mail-qa0-f46.google.com with SMTP id b17so1910114qad.19
        for <linux-mmc@vger.kernel.org>; Sat, 12 May 2012 07:28:30 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello, Developers.
My goal is to provide MMC/SD card support on at91rm9200 embedded
system. Hardware connected properly with slot A.

In a board-specific .c file I made:
static struct at91_mmc_data __initdata naviboard_mmc_data =3D {
=A0=A0=A0 .slot_b =3D 0,
=A0=A0=A0 .wire4 =3D 1,
=A0=A0=A0 .det_pin =3D =A0AT91_PIN_PC0,
};

And in board init function:

at91_add_device_mmc(0, &naviboard_mmc_data);

Part of my .config, related to MMC:

# OTG and related infrastructure
#
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_MMC=3Dy
CONFIG_MMC_DEBUG=3Dy
# CONFIG_MMC_UNSAFE_RESUME is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=3Dy
CONFIG_MMC_BLOCK_BOUNCE=3Dy
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_AT91=3Dy
# CONFIG_MMC_ATMELMCI is not set
# CONFIG_MMC_SPI is not set
# CONFIG_MEMSTICK is not set


And mmc-related logs from dmesg. Not depends on card is inserted, or no=
t.
=2E..
[ =A0 =A01.195312] at91_mci at91_mci: 4 wire bus mode not supported - u=
sing 1 wire
[ =A0 =A01.203125] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wid=
th 0 timing 0
[ =A0 =A01.203125] MMC: Setting controller bus width to 1
[ =A0 =A01.203125] Added MCI driver
[ =A0 =A01.203125] mmc0: clock 0Hz busmode 1 powermode 1 cs 0 Vdd 21 wi=
dth 0 timing0
[ =A0 =A01.203125] MMC: Setting controller bus width to 1
[ =A0 =A01.203125] Registered led device: LED0
[ =A0 =A01.210937] Registered led device: LED1
[ =A0 =A01.218750] Registered led device: LED2
[ =A0 =A01.226562] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd =
21 width 0 t0
[ =A0 =A01.226562] clkdiv =3D 74. mcck =3D 399360
[ =A0 =A01.226562] MMC: Setting controller bus width to 1
[ =A0 =A01.226562] IPv4 over IPv4 tunneling driver
[ =A0 =A01.234375] TCP cubic registered
[ =A0 =A01.234375] NET: Registered protocol family 17
[ =A0 =A01.250000] rtc-ds1672 0-0068: setting system clock to 2012-05-1=
2 15:14:46 U)
[ =A0 =A01.257812] Waiting for root device /dev/sda1...
[ =A0 =A01.265625] mmc0: clock 400000Hz busmode 1 powermode 2 cs 1 Vdd =
21 width 0 t0
[ =A0 =A01.265625] clkdiv =3D 74. mcck =3D 399360
[ =A0 =A01.265625] MMC: Setting controller bus width to 1
[ =A0 =A01.265625] mmc0: starting CMD0 arg 00000000 flags 000000c0
[ =A0 =A01.265625] Sending command 0 as 00000800, arg =3D 00000000, blo=
cks =3D 0, lengt)
[ =A0 =A01.265625] MCI irq: status =3D 0000C0E5, C07F0001, 00000001
[ =A0 =A01.265625] Command ready
[ =A0 =A01.265625] Completed command
[ =A0 =A01.265625] Status =3D 00000001/0000c0e5 [00000000 00000000 0000=
0000 00000000]
[ =A0 =A01.265625] mmc0: req done (CMD0): 0: 00000000 00000000 00000000=
 00000000
[ =A0 =A01.265625] mmc0: clock 400000Hz busmode 1 powermode 2 cs 0 Vdd =
21 width 0 t0
[ =A0 =A01.265625] clkdiv =3D 74. mcck =3D 399360
[ =A0 =A01.265625] MMC: Setting controller bus width to 1
[ =A0 =A01.265625] mmc0: starting CMD8 arg 000001aa flags 000002f5
[ =A0 =A01.265625] Sending command 8 as 00001848, arg =3D 000001AA, blo=
cks =3D 0, lengt)
[ =A0 =A01.265625] MCI irq: status =3D 0010C0E5, C07F0001, 00100001
[ =A0 =A01.265625] MMC: Response timeout
[ =A0 =A01.265625] Completed command
[ =A0 =A01.265625] Status =3D 00100001/0010c0e5 [00000000 00000000 0000=
0000 00000000]
[ =A0 =A01.265625] Error detected and set to -110/0 (cmd =3D 8, retries=
 =3D 0)
[ =A0 =A01.265625] mmc0: req done (CMD8): -110: 00000000 00000000 00000=
000 00000000
[ =A0 =A01.265625] mmc0: starting CMD5 arg 00000000 flags 000002e1
[ =A0 =A01.265625] Sending command 5 as 00001845, arg =3D 00000000, blo=
cks =3D 0, lengt)
[ =A0 =A01.265625] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
[ =A0 =A01.265625] MMC: Response timeout
[ =A0 =A01.265625] Completed command
[ =A0 =A01.265625] Status =3D 00100000/0010c0e5 [00000000 00000000 0000=
0000 00000000]
[ =A0 =A01.265625] Error detected and set to -110/0 (cmd =3D 5, retries=
 =3D 3)
[ =A0 =A01.265625] mmc0: req failed (CMD5): -110, retrying...
[ =A0 =A01.265625] Sending command 5 as 00001845, arg =3D 00000000, blo=
cks =3D 0, lengt)
[ =A0 =A01.273437] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
[ =A0 =A01.273437] MMC: Response timeout
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00100000/0010c0e5 [00000000 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -110/0 (cmd =3D 5, retries=
 =3D 2)
[ =A0 =A01.273437] mmc0: req failed (CMD5): -110, retrying...
[ =A0 =A01.273437] Sending command 5 as 00001845, arg =3D 00000000, blo=
cks =3D 0, lengt)
[ =A0 =A01.273437] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
[ =A0 =A01.273437] MMC: Response timeout
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00100000/0010c0e5 [00000000 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -110/0 (cmd =3D 5, retries=
 =3D 1)
[ =A0 =A01.273437] mmc0: req failed (CMD5): -110, retrying...
[ =A0 =A01.273437] Sending command 5 as 00001845, arg =3D 00000000, blo=
cks =3D 0, lengt)
[ =A0 =A01.273437] MCI irq: status =3D 0010C0E4, C07F0001, 00100000
[ =A0 =A01.273437] MMC: Response timeout
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00100000/0010c0e5 [00000000 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -110/0 (cmd =3D 5, retries=
 =3D 0)
[ =A0 =A01.273437] mmc0: req done (CMD5): -110: 00000000 00000000 00000=
000 00000000
[ =A0 =A01.273437] mmc0: starting CMD55 arg 00000000 flags 000000f5
[ =A0 =A01.273437] Sending command 55 as 00001877, arg =3D 00000000, bl=
ocks =3D 0, leng)
[ =A0 =A01.273437] MCI irq: status =3D 0002C0E4, C07F0001, 00020000
[ =A0 =A01.273437] MMC: Response direction error
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00020000/0006c0e5 [FFFFFFFF 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -5/0 (cmd =3D 55, retries =
=3D 0)
[ =A0 =A01.273437] mmc0: req done (CMD55): -5: ffffffff 00000000 000000=
00 00000000
[ =A0 =A01.273437] mmc0: starting CMD55 arg 00000000 flags 000000f5
[ =A0 =A01.273437] Sending command 55 as 00001877, arg =3D 00000000, bl=
ocks =3D 0, leng)
[ =A0 =A01.273437] MCI irq: status =3D 0002C0E4, C07F0001, 00020000
[ =A0 =A01.273437] MMC: Response direction error
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00020000/0006c0e5 [FFFFFFFF 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -5/0 (cmd =3D 55, retries =
=3D 0)
[ =A0 =A01.273437] mmc0: req done (CMD55): -5: ffffffff 00000000 000000=
00 00000000
[ =A0 =A01.273437] mmc0: starting CMD55 arg 00000000 flags 000000f5
[ =A0 =A01.273437] Sending command 55 as 00001877, arg =3D 00000000, bl=
ocks =3D 0, leng)
[ =A0 =A01.273437] MCI irq: status =3D 0002C0E4, C07F0001, 00020000
[ =A0 =A01.273437] MMC: Response direction error
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00020000/0006c0e5 [FFFFFFFF 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -5/0 (cmd =3D 55, retries =
=3D 0)
[ =A0 =A01.273437] mmc0: req done (CMD55): -5: ffffffff 00000000 000000=
00 00000000
[ =A0 =A01.273437] mmc0: starting CMD55 arg 00000000 flags 000000f5
[ =A0 =A01.273437] Sending command 55 as 00001877, arg =3D 00000000, bl=
ocks =3D 0, leng)
[ =A0 =A01.273437] MCI irq: status =3D 0002C0E4, C07F0001, 00020000
[ =A0 =A01.273437] MMC: Response direction error
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00020000/0006c0e5 [FFFFFFFF 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -5/0 (cmd =3D 55, retries =
=3D 0)
[ =A0 =A01.273437] mmc0: req done (CMD55): -5: ffffffff 00000000 000000=
00 00000000
[ =A0 =A01.273437] mmc0: starting CMD1 arg 00000000 flags 000000e1
[ =A0 =A01.273437] Sending command 1 as 00001841, arg =3D 00000000, blo=
cks =3D 0, lengt)
[ =A0 =A01.273437] MCI irq: status =3D 0002C0E4, C07F0001, 00020000
[ =A0 =A01.273437] MMC: Response direction error
[ =A0 =A01.273437] Completed command
[ =A0 =A01.273437] Status =3D 00020000/0006c0e5 [FFFFFFFF 00000000 0000=
0000 00000000]
[ =A0 =A01.273437] Error detected and set to -5/0 (cmd =3D 1, retries =3D=
 0)
[ =A0 =A01.273437] mmc0: req done (CMD1): -5: ffffffff 00000000 0000000=
0 00000000
[ =A0 =A01.273437] mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 wid=
th 0 timing 0
[ =A0 =A01.273437] MMC: Setting controller bus width to 1
=2E..

No reaction on SD inserting, no mmcblk* file in /dev.
Please, how do you explain the problem.

Kernel versions I tried: 2.6.30.9, 2.6.32.59

Thanks.
--
Best Regards,
Dmitriy Alekseev
