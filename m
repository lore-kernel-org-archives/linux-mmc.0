From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: support sdhci-mmp2
Date: Wed, 8 Jun 2011 14:08:33 +0800
Message-ID: <BANLkTi=DOHLt1uv-Oz=qnQCE-qmNAVahcg@mail.gmail.com>
References: <1306315367-15602-1-git-send-email-zhangfei.gao@marvell.com>
	<201105271746.04775.arnd@arndb.de>
	<BANLkTi=S=Q+AdKECCHg2u6X=VWEOtEox_w@mail.gmail.com>
	<86F2B225-A55D-41D9-B805-41C639C1882C@marvell.com>
	<BANLkTinTKV3DwVdi8p-BYCZ4ON_ce4T74g@mail.gmail.com>
	<6B2AC372-8A17-41B9-AA5F-BBE5189D17C4@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34030 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab1FHGIe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 02:08:34 -0400
Received: by vxi39 with SMTP id 39so122383vxi.19
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2011 23:08:33 -0700 (PDT)
In-Reply-To: <6B2AC372-8A17-41B9-AA5F-BBE5189D17C4@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao <zgao6@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

>>
>> This method is used in v1,
>> The method makes sdhci_ops non-const and have to dynamically alloc
>> sdhci_ops, since host->ops is pointer.
>> Will keep use const sdhci_ops, recommended by Arnd.
>
>
> Not acceptable.
>
>
> There are =A03 cases for =A0WP signal
>
> a) They are connected to the controller using GPIO
> b( They are NOT connected and the corresponding =A0pin is not used
> c) They are NOT connected and the corresponding =A0pin is used by som=
ething else.
>
> case a)
> =A0 =A0 =A0 =A0program GPIO as is done today in brownstone and aspen
>
> case b)
> =A0 =A0 =A0 =A0configure the MFP pin to be pull high/low to indicate =
NO WP. =A0The pin cannot be left floating

Thanks, configure WP pin to LOW should be work for micro sd card.
>
> case c)
> =A0 =A0 =A0 =A0you need a quirk and the call back.
>
>
>
>
>
>
