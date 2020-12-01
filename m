Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4906C71155
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 01:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538F22085B
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 01:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbgLABlH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 20:41:07 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:43919 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgLABlF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 20:41:05 -0500
Received: by mail-il1-f194.google.com with SMTP id z14so101415ilm.10;
        Mon, 30 Nov 2020 17:40:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tS+akVXCXQeo5clvNOOFrqcagg0b7+JKhB3morgjsO4=;
        b=OszfUUrofoRx/xBYbzWTfOmyUUxZlEV6LP0RhGLt6cXm+vAhICU7V3khZBozHAbe7N
         wc1J3bRDoPrBbCWIfIxhRkqt8Y0efCG54rtw5nbLLsvfMUNkdHxNQQObLOSfQy9+m3bd
         D9xsDXhGjXkJyHaBlmKg9ChJkr9AZaSY/odYWVwywi8OtuBjH/7Zedv7zm1tkh+vQmNt
         Fsd66y3VHL01w6tgM0NaQmcq5/KNZJTmiys/gtOj02E2k2wg7rMv5nK7NWOd3jyRdUnY
         ZcFubSDT2OcTCpXoYCspp+52QLlSx0AibzQoCiRtpjqC1sthR5HVN8lQumfTAjB1Z/Gt
         PhjQ==
X-Gm-Message-State: AOAM531NgdSxoaFb1yQPylypaeJ59GqFaEUutLNXuWwWs16RhC58Wmwj
        puGpZgNnwZvKhdzJF/KiptojfIfrnQ==
X-Google-Smtp-Source: ABdhPJyO9V0PSoCoEdWgEM/khWUk9iPvFlLurxSewZcp74f39RaIQqRRq8hz7+qXOJIPjRP9EeXQDg==
X-Received: by 2002:a92:cd43:: with SMTP id v3mr545988ilq.58.1606786825067;
        Mon, 30 Nov 2020 17:40:25 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m12sm193738ilq.51.2020.11.30.17.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 17:40:24 -0800 (PST)
Received: (nullmailer pid 3449338 invoked by uid 1000);
        Tue, 01 Dec 2020 01:40:21 -0000
Date:   Mon, 30 Nov 2020 18:40:21 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v4 03/18] dt-bindings: mailbox: mu: add imx8qm
 support
Message-ID: <20201201014021.GA3449286@robh.at.kernel.org>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
 <20201126105900.26658-4-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126105900.26658-4-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Nov 2020 18:58:45 +0800, Dong Aisheng wrote:
> Add imx8qm support
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/mailbox/fsl,mu.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
