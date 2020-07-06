Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26277C433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C0D206E6
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="taqKJ3OB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgGFOuF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgGFOuF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:50:05 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33D1C08C5DF
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:50:04 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a17so9833138vsq.6
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWA25aZsg+amDOJvt4Y158PEbRGk+vCsxnKr+qd7EXU=;
        b=taqKJ3OBsVxei3aYyQpx5E7jAO+c1xVScXydVxtz+3dHOGbroJQYL2n3DOlwxJKzKs
         Ouh0ocprkUbxvvDhnFX3mOW7itQeN18QlyQPR9ViQuihWANWXVwzs0XcFq3Il0omKTd0
         rnFJEXbqLgNILJf/LvtWVnER9c8BBEzTqmGHfUouCPej5YWpqxus3RAxsF+YRw4r7yeg
         hstbRwZJNQ35po06x1VPte01xdU7/Krn8zqZR20t6O65tB0PaY4zxV2Mq/CQ+s9CrUdk
         2uvqdo1jp7/DbNX8p+WrRWjuQvoWBcOLffugp10y9AwsF65NstPUP37Br1k/mHijY374
         rnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWA25aZsg+amDOJvt4Y158PEbRGk+vCsxnKr+qd7EXU=;
        b=MV++bRNMsObJ9uQjt5sItjgM6OLugqJw2NqKeQ99wqsXBxA08D7sTjiVg15a/sbrqt
         twilZn7Send0R0BOMK0Hb2WgEGNTpyDeo3+SqNKA2NWBOABrbCBrty+KJwdRe1R9FvGY
         T1Rqh9ve3QVgDpfC6CCAkCQd+I4+DtGhI4zBmevAB2p49vxPDbfUrOdoIxPuKQckOzAW
         tb+Yb60kq+GDamKXVwEoN/HF+5jXIFOtyFqa56mMSfoJD045sQGB4DDvHOX8dFXDTyLM
         UQJ+IvPKQvQCxqatoKRo/4N/B+/8yi4BZVmZ6pKGgxTvavfgAv8YF20iLkhk4LYW3z5w
         f32A==
X-Gm-Message-State: AOAM531LP/Q2Guglb7AJlEZcQ0kJTnW5JsafcgcwtToudeUUYMITmn+/
        rgUDD4YZDPNT3aw7KY4xLyqen7+3apAKD+/ifGqnAw==
X-Google-Smtp-Source: ABdhPJxp7EQdsYXKyXmIwNKtH/jXmN/JFTTqCw29aNQ82/P1aOfsCs80wZaC7wnclqEWyJePDEkpHKIZfvV8xexmmqk=
X-Received: by 2002:a05:6102:126a:: with SMTP id q10mr18466459vsg.35.1594047004092;
 Mon, 06 Jul 2020 07:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200630223655.2627-1-l4stpr0gr4m@gmail.com>
In-Reply-To: <20200630223655.2627-1-l4stpr0gr4m@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:26 +0200
Message-ID: <CAPDyKFqS6Ew2Op1qx_YHMCd0qFmRm_XtUQrgdWLY_+v0kxr8pA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-sirf
To:     Kangmin Park <l4stpr0gr4m@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 1 Jul 2020 at 00:37, Kangmin Park <l4stpr0gr4m@gmail.com> wrote:
>
> Fix unit address to match the first address specified in the reg
> property of the node.

Rather than fixing legacy DT doc, can you please consider to convert
the doc into the yaml format instead?

Kind regards
Uffe


>
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-sirf.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> index dd6ed464bcb8..61185bbfdf9e 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> @@ -11,7 +11,7 @@ Optional properties:
>
>  Example:
>
> -       sd0: sdhci@56000000 {
> +       sd0: sdhci@cd000000 {
>                 compatible = "sirf,prima2-sdhc";
>                 reg = <0xcd000000 0x100000>;
>                 cd-gpios = <&gpio 6 0>;
> --
> 2.26.2
>
