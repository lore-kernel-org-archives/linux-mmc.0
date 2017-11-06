From: Isaac Good <isaacgood@gmail.com>
Subject: NUC6CAYB - seeing mce Hardware Errors on boot (new hardware)
Date: Mon, 6 Nov 2017 13:08:06 -0800
Message-ID: <20171106210806.GA334@netbook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:49539 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbdKFVIV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2017 16:08:21 -0500
Received: by mail-pf0-f181.google.com with SMTP id i5so8642782pfe.6
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2017 13:08:21 -0800 (PST)
Received: from netbook (c-24-6-57-193.hsd1.ca.comcast.net. [24.6.57.193])
        by smtp.gmail.com with ESMTPSA id p14sm20763281pgr.51.2017.11.06.13.08.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Nov 2017 13:08:19 -0800 (PST)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Just purchased an Intel NUC6CAYS. Getting MCE errors on it and a 50% chance of the eMMC actually loading. Some logs and debug info below from a successful boot.
Very partial screenshot of a failed boot: https://photos.app.goo.gl/2PflUkzQk4C2lg4C3

Nov 06 00:02:52 nuc kernel: mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 4: e600000000020408
Nov 06 00:02:52 nuc kernel: mce: [Hardware Error]: TSC 0 ADDR fef13b00 
Nov 06 00:02:52 nuc kernel: mce: [Hardware Error]: PROCESSOR 0:506c9 TIME 1509955370 SOCKET 0 APIC 0 microcode 20
...
Nov 06 00:02:52 nuc kernel: mmc0: switch to bus width for hs400 failed, err:-84
Nov 06 00:02:52 nuc kernel: mmc0: error -84 whilst initialising MMC card

Any input/followup Q's welcome.

00:1c.0 SD Host controller: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series eMMC Controller (rev 0b) (prog-if 01)
        Subsystem: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series eMMC Controller


ras-mc-ctl: mainboard: Intel Corporation model NUC6CAYB

lspci: http://sprunge.us/ZQCP
lspci -vv: http://sprunge.us/XBeS

/sys/kernel/debug/mmc0/ios: http://sprunge.us/KWCb
Complete dmesg: http://sprunge.us/KRDE
dmesg errors: http://sprunge.us/YeVY
