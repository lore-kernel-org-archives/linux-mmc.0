Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B89C433E1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 434FE22CBB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283698;
	bh=QBVEF6GoD/BriDC2232Tk+DSoCwhv1gZXWPuakVMLQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I4R4IIoG3wTZdXdQlonm1zsF1W4a8RJJ5ycw8KIkbLuhfBKon/zeRU+C25aLh+UyN
	 kf23BbQ30eaDKTTbJi2H0o/NMRqIHLmUgdLdLRZHZEJgQ+vbRnCGXYZ8pS4BLdPK6l
	 vmOegbWTVmIIGuG0tGhyPiH3qy8UQKee6DXFL374=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgGTWVe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:21:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46039 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTWVe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 18:21:34 -0400
Received: by mail-io1-f68.google.com with SMTP id e64so19300901iof.12;
        Mon, 20 Jul 2020 15:21:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bKYIymgYEsaoAp0VGuX+X+GdB+8XUwPd9yIWMXOJP1w=;
        b=hyTu/7AZwsxWFKuXgHnq/8w3UkGTp2ZOT/wjdl+ecTqi+F7gHTc8szOv8BUYE1Wb1Y
         Ie+uzbEwe0V02SvAEE7ajlFj85aMVKwxkFEhKDLQGmTiSNa/VuBjNT7Z8vudFQ3MJcWp
         tBhgE+Q2Vdvym3BNc+bZ9GOv6l/pcphSDrXm3sJ+599u5xfFRmSwelKG3seOIvy65HCp
         +cucKDdr4xMvr6ifw0ElxIybvbQKYvKPzIMcPK20KFdTzRoJ2EfIV6TJkVeoUM1b9erd
         Da9Vc4U6BsIV8MAB/oxGFC1Aav0ABecPMzqpWF+hNBhGHwobBcbmaBzbDx3eJXkMixi2
         D8VQ==
X-Gm-Message-State: AOAM53133vsFyVUtIjvoUKePadMO4QtB+CaVrymcgsdU93ON2X3PhOMu
        mVx/asb3fUiOSckQVflzfg==
X-Google-Smtp-Source: ABdhPJyw7PV9vqQm9bNholJCp9qVWUHQhJ4HzWTR9RO+AmibGdJC53lLZ6Ro0lZ/VF/HqsMbn+QlAg==
X-Received: by 2002:a05:6638:1187:: with SMTP id f7mr29447388jas.21.1595283693108;
        Mon, 20 Jul 2020 15:21:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n1sm9463052ilo.68.2020.07.20.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:21:32 -0700 (PDT)
Received: (nullmailer pid 3055517 invoked by uid 1000);
        Mon, 20 Jul 2020 22:21:31 -0000
Date:   Mon, 20 Jul 2020 16:21:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-serial@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: mmc: renesas,sdhi: Add r8a774e1 support
Message-ID: <20200720222131.GA3055470@bogus>
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594230511-24790-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 08 Jul 2020 18:48:27 +0100, Lad Prabhakar wrote:
> Document SDHI controller for RZ/G2H (R8A774E1) SoC, which is compatible
> with R-Car Gen3 SoC family.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
