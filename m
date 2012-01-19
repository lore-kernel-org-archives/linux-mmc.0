From: Thomas Bechtold <thomasbechtold@jpberlin.de>
Subject: "mmc_host mmc0: WARNING: IMR=0x00004040" on debug console
Date: Thu, 19 Jan 2012 15:04:10 +0100
Message-ID: <4F1822DA.6090200@jpberlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.jpberlin.de ([213.203.238.11]:59650 "EHLO mail.jpberlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab2ASOLO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jan 2012 09:11:14 -0500
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
	by plasma.jpberlin.de (Postfix) with ESMTP id DB61C84A68
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2012 15:04:21 +0100 (CET)
Received: from plasma.jpberlin.de ([91.198.250.140])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10024)
	with ESMTP id xE22vUuJUOmi for <linux-mmc@vger.kernel.org>;
	Thu, 19 Jan 2012 15:04:11 +0100 (CET)
Received: from [192.168.12.35] (unknown [213.172.126.10])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: thomasbechtold)
	by plasma.jpberlin.de (Postfix) with ESMTPSA id 05AEB8471E
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2012 15:04:10 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

i updated from kernel 2.6.35.3 (from kernel.org) to kernel 3.2.1 (from 
kernel.org) on arm (at91stamp9G20) and have a MMC card which can be 
completly disabled with a hardware switch. The mmc card is then used by 
another processor without linux. That works very well.
My question is, why i get always the message "mmc_host mmc0: WARNING: 
IMR=0x00004040" after i removed the mmc card slot once. That's a new 
behavior with 3.2.1. I had no message with 2.6.35.3.
When the mmc slot returns to linux, the message stops and i get:

mmc_host mmc0: WARNING: IMR=0x00004040
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card at address b368
mmcblk0: mmc0:b368 H1697 1.91 GiB
  mmcblk0: unknown partition table

That's fine.

Should i just ignore the message (or simple patch 
driver/mmc/host/atmel_mci.c)?

TIA


Tom

