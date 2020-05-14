Return-Path: <SRS0=Uo47=64=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE9C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58320727
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589461436;
	bh=3bIZOzLSNAE/EGch6NutsDyhByrv9G1g20b34R7O++c=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=dwzlFyEOFrgW6PG8fS4BC+C+aFMk9zklE/qLhe7M/pLxJCUsYtggqSE5Tyb3qwLqK
	 BUkPmuSTD4C0wE5TUaMgu2IHZUNGZpVELSgTDVIa3Srgjrj/VrJY2d31mxdH4pWR/n
	 wLeqpqF9IWbV/WYPRXePOec/H/rrkgbSyQg2ZR10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgENNDz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 09:03:55 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42094 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENNDz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2020 09:03:55 -0400
Received: by mail-oo1-f67.google.com with SMTP id a83so692284oob.9;
        Thu, 14 May 2020 06:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQlGy1003OHhQDoA039YQUlM3pD9hZvmAohGgf3kvn4=;
        b=O75EE9Wfl290v9u4EM0BOhEZvXnoj4BqbCOWWiOpxDMhftp5riVsr0v4/RsXdlzGPn
         K54gU8sLhlAicSWafHUQshXGO3EQp3riJm8BcnnSmXuPthoymMfJ1N4r3q+RU7CpWv5P
         /7Clu6YUIw2UXWKlAaKVkIVBl+9PXBxY7vpSC3AS+OTKA3UOK0C+GK2imxf9vc927OE+
         8YtquOnaa8Mw9/ip9csNnVV+ia4WjusDLU1HLi4/JgKwAh9SAapRwdKCHQcBNzJRh0ew
         FMKaD4nIc9KZFSpe0qRhdiWHHBVw6Q/lQRGerdbCeunouhAW1iw5Hq9aQ+VkYP73sz3S
         1maw==
X-Gm-Message-State: AOAM531sgT9EluGnyc4UUneHqClUdUTPd2aZf4NcKYdsqNwurBsTOTFx
        LT+iOSX4nYURJ2zfuZXjOjiLFmw=
X-Google-Smtp-Source: ABdhPJxYFBjlqFYAj1GqfM1gMHAmeTVKS1xzDLOHNBWjxWUb+onZgcIBtfAiY2GmmiFtwefYIt7M5A==
X-Received: by 2002:a4a:1a42:: with SMTP id 63mr1040493oof.16.1589461432786;
        Thu, 14 May 2020 06:03:52 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q68sm755657ooa.29.2020.05.14.06.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 06:03:52 -0700 (PDT)
Received: (nullmailer pid 18205 invoked by uid 1000);
        Thu, 14 May 2020 13:03:51 -0000
Date:   Thu, 14 May 2020 08:03:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        devicetree@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller
 bindings
Message-ID: <20200514130351.GA17797@bogus>
References: <20200513133122.25121-1-lars.povlsen@microchip.com>
 <20200513133122.25121-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513133122.25121-2-lars.povlsen@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 May 2020 15:31:20 +0200, Lars Povlsen wrote:
> The Sparx5 SDHCI controller is based on the Designware controller IP.
> 
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dts:20:18: fatal error: dt-bindings/clock/microchip,sparx5.h: No such file or directory
         #include <dt-bindings/clock/microchip,sparx5.h>
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
scripts/Makefile.lib:312: recipe for target 'Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1289290

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

