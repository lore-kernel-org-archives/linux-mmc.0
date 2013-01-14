From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] Vqmmc vs. Vmmc supply
Date: Mon, 14 Jan 2013 18:17:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301141751500.2337@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:49375 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757198Ab3ANRRe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jan 2013 12:17:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by axis700.grange (Postfix) with ESMTP id 174B640B98
	for <linux-mmc@vger.kernel.org>; Mon, 14 Jan 2013 18:17:33 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi

I'm trying to understand requirements for switching Vmmc and Vqmmc supply 
voltages of SD cards.

IIUC, Vmmc is the card supply voltage, applied to the card's VDD pin, 
Vqmmc is the voltage, used to pull up signal lines. Traditionally it used 
to be the same voltage, respectively, OCR reflects _the_ voltages, that 
cards support. Both voltages also would normally be supplied by one 
regulator, so, applied and removed "simultaneously."

Now this changes with UHS SD cards, which require 1.8V Vqmmc and 3.3V Vmmc 
for high-speed operation. The SDHCI driver provides a reasonable example 
of the run-time power-supply management. I've also looked at the SD 
simplified physical layer spec (part 1) final version 3.01. But, I still 
have (at least) one question: what is the correct way to bring up the two 
regulators - Vmmc and Vqmmc in a generic case? I.e., if they really are 
provided by two separate regulators? Arguably, this isn't a very safe (or 
even compliant) design. Probably, you would supply Vqmmc from Vmmc too, in 
which case "enabling" Vqmmc first should be safe, but what if those are 
really two independent regulators? If we power Vmmc first we risk random 
garbage on data lines... So, looks like we really have to enable Vqmmc 
first and just hope that this really won't apply power to the pins before 
Vmmc is also switched on? Or should cards be able to handle Vqmmc on with 
Vmmc off?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
