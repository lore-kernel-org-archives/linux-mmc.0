Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95029C432C3
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 19:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CEC20640
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 19:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575401256;
	bh=Jp12xL/q3X4tITxAgZn2nPi7Ls3/U09vhmfrLbRRoeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b34pGdmR4ICEpgWs/fWDMnsVNqUohSc8CxJI7mfsDBzD1tJ4KMjZkWLYOs0N3YQT1
	 g35Q+Ky8uXsHkdYSdKOhZTzPruMloy395iLW+9czk/tnl4Y/suALac7fcWrte88ECA
	 QT3JNFDiLlbG3iVKU8yXEtX3kiO1R2VIZK8lcVpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfLCT1f (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:27:35 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42844 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfLCT1f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2019 14:27:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id j22so4417483oij.9;
        Tue, 03 Dec 2019 11:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zr7PO32uOy5D8YwNgomoY3arozHA4IfHGCcBotb054w=;
        b=WNsFZZgWQ/iKULntAYhjPgeKtcNsSUTdxkPgKw1rx1iiw+Qr9617Su4T1qDp1cEf5p
         GEGXYAVj53XDQALcD0Y45TJ0wH0tymJJpIrGuYFuo+EEAFjwHCojkE91rdQdb3Z+5vq9
         /VJ4dNJKV9E7sgyM2Put8Ghe8hUatjmX99muzz1vyVPSYpUUVHsup8e2hI8JGQ676DMK
         a9HhRGMyDTY9MrqaVuGiDDfZIgzASWGI3PRjcAstDNfMKIZvqHbTEjdmVbIfWvGxr2sw
         NxM6OZsU3RB55yb+kR7B6bZLniJc2W/9a2LvAa1IwOkihQLEucmfwBAjz9+DCUmCZ55h
         F7iQ==
X-Gm-Message-State: APjAAAXajg8E+wSmM6S2jNl/u2oKy8iD15RtCY3JSAyETDtp5cicQPyI
        GIDFwYIMmtTswl2vGOeHCw==
X-Google-Smtp-Source: APXvYqwBpLszr2ZMq6k6wfrz9fB2KVZNnhLtQp0sCvxzYzi2F8Zrz1hDWGG5mcQQI84DY/guTt2fOA==
X-Received: by 2002:aca:5dd7:: with SMTP id r206mr5215502oib.3.1575401254447;
        Tue, 03 Dec 2019 11:27:34 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u26sm414885otk.0.2019.12.03.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 11:27:33 -0800 (PST)
Date:   Tue, 3 Dec 2019 13:27:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, mark.rutland@arm.com,
        kernel@pengutronix.de, devicetree@vger.kernel.org,
        festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH 12/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken
 binding
Message-ID: <20191203192733.GA24286@bogus>
References: <1573816606-26779-1-git-send-email-haibo.chen@nxp.com>
 <1573816606-26779-2-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573816606-26779-2-git-send-email-haibo.chen@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Nov 15, 2019 at 07:16:46PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add fsl,auto-cmd23-broken binding.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> index d50144f5f1d2..a776f418a028 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
> @@ -43,6 +43,14 @@ Optional properties:
>    property allows user to change the delay target for the strobe input read clock.
>    If not use this property, driver default set the delay target to value 7.
>    Only eMMC HS400 mode need to take care of this property.
> +- fsl,auto-cmd23-broken: disable the ACMD23 function of USDHC.
> +  This is required for eMMC on imx6qpdl/imx6sx/imx7d when it use ADMA mode. Because
> +  for these SoC, it do not support the ACMD23 completely, only take the 16 bit block
> +  count from the 0x4 register (BLK_ATT) as argument for the ACMD23, the upper 16 bit
> +  of the CMD23's argument is ignored. This will impact the reliable write operation
> +  and the RPMB block write operation, because these operations need to set the bit 31
> +  of the CMD23's argument. SDMA mode will default disable the ACMD23 mode. SD card do
> +  not has this limitation on these SoCs.

Use the compatible string or perhaps the version register like the 
sdhci-esdhc driver does.

Rob
