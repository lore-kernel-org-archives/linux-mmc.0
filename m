From: Brice Goglin <Brice.Goglin@ens-lyon.org>
Subject: Dell Latitude E6410 Ricoh e822 not working with 2.6.36-rc
Date: Mon, 20 Sep 2010 14:40:21 +0200
Message-ID: <4C975635.5090108@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from iona.labri.fr ([147.210.8.143]:53697 "EHLO iona.labri.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753728Ab0ITNCj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Sep 2010 09:02:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iona.labri.fr (Postfix) with ESMTP id E715536B99
	for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 14:40:25 +0200 (CEST)
Received: from iona.labri.fr ([127.0.0.1])
	by localhost (iona.labri.fr [127.0.0.1]) (amavisd-new, port 10027)
	with LMTP id XmKxdeMjOKFb for <linux-mmc@vger.kernel.org>;
	Mon, 20 Sep 2010 14:40:25 +0200 (CEST)
Received: from [193.50.110.244] (unknown [193.50.110.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by iona.labri.fr (Postfix) with ESMTP id CECEA36B93
	for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 14:40:25 +0200 (CEST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I have a Dell Latitude E6410 laptop with the following Ricoh reader:

03:00.0 SD Host controller: Ricoh Co Ltd Device e822 (rev 03) (prog-if 01)
	Subsystem: Dell Device 040a
	Flags: bus master, fast devsel, latency 0, IRQ 19
	Memory at f2c40000 (32-bit, non-prefetchable) [size=256]
	Capabilities: <access denied>
	Kernel driver in use: sdhci-pci



The driver has been failing with ugly errors for a long time and I was
following [1] (pointed out from [2]) to get proper support. According to
[2], 2.6.36 is supposed to contain what's needed to support my reader,
but 2.6.36-rc3 still fails to read my SD card. It just says

  mmc0: new high speed SD card at address b368

And nothing else happens. dmesg with mmc debug enabled is available at

  https://bugzilla.redhat.com/attachment.cgi?id=447442


For the record, the same SD card works fine on a Dell Latitude E6500
(older model) with Ubuntu 10.4

  03:01.2 SD Host controller: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 21)


I was told to report the upstream here, so here I am.

Brice

[1] https://bugzilla.redhat.com/show_bug.cgi?id=596475
[2] https://bugzilla.kernel.org/show_bug.cgi?id=16390

