From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 0/8] mmc: sdhci-esdhc-imx: add SD3.0 support
Date: Fri, 6 Sep 2013 02:01:31 +0800
Message-ID: <CAA+hA=Sq0UfafVZNV3BXzXBy5Q0_gMXxG9iWgvT6easY7OtJGg@mail.gmail.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
	<CAPDyKFprH0dixTojis63R0oho6CLaPuzSVDuPia6HWQ6cLYmNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:43212 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753214Ab3IESBb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2013 14:01:31 -0400
Received: by mail-qe0-f45.google.com with SMTP id 6so1141945qea.4
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2013 11:01:31 -0700 (PDT)
In-Reply-To: <CAPDyKFprH0dixTojis63R0oho6CLaPuzSVDuPia6HWQ6cLYmNA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, anton@enomsg.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ulf,

On Thu, Sep 5, 2013 at 3:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 September 2013 14:54, Dong Aisheng <b29396@freescale.com> wrote:
>> This patch series add SD3.0 support for i.MX6Q/DL.
>> Since freescale i.MX6Q/DL uSDHC clock tuning progress is a little different from
>> the standard tuning process defined in host controller spec v3.0.
>> So we add a hook to allow execute platform specific tuning instead of
>> standard host controller tuning.
>>
>> The main difference are:
>> 1) not only generate Buffer Read Ready interrupt when tuning is performing.
>> It generates all other DATA interrupts like the normal data command.
>> 2) SDHCI_CTRL_EXEC_TUNING is not automatically cleared by HW,
>> instead it's controlled by SW.
>> 3) SDHCI_CTRL_TUNED_CLK is not automatically set by HW,
>> it's controlled by SW.
>> 4) the clock delay for every tuning is set by SW.
>
> An overall question. Do you have any thoughts around periodic/idle
> re-tuning. It is has nothing directly to do with this patchset, but
> since you implemented the tuning sequence here, maybe you have some
> thoughts around it?
>

It seems sdhci already implements re-tuning mode1 based on timer.
The i.MX6 supports auto-retuning, so we may not use timer
based(periodic) re-tuning.
I plan to add auto-retuning support based on standard host
controller spec into sdhci driver later if no one else does it.

Regards
Dong Aisheng

> Kind regards
> Ulf Hansson
>
>>
>> Tested on i.MX6Q Sabreauto board.
>>
>> The series is based on latest Linus tree.
>>
>> Dong Aisheng (8):
>>   mmc: sdhci: add hooks for platform specific tuning
>>   mmc: sdhci: allow platform access of sdhci_send_command
>>   sdhci: sdhci-esdhc-imx: support real clock on and off for imx6q
>>   sdhci: sdhci-esdhci-imx: add sd3.0 clock tuning support
>>   sdhci: sdhci-esdhc-imx: change pinctrl state according to uhs mode
>>   mmc: sdhci-esdhc: correct pre_div for imx6q
>>   mmc: sdhci-esdhc: set actual_clock in clock setting
>>   ARM: dts: imx6qdl: add uhs pinctrl state for usdhc3
>>
>>  arch/arm/boot/dts/imx6dl.dtsi               |   33 +++
>>  arch/arm/boot/dts/imx6q.dtsi                |   33 +++
>>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi    |    4 +-
>>  drivers/mmc/host/sdhci-esdhc-imx.c          |  307 ++++++++++++++++++++++++++-
>>  drivers/mmc/host/sdhci-esdhc.h              |   35 +++-
>>  drivers/mmc/host/sdhci.c                    |   12 +-
>>  drivers/mmc/host/sdhci.h                    |    3 +
>>  include/linux/platform_data/mmc-esdhc-imx.h |    4 +
>>  8 files changed, 419 insertions(+), 12 deletions(-)
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
