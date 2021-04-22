Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B7C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E4A61176
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Apr 2021 17:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhDVRYE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Apr 2021 13:24:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54176 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhDVRYD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2021 13:24:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 3EF8B1F4361F
Message-ID: <7d1f197d868ae84a8bc475f1f48178d2737518c1.camel@collabora.com>
Subject: Re: [PATCH v1 4/5] arm64: dts: rockchip: add core dtsi for RK3568
 SoC
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        cl@rock-chips.com
Cc:     robh+dt@kernel.org, jagan@amarulasolutions.com, wens@csie.org,
        uwe@kleine-koenig.org, mail@david-bauer.net, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        kever.yang@rock-chips.com
Date:   Thu, 22 Apr 2021 14:23:15 -0300
In-Reply-To: <11131098.F0gNSz5aLb@diego>
References: <20210421065921.23917-1-cl@rock-chips.com>
         <20210421065921.23917-5-cl@rock-chips.com> <11131098.F0gNSz5aLb@diego>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Liang,

I'm very impressed Rockchip is pushing patches so early, thanks a lot!

See below.

On Wed, 2021-04-21 at 11:13 +0200, Heiko Stübner wrote:
> Hi Liang,
> 
> Am Mittwoch, 21. April 2021, 08:59:20 CEST schrieb cl@rock-chips.com:
> > From: Liang Chen <cl@rock-chips.com>
> > 
> > RK3568 is a high-performance and low power quad-core application processor
> > designed for personal mobile internet device and AIoT equipments.
> > 
> > This patch add basic core dtsi file for it.
> > 
> > Signed-off-by: Liang Chen <cl@rock-chips.com>
> 
> this is a first round of basic stuff :-) .
> 
> First of all, I really like the move of moving the pretty standardized
> pinconfig entries to the rockchip-pinconf.dtsi .
> 
> (1) But please move this into a separate patch to make that more visible
> and maybe even convert _some_ or all arm64 Rockchip socs to use that
> as well
> 
> "arm64: dts: rockchip: add generic pinconfig settings used by most Rockchip socs
> 
> The pinconfig settings for Rockchip SoCs are pretty similar on all socs,
> so move them to a shared dtsi to be included, instead of redefining them
> for each soc"
> 
> (2) I also like the external rk3568-pinctrl approach with the dtsi getting
> auto-generated. This will probably help us in keeping pinctrl settings
> synchronous between mainline and the vendor kernel.
> 
> (3) From my basic understanding the rk3568 is basically a rk3566 + more
> peripherals, so ideally they would share the basic ones in a rk3566.dtsi
> which the rk3568.dtsi then could include and extend with its additional
> peripherals.
> 
> With at least the pine64 boards being based on the rk3566, there probably
> will be quite a mainline use of it as well.
> 
> Or is there something that would prevent this?
> 

I agree with having a rk3566.dtsi, and rk3568.dtsi on top, instead of the
other way around. We have some RK3566 boards here, so we can surely test
the RK3566.dtsi patches very quickly.

Also, it's fine if you want to send v2 with just these minimal peripherals.
However, I think you could include GMAC and TS-ADC:

https://lore.kernel.org/linux-rockchip/31c2e531-96d0-a1c1-644c-28c60eb40cf4@gmail.com/T/#t
https://lore.kernel.org/linux-rockchip/20210421203409.40717-1-ezequiel@collabora.com/T/#t

These should work right out of the box!

Thanks!
Ezequiel

