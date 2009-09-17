From: "Eric Millbrandt" <emillbrandt@coldhaus.com>
Subject: mmc_spi: do propper retry managment in the block layer
Date: Thu, 17 Sep 2009 13:53:34 -0500
Message-ID: <20090917185335.M87521@coldhaus.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from workbench.coldhaus.com ([74.0.48.218]:54634 "EHLO
	workbench.coldhaus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759148AbZIQTBM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Sep 2009 15:01:12 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wolfgang.mues@auerswald.de
Cc: linux-mmc@vger.kernel.org

Hello Wolfgang,

What ever happened to your patch "mmc_spi: do propper retry managment in the
block layer - 4th try"? (http://patchwork.kernel.org/patch/29551/)  I have
been using this patch with success on my hardware.  I have not seen this patch
picked up in either Pierre Ossman's or the -stable tree.  The patch does not
apply cleanly to the 2.6.31 kernel, but I was able to iron out the
differences.  It would be a shame to see you work go to waste.

Eric

