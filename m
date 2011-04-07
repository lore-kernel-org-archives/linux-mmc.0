From: Johan <kungjohan@gmail.com>
Subject: Problem when using SDIO interrupts on Nexus One
Date: Thu, 7 Apr 2011 21:23:19 +0200
Message-ID: <BANLkTin2cVt7236-Ds+3Wg0SsCuSSSZGsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36804 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771Ab1DGTXV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2011 15:23:21 -0400
Received: by eyx24 with SMTP id 24so898057eyx.19
        for <linux-mmc@vger.kernel.org>; Thu, 07 Apr 2011 12:23:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I have a Nexus One Android phone and I am trying to use a SDIO device
connected to the memory slot available on the phone. This device uses
SDIO interrupts on SD_D1 to signal interrupts to the host.

I am using a 2.6-32 kernel from the android-msm-2.6.32 branch
available fromgit://android.git.kernel.org/kernel/msm.git and has
built the kernel with the mahimahi_defconfig.

I have modified drivers/mmc/host/msm_sdcc.c so that SDIO interrupts is
used -> msmsdcc_sdioirq = 1;

My device is working quite well with SDIO interrupts but sometime I
can miss a interrupt and will get this interrupt when I try to send a
command to my device. I can see this behaviour if my device tries to
signal a interrupt 1 second of the last command sent to the device.
The SDIO interrupt line goes low and the host does not signal the
interrupt at once. My assumption is that this is due to some kind of
power management of the SDIO controller. I will get this interrupt
when I activate the SDIO controller by sending a command to my device.
 I have verified this with a logic analyzer attached to the bus and
can attach a screen shot if anyone wants to see this.

So my question is if anyone know how to get reliable SDIO interrupts
on this host, Qualcomm MSM? It seems like Qualcomm does not provide
documentation for this host.

Best Regards
Johan
