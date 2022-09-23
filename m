Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A7AC6FA91
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Sep 2022 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiIWKXA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Sep 2022 06:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIWKW7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2022 06:22:59 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2134812E439;
        Fri, 23 Sep 2022 03:22:57 -0700 (PDT)
Received: from p508fdb48.dip0.t-ipconnect.de ([80.143.219.72] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1obfpM-0005nH-6s; Fri, 23 Sep 2022 12:22:36 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ulf.hansson@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        kishon@ti.com, vkoul@kernel.org, thierry.reding@gmail.com,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net,
        zhangqing@rock-chips.com, jamie@jamieiles.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 03/11] dt-bindings: pwm: rockchip: add rockchip,rk3128-pwm
Date:   Fri, 23 Sep 2022 12:22:34 +0200
Message-ID: <2166557.taCxCBeP46@phil>
In-Reply-To: <20220920062149.o6gdhsh7bk5rl4ah@pengutronix.de>
References: <20220909212543.17428-1-jbx6244@gmail.com> <f5dd0ee4-d97e-d878-ffde-c06e9b233e38@gmail.com> <20220920062149.o6gdhsh7bk5rl4ah@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am Dienstag, 20. September 2022, 08:21:49 CEST schrieb Uwe Kleine-König:
> Hello,
> 
> On Sat, Sep 10, 2022 at 12:02:22AM +0200, Johan Jonker wrote:
> > Add rockchip,rk3128-pwm compatible string.
> > 
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Is the expectation that this goes in via PWM, or together with the other
> patches via the rockchip maintainers?

in general I think bindings always go through the subsystem that
they're targetting - PWM in this case.

Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko


