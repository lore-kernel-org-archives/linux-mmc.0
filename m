From: =?UTF-8?Q?David_M=c3=bcller_=28ELSOFT_AG=29?= <d.mueller@elsoft.ch>
Subject: "Card stuck in programming state! __mmc_switch" problem on i.MX6 + eMMC
Date: Tue, 16 Sep 2014 16:37:13 +0200
Message-ID: <54184B19.4080909@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.hostpark.net ([212.243.197.30]:50987 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbaIPOqH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Sep 2014 10:46:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hostpark.net (Postfix) with ESMTP id 035F316C4C
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2014 16:37:04 +0200 (CEST)
Received: from mail.hostpark.net ([127.0.0.1])
	by localhost (mail1.hostpark.net [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id SGBxAtRtC50z for <linux-mmc@vger.kernel.org>;
	Tue, 16 Sep 2014 16:37:03 +0200 (CEST)
Received: from [192.168.11.10] (80-218-111-224.dclient.hispeed.ch [80.218.111.224])
	by mail.hostpark.net (Postfix) with ESMTPA id CDF7616E1E
	for <linux-mmc@vger.kernel.org>; Tue, 16 Sep 2014 16:37:03 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello

I have a custom i.MX6Q based board with a Hynix eMMC chip attached to
USDHC3. OS is a vanilla Linux 3.16 with some patches.

Loading the iMX SDHC driver results in the following error:

modprobe sdhci-esdhc-imx
sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pltfm: SDHCI platform and OF driver helper
mmc0: no vqmmc regulator found
mmc0: SDHCI controller on 2198000.usdhc [2198000.usdhc] using ADMA
mmc0: BKOPS_EN bit is not set
mmc0: Card stuck in programming state! __mmc_switch
mmc0: error -110 whilst initialising MMC card
mmc0: BKOPS_EN bit is not set
mmc0: Card stuck in programming state! __mmc_switch
mmc0: error -110 whilst initialising MMC card
mmc0: BKOPS_EN bit is not set
mmc0: Card stuck in programming state! __mmc_switch
mmc0: error -110 whilst initialising MMC card
mmc0: BKOPS_EN bit is not set
mmc0: Card stuck in programming state! __mmc_switch
mmc0: error -110 whilst initialising MMC card


Pin muxing looks ok nevertheless I played around with it to see if it
makes a difference. I also tried the "Add delay between CMD6 and CMD13
for Sandisk eMMC cards" workaround previously mentioned on this list.

As the whole thing is working under U-Boot as shown below, I tend to
rule out soldering problems and non-functional hardware.

=> ver
U-Boot 2014.07-00045-g0955ecc-dirty (Aug 26 2014 - 12:47:21)
=> mmc dev 1
switch to partitions #0, OK
mmc1(part 0) is current device
=> mmc info
Device: FSL_SDHC
Manufacturer ID: 90
OEM: 14a
Name: H8G2d
Tran Speed: 52000000
Rd Block Len: 512
MMC version 4.41
High Capacity: Yes
Capacity: 7.2 GiB
Bus Width: 8-bit


Any idea what is going wrong?
Has anybody a Hynix eMMC working under Linux?

