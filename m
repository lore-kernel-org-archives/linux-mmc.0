From: Thomas Bechtold <thomasbechtold@jpberlin.de>
Subject: "mmc_host mmc0: WARNING: IMR=0x00004040" on debug console
Date: Thu, 19 Jan 2012 17:11:44 +0100
Message-ID: <1326989504.2687.3.camel@salbei.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.jpberlin.de ([213.203.238.11]:33433 "EHLO mail.jpberlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932484Ab2ASQL5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jan 2012 11:11:57 -0500
Received: from hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172])
	by plasma.jpberlin.de (Postfix) with ESMTP id 6145484108
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2012 17:11:56 +0100 (CET)
Received: from plasma.jpberlin.de ([91.198.250.140])
	by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
	with ESMTP id Kav0lnS4LDyz for <linux-mmc@vger.kernel.org>;
	Thu, 19 Jan 2012 17:11:46 +0100 (CET)
Received: from [192.168.178.20] (brln-4dba93b5.pool.mediaWays.net [77.186.147.181])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: thomasbechtold)
	by plasma.jpberlin.de (Postfix) with ESMTPSA id E1C0E84166
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2012 17:11:45 +0100 (CET)
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

