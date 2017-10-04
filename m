From: Carlo Caione <carlo@endlessm.com>
Subject: SD card reader problems on Cherry-Trail
Date: Wed, 4 Oct 2017 17:00:37 +0200
Message-ID: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:57037 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdJDPAj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Oct 2017 11:00:39 -0400
Received: by mail-ua0-f169.google.com with SMTP id n22so5950037uaj.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Oct 2017 08:00:38 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Haye,
I'm working on a Cherry-Trail laptop shipping an SDHCI controller on
ACPI [80860F14:03].
The problem is that on this hardware the controller seems to be
particularly picky about the type of SD cards it likes. In particular:

- With ultra high speed DDR50 SDHC cards I see no problems
- With ultra high speed SDR104 SDHC cards as soon as the card is inserted I get:

mmc2: Tuning timeout, falling back to fixed sampling clock
mmc2: new ultra high speed SDR104 SDHC card at address 59b4
mmcblk2: mmc2:59b4 USD00 15.0 GiB
mmc2: Timeout waiting for hardware interrupt.
mmc2: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc2: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
mmc2: sdhci: Argument:  0x00000000 | Trn mode: 0x0000003b
mmc2: sdhci: Present:   0x01ff0001 | Host ctl: 0x00000017
mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000080
mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000007
mmc2: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
mmc2: sdhci: Int enab:  0x02ff008b | Sig enab: 0x02ff008b
mmc2: sdhci: AC12 err:  0x00000000 | Slot int: 0x00000000
mmc2: sdhci: Caps:      0x0568c8b2 | Caps_1:   0x00000807
mmc2: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
mmc2: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x0077dd7f
mmc2: sdhci: Resp[2]:   0x325b5900 | Resp[3]:  0x00000000
mmc2: sdhci: Host ctl2: 0x0000800b
mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x335c9200
mmc2: sdhci: ============================================
mmcblk2: error -110 sending status command, retrying
mmcblk2: error -110 sending status command, retrying
mmcblk2: error -110 sending status command, aborting

reading and writing is painfully slow.

- With high speed SDHC cards I get a weird behavior where apparently
there is no problem but it's impossible to format the card. mkfs.ext4
gets stuck at:

Discarding device blocks:    4096/3778299

Have you ever seen something like this or any hint how to debug this mess?

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
