From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: support sdhci-mmp2
Date: Wed, 25 May 2011 04:41:24 -0400
Message-ID: <BANLkTikEuWVKkswNU8d5fs+P9FqK5pcYSQ@mail.gmail.com>
References: <1306156882-12124-1-git-send-email-zhangfei.gao@marvell.com>
	<201105231701.38198.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34066 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932782Ab1EYIlZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 04:41:25 -0400
Received: by vws1 with SMTP id 1so5605039vws.19
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 01:41:24 -0700 (PDT)
In-Reply-To: <201105231701.38198.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Philip Rakity <prakity@marvell.com>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Mark Brown <mark.brown314@gmail.com>, Shawn Guo <shawn.guo@linaro.org>

On Mon, May 23, 2011 at 11:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 23 May 2011, Zhangfei Gao wrote:
>> =A0 =A0 =A0 =A0 Delete sdhci-pxa.c and replace with sdhci-mmp2.c spe=
cificlly for mmp2
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 43 ++++-
>> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +=
-
>> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +=
-
>> =A0drivers/mmc/host/sdhci-mmp2.c =A0 =A0 =A0 =A0 =A0| =A0304 +++++++=
+++++++++++++++++++++++++
>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0303 -------=
------------------------
>> =A05 files changed, 349 insertions(+), 312 deletions(-)
>> =A0create mode 100644 drivers/mmc/host/sdhci-mmp2.c
>> =A0delete mode 100644 drivers/mmc/host/sdhci-pxa.c
>
> Hi Zhangfei,
>
> You should really try to improve your changelog texts. Instead of
> the one-line summary that describes what you do 'Delete sdhci-pxa.c a=
nd
> replace ...', please provide a paragraph explaining why you do it,
> and what the bigger plan is here.

Thanks Arnd, will add more change log for explanation.
>
> Also, when renaming a file, please use 'git diff -M' or 'git format-p=
atch -M'
> to detect renames and generate a diff for the changes you did to the =
file.

Double checked same patch coming using  'git format-patch -M' or  'git
format-patch' , since the two files changes a lot.

>
> =A0 =A0 =A0 =A0Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
