Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28026C4332F
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 16:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245534AbiEYQ7D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbiEYQ7B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 12:59:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EA0A5031
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 09:59:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id z15so7130877wrg.11
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BuZEGOxN6s+QpJ7ff5N18tZNmtTRq26kp+p3466K8F8=;
        b=PN7c+ZsciJ/kEOjPj7CShyBj/DLMdY+SeuzKoJuV+aZs00rsfGtKPxXYuXkDBJ+S65
         +uM95I3LPBfkBnNJtlsq3Hb54Vee//W2JCMtzVXiGtQO50V488NIYCi61azqiCWc6O3c
         Q5lU3W83LYTjnEIjbwpSasu8MmFtG9SIpezhIsHVO5szkxK6XNck9CfoRN9NbVUaLhQ8
         rYnP9qSQ9RsaMMG4frzZhL/yat5iLtRzzgeCf/MMbJh08/WMAAcFYYbFqaqpNUYbIOLm
         zw8NrHxtN81kOAdgF/FzYqXwubENk2rIRCDyHk6nuO2yj17cVhEWMQAi40vrNhwTac3X
         RwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BuZEGOxN6s+QpJ7ff5N18tZNmtTRq26kp+p3466K8F8=;
        b=gcJTn4TKivMPdO+cfIAMWk+5KnK83mdqhJgxEMiVQtMXSO1zw+Hv4pPv/VOaY/tzjt
         VPcIF+u3N8gZNfxqbXL1nvYhfErkjcdKe3xBtso2jOmUh1taVgKKBJ5xczL+xSjVhyeW
         S6XP7zasI3S0I0HZQqAfDnKspothvXdtUeuPL16JGQg6tiwo1HewiqWZVsHri7+keknI
         P95BZc/sEVn+w3MeiT8/0iKs8C/O3C8JnCIKslQA5LhGzGVPW69teGIwcncIBGNZsqPX
         bOoe5/F6HonihaOdCOpaMoUHz4TYLvQIGkyOnhF32xc49lYHzAsp0yPubfjrmH1JS1Xk
         Od0Q==
X-Gm-Message-State: AOAM530Do5/OE/T+YKlINOKHm4jVNyNyVn4k5m+zXZFj+t5q2ujGRxEi
        TB4u7n49EpqTSCCGo8d3R0VuCarzg83xFtAlrYWZig==
X-Google-Smtp-Source: ABdhPJybIyWNzIkBX1luV1MnU9OIiN8pAZht74AaILdEoJbIQZLlkTffZeSVmkFeLQons+gYVBsMhKaLpMV+YAPqwYA=
X-Received: by 2002:a5d:5954:0:b0:20c:4d55:1388 with SMTP id
 e20-20020a5d5954000000b0020c4d551388mr28019559wri.90.1653497938850; Wed, 25
 May 2022 09:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220406233648.21644-1-brad@pensando.io> <20220406233648.21644-5-brad@pensando.io>
 <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
In-Reply-To: <7363c5bb-89ed-b6aa-b346-f314a058f2a7@linaro.org>
From:   Brad Larson <brad@pensando.io>
Date:   Wed, 25 May 2022 09:58:47 -0700
Message-ID: <CAK9rFnzHOTg9BR-KY7rQttN2Cu2SYqAXfjXLYsH+RKYO8Su01g@mail.gmail.com>
Subject: Re: [PATCH 04/11] dt-bindings: spi: Add compatible for Pensando Elba SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Thu, Apr 7, 2022 at 11:59 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 07/04/2022 01:36, Brad Larson wrote:
> > Document the cadence qspi controller compatible for Pensando Elba SoC
> > boards.  The Elba qspi fifo size is 1024.
> >

> > @@ -48,7 +49,7 @@ properties:
> >      description:
> >        Size of the data FIFO in words.
> >      $ref: "/schemas/types.yaml#/definitions/uint32"
> > -    enum: [ 128, 256 ]
> > +    enum: [ 128, 256, 1024 ]
>
> Is 1024 valid for other controllers? If not, then probably this should
> be further constraint in allOf:if:then...

I'll change this to allOf:if:then so that the 1024 deep FIFO is
specific to Elba SoC.

Regards,
Brad
