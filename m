From: Wolfram Schlich <lists@wolfram.schlich.org>
Subject: sdhci-pci: probe of 0000:11:00.0 failed with error -22
Date: Mon, 1 Feb 2016 15:19:44 +0100
Message-ID: <20160201141944.GT13086@bla.fasel.org>
References: <S932267AbcBANb3/20160201133129Z+1138@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.laber.fasel.org ([212.7.178.68]:33483 "EHLO
	mail.laber.fasel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932418AbcBAO1u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2016 09:27:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.laber.fasel.org (Postfix/wolfram.schlich.biz) with ESMTP id 6810B83CA3FB
	for <linux-mmc@vger.kernel.org>; Mon,  1 Feb 2016 15:19:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <S932267AbcBANb3/20160201133129Z+1138@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

[ Issue originally reported as https://bugzilla.kernel.org/show_bug.cgi?id=110411 ]

Hi!

I am working on a Dell Precision M4800 laptop with Gentoo Linux and Kernel 4.3.3:

--8<--
Linux zephyr 4.3.3-gentoo #2 SMP Wed Jan 6 00:33:28 CET 2016 x86_64 Intel(R) Core(TM) i7-4910MQ CPU @ 2.90GHz GenuineIntel GNU/Linux
--8<--

It has an O2 Micro SD/MMC card reader (1217:8520) which is supposed to be supported by sdhci-pci-o2micro:

--8<--
11:00.0 SD Host controller: O2 Micro, Inc. SD/MMC Card Reader Controller (rev 01)
11:00.0 0805: 1217:8520 (rev 01)
--8<--

On bootup, the sdhci-pci driver fails to initialize the card reader with error -22:
--8<--
[    4.782054] sdhci: Secure Digital Host Controller Interface driver
[    4.782057] sdhci: Copyright(c) Pierre Ossman
[    4.782187] sdhci-pci 0000:11:00.0: SDHCI controller found [1217:8520] (rev 1)
[    4.782328] sdhci-pci: probe of 0000:11:00.0 failed with error -22
[    4.782376] sdhci-pltfm: SDHCI platform and OF driver helper
--8<--

What's wrong?

BIOS version is A15 from 09/29/2015.

UPDATE: The issue remains unchanged with kernel 4.3.5-gentoo.

Cheers,
Wolfram
