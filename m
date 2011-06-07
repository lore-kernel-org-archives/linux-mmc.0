From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Date: Tue, 7 Jun 2011 13:44:42 +0800
Message-ID: <BANLkTimkk3JfuVmhuBAw4Op93oDtjKdoXw@mail.gmail.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
	<FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:32845 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1FGFon (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 01:44:43 -0400
Received: by vws1 with SMTP id 1so3311943vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2011 22:44:42 -0700 (PDT)
In-Reply-To: <FDBC7F85-3643-4C3C-9E4B-2006D56F24C9@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sat, Jun 4, 2011 at 5:08 AM, Philip Rakity <prakity@marvell.com> wrote:
>
> Please update mmp2 and pxa defconfigs.

The trend is replacing defconfig with device tree, it may not
acceptable to update defconfig.

>
> regards,
>
> Philip
>
> On Jun 3, 2011, at 2:48 AM, zhangfei gao wrote:
>
>> v2->v3, modify according to Arnd and Philip suggestion.
>>
>> Here are patches to provide separate sdhci driver for mmp2 and pxa910
>> based on sdhci-platfm.
>> Rename to sdhci-pxav3.c and sdhci-pxav2.c
>> Remove sdhci-pxa.c, which is used to share among pxa serious, since
>> under this method, platform difference have to be put under arch/arm,
>> which is not easy to track.
>> As a result, mmp2 mmc resource should be updated accordingly.
>
>
