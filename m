From: Ian Molton <ian.molton@codethink.co.uk>
Subject: tmio_mmc: Cleanups
Date: Wed, 30 Apr 2014 17:59:05 +0100
Message-ID: <1398877151-6965-1-git-send-email-ian.molton@codethink.co.uk>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:47911 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S964792AbaD3Q7b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Apr 2014 12:59:31 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@linaro.org, chris@printf.net

This is a series of small cleanups for the tmio_mmc and sh_mobile_sdhi drivers.

Please apply!

-Ian

 [PATCH 1/6] mmc: TMIO: Refactor driver core probe function
 [PATCH 2/6] mmc: TMIO: Fixup error return path
 [PATCH 3/6] mmc: TMIO: Use devm_ioremap()
 [PATCH 4/6] mmc: TMIO: use devm_ for requesting irq
 [PATCH 5/6] shmobile: TMIO: break register specs out from TMIO kernel
 [PATCH 6/6] mmc: TMIO: Move register definitions to where they belong
