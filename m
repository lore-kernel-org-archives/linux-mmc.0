From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Wed, 8 Jun 2011 10:56:17 +0800
Message-ID: <BANLkTinTKV3DwVdi8p-BYCZ4ON_ce4T74g@mail.gmail.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
	<86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58826 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425Ab1FHC4S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2011 22:56:18 -0400
Received: by vxi39 with SMTP id 39so58825vxi.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 19:56:17 -0700 (PDT)
In-Reply-To: <86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Jun 8, 2011 at 7:51 AM, Philip Rakity <prakity@marvell.com> wro=
te:
>
> On May 29, 2011, at 10:42 PM, zhangfei gao wrote:
>
>>>
>>> There is a little room for simplification, I think:
>>>
>>>> +static unsigned int mmp2_get_ro(struct sdhci_host *host)
>>>> +{
>>>> + =A0 =A0 /* Micro SD does not support write-protect feature */
>>>> + =A0 =A0 return 0;
>>>> +}
>>>
>>> You shouldn't need to provide an empty get_ro function, the
>>> default is that there is no write-protect.
>>
>> Thanks Arnd for review.
>> The reason to put get_ro here is some board use micro sd, while some
>> board design is general sd card.
>> The micro sd do not use write-protect, while SDHCI_WRITE_PROTECT wil=
l
>> return 1 in our controller, so it shows read only.
>> So add one call back for the board with micro sd card via flag.
>
>
>
> The code sets get_ro is for all the controllers. =A0 Some board desig=
ns may connect the WP signal.
>
> The host->ops field should be filled in using information in the boar=
d
> file using a flag such as the example with =A0PXA_FLAG_CARD_PERMANENT=
=2E
>
> eg
>
> =A0 =A0 =A0 =A0if (pdata && pdata->flags & PXA_FLAG_NO_WP) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0***** etc ****
> =A0 =A0 =A0 =A0}
>
>

This method is used in v1,
The method makes sdhci_ops non-const and have to dynamically alloc
sdhci_ops, since host->ops is pointer.
Will keep use const sdhci_ops, recommended by Arnd.

>
>
>
