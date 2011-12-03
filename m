From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: Build breakage in sdhci-s3c
Date: Sat, 03 Dec 2011 18:25:03 +0900
Message-ID: <000101ccb19d$705e45b0$511ad110$%kim@samsung.com>
References: <20111202115807.GJ8245@opensource.wolfsonmicro.com>
 <CADPsn1aRwUfP+TjDXisoFqJUxg+H7m+OE3GVBE3PF1JZq-_PfA@mail.gmail.com>
 <20111202130412.GP8245@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54795 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab1LCJZG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Dec 2011 04:25:06 -0500
Received: from epcpsbgm2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVM0093DFHS4E50@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 03 Dec 2011 18:25:04 +0900 (KST)
Received: from DOKGENEKIM03 ([12.23.120.114])
 by mmp2.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LVM004EHFHRUN70@mmp2.samsung.com>
 for linux-mmc@vger.kernel.org; Sat, 03 Dec 2011 18:25:04 +0900 (KST)
In-reply-to: <20111202130412.GP8245@opensource.wolfsonmicro.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Sangwook Lee' <sangwook.lee@linaro.org>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

Mark Brown wrote:
> 
> On Fri, Dec 02, 2011 at 12:59:42PM +0000, Sangwook Lee wrote:
> 
> > and I found out that the following patch wasn't applied This  patch
> > was acked by you and Thomas.
> 
> > http://comments.gmane.org/gmane.linux.kernel.samsung-soc/7832
> > This patch has the title : [PATCH v2 1/2] ARM: SAMSUNG: Add pm_caps
> > into platform data
> 
> > Could you help me to solve the below problem ?
> 
> Probably the simplest/best solution here is for Chris to apply this
> patch with Kukjin and Thomas' acks to the mmc tree.

Uhm...it is due to late pushing from my local, I need to sort out my tree
now :(

Anyway, Mark's suggestion makes sense, in this case. Because it can be
happened during merge window even though I solve/push it now.

Hi Chris,
Could you please pick up Sangwook Lee's '[PATCH v2 1/2] ARM: SAMSUNG: Add
pm_caps into platform data' with my ack?

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

