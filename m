From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] sdhci-pxa: add call back interface to share sdhci-pxa
Date: Mon, 23 May 2011 09:13:32 -0400
Message-ID: <BANLkTim7yniXm_iZGU0vpXH+tC_rqzjN_Q@mail.gmail.com>
References: <BANLkTimPN=GauwY7Rwh3xUEkV3=q3wfzAQ@mail.gmail.com>
	<201105182238.45614.arnd@arndb.de>
	<BANLkTinGQLPD4LmjiSjtswqJ19xtvimjUw@mail.gmail.com>
	<201105191504.49875.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34418 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751691Ab1EWNNd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2011 09:13:33 -0400
Received: by vxi39 with SMTP id 39so4045227vxi.19
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2011 06:13:32 -0700 (PDT)
In-Reply-To: <201105191504.49875.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Thu, May 19, 2011 at 9:04 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 19 May 2011, zhangfei gao wrote:
>> To make sdhci-pxa easy to maintain, we still prefer put platform
>> specific difference under platform code.
>>
>> "Identify controller from platform data" looks to me is same as usin=
g #ifdef.
>> The method is used in our another driver before.
>
> I meant run-time code, not compile-time #ifdef. In the long run, we
> want to have a kernel that is able to work on many different systems,
> and that means the drivers should not impose hardcoded limitations.
>
>> More and more workaround comes when more and more platform need to
>> support, making the driver bigger and bigger and not easy to maintai=
n.
>> Nobody remember what's the workaround purpose several years later.
>> So the result is we have to re-write the driver again to make it sim=
ple :(
>>
>> Currently, the ip is shared among mmp2, pxa910, pxa168 etc, pxa910
>> maintainer does not care what workaround is used on pxa168.
>> When mmp3 wants to reuse the ip, it's easier to not care what's the
>> history at all.
>>
>> So we still prefer keep driver as simple as possible, while specific
>> platform self-maintain specific workaround , which is not aware to
>> other platform.
>
> There are a lot of different ways to do the same thing, but splitting
> out code into the subarchitecture is not a good one. Please have a lo=
ok
> at how Shawn Guo has reworked the sdhci-pltfm drivers to have common
> part as a library and then multiple users of that. You can probably
> do the same with the different versions of the sdhci-pxa driver.
>
> =A0 =A0 =A0 =A0Arnd
>
Hi, Arnd

When we start to share sdhci-pxa, we find another sdhci-platfm occurs.
While in Shawn's patch, driver self-register is recommended.
If this is new trend, it maybe a better choice to use separate driver
for each device based on updated sdhci-platfm.c by Shawn.
Will update the sdhci-mmp2.c for mmp2 only based on Shawn's modificatio=
n.

Thanks
