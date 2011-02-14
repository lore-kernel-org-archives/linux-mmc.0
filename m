From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH 0/1] mmc: sdhci: Force delay in operations due to silicon
 issues
Date: Sun, 13 Feb 2011 23:20:34 -0800
Message-ID: <24E95653-EF7E-428E-95A5-9804CB0D0F0F@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36734 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751367Ab1BNHXT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Feb 2011 02:23:19 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


patch set 10/12

[PATCH] sdhci: add ops to force delay in operations due to silicon issues

PXA168 controller needs at least 8 clocks before it can start the
next transaction.  When the bus speed is slow the CPU can get back
to the controller before the 8 clocks causing SD CRC errors.

Add a new host->op to call into platform specific code to delay
the operation until the time has expired
