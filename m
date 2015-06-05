From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] SDHCI: Change AMD SDHCI quirk application scope
Date: Fri, 5 Jun 2015 18:01:56 +0800
Message-ID: <CAKT61h8kN33D03jV7pJ7b25p9M6JSPm2WxLgh4DhJxnteHQnrw@mail.gmail.com>
References: <1433428437-6067-1-git-send-email-Vincent.Wan@amd.com>
 <20150604153220.GA4521@pd.tnic> <CAKT61h8E3=gvO=ZfFDPhBuWsWuPnGCxtxYa-izSOJk=RWKyUtQ@mail.gmail.com>
 <20150605092001.GB3679@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34688 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbbFEKCR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jun 2015 06:02:17 -0400
In-Reply-To: <20150605092001.GB3679@pd.tnic>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Wan ZongShun <Vincent.Wan@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Wan ZongShun <linux@mcuos.com>

2015-06-05 17:20 GMT+08:00 Borislav Petkov <bp@alien8.de>:
> On Fri, Jun 05, 2015 at 09:37:09AM +0800, Wan ZongShun wrote:
>> Boris, I means I put this KERCZ Mircro in pci_ids.h, and I also will
>> send the other patch to instead the following '0x790b' of codes. I
>> think it is reasonable, right?
>
> No, it means two things:
>
> * why does it contain KERNCZ? What does that mean?

The KERNCZ is new AMD SB/FCH generation name, like HUDSON2 is old FCH
generation.
We will adopt 0x790b as device ID since from this KERNCZ gereration.

>
> * #define PCI_DEVICE_ID_AMD_<better_name>_SMBUS 0x790b should be in
> drivers/mmc/host/sdhci-pci.c as it is used only there.


The i2cpiix4.c driver and eMMC driver both will use this device ID
macro, Do you think I should submit two patches synchronously? like
patch1: change i2cpiix4 driver to use PCI_DEVICE_ID_AMD_KERNCZ_SMBUS,
patch2: for eMMC quirk in sdhci-pci.c?

And then the PCI_DEVICE_ID_AMD_KERNCZ_SMBUS can be go into pci ids.h?

>
> Thanks.
>
> --
> Regards/Gruss,
>     Boris.
>
> ECO tip #101: Trim your mails when you reply.
> --



-- 
Wan ZongShun.
www.mcuos.com
