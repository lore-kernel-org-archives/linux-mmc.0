From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v3 0/3] provide sdhci driver for mmp2 and pxa910
Date: Tue, 7 Jun 2011 13:26:45 +0800
Message-ID: <BANLkTimefL_HHtvXc0af43dDv=B12roevA@mail.gmail.com>
References: <BANLkTikP72ybaqa8zDgNjBQg8Q6SH5fMdw@mail.gmail.com>
	<201106031820.51922.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41881 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab1FGF0q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 01:26:46 -0400
Received: by vws1 with SMTP id 1so3306206vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jun 2011 22:26:46 -0700 (PDT)
In-Reply-To: <201106031820.51922.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sat, Jun 4, 2011 at 12:20 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 03 June 2011, zhangfei gao wrote:
>> Here are patches to provide separate sdhci driver for mmp2 and pxa91=
0
>> based on sdhci-platfm.
>> Rename to sdhci-pxav3.c and sdhci-pxav2.c
>> Remove sdhci-pxa.c, which is used to share among pxa serious, since
>> under this method, platform difference have to be put under arch/arm=
,
>> which is not easy to track.
>> As a result, mmp2 mmc resource should be updated accordingly.
>
> Looks all good content-wise. I do have a few comments regarding the
> style of submission, please follow that the next time:
>
> * Make all patches a reply to the =A0[PATCH 0/x] email, so they show =
up
> =A0as a single thread. This helps finding the emails when your mail
> =A0client sorts threads by last reply. The option in git-send-email
> =A0is '--thread --no-chain-reply'.
>
> * The changelog has extra spaces in it that shouldn't be there. I ass=
ume
> =A0they come from using git-show instead of git-format-patch to creat=
e
> =A0the emails.
>
> * Make sure a series is bisectable. This means that each patch result=
s
> =A0in a working kernel without regressions when you apply only part o=
f
> =A0the series. There are multiple ways to get there. In this case, yo=
u
> =A0could fold the patch that updates the resources into the patch tha=
t
> =A0changes the format. Alternatively, you could first create the new =
driver
> =A0in the new format, then change the resources, and finally remove t=
he
> =A0now obsolete driver.
>
> =A0 =A0 =A0 =A0Arnd

Thanks Arnd for your patient explanation, will take more care next time=
=2E
>
