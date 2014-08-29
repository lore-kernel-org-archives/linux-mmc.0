From: Markus Niebel <list-09_linux-mmc@tqsc.de>
Subject: mmc:  eMMC BKOPS status handling lock for non urgent case
Date: Fri, 29 Aug 2014 18:49:08 +0200
Message-ID: <5400AF04.2040708@tqsc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:48608 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbaH2Qnj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Aug 2014 12:43:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com
Cc: linux-mmc@vger.kernel.org

Hello,

experimenting with the current BKOPS code we found, that when triggering from BKOPS_LEVEL 1,
the status stored with mmc_card_set_doing_bkops is never reset preventing BKOPS from working.

Since I'm not an expert in the mmc subsystem I ask for a hint where to look for completion
and implement proper status reset.

Thanks in advance

Markus Niebel
