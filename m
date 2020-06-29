Return-Path: <SRS0=XB32=AK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07FBC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98C0206A5
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 21:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467677;
	bh=5rhii0RPtqMd801EeEYeeEKTbuvPVzbyTh8iApbbK/o=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To:List-ID:
	 From;
	b=0Cvm81WR3Ku0s5lKJ9eGoB1aLiiS5/fcWYoUtW8hb5zcnG7ggIINSdPcmslpbPcae
	 YiTdj5Pirauo3Urf7a9TjcWwGLvVwCc1bQEcrQIZCR1yT4Lun+Lsln/cbBLCuJ5+hg
	 Gc0HT1v785Mdbtqa8ZQdivgKJwC79iz2hTPch8Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732848AbgF2Vyd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:54:33 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:45362 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389336AbgF2Vy2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2020 17:54:28 -0400
Received: by mail-il1-f194.google.com with SMTP id l9so15863059ilq.12;
        Mon, 29 Jun 2020 14:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C8dUSvhRmWNPjC/Gxl3IeAC98sriVh3zuvoUxs+yN3o=;
        b=UBGlhBo9qQTRssFhh/7fDs7y1nRpj6NGSpivSRzbxVhbqioJnjpyEUM1gcyKvEW7+O
         9r6V7uHJntwbWG2yU/yxqXmZwOOoyIekPFG+eV1yfOZjO777pUzf1BZ/HOrcXK/mCR39
         xa5slE+1Pc/zUdOA9EjBUMcbj+1+mZxMck6m6QRHCS8niYmTv4+BaXLMKqpZwRl2uUM7
         xgnTQFGRVTxJv4AXMzjnnXMNhjc5OVoYB5BjwCikOtvbv6yZ+UBEP4QSMyItrmYwbAcH
         6s6YqZNkkMMoRwEvp8Qu8x3pKimkgGwocb/dq9Py6Qmlof8grR1fRyCafi0Bj6eZwiO8
         YzIQ==
X-Gm-Message-State: AOAM533ECi4X4Pn4EG5gkgtKTfI1CMX3I/gJ12qzgrZGPhs9yrdabM3V
        JqBCCSAP9Yy0afdh9+GTmg==
X-Google-Smtp-Source: ABdhPJydHNBwHC1sjSL393mIV8ElpWA8UM200L9n5v4oEctdkRP/KNOR4wq2uIs9B/BUiGXS1q9B0w==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr15678654ilm.160.1593467667476;
        Mon, 29 Jun 2020 14:54:27 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id t18sm611073ilm.55.2020.06.29.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:54:26 -0700 (PDT)
Received: (nullmailer pid 2997019 invoked by uid 1000);
        Mon, 29 Jun 2020 21:54:24 -0000
Date:   Mon, 29 Jun 2020 15:54:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        SoC Team <soc@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: Add Sparx5 SDHCI controller
 bindings
Message-ID: <20200629215424.GA2996213@bogus>
References: <20200618141326.25723-1-lars.povlsen@microchip.com>
 <20200618141326.25723-2-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618141326.25723-2-lars.povlsen@microchip.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 16:13:24 +0200, Lars Povlsen wrote:
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


See https://patchwork.ozlabs.org/patch/1312158

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

