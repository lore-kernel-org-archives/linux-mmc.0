From: =?ISO-8859-1?Q?Thomas_Lang=E5s?= <thomas.langaas@gmail.com>
Subject: SDIO wifi card works with 2.6.36, not with 3.2
Date: Fri, 25 Nov 2011 23:26:52 +0100
Message-ID: <CANN7TQkp4t2rhfS=LM38TSUdrp2pE7d0VX_t36AjiEEqayqNmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37864 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab1KYW0x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2011 17:26:53 -0500
Received: by iage36 with SMTP id e36so5135619iag.19
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2011 14:26:53 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have a slightly weird problem; I have an Samsung Exynos 4210 with an BCM4329
wifi-chip connected through the MMC-bus using SDIO.

This setup works fine with 2.6.35.7 Android-kernel, but not with
3.2-rc1 (non-Android).

CMD52 read/write works correctly, but CMD53 only works with reads. All CMD53
writes fails.

Here's an example output of the errorlog:
[  267.175000] brcmf_sdioh_request_word: rw=1, func=1, addr=0x0bf98, nbytes=4
[  267.175000] mmc1: starting CMD53 arg 957f3004 flags 000001b5
[  267.175000] mmc1:     blksz 4 blocks 1 flags 00000100 tsac 1000 ms nsac 0
[  267.175000] sdhci [sdhci_irq()]: *** mmc1 got interrupt: 0x00208003
[  267.175000] mmc1: req done (CMD53): 0: 00001000 00000000 00000000 00000000
[  267.175000] mmc1:     0 bytes transferred: -84

I've checked the setup registers (pad-controlls to see that all pads
are set to mmc
instead of gpio, and mmc registers).  All are identical on Android and
non-Android,
so it doesn'tseem like the problem is there at least.

Any ideas on how to proceed with locating the problem?

-- 
Thomas
