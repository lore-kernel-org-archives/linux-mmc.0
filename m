Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C2CC433E8
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3FF206E9
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283625;
	bh=txRkMDErEdjZSLmFbEXoKjLrafYC+z8fsCIWHkHqjoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rFKKeiQKul0trSD8hvSR8nFyYVUDT2fUJf7o1euzbqlG084gD169WiVuEIGRHZ99k
	 aaIxi1MpJ3+mZ7ASw09YsecK4V+xSAMjg3sy5LCT17yH0vsFuAIg9utihfv0oyv7Vt
	 8s70JMcG1jsQuhy2LFtVvQcVJXs5eLWLMuD5fJZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgGTWUV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:20:21 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38242 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGTWUU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 18:20:20 -0400
Received: by mail-il1-f196.google.com with SMTP id s21so14686659ilk.5;
        Mon, 20 Jul 2020 15:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5aNu8Bj2xSBjAjdaD2TAewp6TUSbKQpg/yqNYp/6xM=;
        b=XXC6dSdqldCTwAab/QlB59YdmAGRHznYA/iSuQFv+PT/8qZXdp4yh4WtPvH4pu4tFv
         xj7aXHbqIsEVawSXqdasOsg5Oh7y8nlg2IJwG6wCrxf9sbwJjVVTbJofM21PXTsnORn1
         klnpmhH2ssDgEaEvhFHlTPTfiPGBPS68Actd5xeiwgFjkYSulqQrgHrY8fcXg2u/FIcQ
         Hhn+yOvmjeHo3acguP0ifVvQdVnX/vUZgER2Xrqt9ZKvddXu2r3zFflN1U1AVejmKjBl
         KWOOaXxQfRh63+WFv5AFG13yBvnpZ5Uz8EOZTJM8I4WBREM/d5skjsYOwzDZCQM+uOF8
         F/cQ==
X-Gm-Message-State: AOAM530O4RyVbrvB3eE0rU+QwBhtMwka48T8QpZ5Zc1la32JqlqbURJx
        bTLnpu4SrZAveN4cEvpK+w==
X-Google-Smtp-Source: ABdhPJzPXOxXLly5DaYJYfcd1QZDwnC5GqJ1CI05J/8Ic47RoXu/ud8yClr8GlFmT9QOOc3s48CRXw==
X-Received: by 2002:a05:6e02:1313:: with SMTP id g19mr23470335ilr.123.1595283619725;
        Mon, 20 Jul 2020 15:20:19 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id z9sm9524946iob.39.2020.07.20.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:20:18 -0700 (PDT)
Received: (nullmailer pid 3053563 invoked by uid 1000);
        Mon, 20 Jul 2020 22:20:17 -0000
Date:   Mon, 20 Jul 2020 16:20:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jason Cooper <jason@lakedaemon.net>,
        Will Deacon <will@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: serial: renesas, scif: Document
 r8a774e1 bindings
Message-ID: <20200720222017.GA3053528@bogus>
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594230511-24790-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 08 Jul 2020 18:48:24 +0100, Lad Prabhakar wrote:
> RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible SCIF ports,
> so document the SoC specific bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,scif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
