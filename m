From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Add support for HS200 tuning mode, on AMD eMMC-4.5.1
Date: Wed, 9 Nov 2016 19:11:27 +0100
Message-ID: <CAPDyKFpa=dhZLqzk-yhoKAXSvrfg7oPAoMBHJa81fqi2vDNJLA@mail.gmail.com>
References: <201611091506.s29MX9Hj%fengguang.wu@intel.com> <67dbdf7c-d910-20bc-6a42-aa2ac8a13b30@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35178 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbcKISLa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Nov 2016 13:11:30 -0500
Received: by mail-wm0-f48.google.com with SMTP id a197so323301844wmd.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Nov 2016 10:11:29 -0800 (PST)
In-Reply-To: <67dbdf7c-d910-20bc-6a42-aa2ac8a13b30@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shyam Sundar S K <ssundark@amd.com>
Cc: kbuild test robot <lkp@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

On 9 November 2016 at 08:14, Shyam Sundar S K <ssundark@amd.com> wrote:
> Hi Ulf, Adrian
>
>>    drivers/mmc/host/sdhci-pci-core.c: In function 'amd_find_good_phase':
>>>> drivers/mmc/host/sdhci-pci-core.c:877:37: error: implicit declaration of function 'sdhci_pci_priv' [-Werror=implicit-function-declaration]
>>      struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
>
> This build error is because, it has dependency on Adrian patch "mmc: sdhci-pci: Let devices define their own private data".
>
> Kindly add our patch on top of Adrian's patch and that will resolve the build error.

Please resend as a series, then kbuild will use the first patch before
trying the second.

[...]

Kind regards
Uffe
