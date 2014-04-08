From: Stefan Roese <stefan.roese@gmail.com>
Subject: Re: omap_hsmmc: Problem with SanDisk Extreme Pro MicroSDHC 1
Date: Tue, 08 Apr 2014 16:09:44 +0200
Message-ID: <53440328.5010609@gmail.com>
References: <5342AC5C.8000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.180]:11207 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756996AbaDHOJ0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Apr 2014 10:09:26 -0400
In-Reply-To: <5342AC5C.8000904@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Balaji T K <balajitk@ti.com>

On 07.04.2014 15:47, Stefan Roese wrote:
> I'm currently testing on an OMAP3530 board (tao3530 SOM with custom
> baseboard) with v3.14. I applied all the OMAP/pbias patch from Balaji
> and MMC/SDcard detection seemed to work reliably.
>
> But now I noticed that the SanDisk Extreme Pro MicroSDHC 1 (8 GB) is not
> detected all the time. It seems that the card detected fails with
> timeout on (approx?) each 2nd reboot (via reset button). A quick check
> shows that the timeout happens in mmc_send_app_op_cond():
>
> [    4.901275] mmc0: error -110 whilst initialising SD card
> [    4.939849] mmc1: new SDIO card at address 0001
>
> Is this a known issue? Any ideas on how to fix this?

Just to let you know. I missed to add the "cd-gpios" property to the mmc 
DT node. With this addition the detection seems to work reliably.

Sorry for the noise,
Stefan

