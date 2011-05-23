From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Mon, 23 May 2011 16:56:36 +0200
Message-ID: <201105231656.36944.arnd@arndb.de>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com> <201105191504.49875.arnd@arndb.de> <BANLkTim7yniXm_iZGU0vpXH+tC_rqzjN_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64100 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324Ab1EWO4u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 10:56:50 -0400
In-Reply-To: <BANLkTim7yniXm_iZGU0vpXH+tC_rqzjN_Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Monday 23 May 2011, zhangfei gao wrote:
> When we start to share sdhci-pxa, we find another sdhci-platfm occurs.
> While in Shawn's patch, driver self-register is recommended.
> If this is new trend, it maybe a better choice to use separate driver
> for each device based on updated sdhci-platfm.c by Shawn.
> Will update the sdhci-mmp2.c for mmp2 only based on Shawn's modification.

Having each driver register its own platform_driver sounds like
the best solution to me. Whether you do that on top of sdhci-pltfm.c or
model sdhci-pxa.c to be similar to sdhci-pltfm.c is a different
question. I don't care much either way, so just do whichever works
best for you. Maybe Shawn or Chris can recommend what they think would
work better.

	Arnd
