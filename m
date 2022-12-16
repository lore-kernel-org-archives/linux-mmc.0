Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257AC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Dec 2022 09:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiLPJWl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Dec 2022 04:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiLPJWj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2022 04:22:39 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC633F04C
        for <linux-mmc@vger.kernel.org>; Fri, 16 Dec 2022 01:22:37 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 130so1365768pfu.8
        for <linux-mmc@vger.kernel.org>; Fri, 16 Dec 2022 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v1fP5fRdrMizfsWMQ3E1/1TNzCxj+enzPNdKZzOn0UA=;
        b=omOeDYDPhBf+aN+VcZkjPgRWPHaeGx5XhwkZP6TBzejDSQ0jZtXfL+hHtoOXehm8Ul
         efAVknjUoJwvYOI0zvs6b8R7IPmTwjlLdOVUJLlv9HjtqYoGZtFEiO38GlV0NECbHIrS
         OIKxNJIGuCJLg4BsyqExaY8YvC5qJXqdBEmOzoFoQuMEI0pzpwAM4XgSLTTIm3qzccm3
         PCaNktneamtJh0ypbFSlRpzEzN9U/je1b5U/+l5UcovZrjeP/9yJJxjHK5UQ091cZhrq
         NcmaIjhgqyvfnLMtghWVf8uFe7l+M78yd6vI0shcrpn1GmTxTCfUJHIVJZVGQebvqDs9
         8ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v1fP5fRdrMizfsWMQ3E1/1TNzCxj+enzPNdKZzOn0UA=;
        b=RXoJbauroXHJfLuWaxjT3cfmvaBPvjB3hz6Km1JhqnA75OzYDg7XLCf4ZdO3UdJDtr
         zLQueVbIxTQqWPERjsr8UF6NHk8eY303ERillwuWbsotsjsfoJNBPAxtSF1QrNbsZYZy
         gSqj55at4FFQ5KH0PVWkPB2KF7tcE8GR3t1XyIgR2e+hOBoWsS6TprL+OBDmdycxhJBp
         qOsvU7kF4gubfpIcFUWCvAmF5yW4cHnX73mqQfs4quZU6iHz6jvH5J1fwdJLzn4kBdx2
         kstgddB9HvapLCuyh3+WNo4GQAhWHEwaEPx4do4arpMKJKYDLpnRpz8vFYeKIRbBGC9c
         GFqA==
X-Gm-Message-State: ANoB5pkYkk3DcPS7TVY/YXOwrmgpzrBPGU1IDDB6unhb5xDbF9g2vGap
        EILTAHeCQQA4Fsd6FfqySEMFmDrvp4ks+5pI8kHl0A==
X-Google-Smtp-Source: AA0mqf7N87TIr/u2Xinh0I/i4Gx5SNh8dUb223ncD5i94MGrdKiCEfWYNI+lkK6pN7qAcudY2sEvz7g7NhlT96MUsJU=
X-Received: by 2002:a63:334e:0:b0:479:2227:3aa1 with SMTP id
 z75-20020a63334e000000b0047922273aa1mr1364607pgz.595.1671182556675; Fri, 16
 Dec 2022 01:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <420d067c-665b-b247-b0cd-8ac242c19924@starfivetech.com>
In-Reply-To: <420d067c-665b-b247-b0cd-8ac242c19924@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Dec 2022 10:22:00 +0100
Message-ID: <CAPDyKFoosrm9CSi4s=YSxdg4xqv118wOFUAc5QRcOgtMCiX=DA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] StarFive's SDIO/eMMC driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Dec 2022 at 03:02, William Qiu <william.qiu@starfivetech.com> wrote:
>
>
>
> On 2022/12/7 21:17, William Qiu wrote:
> > Hi,
> >
> > This patchset adds initial rudimentary support for the StarFive
> > designware mobile storage host controller driver. And this driver will
> > be used in StarFive's visionfive-v2 board. The main purpose of adding
> > this driver is to accommodate the ultra-high speed mode of eMMC.
> >
> > The patch series is based on v6.1-rc5.
> >
> > -- William
> >
> > William Qiu (3):
> >   dt-bindings: mmc: Add bindings for StarFive
> >   mmc: starfive: Add sdio/emmc driver support
> >   riscv: dts: starfive: Add mmc node
> >
> >  .../bindings/mmc/starfive,jh7110-sdio.yaml    |  71 +++++++
> >  MAINTAINERS                                   |   6 +
> >  .../jh7110-starfive-visionfive-v2.dts         |  25 +++
> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++++
> >  drivers/mmc/host/Kconfig                      |  10 +
> >  drivers/mmc/host/Makefile                     |   1 +
> >  drivers/mmc/host/dw_mmc-starfive.c            | 197 ++++++++++++++++++
> >  7 files changed, 348 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
> >
> > --
> > 2.34.1
> >
>
> Hi Jaehoon/Ulf,
>
> Could you please help to review and provide comments on this patch series?
> Thank you in advance.

Hi William,

Looks like you have received plenty of good comments already and there
are a lot of things for you to update. That said, I think it makes
better sense for me to look at the next version instead.

>
> Best regards,
> William Qiu

Kind regards
Uffe
