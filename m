Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256C9C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 21:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DDF619C0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 21:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhCWVI1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 17:08:27 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:38518 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhCWVIR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 17:08:17 -0400
Received: by mail-io1-f48.google.com with SMTP id e8so19259559iok.5;
        Tue, 23 Mar 2021 14:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JZelDKKXclIol74spAdVi/fynrQDuz+32X7i8r9v4EU=;
        b=mg4C42YHYYgv5UoZKG3rlJwrFWAz+p5LvsYvKIVFgvwe+iUixLHUJgJBnUEvlrWcyu
         waVXjCIEYpsqcxTexOh7JwsDFLF1HoA/yH1g/3dtOdLFZuVjELa2Lbr9lCf1hU7Zbfy1
         AL3VLL1hh8cOGSjWksdvckIQ4jmO88dIzp0uWsMd2ebUn9YcTqj3x+bSRv6jeIS7gI2l
         GmIGuiqKoT9X7X5gYjWkfP8DBT5gpE/MXqxiDd6gVVGY7Pu2Uc9Wd09woiUnmtocRH1l
         IbDmDTB3Wz6yXADpBeZ/nDo9oJxvQ8tnQYOyBERS/jh8SswTfh3YLmeG172ku1aPZLoG
         MKIA==
X-Gm-Message-State: AOAM530JQB7SSI5qaHYJMN8FVs9OtR65j8Fu3QzKi3FRlpInpB2jMb1M
        LMES4KAQd2VzvMXf7P693eI1tTV17g==
X-Google-Smtp-Source: ABdhPJzYlEcksihAORQf6PyjIBkT3hrljQ7weuU86zb0eUS1SWhXvLglPbs4XhJ3YvH3CIu51m+zuA==
X-Received: by 2002:a6b:4f09:: with SMTP id d9mr65238iob.60.1616533696947;
        Tue, 23 Mar 2021 14:08:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b9sm11836iof.54.2021.03.23.14.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 14:08:16 -0700 (PDT)
Received: (nullmailer pid 1325739 invoked by uid 1000);
        Tue, 23 Mar 2021 21:08:12 -0000
Date:   Tue, 23 Mar 2021 15:08:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>, f.fainelli@gmail.com,
        phil@raspberrypi.com, tim.gover@raspberrypi.com,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
Message-ID: <20210323210812.GA1318204@robh.at.kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
 <20210322185816.27582-2-nsaenz@kernel.org>
 <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e98588e-65f1-6839-1fcd-584b480a31bd@broadcom.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 22, 2021 at 12:11:29PM -0700, Scott Branden wrote:
> On 2021-03-22 11:58 a.m., Nicolas Saenz Julienne wrote:
> > Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> > ---
> >  .../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 +++++++++++++++++++
> >  .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
> >  2 files changed, 58 insertions(+), 37 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > new file mode 100644
> > index 000000000000..19d84f3ef9e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom IPROC SDHCI controller
> > +
> > +maintainers:
> > +  - Nicolas Saenz Julienne <nsaenz@kernel.org>
> This is already covered in the MAINTAINERS section via "N:	iproc".
> M:	Ray Jui <ray.jui@broadcom.com>
> 
> M:	Scott Branden <scott.branden@broadcom.com>
> 
> M:	bcm-kernel-feedback-list@broadcom.com

Maybe so, but still required here. The problem is there is no 
MAINTAINERS file in the DT only tree[1].

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/
