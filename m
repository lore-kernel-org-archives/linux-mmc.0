From: Simon Horman <horms@verge.net.au>
Subject: [patch 0/3] mmc, ARM: Add zboot from MMC support for SuperH Mobile ARM
Date: Mon, 06 Dec 2010 09:12:43 +0900
Message-ID: <20101206001243.949375995@vergenet.net>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:59005 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab0LFAO3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 19:14:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

This short series allows a ROM-able zImage to be written to MMC and for
SuperH Mobile ARM to boot directly from the MMCIF hardware block.

The first two patches make minor preparatory changes to the MMCIF code.
The last patch contains the code to load from the MMCIF hardware block.

