From: Li Yang-R58472 <r58472@freescale.com>
Subject: RE: [PATCH] SD/MMC: fix the issue of SDHC performance regression
Date: Mon, 7 Nov 2011 10:08:40 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052BB30A@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1320658589-13143-1-git-send-email-b32616@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:24807 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753048Ab1KGKIn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Nov 2011 05:08:43 -0500
In-Reply-To: <1320658589-13143-1-git-send-email-b32616@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Liu Qiang-B32616 <B32616@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, Gala Kumar-B11780 <B11780@freescale.com>



>-----Original Message-----
>From: Liu Qiang-B32616
>Sent: Monday, November 07, 2011 5:36 PM
>To: linux-mmc@vger.kernel.org
>Cc: cjb@laptop.org; Li Yang-R58472; Gala Kumar-B11780; Liu Qiang-B32616
>Subject: [PATCH] SD/MMC: fix the issue of SDHC performance regression
>
>Low performance of SDHC (half of before) due to its frequency was set to
>25MHz,
>but not 50MHz (involved by commit id
>013909c4ffd16ded4895528b856fd8782df04dc6,
>add support for query function modes for uhs cards according to Physical
>Layer
>SPEC V3.01).
>
>Set high speed max frequency according to response status of CMD6, but
>not for SPEC Version. Response of switch command is first consideration
>factor when set SDHC max working frequency. TRAN_SPEED in CSD register
>will be seemed as the second factor.

I'm curious why many SD cards are not setting the clock frequency correctly in the CSD register.  Anyone has a clue?

- Leo


