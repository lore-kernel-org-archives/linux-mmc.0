From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 4/4] mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7790
Date: Thu, 03 Apr 2014 16:01:23 +0100
Message-ID: <533D77C3.7000606@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:60646 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752412AbaDCPBa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Apr 2014 11:01:30 -0400
In-Reply-To: 877g9g7m3r.wl%kuninori.morimoto.gx@gmail.com
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linux MMC List <linux-mmc@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@lists.codethink.co.uk>, Rob Taylor <rob.taylor@codethink.co.uk>, William Towle <william.towle@codethink.co.uk>

We tested this patch with our current kernel, and have a question
about the addition of the of_rcar_gen2_compatible area.

+static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
+       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | 
TMIO_MMC_WRPROTECT_DISABLE,
+       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+       .capabilities2  = MMC_CAP2_NO_MULTI_READ,
+};

We have been doing some speed tests and this is causing an order
of magnitude speed loss with a number of cards. We're seeing 
1.2-1.6MB/sec instead of 10+MB/sec we would expect from a Class 10
or UHS-1 card.

Is there any reason to stop using the MULTI_READ as the system seems
to work without MMC_CAP2_NO_MULTI_READ.

Also, this series does not seem to be in any of the git trees I
would expect. Does it need re-sending?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
