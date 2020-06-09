Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BC6C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 23:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED0920734
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591743745;
	bh=8vAND9tiTsz++BCaHz0XGGCZBqSa9+BRIRGPBWK/rzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZzGqJmUkgnBHIxAjrTuSeYoVF0+5gQz43cBXSuxBLgOyi0hKkkN+KVX2a6gWeFpel
	 DPHF12bGIbFQK385oeVHKrThK6uCtKZgddV/fBuZe1B/oYtIv2pBikWiwEKSEEw2cd
	 miKJWuV9aw26Olf2kdF5Np8PZXuZoV/6/J0Wl6+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgFIXCU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:02:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45345 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgFIXCT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 19:02:19 -0400
Received: by mail-io1-f65.google.com with SMTP id y5so27438iob.12;
        Tue, 09 Jun 2020 16:02:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9UAjDcGkiv4VYRf/6C6V6G9cxQr/lplrc3OR9Y4YnTY=;
        b=gLh5b/Mzx82dvgT9FDtczaQdpF0KgOSUHi1oup2Oa0mYMxOSTwgSy0/vzr0pBoQpB7
         ciGTjXnjxoBXTEPCmZSmljkiqmYHor9SYubXvECIVZBSzmoDFOiM8X5A4/EBR2KPCrV6
         X9Bpv5q2v/iyndwOt+ZyF6rEt6nN2jH3P/yMVF/sb9xozlJfTnR8OXYs6ZQLM8YOcOIZ
         MC7pKOWBZHZWHie3nSSsvEca1I5+GZLk7tvx7zU9tPspSCe+gtsxIJdiUymsznANOpFH
         Aa3HNA74JgpzrvBNuFMufcTEN6QWMfi5EgX/kM19ACGIhHJ/CTjE2uYgOokScAomBLFC
         7Lmg==
X-Gm-Message-State: AOAM531FWlCScH9s/fatIeF9jBJh4njLQFBtjsqh8mYSDjRiy0mLaGKz
        UDW7f/QMkAvXICLKjheJyA==
X-Google-Smtp-Source: ABdhPJw3B/5yrBt/y3dpRloQGYK8NgxRmXYSpins8OjJRCa8Nz5fGw8lZcOgcw38BCyDDNJuKrHPCA==
X-Received: by 2002:a02:a46:: with SMTP id 67mr481777jaw.144.1591743738577;
        Tue, 09 Jun 2020 16:02:18 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r19sm8035022ioj.12.2020.06.09.16.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 16:02:17 -0700 (PDT)
Received: (nullmailer pid 1670237 invoked by uid 1000);
        Tue, 09 Jun 2020 23:02:16 -0000
Date:   Tue, 9 Jun 2020 17:02:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        bjorn.andersson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: Supply max load for mmc supplies
Message-ID: <20200609230216.GA1655591@bogus>
References: <1589541535-8523-1-git-send-email-vbadigan@codeaurora.org>
 <1591094883-11674-1-git-send-email-vbadigan@codeaurora.org>
 <1591094883-11674-2-git-send-email-vbadigan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591094883-11674-2-git-send-email-vbadigan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+Mark B

On Tue, Jun 02, 2020 at 04:17:54PM +0530, Veerabhadrarao Badiganti wrote:
> Supply the max load needed for driving the mmc supplies.
> 
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index acc9f10871d4..d95219721fa1 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -290,6 +290,12 @@ properties:
>      description:
>        Supply for the bus IO line power
>  
> +  vmmc-supply-max-microamp:
> +    description: Maximum load for the card power.
> +
> +  vqmmc-supply-max-microamp:
> +    description: Maximum load for the bus IO line power.

By a 'common regulator property' I meant documented with regulator 
binding like *-supply, not common to MMC. How is MMC special?

Thinking about this some more, what's wrong with the max current in the 
regulator nodes? I suppose you could have more than one load and need to 
define the loads separately?

Rob
