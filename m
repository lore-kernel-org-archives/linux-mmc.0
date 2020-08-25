Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F6C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C687920782
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598371606;
	bh=8zmpHksz4OFu/h6PR7qcApCchuk+pUAcYARjrfwGk3s=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=Os3rJcqj5KEciVzFAS231n6RRBBaXsfAjkHX3cImSiFy5u/iVhc+xXLltIAB7Sl89
	 bvn8wVHADHkPs/87lfTd68e8Jj3+JoB1n4phczuN3pahV+MUG5aCnE7LbDAfsR6Lnh
	 i+C6cYnXxuJ4d9i61N+o7GVNZ4jjnG23I9y001nk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgHYQGq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:06:46 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44367 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgHYQGn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 12:06:43 -0400
Received: by mail-io1-f66.google.com with SMTP id v6so13016562iow.11;
        Tue, 25 Aug 2020 09:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FcGWZ2U1TK3jm7niFe702isUINLMowDtiawDKgg8fkA=;
        b=gdFGOK+x31x/LOzlZZIhUrpsfxFE8QiL5C4oMPn/+9mF4uTwv/gmsGSsMRNaQYhgaI
         hmYYCgsaG+65bAxYGsvhsrDZdAOSS2LviGEsYPi9FwgsIuPI57FqXqyoDQ8ZLnU6Hm8y
         BZTJdQ2DZKe9MSZfDCWx1InTDZ9EMBHPCOv4PFCim7Lh8vIL+QZxKm6cbzbAdBXT4aYe
         5g4IT35F//JQ/neubdZWZmzVEkfLX5ewCjja8Q2Z2uWpGJFF/3mhtNSQ1K6nPMmxzn/T
         aULsqe0cRgVMGv2HBs23cIqF/pfISuhDJWLv2U58MWNont6J9OOagUWUgPYauZKFYykq
         SCKg==
X-Gm-Message-State: AOAM530UibIkzXimSRJTQimHEv6JBzIYzm+py3VfOZEJUv/SMCBuxlki
        uOGlyUtGwNHD67CFe6jz7A==
X-Google-Smtp-Source: ABdhPJx0h9k3JUbzENgSVuwUkvdI2/jgdzcczgNdiO3Aryf/zAQG4NWt/tLA6YUIQe1N2QCEJWnU3A==
X-Received: by 2002:a5e:930d:: with SMTP id k13mr9528967iom.40.1598371602507;
        Tue, 25 Aug 2020 09:06:42 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m15sm3896884ioh.24.2020.08.25.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:06:41 -0700 (PDT)
Received: (nullmailer pid 864451 invoked by uid 1000);
        Tue, 25 Aug 2020 16:06:40 -0000
Date:   Tue, 25 Aug 2020 10:06:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        SoC Team <soc@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller
 bindings
Message-ID: <20200825160640.GA863416@bogus>
References: <20200825081357.32354-1-lars.povlsen@microchip.com>
 <20200825081357.32354-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825081357.32354-2-lars.povlsen@microchip.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 25 Aug 2020 10:13:55 +0200, Lars Povlsen wrote:
> The Sparx5 SDHCI controller is based on the Designware controller IP.
> 
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> ---
>  .../mmc/microchip,dw-sparx5-sdhci.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.example.dt.yaml: mmc0@600800000: $nodename:0: 'mmc0@600800000' does not match '^mmc(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/microchip,dw-sparx5-sdhci.yaml


See https://patchwork.ozlabs.org/patch/1350851

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

