From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 11/14] mmc: sdhci-pic32: Add PIC32 SDHC host controller driver
Date: Wed, 25 Nov 2015 17:38:57 +0100
Message-ID: <CAPDyKFph3vDzDJCxZFZYGN2BsBcqSqhvsug5F_JUdEryNa9udw@mail.gmail.com>
References: <1448065205-15762-1-git-send-email-joshua.henderson@microchip.com>
	<1448065205-15762-12-git-send-email-joshua.henderson@microchip.com>
	<CAPDyKFrFZgi3bQYZgrB0OVq4i3__Vor129F7abGYJ+rrPmP6EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36546 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753857AbbKYQi6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Nov 2015 11:38:58 -0500
Received: by ykdr82 with SMTP id r82so61490011ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2015 08:38:57 -0800 (PST)
In-Reply-To: <CAPDyKFrFZgi3bQYZgrB0OVq4i3__Vor129F7abGYJ+rrPmP6EQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joshua Henderson <joshua.henderson@microchip.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org, Andrei Pistirica <andrei.pistirica@microchip.com>, Jean Delvare <jdelvare@suse.de>, Corneliu Doban <cdoban@broadcom.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Alim Akhtar <alim.akhtar@samsung.com>, Luis de Bethencourt <luisbg@osg.samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Lokesh Vutla <lokeshvutla@ti.com>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, yangbo lu <yangbo.lu@freescale.com>, Kevin Hao <haokexin@gmail.com>, Ben Hutchings <ben@decadent.org.uk>, Andy Green <andy.green@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

[...]

>> +sdhci_pic32_probe_dts(struct platform_device *pdev,
>> +                     struct pic32_sdhci_pdata *boarddata)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +
>> +       if (!np)
>> +               return -ENODEV;
>> +
>> +       if (of_find_property(np, "no-1-8-v", NULL))
>
> Please don't use this property as it's broken. It has two different
> purposes and those are conflicting as discussed here[1].

Realized that I forgot to attach the reference to the discussion, here it is.

[1]
http://comments.gmane.org/gmane.linux.kernel.mmc/32751

>
> You have two options, either invent a new binding which provides
> information about which signal voltage that *is* supported, or use the
> current existing common MMC dt bindings to override the SDHCI
> capabilities register.
>

[...]

Kind regards
Uffe
