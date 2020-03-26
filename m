Return-Path: <SRS0=y6Wy=5L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353BAC2D0E8
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 14:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED3C207FF
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Mar 2020 14:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0Gbhldy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgCZO25 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:28:57 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45827 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgCZO2z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Mar 2020 10:28:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id x82so3915812vsc.12
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2020 07:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m96cR6V03dd7lbjAOl6gquDvXkdRzHGRSDXkk0VydMg=;
        b=d0GbhldybAe0gmG8ZlfyrlQwNBKzrfy5JDwFDaOsHBBgGdMkw0TJb3XjhMtRqSbv7U
         raadlG2wUvxjwaK8JQEXjXpEDrxdok4PtGhzk8vlvcx6tqX50JoBJjW9oeCcSufljH6d
         zXUOtYr9xOurSTFj6t0Jo5XxpR4v0b0dQlHfJkM50DxfClQkvWEwr0+ZVMW14u+Ih3zr
         bXT7WivtSYOhdHJnSZYPl0aXpH0+RKcAZCDkMR+fTMFW7uZMY/N5YrpJM+980D1BsBA0
         B429AUyrl4jmmVgGSaDLzpQR41VY8fCcxS1hN7EuVUp7OYsa1cZg42gDGUtJY7L1P3No
         T3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m96cR6V03dd7lbjAOl6gquDvXkdRzHGRSDXkk0VydMg=;
        b=D2R9DP7rp/qfAkt+w3Scx6X1CkqCc7yignZSJKLmQZi60w3LXdyK0Ac+r1qIzk0z90
         fE7gXxdok2o6U1ks8Lgo4m6MC0GqeNZjdaPW9Er7l5pJvcxu4J7ZUJ18J/Jlsqzj+5HR
         wdUQHfsZsp8hD3Ua3a0lzGRKyycut4Crd3J7dZhPoYPvB1LUjFXToMVnyugxeGC/MwOt
         HSrBHMY54UMj532l0K5wqS2SaP32slVRQOno33MJlcoJ4vb0vpmynsvc93GtsINdRNk5
         Z1iPyfIHRhgFHSm0DzjuCgv12J3CxcG+vX7E/fkvwD1CI4rAXD8kPeQaINxdOCQCuhqm
         Z4Jg==
X-Gm-Message-State: ANhLgQ34ptlMfnmV9VB1gnH/rY1cy9ZpgdQuNqLAib3UbArwYM92ihvt
        qLcrjSoioBJ+9gYYuhaDNkFSjnmrfjKdl12b8E6CYQ==
X-Google-Smtp-Source: ADFU+vuWH5zQui20lK3L0xhEESoh9O6oNICswpYudGihwgeVkXw9INd4a0Qcv2xNvGUAEUT8yqdnif+9yZAdCYPExLo=
X-Received: by 2002:a67:646:: with SMTP id 67mr6606515vsg.34.1585232933632;
 Thu, 26 Mar 2020 07:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200317093922.20785-1-lkundrak@v3.sk> <20200317093922.20785-19-lkundrak@v3.sk>
In-Reply-To: <20200317093922.20785-19-lkundrak@v3.sk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 26 Mar 2020 15:28:17 +0100
Message-ID: <CAPDyKFrcrgMrd9Nv425XuzssBhd+GvSUu29hXoVShwS0GNyjtQ@mail.gmail.com>
Subject: Re: [PATCH 18/28] dt-bindings: mmc: Fix node name in an example
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c@vger.kernel.org, linux-media@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Linux USB List <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Mar 2020 at 10:40, Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The $nodename allows only "mmc@*" whereas the example node is named
> "sdhci".
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index c9384ed685b8f..c03fe268c29a0 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -351,7 +351,7 @@ dependencies:
>
>  examples:
>    - |
> -    sdhci@ab000000 {
> +    mmc@ab000000 {
>          compatible = "sdhci";
>          reg = <0xab000000 0x200>;
>          interrupts = <23>;
> --
> 2.25.1
>
