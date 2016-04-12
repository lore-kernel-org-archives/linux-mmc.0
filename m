From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Tue, 12 Apr 2016 14:55:09 +0200
Message-ID: <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
	<1459525479-20842-3-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35048 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbcDLMzL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2016 08:55:11 -0400
In-Reply-To: <1459525479-20842-3-git-send-email-wsa@the-dreams.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

On Fri, Apr 1, 2016 at 5:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Ben Hutchings <ben.hutchings@codethink.co.uk>
>
> Currently tmio_mmc assumes that the input clock frequency is fixed and
> only its own clock divider can be changed.  This is not true in the
> case of sh_mobile_sdhi; we can use the clock API to change it.
>
> In tmio_mmc:
> - Delegate setting of f_min from tmio to the clk_enable operation (if
>   implemented), as it can be smaller than f_max / 512
> - Add an optional clk_update operation called from tmio_mmc_set_clock()
>   that updates the input clock frequency
> - Rename tmio_mmc_clk_update() to tmio_mmc_clk_enable(), to avoid
>   confusion with the clk_update operation
>
> In sh_mobile_sdhi:
> - Make the setting of f_max conditional; it should be set through the
>   max-frequency property in the device tree in future
> - Set f_min based on the input clock's minimum frequency
> - Implement the clk_update operation, selecting the best input clock
>   frequency for the bus frequency that's wanted
>
> sh_mobile_sdhi_clk_update() is loosely based on Kuninori Morimoto's work
> in sh_mmcif.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This is now commit 2e21101df4fe8bdc ("mmc: tmio, sh_mobile_sdhi: Add support
for variable input clock frequency") in the next branch of Ulf's mmc.git.

  1. The SDHI/MMC clocks now run much slower than before. Perhaps this is
     intentional, and a consequence of finding the best way to drive the SD
     card at the target frequency?
  2. On r8a7740, the situation is worse: the HP ("High-speed Peripheral")
     clock is also scaled down from 99 MHz to 12.375 MHz.
     As the HP clock is the parent of lots of on-chip devices, this may affect
     performance for all of them.

On r8a73a4, r8a7791, and sh73a0, the SDHI clocks are children of the pll1_div2
clocks, which are fixed.
On r8a7740, the SDHI and MMC clocks are children of the HP clock,
which is also scaled down, affecting all other siblings.

dmesg and /sys/kernel/debug/clk/clk_summary differences below.


r8a73a4/ape6evm
---------------

-sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 88 MHz
+sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 88 MHz

-sh_mobile_sdhi ee120000.sd: mmc1 base at 0xee120000 clock rate 12 MHz
+sh_mobile_sdhi ee120000.sd: mmc1 base at 0xee120000 max clock rate 12 MHz

   clock           enable_cnt  prepare_cnt        rate   accuracy   phase
-------------------------------------------------------------------------

-     sdhi1ck               1            1    12500000          0 0
-        sdhi1              2            2    12500000          0 0
-     sdhi0ck               1            1    88888888          0 0
-        sdhi0              1            2    88888888          0 0
+     sdhi1ck               1            1    12698412          0 0
+        sdhi1              2            2    12698412          0 0
+     sdhi0ck               1            1    12698412          0 0
+        sdhi0              1            2    12698412          0 0


r8a7791/koelsch
---------------

-sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 97 MHz
+sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 97 MHz

-sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 48 MHz
+sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 max clock rate 48 MHz

-sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 clock rate 48 MHz
+sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 48 MHz


      mmc0                  0            0    12187500          0 0
         mmcif0             0            0    12187500          0 0
-     sd3                   1            1    48750000          0 0
-        sdhi2              1            2    48750000          0 0
-     sd2                   1            1    48750000          0 0
-        sdhi1              1            2    48750000          0 0
+     sd3                   1            1    12786885          0 0
+        sdhi2              1            2    12786885          0 0
+     sd2                   1            1    12786885          0 0
+        sdhi1              1            2    12786885          0 0


sh73a0/kzm9g
------------

-sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 clock rate 69 MHz
+sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 69 MHz

-sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 clock rate 69 MHz
+sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 max clock rate 69 MHz


-    sdhi2ck                1            1    69333333          0 0
-       sdhi2               2            2    69333333          0 0
+    sdhi2ck                1            1    12734693          0 0
+       sdhi2               2            2    12734693          0 0
     sdhi1ck                0            0    69333333          0 0
        sdhi1               0            0    69333333          0 0
-    sdhi0ck                1            1    69333333          0 0
-       sdhi0               1            2    69333333          0 0
+    sdhi0ck                1            1    12734693          0 0
+       sdhi0               1            2    12734693          0 0


r8a7740/armadillo
-----------------

-sh_mobile_sdhi e6850000.sd: mmc0 base at 0xe6850000 clock rate 99 MHz
+sh_mobile_sdhi e6850000.sd: mmc0 base at 0xe6850000 max clock rate 99 MHz

-sh_mmcif e6bd0000.mmc: Chip version 0x0003, clock rate 99MHz
+sh_mmcif e6bd0000.mmc: Chip version 0x0003, clock rate 12MHz

-   hp                      4            6    99000000          0 0
-      tpu0                 0            1    99000000          0 0
-      gether               1            1    99000000          0 0
-      mmc                  2            2    99000000          0 0
-      sdhi1                0            0    99000000          0 0
-      sdhi0                1            2    99000000          0 0
-      usbf                 0            0    99000000          0 0
-      fsi                  0            1    99000000          0 0
-      usbdmac              0            0    99000000          0 0
-      dmac3                0            0    99000000          0 0
-      dmac2                0            0    99000000          0 0
-      dmac1                0            0    99000000          0 0
-      intca                4            4    99000000          0 0
-      usphy                0            0    99000000          0 0
-      usbfunc              0            0    99000000          0 0
-      sdhi2                0            0    99000000          0 0
-      usbhost              0            0    99000000          0 0
+   hp                      4            6    12375000          0 0
+      tpu0                 0            1    12375000          0 0
+      gether               1            1    12375000          0 0
+      mmc                  2            2    12375000          0 0
+      sdhi1                0            0    12375000          0 0
+      sdhi0                1            2    12375000          0 0
+      usbf                 0            0    12375000          0 0
+      fsi                  0            1    12375000          0 0
+      usbdmac              0            0    12375000          0 0
+      dmac3                0            0    12375000          0 0
+      dmac2                0            0    12375000          0 0
+      dmac1                0            0    12375000          0 0
+      intca                4            4    12375000          0 0
+      usphy                0            0    12375000          0 0
+      usbfunc              0            0    12375000          0 0
+      sdhi2                0            0    12375000          0 0
+      usbhost              0            0    12375000          0 0

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
