Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52CC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 20:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843ED208A7
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 20:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696274;
	bh=TRXCcDTCkpjwKNGmnR/kDAUh/991qEvepbXO6/PKpcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DlqMj/n7RLvuv1ExEjVJJXZv8Wgg6G25uasTkD8SUqZpItHnMroywR3hE51bMfvtk
	 r8bHZFr1lQ+AOLKbhVSiOLY+cdT7v7qEZWJY6vDW7D8jjNemly3CfdVRdD5SaskTqE
	 BDqx5Ov0VmegMdEizFDrVqBpXFnadbTSpUy6Hp/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406785AbgE1UEc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 16:04:32 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46738 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406907AbgE1UEY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 16:04:24 -0400
Received: by mail-io1-f65.google.com with SMTP id j8so31497177iog.13;
        Thu, 28 May 2020 13:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+8NZuaOinPrjdA8rsR2Wsvvaxw3Pl0ruxlmsq2aRKdE=;
        b=NbusgPa0BQcOHPcQpbWZv5vvJlfDemwLvOR8RRJmRG0+sMGG8CZquwgC47IgaVgaQ7
         1Y7i78RGAOCPdUyUVY1uvI6/iu1BBuFNdbSIYAFD4lh58pWtx8om5hPfKUr5NfEP09h/
         Ytme3Kb3FzIvEXh5iL89/gS6eBfpv9kKtGN74NJWsrdXek8uPZ+7wvIl11RJk7sE0aUS
         IXGuxq1J9NtSTp3uYIJIvP0l9fOFa4TT+pdTbomISir3elUmf7712Nmhxgkz4dJiMwzS
         wif0q1pT3r0ZSVdOkgeiQliATEKuYkiENIsIif15yIJSPvhEoAXoqgZv0bM2cNPT1vLG
         nIHw==
X-Gm-Message-State: AOAM530hmwsEJFUev6pY1FjB6s/EszaoAo4LKVxkJbJ3w9EH0KAyP81k
        rI1//NFd+E6AzuNpdKg4cA==
X-Google-Smtp-Source: ABdhPJxajfmATtw1jRSaNMzRQiAbZVxL00s/0hrIyNylY6vJpWo2Tjrk+jNg8N57Yj+myByb+xFEqA==
X-Received: by 2002:a6b:8b51:: with SMTP id n78mr3746602iod.120.1590696263105;
        Thu, 28 May 2020 13:04:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u21sm2912412iot.5.2020.05.28.13.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:04:22 -0700 (PDT)
Received: (nullmailer pid 590566 invoked by uid 1000);
        Thu, 28 May 2020 20:04:21 -0000
Date:   Thu, 28 May 2020 14:04:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 10/17] dt-bindings: net: renesas,ravb: Add support for
 r8a7742 SoC
Message-ID: <20200528200421.GA590521@bogus>
References: <1589555337-5498-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1589555337-5498-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589555337-5498-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 May 2020 16:08:50 +0100, Lad Prabhakar wrote:
> Document RZ/G1H (R8A7742) SoC bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
