From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Thu, 19 May 2011 15:04:49 +0200
Message-ID: <201105191504.49875.arnd@arndb.de>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com> <201105182238.45614.arnd@arndb.de> <BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54358 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770Ab1ESNE6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2011 09:04:58 -0400
In-Reply-To: <BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Thursday 19 May 2011, zhangfei gao wrote:
> To make sdhci-pxa easy to maintain, we still prefer put platform
> specific difference under platform code.
> 
> "Identify controller from platform data" looks to me is same as using #ifdef.
> The method is used in our another driver before.

I meant run-time code, not compile-time #ifdef. In the long run, we
want to have a kernel that is able to work on many different systems,
and that means the drivers should not impose hardcoded limitations.

> More and more workaround comes when more and more platform need to
> support, making the driver bigger and bigger and not easy to maintain.
> Nobody remember what's the workaround purpose several years later.
> So the result is we have to re-write the driver again to make it simple :(
> 
> Currently, the ip is shared among mmp2, pxa910, pxa168 etc, pxa910
> maintainer does not care what workaround is used on pxa168.
> When mmp3 wants to reuse the ip, it's easier to not care what's the
> history at all.
> 
> So we still prefer keep driver as simple as possible, while specific
> platform self-maintain specific workaround , which is not aware to
> other platform.

There are a lot of different ways to do the same thing, but splitting
out code into the subarchitecture is not a good one. Please have a look
at how Shawn Guo has reworked the sdhci-pltfm drivers to have common
part as a library and then multiple users of that. You can probably
do the same with the different versions of the sdhci-pxa driver.

	Arnd
