From: Ed Sutter <ed.sutter@alcatel-lucent.com>
Subject: imx6 emmc issue
Date: Wed, 20 Nov 2013 11:06:02 -0500
Message-ID: <528CDDEA.1040500@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ihemail2.lucent.com ([135.245.0.35]:34033 "EHLO
	ihemail2.lucent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab3KTQYM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Nov 2013 11:24:12 -0500
Received: from usnavsmail3.ndc.alcatel-lucent.com (usnavsmail3.ndc.alcatel-lucent.com [135.3.39.11])
	by ihemail2.lucent.com (8.13.8/IER-o) with ESMTP id rAKG73n5018064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2013 10:07:04 -0600 (CST)
Received: from umail.lucent.com (umail.ndc.lucent.com [135.3.40.61])
	by usnavsmail3.ndc.alcatel-lucent.com (8.14.3/8.14.3/GMO) with ESMTP id rAKG73aN027481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2013 10:07:03 -0600
Received: from [135.222.138.133] (Ed-PC.mh.lucent.com [135.222.138.133])
	by umail.lucent.com (8.13.8/TPES) with ESMTP id rAKG72Jk010898
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2013 10:07:03 -0600 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Dong,
Hello, I am currently working on an Freescale iMX6 SABRE Board platform
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=RDIMX6SABREBRD

I'm trying to run with mainline kernel/uboot/buildroot just to be a bit more
up-to-date than the LTIB distribution.  I am trying to setup a ROOTFS 
directly
on the eMMC device.  Referring to this thread on the freescale forum:

https://community.freescale.com/message/363870?et=watches.email.thread#363870

I'm working with linux-3.12 and patch-v3.12-next-20131119 and I've 
applied these
additional patches: http://comments.gmane.org/gmane.linux.kernel.mmc/23339

I am able to access the emmc device from linux when using fdisk; however,
when I attempt to run "mkfs.ext3 /dev/mmcblk0p1" the "Discarding device 
blocks"
step takes over an hour (80 minutes last time I tried it).

Fabio Estevam (from freescale) suggested I report this to you.
Are you aware of this issue?  Are you aware of anyone that's actually tried
to do mkfs.ext3 on emmc with a recent kernel version for this board/SOC?

Thanks in advance,
Ed Sutter
