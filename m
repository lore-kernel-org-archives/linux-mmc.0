From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: RE: [PATCH 0/5] mmc: Miscellaneous fixes for SDHCI and MMC core
Date: Mon, 13 Oct 2014 15:53:52 +0400
Message-ID: <000101cfe6dc$5c539990$14faccb0$@mentor.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:45765 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbaJMLyH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Oct 2014 07:54:07 -0400
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

Any comments on this?

> -----Original Message-----
> From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Sent: Wednesday, October 01, 2014 4:14 PM
> To: linux-mmc@vger.kernel.org
> Subject: [PATCH 0/5] mmc: Miscellaneous fixes for SDHCI and MMC core
> 
> Andrew Gabbasov (5):
>   mmc: sdhci: Balance vmmc regulator_disable()
>   mmc: sdhci: fix error conditions for controller reset
>   mmc: core: Initialize SET_BLOCK_COUNT request fields
>   mmc: core: Add debug message for SET_BLOCK_COUNT result
>   mmc: core: Fix error paths and messages in mmc_init_card
> 
>  drivers/mmc/core/core.c  | 12 ++++++++++++
>  drivers/mmc/core/mmc.c   | 16 ++++++++--------
>  drivers/mmc/host/sdhci.c | 10 ++++------
>  3 files changed, 24 insertions(+), 14 deletions(-)
> 
> --
> 2.1.0

Thanks.

Best regards,
Andrew Gabbasov


