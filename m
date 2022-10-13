Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE47C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Oct 2022 20:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJMUbp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Oct 2022 16:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJMUbo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2022 16:31:44 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C375160851;
        Thu, 13 Oct 2022 13:31:41 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-134072c15c1so3686402fac.2;
        Thu, 13 Oct 2022 13:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL6Lqe/Om1hnuXQMKSZr9Ct2LX6fKcwCs8dF7JbScbc=;
        b=fkTod943YiSVmgt//pYCNfb9rXkchSpH9M6/T4+f1zmi/BaxzYn5GnJBrgSvk+LQeL
         SphdInndKdJpiw/H5wjaJhu1g0tN3qZVaLZFNS8uDRAtoKuODI2WFKk9FeAXm/e6gDQb
         yKLv0fHoucWJ6AqUrrijC8Afh8ECHJ61cNdfvzSub/l/PXrmQIkTbGxc30/jGFgKspcA
         12e1EY48fHTjUIYxb7OQyAnTwnB8tHcb85pjME7GIFmXy4Ro6Lq3N+VXIJ7tPbKEWMKo
         RtWj4kSUHgTygKEsbpEUB9F7DJwzPobOTj9v1/QEVQPjB+w0ve1rZ2hMx90ztIQFV+II
         LkJA==
X-Gm-Message-State: ACrzQf0zElHeegOAf5cjic4QjX6pu4DAN52Yi2ULZ7iXqX5n8v8VSdaV
        28+CfY6Nf6TXke3ds/XAvA==
X-Google-Smtp-Source: AMsMyM62pNn5W6z4ChVz5v6D/sR5XjDArsIytxlLRWy932CttCZuViD9XmE/M0qo+YwzSmkEt/xbIw==
X-Received: by 2002:a05:6871:b2b:b0:132:40e6:9d50 with SMTP id fq43-20020a0568710b2b00b0013240e69d50mr840811oab.157.1665693100217;
        Thu, 13 Oct 2022 13:31:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l75-20020a9d1b51000000b00660d73c8bdesm389283otl.50.2022.10.13.13.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:31:39 -0700 (PDT)
Received: (nullmailer pid 180063 invoked by uid 1000);
        Thu, 13 Oct 2022 20:31:39 -0000
Date:   Thu, 13 Oct 2022 15:31:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     ulf.hansson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: add ti,itap-del-sel-ddr50
 to schema
Message-ID: <20221013203139.GA178344-robh@kernel.org>
References: <20221013024021.121104-1-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013024021.121104-1-mranostay@ti.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 12, 2022 at 07:40:21PM -0700, Matt Ranostay wrote:
> Add missing ti,itap-del-sel-ddr50 property to schema to clear up the
> following warnings.
> 
> mmc@4fb0000: Unevaluated properties are not allowed ('ti,itap-del-sel-ddr50' was unexpected)

Not the only missing property, so I'm curious why not fixing them all?

> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

In any case, one is better than none.

Reviewed-by: Rob Herring <robh@kernel.org>
