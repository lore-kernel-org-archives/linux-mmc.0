From: Bear <jilingshu@gmail.com>
Subject: Is the mmc driver for Freescale MPC8313E broken?
Date: Sat, 02 Jul 2011 22:08:46 +0800
Message-ID: <4E0F266E.4070609@Gmail.com>
References: <S1754370Ab1GBN5G/20110702135706Z+988@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34935 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab1GBOI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jul 2011 10:08:59 -0400
Received: by pvg12 with SMTP id 12so3237769pvg.19
        for <linux-mmc@vger.kernel.org>; Sat, 02 Jul 2011 07:08:59 -0700 (PDT)
In-Reply-To: <S1754370Ab1GBN5G/20110702135706Z+988@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

hi there,
I am trying to build a kernel with SD Card support for my MPC8313E-RDB. 
The MMC support and "MMC via SPI" has been checked. I also checked 
Freescale SPI support and Freescale eSPI support in SPI setting. But 
when I boot this kernel and logged in my system, I found there are no 
MMC device found. There are no related information in "dmesg" or 
/proc/partitions or /dev.
Is there anyone who can help me on building a MMC-enabled kernel for my 
board? Or if it is not supported yet?
Thanks in advanced.
