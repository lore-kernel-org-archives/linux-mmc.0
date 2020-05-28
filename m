Return-Path: <SRS0=dyeO=7K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC1CC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 20:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 596F0208B8
	for <linux-mmc@archiver.kernel.org>; Thu, 28 May 2020 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696310;
	bh=pOrsTltkcIJPA2cIPeY6EK0sAi0kvc7UhbcK/UOt7HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JNFWJitQ6MnNx5wl1Pee1mUhcMs3t2IQCyeeyyOpjGJxlJIPO5cUUKvMEgbHrKjr/
	 /6Ev8AZ8Bc3skWjdy3Kd8zpnaWJ1Og1Qhjpo9ij9d1VwjT51Ufg7zgoCDfwv/fDKOp
	 3nzZhuagmV1pejjF7zkEVwM0BtzZBtibOFPbnuf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406849AbgE1UFI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 May 2020 16:05:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32959 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406787AbgE1UFG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 May 2020 16:05:06 -0400
Received: by mail-io1-f65.google.com with SMTP id k18so31613911ion.0;
        Thu, 28 May 2020 13:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G3oBLq5QliQ4IzU/NPxmbvWurf2zPONVKqHTn1jFm2o=;
        b=piiAQC4F9Nkn/bp8Vn/nyeNHGm7QAi+HFvWw3PAIK+ogQEDtYM9Nm8S0dR3npLTY+O
         NU999q0sA7KKnxxGBBy8QSK1bsPQX2tyOH5z9Odka6H3tFXrJMEkLMQOmrYsZEj2w1GQ
         rBeu9lwFzIoaux4GOMADu8MuobqsbUDtSbBsBgud0OhIK7Ct0nJdck3mUBID4rNC/RqK
         +ewL79iOec+Ljf7ydBIpmX7OPkMAjbkzUhYfGkTWf3Nt5TuQHBr5/AqgWCRNP0x1LvYK
         gzrTt1Tj69JuqzloWBmRtiLUtVa0TbqyV+zSsd+g3ADtK5e9YVyEMAc1RIOooHZ99g6n
         rINQ==
X-Gm-Message-State: AOAM531bR9ife/uJ0G52EApiihFRPSJxiXULjU8Bi2AWM6rc9HzLJ9mA
        lI7yvAM8o4uyMqnOZOkuPA==
X-Google-Smtp-Source: ABdhPJw/9LwdK1Nn3Ofbo62Q4Ys6/0Wk46kqXtMKa1w/vugW8+zhezIAfkZycgoWQQ/d+JtykGMNZg==
X-Received: by 2002:a5e:dd07:: with SMTP id t7mr3814841iop.21.1590696304973;
        Thu, 28 May 2020 13:05:04 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i2sm2905114ion.35.2020.05.28.13.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:05:04 -0700 (PDT)
Received: (nullmailer pid 591807 invoked by uid 1000);
        Thu, 28 May 2020 20:05:03 -0000
Date:   Thu, 28 May 2020 14:05:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-watchdog@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        netdev@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "David S. Miller" <davem@davemloft.net>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 14/17] dt-bindings: power: renesas,apmu: Document r8a7742
 support
Message-ID: <20200528200503.GA591757@bogus>
References: <1589555337-5498-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1589555337-5498-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589555337-5498-15-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 May 2020 16:08:54 +0100, Lad Prabhakar wrote:
> Document APMU and SMP enable method for RZ/G1H (also known as r8a7742)
> SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/power/renesas,apmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
