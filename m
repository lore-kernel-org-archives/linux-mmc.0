From: Stefan Koch <stefan.koch10@gmail.com>
Subject: [MX25][MMC]: SDHC very slow (300-600 KB/s) on i.MX25 board
Date: Mon, 26 Nov 2012 11:42:46 +0100
Message-ID: <50B347A6.2020904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:41973 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359Ab2KZKmt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Nov 2012 05:42:49 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so5536534lbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Nov 2012 02:42:48 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

I have ported linux-3.7-rc4 to a board with i.MX257 CPU.
As distribution I use Debian squeeze.
Booting time (with Xorg and IceWM) is different with different SD-Cards.
Boot time with 2GB Standard micro SD-Card: over 2:30 minutes
Boot time with 4GB Class 10 micro SDHC: 1:40 minutes
Boot time with 8GB UHS-1 micro SDHC: 1:15 minutes
Boot time with NFS (Network without SD/SDHC): 40 seconds

Starting applications is faster with NFS as with SD/SDHC.
At SD/SDHC linux is system is waiting a lot of time.
Then CPU can not run at 100% usage, so system is not so fast as possible.

Tests with dd give ratings from a. e. 300 KB/s (this could be a Class 10 
card).

But there is a relationship with slower and faster SD/SDHC-cards:
A UHS card works faster than a class 10 card an so on.
And a Standard 2GB SD card is the slowest.
But the Standard 2GB SC card works with a card reader connected to an 
Notebook faster than the UHS-1 Card in the imx257 Target system with imx 
integrated SDHC controller.

How to solve this problem?
Is it a driver issue?

Thanks

Stefan Koch

