Return-Path: <SRS0=Uo47=64=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C75AC433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 18:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 320C6206A5
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 18:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589481793;
	bh=BeBb7bNCglxE5Wm/tjXIDeZkke/2v4+gPrRjkPF3Ago=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YKXOO5/TwCnaSW85e3bdPheYfMriFDPbZJlVOs+SJhk9oqymyex2xCUptVUp5bjSH
	 lv6pMF//BkTnnOB/PBfMTbvHRgpAD7Ces8h2sYwB1ltk82n/aer5Rt0CuHmYuRfWb+
	 TGOs5dc9DtLFFSZYmX38ao2adFgEH/lAfSab4EvM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgENSnK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 14:43:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34940 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgENSnJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2020 14:43:09 -0400
Received: by mail-ot1-f65.google.com with SMTP id k110so3227723otc.2;
        Thu, 14 May 2020 11:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGIrY8SDvuTjzejIhxpj+PL53sSxg728mdDpAEJQxe8=;
        b=VjMLuS9LaTLFpJxYAiOTvbA77irUT3TzEmddQKQiW48weKq+0ztjMvoUGxDmSvGofA
         5HVk9GHmSMrWwg2ZxR8R+AalcuzWy4Kxg4xGaqEgV/X1hyhS2cUKv6SxCj01SmOUOJeU
         9DdM6OU8glQtxAg6TwTchBI0rllF+xjlhCAMo7iFeu5cKhS1Mff2OqxMmnnryAkpvIlc
         YPnghLK5Lmj8nilC7eV9qodckZooxEMYJlvlc/o29EcK0R0FJ0UHHNCJ3iMvoKUptDUQ
         FQYB23iCcXJwRgTy48tDNlfaiXeOSn2ISPXtHPsDlzg/KmpGpJWwmGEXOg4lUk/pcsBY
         KPlQ==
X-Gm-Message-State: AOAM531ZLX7uoEa7knaT7m/VyrRHC4SYyiEoy7qCAS5xA/RFxWMUhmTs
        VIpXHmGdoT1u/LrCR2kHHQ==
X-Google-Smtp-Source: ABdhPJx/47NNA/05up2GtjIFWDb9o6IjAicvuuijIfSOZFUWsZZdtOa4nLGqRlZMFhvFdlQEXu78YQ==
X-Received: by 2002:a05:6830:2147:: with SMTP id r7mr4711948otd.325.1589481788330;
        Thu, 14 May 2020 11:43:08 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm974717otr.80.2020.05.14.11.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:43:07 -0700 (PDT)
Received: (nullmailer pid 8968 invoked by uid 1000);
        Thu, 14 May 2020 18:43:06 -0000
Date:   Thu, 14 May 2020 13:43:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: irqchip: renesas-irqc: Document
 r8a7742 bindings
Message-ID: <20200514184306.GA8929@bogus>
References: <1588794695-27852-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588794695-27852-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588794695-27852-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed,  6 May 2020 20:51:28 +0100, Lad Prabhakar wrote:
> Document SoC specific bindings for RZ/G1H (r8a7742) SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1->v2:
> * No change
> ---
> 
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
