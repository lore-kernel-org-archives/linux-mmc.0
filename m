Return-Path: <SRS0=Uo47=64=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3000AC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 18:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F081B20727
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 18:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482678;
	bh=3IGUW1A0A34qCS0X3AaDv5KGQANC6L9T+wI8LUKt1b4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tf3IeYPeRiBkHY5Wvi6XD7vKD3NSf6sUqBzuNSr3D0BxhzuzTJXNs75SEybinwPL9
	 yfFu8vofKke5ar8h7emJQQ2S3UInkSaOCZgS7s/llIeucB1hf1APkyVwljMICB6Iy2
	 +AqhrYLxTKcJ33NO4j+comP35+ZiTaTkcOra6Ml8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgENS54 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 14:57:56 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38766 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgENS5y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2020 14:57:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id j145so3655541oib.5;
        Thu, 14 May 2020 11:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nxzudyoHUEYAH8KEsSe3KpgFYuo86VuqnywBjWoEET4=;
        b=aG1HCfLQU3mcr8CzjrwuwjvTa4N+0ikeutyQUmoXU4rm3j/3sLXcC3YJJ7wZ58gARw
         dGWt4fUJ7ukKHD9+jBtimUlesBuCcfGMGQFi1hiubBteYG4XxUOpnSz3wXDPePLAtT1z
         gR367S30CraXQgfF32tdM0gcD+vf3q4TFgulB5iKbKiYzMKV/Pr7goPx34/Anp5Pi5+H
         3mkk9Q0CmYapVXYoZoe8QSkcTUCuS/11qAA0HGGERv1iuQuFqRKd6JK4O6K9DDjsvmA/
         ZQIiwa8sEYMjEbRvczq0temsCvzYr/c3HPOmjkVCQsqXMZgBcmEbdGd1CcPMq92hX7OY
         A6yA==
X-Gm-Message-State: AGi0PuYxjugMhcwIjneMYbjE0L527TStc5iwX/fNxQjJCS1yAorD/N2p
        rq4I7xGqOJ+X4UG/GpnaKA==
X-Google-Smtp-Source: APiQypKjfRyKde3xEfB2aCXkS3yVIEAxHJaGfzUhHRPMgjgw/bWE0/UhjN+F6YNCTUH/+3j853arkQ==
X-Received: by 2002:aca:53cd:: with SMTP id h196mr32003545oib.104.1589482673516;
        Thu, 14 May 2020 11:57:53 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 60sm987092oth.38.2020.05.14.11.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 11:57:52 -0700 (PDT)
Received: (nullmailer pid 29634 invoked by uid 1000);
        Thu, 14 May 2020 18:57:51 -0000
Date:   Thu, 14 May 2020 13:57:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/9] dt-bindings: serial: renesas,scif: Document
 r8a7742 bindings
Message-ID: <20200514185751.GA29577@bogus>
References: <1588794695-27852-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1588794695-27852-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588794695-27852-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed,  6 May 2020 20:51:30 +0100, Lad Prabhakar wrote:
> RZ/G1H (R8A7742) SoC also has the R-Car gen2 compatible SCIF ports,
> so document the SoC specific bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1->v2:
> * No change
> ---
> 
>  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
