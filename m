From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Date: Fri, 3 Jun 2011 14:08:18 -0700
Message-ID: <FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:38423 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756429Ab1FCVIc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Jun 2011 17:08:32 -0400
In-Reply-To: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>


Please update mmp2 and pxa defconfigs.

regards,

Philip

On Jun 3, 2011, at 2:48 AM, zhangfei gao wrote:

> v2->v3, modify according to Arnd and Philip suggestion.
> 
> Here are patches to provide separate sdhci driver for mmp2 and pxa910
> based on sdhci-platfm.
> Rename to sdhci-pxav3.c and sdhci-pxav2.c
> Remove sdhci-pxa.c, which is used to share among pxa serious, since
> under this method, platform difference have to be put under arch/arm,
> which is not easy to track.
> As a result, mmp2 mmc resource should be updated accordingly.

