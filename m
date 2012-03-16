From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Commit "mmc: tmio_mmc: do not enable card hotplug interrupts, if
 unused" breaks linux-next
Date: Fri, 16 Mar 2012 14:08:51 -0400
Message-ID: <4F6381B3.1010806@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54258 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab2CPSJJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Mar 2012 14:09:09 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: g.liakhovetski@gmx.de, Chris Ball <cjb@laptop.org>
Cc: linux-next@vger.kernel.org, linux-mmc@vger.kernel.org

Just a heads up that the commit below is causing build failures in linux-next:

drivers/mmc/host/tmio_mmc_pio.c:343:11: error: 'struct tmio_mmc_host' has no member named 'native_hotplug'
drivers/mmc/host/tmio_mmc_pio.c:969:12: error: 'struct tmio_mmc_host' has no member named 'native_hotplug'
make[4]: *** [drivers/mmc/host/tmio_mmc_pio.o] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/5878512/

Paul.
--

commit 6c34d289dcc6675da8c130c5d5cdc5e8f15ec7d7
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Wed Feb 22 13:16:09 2012 +0100

    mmc: tmio_mmc: do not enable card hotplug interrupts, if unused
    
    If TMIO MMC is used in polling mode, or the card is non-removable, or
    card-detection is performed, using an external interrupt, there is no
    need to enable controller native card hotplug interrupts.
    
    Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Signed-off-by: Chris Ball <cjb@laptop.org>



