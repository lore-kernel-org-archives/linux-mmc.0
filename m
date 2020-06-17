Return-Path: <SRS0=v6Vx=76=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B063CC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Jun 2020 17:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BED20853
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Jun 2020 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592413233;
	bh=Jrt6bJioLbNwFQmv2RS3sJsO1sWVTeNe/fdt10EMKOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WF3NO2nTwQ0r1PhHlFyb3McRRlpLoyFW708S+5qaqbif93tUJ/AhJL+ZfYlT1XMtA
	 f/OFzOBXtQVvZ8EScS/MlJDNrRQRsk4uQvhu4Et2DewFVxf0Y5jh8RJyigbfl2ER12
	 m2EvBOD8Esx/j2Pk/19YqRqohnua0dOnR3R+VyZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgFQRA2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:00:28 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45535 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQRA1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Jun 2020 13:00:27 -0400
Received: by mail-io1-f66.google.com with SMTP id y5so3539593iob.12;
        Wed, 17 Jun 2020 10:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fki83yGjWsSUmt5apeBY0MavNHGcAOsj5zPBT6SYQlg=;
        b=RxVko4lKqgYT404Yy2CS5s0faIFcm7r1ieELqICtaxQJmaKGqG2rMOMZ9WkuJ+jJw9
         JcWCwcdW8YaN6kdSjwTuekW6BheUYHQkg1XEi9fckLxejf4uidJsqXapN0k6QKkQsd/J
         YkI+R9J8CmixQL4YwNZJYi8FYR51V+AjHPNX/9izocWU2/HaMD548WCuJ0meaGeHIvym
         fHKgnVaj6JfNt1AkN5TTfy8YBwvA9qRpsZ3WQ8tM5wkhDXaUKGmZqMJmJSRvbqT0InHh
         GNodGE39l0BoSeoaJ/Ewwdu5MMiyXVKtjxcNSQJ52MTE0CqsAmJBwp2zEQEmSaiXXVJj
         MAiw==
X-Gm-Message-State: AOAM530grw4D4fhe7aQ4JX5uItWR4onxUXnCn1nk7/8zH1HmmVz2PyOA
        YZUKmQq0gXMGtI2HboVY3A==
X-Google-Smtp-Source: ABdhPJx+p0Qee6x37cKl8Eb4FOZ43dbLofGKP87bW/hSWuvOLKjm3DEF+vk9a5mWaReVwREnPvpVIQ==
X-Received: by 2002:a6b:440d:: with SMTP id r13mr310698ioa.95.1592413226572;
        Wed, 17 Jun 2020 10:00:26 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id n4sm246839ioc.8.2020.06.17.10.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 10:00:25 -0700 (PDT)
Received: (nullmailer pid 2303368 invoked by uid 1000);
        Wed, 17 Jun 2020 17:00:24 -0000
Date:   Wed, 17 Jun 2020 11:00:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     shawnguo@kernel.org, ulf.hansson@linaro.org,
        devicetree@vger.kernel.org, s.hauer@pengutronix.de,
        Linux-imx@nxp.com, robh+dt@kernel.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V3] dt-bindings: mmc: Convert imx esdhc to json-schema
Message-ID: <20200617170024.GA2301944@bogus>
References: <1592278549-32283-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592278549-32283-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Jun 2020 11:35:49 +0800, Anson Huang wrote:
> Convert the i.MX ESDHC binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V2:
> 	- fix typo of "dealy" to "delay";
> 	- remove unused "Several ranges could be specified." in voltage-ranges which contradicts
> 	  the min/max items.
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |  67 -----------
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml     | 124 +++++++++++++++++++++
>  2 files changed, 124 insertions(+), 67 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible: Additional items are not allowed ('fsl,imx7d-usdhc' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: compatible: ['fsl,imx8qxp-usdhc', 'fsl,imx7d-usdhc'] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx35-clock.example.dt.yaml: esdhc@53fb4000: $nodename:0: 'esdhc@53fb4000' does not match '^mmc(@.*)?$'


See https://patchwork.ozlabs.org/patch/1309972

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

