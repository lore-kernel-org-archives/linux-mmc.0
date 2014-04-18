From: Tim Kryger <tim.kryger@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Set ocr_avail directly based on vmmc
Date: Fri, 18 Apr 2014 14:23:34 -0700
Message-ID: <CAAYSxhp=oQRpX05dAoxJNyRGXCfpM4EsxUbLz=doVWxWf6bODQ@mail.gmail.com>
References: <1397172708-19735-1-git-send-email-tim.kryger@linaro.org>
	<CAPDyKFrFyBLtL6dVgFy6DkY0gdCjiVpk1OhsfUXD0nhajCetxg@mail.gmail.com>
	<CAAYSxho=S5TqSU4uOiSuH-yh-O6tQxbKEzCn6ow=PLDBKPiSpQ@mail.gmail.com>
	<CAPDyKFp+xTbLtMip847wn1XM_ZJNix_TgQ6Psjq4RrB9=CWThw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:35558 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaDRVXe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Apr 2014 17:23:34 -0400
Received: by mail-oa0-f54.google.com with SMTP id n16so2225330oag.13
        for <linux-mmc@vger.kernel.org>; Fri, 18 Apr 2014 14:23:34 -0700 (PDT)
In-Reply-To: <CAPDyKFp+xTbLtMip847wn1XM_ZJNix_TgQ6Psjq4RrB9=CWThw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, Linux MMC Mailing List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Apr 16, 2014 at 12:20 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 15 April 2014 19:09, Tim Kryger <tim.kryger@linaro.org> wrote:
>> On Fri, Apr 11, 2014 at 1:15 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:

>>> A few times I have suggested to switch to use the
>>> mmc_regulator_get_supply() API to simplify and consolidate code. Could
>>> you please have a look at that?
>>
>> This function will solve my problem but it also suggests that SDHCI
>> drivers should use the vmmc/vqmmc pointers in the mmc_host struct
>> rather than the ones in the sdhci_host struct.
>>
>> Is this your intent?  Do you want to see the regulator pointers in the
>> sdhci_host struct removed once all drivers are modified to use the
>> mmc_host ones?
>
> Correct. That will consolidate code!
>
> Then if sdhci has some special needs for regulators, let's first see
> if we can adopt the API to handle it, before we decide to put that
> code in sdhci driver.

Sounds good.  Please forget about this patch and consider the new
series instead.

https://lkml.org/lkml/2014/4/17/653
