From: Christian Daudt <bcm@fixthebug.org>
Subject: Re: [PATCH v2 2/4] rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
Date: Fri, 13 Dec 2013 08:43:46 -0800
Message-ID: <CAEPRUYpxrhsif-OWi+mcbwbp1V7=8H250Fvx5McbGqifRzh8rg@mail.gmail.com>
References: <1379956836-5866-1-git-send-email-bcm@fixthebug.org>
	<1379956836-5866-3-git-send-email-bcm@fixthebug.org>
	<52AAC9E1.6070405@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:62832 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab3LMQnu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 11:43:50 -0500
Received: by mail-ee0-f51.google.com with SMTP id b15so995168eek.38
        for <linux-mmc@vger.kernel.org>; Fri, 13 Dec 2013 08:43:49 -0800 (PST)
In-Reply-To: <52AAC9E1.6070405@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Chris Ball <cjb@laptop.org>, Alex Elder <alex.elder@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Christian Daudt <csd@broadcom.com>, Hauke Mehrtens <hauke@hauke-m.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Domenico Andreoli <cavokz@gmail.com>, Matt Porter <matt.porter@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Dec 13, 2013 at 12:48 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 09/23/2013 07:20 PM, Christian Daudt wrote:
>>
>> Currently ARCH_BCM has been used for Broadcom
>> Mobile V7 based SoCs. In order to allow other Broadcom
>> SoCs to also use mach-bcm directory and files, this patch
>> renames the original ARCH_BCM to ARCH_BCM_MOBILE, and
>> uses ARCH_BCM to define any Broadcom chip residing
>> in mach-bcm directory.
>>
>> Signed-off-by: Christian Daudt <bcm@fixthebug.org>
>> Acked-by: Olof Johansson <olof@lixom.net>
>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Thanks. I've applied it to armsoc/for-3.14/soc


 csd
