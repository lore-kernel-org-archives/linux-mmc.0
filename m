Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8927CC433F1
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A6C6206E9
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283638;
	bh=FafJpWsg5zpiNoHKZd/rmHipNMjtXCZGc5bnmSJ7Cxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NPqMOHdqZ7NJgViqf3aU6y7MDDE7XgXeMkG4x2X5EB+dARhX1+xHYWlh5DnmFGDnr
	 ckPnqU8Wvv+15FR8KjSW8fGxjrQRmqm8PIVjzBDJb4kHbCS1scMh29YLCpjnOMMXDn
	 +nZAzQwOf9SxT6KLs/L/Y19+OVp1g9CwytMCNuuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGTWUf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:20:35 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40316 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGTWUe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 18:20:34 -0400
Received: by mail-io1-f66.google.com with SMTP id l17so19255647iok.7;
        Mon, 20 Jul 2020 15:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdTcN2QOtuK4/ple9u7bww4BbmoGROQu1AN0m9hHaQk=;
        b=DfTcGeIGUU4s3XURSQhOZe33gapK8II6x7KRNh98SAcVHTBhMD0MezB76A0O3TD+7x
         D/sUfDHSCoP0tzAMgPmtL0grGQAkLmBFKXa1YcFxmzgVI3VzMiWd3dfbLgfDIM0APi4t
         UBp8vzXF16bvbmKOkm1Ccsdrn7HIXqTVMqAAmgptuTOlVzIlos3vXo37siHTnZLqmKQ6
         CxHk8je2/wAMXskF0Ugc+Wjt9t1qlJ66S8k96cJDH9+EDy9mrUcNKzP38wyELaa35pEf
         WBbQL2kVvO2UtvRxM0CtqdXX0G171p+nigxEn6ajhMfIsjRQDHKte4jjHI3vo5pF81Rh
         jZSw==
X-Gm-Message-State: AOAM530ePFy7L4yY2OQu0ZLWvRAfVnOHfma3hpelmnnuqcVkIWV7g9Q2
        uSLcop+UOmufBCcg4P0tVQ==
X-Google-Smtp-Source: ABdhPJz/tXsuLsaWFMPiIrxvDvKJbTsiFgo2FYfezivTjBh9nWBYDBpgDVa8aJOQ19/UAFKhgbwUgg==
X-Received: by 2002:a02:7f89:: with SMTP id r131mr27491532jac.98.1595283633485;
        Mon, 20 Jul 2020 15:20:33 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b2sm9578924ilf.0.2020.07.20.15.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:20:32 -0700 (PDT)
Received: (nullmailer pid 3054009 invoked by uid 1000);
        Mon, 20 Jul 2020 22:20:31 -0000
Date:   Mon, 20 Jul 2020 16:20:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jason Cooper <jason@lakedaemon.net>,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: serial: renesas, hscif: Document
 r8a774e1 bindings
Message-ID: <20200720222031.GA3053957@bogus>
References: <1594230511-24790-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594230511-24790-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594230511-24790-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 08 Jul 2020 18:48:25 +0100, Lad Prabhakar wrote:
> RZ/G2H (R8A774E1) SoC also has the R-Car gen3 compatible HSCIF ports,
> so document the SoC specific bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,hscif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
