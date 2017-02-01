From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/4] dt-bindings: Add binding for brcm,bcm2835-sdhost.
Date: Wed, 01 Feb 2017 16:54:08 +0100
Message-ID: <1485964448.1076.68.camel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
         <1485516989-1072-2-git-send-email-kraxel@redhat.com>
         <20170201150252.gvoqp3eprj5bosvu@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbdBAPyT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 1 Feb 2017 10:54:19 -0500
In-Reply-To: <20170201150252.gvoqp3eprj5bosvu@rob-hp-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-rpi-kernel@lists.infradead.org, ulf.hansson@linaro.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@armlinux.org.uk, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

> > +++ b/Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhost.txt

> > +Example:
> > +
> > +sdhost: sdhost@7e202000 {
> 
> Node names should be the generic type of device, so:
> 
> mmc@...

Ok, done.

I guess arch/arm/boot/dts/bcm283x.dtsi should get the same update?

cheers,
  Gerd

