From: Arnd Hannemann <arnd@arndnet.de>
Subject: [PATCH 0/4] Fix/improve hotplug for sh_mobile_sdhi/tmio_mmc/sh_mmcif
Date: Tue, 24 Aug 2010 17:26:58 +0200
Message-ID: <1282663622-20564-1-git-send-email-arnd@arndnet.de>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mta-1.ms.rz.RWTH-Aachen.DE ([134.130.7.72]:49635 "EHLO
	mta-1.ms.rz.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752366Ab0HXP1I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2010 11:27:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ian@mnementh.co.uk
Cc: sameo@linux.intel.com, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com

This patch series attempts to fix hotplug (for sh_mobile_sdhi/tmio_mmc) and 
improve hotplug (for sh_mmcif) on the AP4EVB (shmobile) board, by handling the 
card detect in platform code.

Best regards,
Arnd

