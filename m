From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: timeout waiting for hardware interrupt CMD19
Date: Fri, 10 Mar 2017 18:47:25 +0100
Message-ID: <CAMuHMdWHJvKv_Kva0LWL_hekGgkZdR=FHcOdoShpMtzQuXhD2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:32818 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbdCJRrc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2017 12:47:32 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

Hi Wolfram, Simon,

While booting a kernel based on renesas-drivers-2017-03-07-v4.11-rc1 on
the ALT in Magnus' farm, I get:

 mmc2: new high speed SD card at address 0002
 mmcblk2: mmc2:0002 SD    954 MiB (ro)
  mmcblk2: p1
+sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
+sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD19)
+sh_mobile_sdhi ee100000.sd: Tuning procedure failed
+mmc1: tuning execution failed: -110
+mmc1: error -110 whilst initialising SD card
 mmc1: new ultra high speed SDR104 SDHC card at address aaaa
 mmcblk1: mmc1:aaaa SL32G 29.7 GiB (ro)
  mmcblk1: p1

(compared to my last boot using renesas-drivers-2016-09-27-v4.8-rc8+).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
