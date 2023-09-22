Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53843E6FE41
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Sep 2023 15:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjIVPSW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Sep 2023 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjIVPSV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2023 11:18:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F0BA3
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 08:18:14 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fb85afef4so2091846b3a.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695395894; x=1696000694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28ycCMVqr+jLHcID+cLGjL2F35QcRv/+OsF8PSg4e9w=;
        b=ButDVAR9tTC7uXAuV5J2qo4ZQbvJl8oZRiJIqRfLL8Wrj/4DPr8pUXQGcqaNe3cLhK
         POhz0NNfhCmdVR7Cfq0k/a78GWVXkYaa0M4xf5WA5ae8UGtas3u4jFvwDbqo4CnBv6Ee
         b+XEZRXiOCQzeijJhPI31QvcFxi9NHI4MtazLywyBkW1C9+5H+9ZQEWn+YX4GXHUq9Pa
         +zyI7PcWx2QK8klHQWL3P8JatyYCjho8j5Zyi8JpgoQg1tZcH9FKtctvNLFukeGDMur4
         qNwsqaqmsFImdFQeZ5bswJq0wBvMm51FG0yqKeyfm7SC1TGM7Im97qDY8e0UPehHBJ1f
         cNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695395894; x=1696000694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28ycCMVqr+jLHcID+cLGjL2F35QcRv/+OsF8PSg4e9w=;
        b=XY7kKkHROaSr3WoOYSC8oX1uXAZQtlt4k1vwPaBW4GGJSkMGNQsdIMYF0/6h+74UiH
         sooosB03lhfU0S76FITMBbahKlbeVSy4e6idI9jkKCBxiHCR9dGqilQ0hi+L9wuo5dAC
         T6Mrb3s0OyDptPm0yubfl7FEdNvblM6Q1QzIx7n0iwQS/ABD/O2QEmrWo1/cgzu5//6Z
         edFx6pGd6yZtrS9/9uSuIClHC3uoCHdc5ibOvgVTZdXsRIE2K/fFcIslHMtjDKBRUROE
         lX3YfWchpDaTQ2cTVF3+5Mn78Fj5+zKa7CgYY/QFQLeaH1aJeIZv/mUphDlLDxAth73f
         eQWQ==
X-Gm-Message-State: AOJu0Yx12NogI1qMDhUU4+4BnxWqUWYney4uYv6+LnXTELuv9Zl7o/1y
        RvaHB6WyMAhrTV60qgn4GMoBmQ==
X-Google-Smtp-Source: AGHT+IEYqxKV/Zdv/b6QlfOjx23Mb/9uFyIcZZjiFtr8f5V9ahoe0eQHX3dZEw5wH7KcGntm/EnFFg==
X-Received: by 2002:a05:6a21:4881:b0:14c:9a61:a310 with SMTP id av1-20020a056a21488100b0014c9a61a310mr7787505pzc.24.1695395893958;
        Fri, 22 Sep 2023 08:18:13 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:f680:c44:77f:ca7d:adec])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001c1f4edfb87sm3614450plk.92.2023.09.22.08.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:18:13 -0700 (PDT)
Date:   Fri, 22 Sep 2023 08:18:11 -0700
From:   Drew Fustini <dfustini@baylibre.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head
 TH1520 support
Message-ID: <ZQ2tP48Z19C5xRug@x1>
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-1-49f76c274fb3@baylibre.com>
 <20230922-parish-ice-a22e93dc3027@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-parish-ice-a22e93dc3027@spud>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Sep 22, 2023 at 10:57:36AM +0100, Conor Dooley wrote:
> Hey Drew,
> 
> On Thu, Sep 21, 2023 at 06:49:48PM -0700, Drew Fustini wrote:
> > Add compatible value for the T-Head TH1520 dwcmshc controller and add
> > thead,phy-pull-up property.
> > 
> > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > index a43eb837f8da..46b768d46712 100644
> > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > @@ -19,6 +19,7 @@ properties:
> >        - rockchip,rk3568-dwcmshc
> >        - rockchip,rk3588-dwcmshc
> >        - snps,dwcmshc-sdhci
> > +      - thead,th1520-dwcmshc
> >  
> >    reg:
> >      maxItems: 1
> > @@ -60,6 +61,9 @@ properties:
> >      description: Specify the number of delay for tx sampling.
> >      $ref: /schemas/types.yaml#/definitions/uint8
> >  
> > +  thead,phy-pull-up:
> > +    description: Enable weak pull-up on PHY pads
> > +    type: boolean
> 
> Why is the weak pull-up required? How would the dts author know if they
> need to use this property?

This is a good question, and I don't have a good reason beyond it is
what the vendor SDK was doing.

There are only two boards right now using the TH1520 that I know of.
Both the LPi4a [1] and the Ahead [2] have the pull-up property set on
all the mmc controller nodes their downstream device trees.

Rob suggested on #devicetree that it would be simpler to just enable it
in the driver and disable support when needed. I like this idea as it
will simplify this binding patch and the code in the driver patch.

Thanks,
Drew

[1] https://git.beagleboard.org/beaglev-ahead/BeagleBoard-DeviceTrees/-/blob/v5.10.x-ti-unified/src/riscv/light-beagle-ref.dts
[2] https://github.com/revyos/thead-kernel/blob/lpi4a/arch/riscv/boot/dts/thead/light-lpi4a-ref.dts
