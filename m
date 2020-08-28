Return-Path: <SRS0=IgIp=CG=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF01C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBBBD2075B
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Aug 2020 09:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L98VAkj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1Jmp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1Jmk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 05:42:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E361C061232
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 02:42:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so599819ljj.4
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2020 02:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOHxtM5yk1gvAYHJqAG90Qc4zP0j2G+j6TpnDxaoDIA=;
        b=L98VAkj/cNInmoKUxH8AOMVGrtQB6tuwlU+TtqyN5Ybq0OUUvv1/WwZwP/2Q2BHyKh
         vqUlX41ul/3RpVcXqGfRbkUmVVvq6H1hEWgDQMRDV/7DaH91K3EGhG9soVvrYxzDayLX
         Eqax3EwZJned8+IDqYNTwphOYkkSSaXo2hXUr/bYJbdL0c1Fcq87vv4Q3drcyo/ypkPU
         uHS6o48yHpMIBAWuJqv1j5jmWKbAs7euGm039AzZib3oBy7mF/xCc8cB+9yD3drlKdM8
         Vu8bGjLkz3mCqUOQuR1k2EBXuw7/zEKf7s116YtbCzzU427zzOjEE516m3pOeDUBdRQZ
         vWdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOHxtM5yk1gvAYHJqAG90Qc4zP0j2G+j6TpnDxaoDIA=;
        b=rRRxfWEXnCTQXzUS9Qpg6vf7wfdOdebtAI75dn6SkodfNgDp0FiaoE9TYFBEo2EkLP
         FQKeG6uB4mbTigInq3TglI+gs49J1/wTvUoAIzwugTfZlxqLLfIjW4ZDDeD8whBAaLN5
         uxOQu3nHw1KSAPqCCQ47TOSA+EXPR8pdUNzd/GZceiHepQRoizPx2IOKKF6A7xKYQI5O
         jYNgWpWZFzj4FIoYOSTMERGHI5za0qLgAfInadiY3NpLevcQhq+sbmEZYv2GHeAis9Hq
         7iRWf6Xj71qX+r1TEZ9ERNi7UOzVPIaF5QIiFtU4ikZ1PFilFAN6kS+PW2dP44S8YggC
         r1bw==
X-Gm-Message-State: AOAM530Dr7WDRYnx/OVVnbDtV4yk7MYz3ObLaFP4+8d+sYffEVzHrR/w
        HWdajQXJ5WSADOS89yeienhaF3W8T3YcLWojTcjS8A==
X-Google-Smtp-Source: ABdhPJyoS2eg46/tyZ0yOApwD8OZKfUAZkgcEVLTK+EqD3GisGxH98dOWf4tudhOdF9/ATIaddWgil7TZpkYIeZMjNY=
X-Received: by 2002:a2e:558:: with SMTP id 85mr495792ljf.293.1598607758211;
 Fri, 28 Aug 2020 02:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200823161550.3981-1-krzk@kernel.org>
In-Reply-To: <20200823161550.3981-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Aug 2020 11:42:27 +0200
Message-ID: <CACRpkdYRk=1m0+FoE2YKYtwh+Vt6sFbh6w-m1t04YMV0WJR5VA@mail.gmail.com>
Subject: Re: [PATCH 01/22] dt-bindings: gpio: fsl-imx-gpio: Add i.MX 8 compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd@lists.infradead.org, linux-pwm@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Aug 23, 2020 at 6:16 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> DTSes with new i.MX 8 SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
>
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible:0: 'fsl,imx8mm-gpio' is not one of ['fsl,imx1-gpio', 'fsl,imx21-gpio', 'fsl,imx31-gpio', 'fsl,imx35-gpio', 'fsl,imx7d-gpio']
>     From schema: Documentation/devicetree/bindings/gpio/fsl-imx-gpio.yaml
>
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible: ['fsl,imx8mm-gpio', 'fsl,imx35-gpio'] is too long
>
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: gpio@30200000:
>     compatible: Additional items are not allowed ('fsl,imx35-gpio' was unexpected)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I'm just waiting for some review from the i.MX people on these FSL things,
then I can apply it.

Yours,
Linus Walleij
