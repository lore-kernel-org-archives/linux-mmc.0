From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v2 1/4] rename ARCH_BCM to ARCH_BCM_MOBILE (mach-bcm)
Date: Tue, 29 Oct 2013 23:22:26 -0700
Message-ID: <CAEPRUYoMqTTBxtxMSTk6cgyyKBqpWLK0EHaA4XoraNYhwzUL5A@mail.gmail.com>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
	<1379956836-5866-2-git-send-email-bcm@fixthebug.org>
	<CAOesGMi59voTKvu1zA5zpv4xDiF_2OQFMOjtx2wg4S7W=MhY3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:55052 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605Ab3J3GW2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 02:22:28 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so372383eek.25
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2013 23:22:26 -0700 (PDT)
In-Reply-To: <CAOesGMi59voTKvu1zA5zpv4xDiF_2OQFMOjtx2wg4S7W=MhY3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Domenico Andreoli <cavokz@gmail.com>, Christian Daudt <csd@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, Matt Porter <matt.porter@linaro.org>, Alex Elder <alex.elder@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Oct 28, 2013 at 1:38 PM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Sep 23, 2013 at 10:20 AM, Christian Daudt <bcm@fixthebug.org> wrote:
>> --- a/arch/arm/mach-bcm/Kconfig
>> +++ b/arch/arm/mach-bcm/Kconfig
>> @@ -1,5 +1,17 @@
>>  config ARCH_BCM
>> -       bool "Broadcom SoC" if ARCH_MULTI_V7
>> +       bool "Broadcom SoC Support"
>> +       select ARCH_MULTIPLATFORM
>
> This should be the other way around -- all other platforms seem to
> depend on ARCH_MULTIPLATFORM instead of selecting it.
>
Done
>> +       help
>> +         This enables support for Broadcom ARM based SoC
>> +          chips
>> +
>> +if ARCH_BCM
>> +
>> +menu "Broadcom SoC Selection"
>> +
>> +config ARCH_BCM_MOBILE
>> +       bool "Broadcom Mobile SoC" if ARCH_MULTI_V7
>> +       default y
>
> This shouldn't be default y, since it makes it less obvious in configs
> such as multi_v7_defconfig that the platform is enabled.
>
done.

 I've amended the existing patch with the mods above, and since they
were pretty minor, I've already folded it into a subsequent pull
request that I just sent out.

 Thanks,
   csd
