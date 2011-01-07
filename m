From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: SD power-control necessary?
Date: Fri, 07 Jan 2011 22:39:14 +0800
Message-ID: <4D272592.6000508@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout02.eigbox.net ([66.96.188.2]:57198 "EHLO
	bosmailout02.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab1AGPVc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2011 10:21:32 -0500
Received: from bosmailscan07.eigbox.net ([10.20.15.7])
	by bosmailout02.eigbox.net with esmtp (Exim)
	id 1PbDUx-0003Aw-Af
	for linux-mmc@vger.kernel.org; Fri, 07 Jan 2011 09:40:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hello,

Maybe a stupid question, but when designing new hardware with a slot
for an sd-card, how essential is it that the driver is able to power off/on
the card?

I would say essential, because I've seen sd-cards in a state in which they
didn't respond to MMC_GO_IDLE_STATE anymore, until they were re-inserted.

Can anyone shed a light on this? How could an sd-card get into such a state?

Will the mmc driver fall back to mmc_rescan() after an initialized card
becomes non-responsive?

Thanks, Hein
