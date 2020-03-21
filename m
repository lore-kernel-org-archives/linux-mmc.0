Return-Path: <SRS0=/RhY=5G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C10C43332
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Mar 2020 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0DD20754
	for <linux-mmc@archiver.kernel.org>; Sat, 21 Mar 2020 07:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgCUHga (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:36:30 -0400
Received: from smtp01.smtpout.orange.fr ([80.12.242.123]:44730 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbgCUHga (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Mar 2020 03:36:30 -0400
Received: from belgarion ([86.210.245.36])
        by mwinf5d77 with ME
        id GvcB220040nqnCN03vcMek; Sat, 21 Mar 2020 08:36:28 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 21 Mar 2020 08:36:28 +0100
X-ME-IP: 86.210.245.36
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 05/28] ARM: dts: pxa3xx: Fix up encoding of the /gpio interrupts property
References: <20200317093922.20785-1-lkundrak@v3.sk>
        <20200317093922.20785-6-lkundrak@v3.sk>
        <20200317132854.GF24270@lunn.ch>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 21 Mar 2020 08:36:10 +0100
In-Reply-To: <20200317132854.GF24270@lunn.ch> (Andrew Lunn's message of "Tue,
        17 Mar 2020 14:28:54 +0100")
Message-ID: <87y2rudus5.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Tue, Mar 17, 2020 at 10:38:59AM +0100, Lubomir Rintel wrote:
>> This way the device tree validator learns that each cell of the property
>> constitutes a separate item. Otherwise it gets unnecessairly upset:
>> 
>>   pxa300-raumfeld-speaker-s.dt.yaml: gpio@40e00000: interrupts:
>>       [[8, 9, 10]] is too short
>> 
>> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr.>

-- 
Robert
