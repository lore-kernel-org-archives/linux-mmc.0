From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Tue, 7 Jun 2011 16:51:07 -0700
Message-ID: <86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
 <201105271746.04775.arnd@arndb.de>
 <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:38662 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751920Ab1FGXvZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 7 Jun 2011 19:51:25 -0400
In-Reply-To: <BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


On May 29, 2011, at 10:42 PM, zhangfei gao wrote:

>> 
>> There is a little room for simplification, I think:
>> 
>>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>>> +{
>>> +     /* Micro SD does not support write-protect feature */
>>> +     return 0;
>>> +}
>> 
>> You shouldn't need to provide an empty get_ro function, the
>> default is that there is no write-protect.
> 
> Thanks Arnd for review.
> The reason to put get_ro here is some board use micro sd, while some
> board design is general sd card.
> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT will
> return 1 in our controller, so it shows read only.
> So add one call back for the board with micro sd card via flag.



The code sets get_ro is for all the controllers.   Some board designs may connect the WP signal.

The host->ops field should be filled in using information in the board
file using a flag such as the example with  PXA_FLAG_CARD_PERMANENT.

eg

	if (pdata && pdata->flags & PXA_FLAG_NO_WP) {
		***** etc ****
	}




