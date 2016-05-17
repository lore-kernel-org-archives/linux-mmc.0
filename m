From: Laszlo Fiat <laszlo.fiat@gmail.com>
Subject: Re: [PATCH] mmc: block: Use the mmc host device index as the mmcblk
 device index
Date: Tue, 17 May 2016 20:11:22 +0200
Message-ID: <CA+7w51inLtQSr656bJvOjGG9oQWKYPXH+xxDPJKbeJ=CcrkS9Q@mail.gmail.com>
References: <1460015861-14004-1-git-send-email-ulf.hansson@linaro.org>
	<CA+7w51h=A4vVjkJTEvNoRG=GRt-GPSwqN4N4P3k-OqnubPo+kg@mail.gmail.com>
	<CAPDyKFp8pfZ1iY7HsAZL1f2qgTuLcimDL_f1k59RMcUq5f-iRQ@mail.gmail.com>
	<570B9C8D.2000600@intel.com>
	<CA+7w51iP3Th-m8kqdx_iObEs+kYJruNd62f5n2OfD0XaeGw=9w@mail.gmail.com>
	<570E2B2D.1080507@intel.com>
	<CA+7w51gUcPz+z8eD8A3dtB7r_Pvr8yO1AjymXC14eq9RgN6skQ@mail.gmail.com>
	<CAPDyKFq=B0PAxCLJgATSzO9zDHR_L7qOVn7PZ0seekbAb0YRPw@mail.gmail.com>
	<57398F0A.7070600@intel.com>
	<5739B261.2010009@intel.com>
	<5739F7C1.707@gmail.com>
	<CA+7w51gbn+nbsk2j-V2sVzupVbkN=7gt9uXeK8ZQdjdOjSSZsA@mail.gmail.com>
	<CA+7w51guSQ6+XHnRwc+B1wwEV=-K=EOPrqPi5hcJc2b+xh+wuA@mail.gmail.com>
	<CAPDyKFpyehaX9rrZq+0JEvHnwOALv8NbvwVpDQEdAKK_XiJaaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35389 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179AbcEQSLY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 May 2016 14:11:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id g17so165995wme.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2016 11:11:23 -0700 (PDT)
In-Reply-To: <CAPDyKFpyehaX9rrZq+0JEvHnwOALv8NbvwVpDQEdAKK_XiJaaA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: nick <xerofoify@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, May 16, 2016 at 11:45 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 16 May 2016 at 22:30, Laszlo Fiat <laszlo.fiat@gmail.com> wrote:
>> I ran into a problem with the kernel compilation using Adrian's patch:
>> ERROR: "acpi_device_fix_up_power" [drivers/mmc/host/sdhci-acpi.ko] undefined!
>> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
>> make[1]: *** [__modpost] Error 1
>> Makefile:1142: recipe for target 'modules' failed
>> make: *** [modules] Error 2
>>
>> The acpi_device_fix_up_power routine is in drivers/acpi/device_pm.c,
>> but I don't know how can I make it to find it.
>>
>> Any help is appreciated.
>
> In drivers/acpi/device_pm.c, after the function implementation, add:
> EXPORT_SYMBOL_GPL(acpi_device_fix_up_power);
>
> Kind regards
> Uffe

 Hello,

The patch Adrian posted in this thread is working fine, my Teclast
X80h tablet finds all it's SD devices with it. You just have to add
the EXPORT_SYMBOL Uffe wrote above to be able to compile with the
patch.

Tested-by: Laszlo Fiat <laszlo.fiat@gmail.com>

Thank you for working on and fixing this problem.

Bye,

Laszlo Fiat
