From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [patch 2/2] mmc: add support of sdhci-pxa driver
Date: Sun, 26 Sep 2010 22:45:02 +0800
Message-ID: <AANLkTimk2_KcmSAV-UZ3JY1JFD657SnfyPFgP_zE5bbP@mail.gmail.com>
References: <AANLkTi=XBbW=R4HQYp5fLVE5eUXHNtzGh1Qf+XyBUSCH@mail.gmail.com>
	<AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44069 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0IZOpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Sep 2010 10:45:03 -0400
Received: by wwd20 with SMTP id 20so172260wwd.1
        for <linux-mmc@vger.kernel.org>; Sun, 26 Sep 2010 07:45:02 -0700 (PDT)
In-Reply-To: <AANLkTim4aJok6=HcopkObi3WrUatiZgK-KZTfhoHwgF7@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>

On Sun, Sep 26, 2010 at 8:39 PM, Eric Miao <eric.y.miao@gmail.com> wrot=
e:
> On Sun, Sep 26, 2010 at 6:56 PM, zhangfei gao <zhangfei.gao@gmail.com=
> wrote:
>>
>> ---
>> =A0arch/arm/plat-pxa/include/plat/sdhci.h | =A0 32 +++++++
>> =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +++
>> =A0drivers/mmc/host/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0drivers/mmc/host/sdhci-pxa.c =A0 =A0 =A0 =A0 =A0 | =A0143 +++++++=
+++++++++++++++++++++++++
>
> I prefer we rename it to something like sdhci-mmp.c and the 'pxa' in =
the source
> code to 'mmp' to cause less confusion with pxamci.c?
>
Maybe sdhci-pxa.c is better. pxamci.c isn't compatible with sdhci, so
it won't make people confusion.

>> +
>> +#endif /* __PLAT_PXA_SDHCI_H */
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 6f12d5d..9510976 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -158,6 +158,17 @@ config MMC_SDHCI_S3C
>>
>> =A0 =A0 =A0 =A0 =A0If unsure, say N.
>>
>> +config MMC_SDHCI_PXA
>> + =A0 =A0 =A0 tristate "Marvell PXA168/PXA910/MMP2 SD Host Controlle=
r support"
>> + =A0 =A0 =A0 depends on ARCH_PXA || ARCH_MMP
>
> Only on ARCH_MMP or is this also used in PXA950+?
>
This SD controller IP is also used in PXA955. PXA955 (MG1) belongs to
ARCH_PXA. So
MMC_SDHCI_PXA should be depend on ARCH_PXA or ARCH_MMP.

Thanks
Haojian
