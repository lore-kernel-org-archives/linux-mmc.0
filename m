Return-Path: <SRS0=v6Vx=76=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60885C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Jun 2020 17:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B276212CC
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Jun 2020 17:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592413366;
	bh=dc+LQ+AYN66hLpsu5bLQY3HQR3L8SZaP8j+oRyYSVoQ=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=cLTCPQ6eBgVg2WNdJFZXHOgIE958tqWtt66JwemhGwd6MrT8E2Tb3tX2mXhYwrbm1
	 AQwnK8SZ4tGk8yMsq9vB0Qo0alxs3hDT3xQOHOHjkIZv7BXoGCWHg+Dso2xaryMNF5
	 z/if3o1z5chtde06Rckm2RqD0A9Z4HSvJh/oL3XQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQRCp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:02:45 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:35490 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgFQRCo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jun 2020 13:02:44 -0400
Received: by mail-il1-f193.google.com with SMTP id l6so2918788ilo.2;
        Wed, 17 Jun 2020 10:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wysgsxusisoXYB/oBjiONlbpR3I9vXszy7LjMADdR3U=;
        b=bhWijklCw/3RHXvBU8uru+YMpxKRO+M8kM/YQn24ZZYW4vvDu5NPvkRxuV3OMfAcIk
         LcwXj9emkzQl7g2AJxUxukh4J1QYvq+bskIbR1dSujmm4Bmo17SqnM4XryOQP7yoW/k6
         If42BZHQ+lM2UUatXqvndDk5tdAT2ULeZ2YfnrcsAdSeGxKrtWP3KiCtl+/JnP8AfskR
         05fbwZOYGoYlfFDnqyZp9n/5BATXiZoN/ErFzzNZnW+lkzZ00tfCA09PAtE8p6Rftmfn
         sCutccCI85bcND6pZ/qm519fiUDPA4T7DWZVcMK1Axmttru7FJp/YVa3nTuGdg4lRaWo
         w4dg==
X-Gm-Message-State: AOAM531D4AimZ2Qn2bdWkL05zVbm9p/1WEiQFVxcGgRHkH+j/WCJ3RKr
        /WOxJoPrK/SLFeIyZ03VIg==
X-Google-Smtp-Source: ABdhPJxImNwbUj9PpjA2BYws1gMI6MBBgEdSo1Q1xpoTQQD6tQRxzu/PREL+1EnhRRsp/OTR/9u+hw==
X-Received: by 2002:a92:cc0c:: with SMTP id s12mr9709396ilp.192.1592413363578;
        Wed, 17 Jun 2020 10:02:43 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id f5sm214085iog.49.2020.06.17.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:02:42 -0700 (PDT)
Received: (nullmailer pid 2307219 invoked by uid 1000);
        Wed, 17 Jun 2020 17:02:41 -0000
Date:   Wed, 17 Jun 2020 11:02:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, SoC Team <soc@kernel.org>,
        linux-kernel@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller
 bindings
Message-ID: <20200617170241.GA2306485@bogus>
References: <20200616140027.4949-1-lars.povlsen@microchip.com>
 <20200616140027.4949-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616140027.4949-2-lars.povlsen@microchip.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Jun 2020 16:00:25 +0200, Lars Povlsen wrote:
> The Sparx5 SDHCI controller is based on the Designware controller IP.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dts:20:18: fatal error: dt-bindings/clock/microchip,sparx5.h: No such file or directory
         #include <dt-bindings/clock/microchip,sparx5.h>
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:315: recipe for target 'Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1347: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2


See https://patchwork.ozlabs.org/patch/1310435

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

