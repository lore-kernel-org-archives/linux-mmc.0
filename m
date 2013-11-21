From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: imx6 emmc issue
Date: Thu, 21 Nov 2013 09:15:33 +0100
Message-ID: <CAH9NwWdou_WTx7ep6pR=s3sMkk2HUdqZsr8d70eRGouN_jxCpQ@mail.gmail.com>
References: <528CDDEA.1040500@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:59490 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959Ab3KUIPy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2013 03:15:54 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so10314769wgh.29
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2013 00:15:53 -0800 (PST)
In-Reply-To: <528CDDEA.1040500@alcatel-lucent.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ed Sutter <ed.sutter@alcatel-lucent.com>
Cc: linux-mmc@vger.kernel.org

Hi Ed


2013/11/20 Ed Sutter <ed.sutter@alcatel-lucent.com>:
> Dong,
> Hello, I am currently working on an Freescale iMX6 SABRE Board platform
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=RDIMX6SABREBRD
>
> I'm trying to run with mainline kernel/uboot/buildroot just to be a bit more
> up-to-date than the LTIB distribution.  I am trying to setup a ROOTFS
> directly
> on the eMMC device.  Referring to this thread on the freescale forum:
>
> https://community.freescale.com/message/363870?et=watches.email.thread#363870
>
> I'm working with linux-3.12 and patch-v3.12-next-20131119 and I've applied
> these
> additional patches: http://comments.gmane.org/gmane.linux.kernel.mmc/23339
>
> I am able to access the emmc device from linux when using fdisk; however,
> when I attempt to run "mkfs.ext3 /dev/mmcblk0p1" the "Discarding device
> blocks"
> step takes over an hour (80 minutes last time I tried it).
>
> Fabio Estevam (from freescale) suggested I report this to you.
> Are you aware of this issue?  Are you aware of anyone that's actually tried
> to do mkfs.ext3 on emmc with a recent kernel version for this board/SOC?
>

I am using a custom board based on a imx6d with a sandisk emmc. A 3.12
kernel with some
light patches (
https://github.com/RobertCNelson/armv7-multiplatform/tree/v3.12.x ) is
used.

For me the emmc works... I only had to disable support for the boot
and rpmb partition types
as I get some looooong delays.

greets
--
Christian Gmeiner, MSc
