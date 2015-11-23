From: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Subject: RE: [RFC 0/6] mmc: Field Firmware Update
Date: Mon, 23 Nov 2015 11:40:04 +0000
Message-ID: <SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0067.outbound.protection.outlook.com ([157.56.110.67]:42592
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751485AbbKWMMc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2015 07:12:32 -0500
In-Reply-To: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

Hi Holger,

Thank you for resubmitting the FFU patches again.
We did couple of fixes since our last submission (in [RFC 6/6]), so we will post them soon.
Also, we would like to leave the original "signed-off-by" names in your FFU patch commits.
Could you please add the original:
Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
Signed-off-by: Alex Lemberg <Alex.Lemberg@sandisk.com>

Thanks,
Avi & Alex

> -----Original Message-----
> From: Holger Schurig [mailto:holgerschurig@gmail.com]
> Sent: Friday, November 13, 2015 4:56 PM
> To: Ulf Hansson; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Avi
> Shchislowski; Alex Lemberg
> Cc: Holger Schurig
> Subject: [RFC 0/6] mmc: Field Firmware Update
> 
> There have been some attempts to add FFU (field firmware update).  The last
> AFAIK in Nov 2014, http://www.spinics.net/lists/linux-mmc/msg29324.html
> 
> But it seems that the committers weren't persistent enought.
> 
> I took the liberty to take Avi's patch and make it hopefully maintainer-review
> friendly.
> 
> The first 5 patches just move functions out of mmc_test.c into core.c. Those
> functions will later be used by both mmc_test.c and mmc_ffu.c.  Contrary to
> Avi's patch I didn't add static helper functions to mmc_test.c, e.g.
> there's no mmc_test_prepare_mrq() that calls mmc_prepare_mrq().  It's
> simpler to call mmc_prepare_mrq() directly.  It's just one more dereference
> from *mmc_card to *mmc_test_card anyway.
> 
> The patch [6/6] is http://www.spinics.net/lists/linux-mmc/msg29326.html, but
> with less checkpatch warnings.  And it doesn't use mmc_send_ext_csd()
> anymore, which has been deleted since November.
> 
> I'm sending this patch as RFC now. It compiles (for me). But I get the firmware
> update file from Kingston only next Tuesday.  That means that so far I haven't
> been testing it. It won't do anything without the proper user-space command in
> mmc-utils anyway :-)
> 
> Comments welcome (I intent to get this patch into the kernel)
> 
> The patch is against Linux GIT (v4.3-11748-g46d862b).
> 
> Holger
> 
>  drivers/mmc/card/Kconfig    |  11 +
>  drivers/mmc/card/Makefile   |   1 +
>  drivers/mmc/card/block.c    |   5 +
>  drivers/mmc/card/mmc_ffu.c  | 489
> ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/card/mmc_test.c | 235 +++++----------------
>  drivers/mmc/core/core.c     | 134 ++++++++++++
>  drivers/mmc/core/mmc_ops.c  |   4 +-
>  include/linux/mmc/card.h    |   1 +
>  include/linux/mmc/core.h    |  41 ++++
>  include/linux/mmc/mmc.h     |   6 +
>  10 files changed, 739 insertions(+), 188 deletions(-)  create mode 100644
> drivers/mmc/card/mmc_ffu.c
> 
> --
> 2.1.4

