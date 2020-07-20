Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D7C433E4
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376EF206E9
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283679;
	bh=ZZsnggx/BtBIx2O5c89dpHBztOTjVPoVkksljZdzayc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W4zWjIbbANtrRVg4aU+DSAHj5HGmqv/KJwC73Mb09frUzNGQj7xjwAGLSWz4PzURc
	 27AxbcpcsLQGnXHw/rafDof+vYYSTScFBznud5BX+b41GfjB2tK6I7sIV5sCwndLpl
	 WF4wJo6YQTqSb2KuAxjAiVigqyjxuRvYoBpta+rI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgGTWVP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:21:15 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:40115 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTWVO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 18:21:14 -0400
Received: by mail-il1-f194.google.com with SMTP id e18so14712922ilr.7;
        Mon, 20 Jul 2020 15:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XriqGcqxOt30stF+2NyyeyIBB0A5PuETde4ptvAri84=;
        b=QROxW/SGs0k5h+pwUkl97hXAeE+YSk3gw/ABmDJKOuC5FSsjNQ9SWR8F6FC4ad/XbA
         zR62yet1/XgFM82JzOJ8kmqAH4Lu4E2Loqc3rrCa1yFvg4/1BWwldB8P2694DG4TMXPM
         qEm+pws75WuL+s1f3dWlP2H26fC3rN+OA/lybyTLBAgn0j/Pji7ztpoWy3qTwCA/Bc/a
         S5G6EGge8oSH3ZqVqlJWvZnHRUlMLe0a8Z3nIx9aSuTzbYSl/AnaYlUpgtxPb/p4f3U4
         GgmkJrEL01UNbOUVYt4QnogjQ3PXtp/HwF3w8UuG9ISKek0iFPErfpxnf4IjVHf0KVHJ
         8U9w==
X-Gm-Message-State: AOAM532OnDTO4J+6FIiQg/8O1FlKMDRpJCfEmSxUNmxSilNqh65Z/vx7
        Gz/6ljtNTtaG/4JFQevjzw==
X-Google-Smtp-Source: ABdhPJwHPmCfrnnLPzvPnXYHjd3r/lsBmlhji1hn9riQDgtUnj7XxS+pz6Hem0rEsxyeVOWzEMRpZg==
X-Received: by 2002:a05:6e02:606:: with SMTP id t6mr24526570ils.181.1595283673829;
        Mon, 20 Jul 2020 15:21:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b20sm9761834ila.5.2020.07.20.15.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:21:13 -0700 (PDT)
Received: (nullmailer pid 3055001 invoked by uid 1000);
        Mon, 20 Jul 2020 22:21:11 -0000
Date:   Mon, 20 Jul 2020 16:21:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mmc@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 3/8] dt-bindings: irqchip: renesas-irqc: Document
 r8a774e1 bindings
Message-ID: <20200720222111.GA3054900@bogus>
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594230511-24790-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 08 Jul 2020 18:48:26 +0100, Lad Prabhakar wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Document SoC specific bindings for RZ/G2H (r8a774e1) SoC.
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../devicetree/bindings/interrupt-controller/renesas,irqc.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
