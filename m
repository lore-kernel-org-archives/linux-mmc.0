Return-Path: <SRS0=XB32=AK=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D8C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A856320656
	for <linux-mmc@archiver.kernel.org>; Mon, 29 Jun 2020 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467300;
	bh=pHWXkpDmMnzt9/atnFVWTOS9Q9wcOY5N5scI8iSGDa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HIHTLgX7K7EJPtIsFBcZ3naq5LE6U9jz64D/axKkzdJYbptsmx4almuKIzc3YOPUC
	 LkQIgr6Nzv9Qq5IVsz1Quz0WyOK5ZZlBytkesRtmYMRhc4CPJ2TxUHfvDBuS963dnN
	 6c717EhzmvABeC3g5d8ZRvOJabphaDOSPX/Ups3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404270AbgF2VsT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:48:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38672 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404255AbgF2VsJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jun 2020 17:48:09 -0400
Received: by mail-io1-f68.google.com with SMTP id f6so3231010ioj.5;
        Mon, 29 Jun 2020 14:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wGWmyGXfNATJETlByWIEZ13t4eNzYwD3JHETLNfxb54=;
        b=LSTQHAqoIoV/qaZ7TayTtaGHtNbbU7i50/njuRYKApJYi5gEpkVGwdXkB8vXP2xdsk
         ysyi5ajs/I2ER9KBGj8+FdLPeUk8NJJgtiU2kYrYe8LvmeJZVEegydgAFgSmUidGI5WE
         XRSdYwZpFaVKH9pNYAuiBhl4LeC0cjIdybvKY0LCYUMqPuHFiCci7zW8rPSRUHfyHuvy
         H/wxaPx+sjuP4DW/i4PbZTOq8/BgZvYCxkrQq9+BHaNs1n2gpQcaogkhoQvBW95ajTAK
         lcIRPfmdOKKvOR8GTecazz47RjfNvCGq1WXPpHwSQ4GAS/yciphyChc6sEuD6dZ1XKTl
         K5qQ==
X-Gm-Message-State: AOAM531m6d+RoibLzHPJ5tXG+6acAXaykD8ExqP0U9wwrSS/kSIyu9wP
        oLPMdakqjKQrvQRXi7jXsA==
X-Google-Smtp-Source: ABdhPJwEfRn6dYm/O5ro6RnMRhK1qWiklysncseXKlDL5Wp1cyeVC6ap1ygyNz6c3jdV70Ag3tnIxg==
X-Received: by 2002:a6b:1496:: with SMTP id 144mr18920446iou.6.1593467288379;
        Mon, 29 Jun 2020 14:48:08 -0700 (PDT)
Received: from xps15 ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id k3sm601299ils.8.2020.06.29.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:48:07 -0700 (PDT)
Received: (nullmailer pid 2985144 invoked by uid 1000);
        Mon, 29 Jun 2020 21:48:05 -0000
Date:   Mon, 29 Jun 2020 15:48:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, ulf.hansson@linaro.org, sboyd@kernel.org,
        aisheng.dong@nxp.com, linux-clk@vger.kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de, robh+dt@kernel.org,
        s.trumtrar@pengutronix.de, devicetree@vger.kernel.org,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: Convert imx esdhc to json-schema
Message-ID: <20200629214805.GA2983242@bogus>
References: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592450578-30140-1-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 18 Jun 2020 11:22:56 +0800, Anson Huang wrote:
> Convert the i.MX ESDHC binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
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


See https://patchwork.ozlabs.org/patch/1311722

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

