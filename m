From: John Tobias <john.tobias.ph@gmail.com>
Subject: iMX6 SDR12 support
Date: Tue, 10 Feb 2015 17:10:46 -0800
Message-ID: <CACUGKYNtUJpNdNaXdTpG5pSnxR3xYhE-VXg9R7Oremw+k_kVMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:57356 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbbBKBKr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 20:10:47 -0500
Received: by mail-lb0-f179.google.com with SMTP id w7so406905lbi.10
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2015 17:10:46 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Aisheng Dong <Aisheng.Dong@freescale.com>

Hello All,

I have a new iMX6SL custom board with WiLink8 chipset. The chipset has
some features  of SDIO 3.0 support and the I/O is 1.8v. I used the
mainline kernel 3.13 and 3.19, both of them detected it. But, the
problem is the voltage signaling is 3.3v and it should be 1.8v.

clock:          50000000 Hz
actual clock:   49500000 Hz
vdd:            7 (1.65 - 1.95 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    2 (sd high-speed)
--->>> signal voltage: 0 (3.30 V)  <---> it should be 1.8v


I would like to know if there's any available patches out there that I
could use in order support SDR25?.

Regards,

John Tobias
