Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A5BC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 22:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiFHW1U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiFHW1Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 18:27:16 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28557140AB
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 15:27:15 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x75so13169860qkb.12
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2022 15:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jH4c12+CVRrTyhBbIEeVtZFXG81rflTZGiVkHkiLLNo=;
        b=79GOQq0/+RRLbqGewSFK851+7PhvVY6uIRw83i4C4/WmB5SQlsbXr91fSZ4M1Aq4zo
         jYEfd9tQql48uWWjKyGf4SSHjZ2kgu3BiGZkLvs50XK+WBCYiR6x2aSw3qcKvV/JjYux
         lNTMO8K+kxoTr+sxFdXVylNC73MD/mvw/XXFjNzdx2z2QpjyA7fvL70Dguby53f0zKXf
         6se2d5PW2hVwFTo4wFVBLKkZf+NeW+iCZTxggUfBrlXWPst6eAk6UiP+9jzYb7f/+cY7
         0jEGy99UQm+Y0vFZQLG2lvPk+3BXvIUufzJzMTeSmgp18wBsqe9dRjxkSNUp6VSQNB5+
         3raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jH4c12+CVRrTyhBbIEeVtZFXG81rflTZGiVkHkiLLNo=;
        b=DeDvB7I+Hj4ZoYKTa+LApqLMc9VR16kt0dUpp01oM8X9nx659X60/Nlgwx3Oyood6M
         7dLpOXzS2vF9qk/TCU1NKP3tJFM5N0pie/pkO3Qr6E2iNf8YyPgNpZZXiIbNCgfx3ItN
         biEv0zRztHouHsczl0trizrPbgssESf5yoMH7sp/vtmF5b84aGBPaBqOf2WCEdjT9wsK
         QdLu1PHty1QyjxUQ6UVdUM70HeQLnr4oSSvv91UkUUD6v8/pRcywwCLX91j6AroEyAwt
         sfIVee/427RbmDdYsQg/izvZ/KKgJZ2lG5NyeOlTniAPnrGgYDgA43KILVS0ehVYe4Eh
         HBAw==
X-Gm-Message-State: AOAM532RAeSwjIScGUt4jqhS40R3iF2zIlKtoAFrEJ2u2c4alJ0JSmTj
        2GsjEqs9B+9N69E13C7mX/c6HFX0qby7mwp5vDzNXw==
X-Google-Smtp-Source: ABdhPJwnmP1wXXzF9NYXnVqUZJwhOa7wXTGFQNqRavcPOps9dctULuEYturAac2aYv7sw0Yyw1hdiyadaWlF3TTaF0o=
X-Received: by 2002:a05:620a:1911:b0:6a6:e8e9:70cd with SMTP id
 bj17-20020a05620a191100b006a6e8e970cdmr6644053qkb.627.1654727234308; Wed, 08
 Jun 2022 15:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220605133300.376161-1-mail@conchuod.ie>
In-Reply-To: <20220605133300.376161-1-mail@conchuod.ie>
From:   Atul Khare <atulkhare@rivosinc.com>
Date:   Wed, 8 Jun 2022 15:27:03 -0700
Message-ID: <CABMhjYq0GSEfg4T+cTqBwRdykC-rbQNEqnAZ1qM5fYbjUah5Mg@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] clear riscv dtbs_check errors
To:     mail@conchuod.ie
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Conor,

Thanks for the feedback. I will rebase and send out a v2 series
shortly (it appears that the 1024 hart context patch is redundant as
well).

On Sun, Jun 5, 2022 at 6:33 AM <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Hey,
> Couple conversions from txt to yaml here with the intent of fixing the
> the dtbs_check warnings for riscv. Atul Khare already sent patches for
> the gpio-line-names & cache-sets (which went awol) and will clear the
> remaining two errors.
>
> Rob/Krzysztof:
> Have I correctly expressed the mutually exclusive properties?
> I had a look around, but wasn't able to find an obvious binding to ape.
>
> Wasn't sure if a txt -> yaml conversion's MAINTAINERS update was meant
> to be in the same patch or not, so feel free to squash.
> Thanks,
> Conor.
>
> Conor Dooley (6):
>   dt-bindings: mmc: convert mmc-spi-slot to yaml
>   dt-bindings: i2c: convert ocores binding to yaml
>   MAINTAINERS: convert ocores i2c dt-binding to yaml
>   dt-bindings: mfd: convert da9063 to yaml
>   MAINTAINERS: convert da9063 to yaml
>   riscv: dts: sifive: "fix" pmic watchdog node name
>
>  .../devicetree/bindings/i2c/i2c-ocores.txt    |  78 -----------
>  .../devicetree/bindings/i2c/i2c-ocores.yaml   | 132 ++++++++++++++++++
>  .../devicetree/bindings/mfd/da9063.txt        | 111 ---------------
>  .../devicetree/bindings/mfd/da9063.yaml       | 123 ++++++++++++++++
>  .../devicetree/bindings/mmc/mmc-spi-slot.txt  |  29 ----
>  .../devicetree/bindings/mmc/mmc-spi-slot.yaml |  76 ++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |   2 -
>  MAINTAINERS                                   |   3 +-
>  .../boot/dts/sifive/hifive-unmatched-a00.dts  |   2 +-
>  9 files changed, 334 insertions(+), 222 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-ocores.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9063.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
>
> --
> 2.36.1
>
