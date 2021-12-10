Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5914DC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Dec 2021 22:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhLJWKn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Dec 2021 17:10:43 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:41653 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbhLJWKm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Dec 2021 17:10:42 -0500
Received: by mail-ot1-f41.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so11019019otl.8;
        Fri, 10 Dec 2021 14:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+geyFh91mJ5V3Y44vs2eSC79TWdCLGhZIfhEU1MNhC0=;
        b=2vhlohziQZ+cHSiNuvk9KrgWfVkvMR27OmjzL0ZdHKf/BT6q7DVgwoobE8Zdd8wNfV
         TRgbeF2zIy8vP3xCM5H59z9B4HXTIdcWv9ofyqpvERXvgKFLEELNIEIFfdz1202EB2HY
         CzCc08dUeHeYzCilat6dnoWPvKijsk9VBZHBLLMiJTIbChnGbZvvEiGjtUCu3x/1//W3
         A7x3mXkZbb1Eevr1iFHUYiXFljc6WfME2niI00QZDUn6iVcBzRINbDulXoBtvnoMgyoJ
         KsByWibQLI9ube/tTyY/PgdNC2E6G/hK6KwBJiVfBHsQFrFmpPGvOZEZoCTGFX2YV1e6
         CmgQ==
X-Gm-Message-State: AOAM530dTi7xxpjDp4zfYivlNFGAYhHX4gjFqVHlFe6rPsJlcy1+vy8k
        GEi4jYgZ8Bg8FA7L6Zn62Q==
X-Google-Smtp-Source: ABdhPJyDvnoFBv3NrqUYd/bYltgaO870OTAYYafWKCFdS267jASwQYxRSEh0cuvDov8+E8ICPRhtQA==
X-Received: by 2002:a05:6830:1d67:: with SMTP id l7mr12845464oti.277.1639174026680;
        Fri, 10 Dec 2021 14:07:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w19sm921238oih.44.2021.12.10.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:07:06 -0800 (PST)
Received: (nullmailer pid 2012324 invoked by uid 1000);
        Fri, 10 Dec 2021 22:07:05 -0000
Date:   Fri, 10 Dec 2021 16:07:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@google.com>, kernel@axis.com,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: mmc: exynos-dw-mshc: Add support for
 ARTPEC-8
Message-ID: <YbPPiXh6GgJ7iHQZ@robh.at.kernel.org>
References: <20211209205456.11027-1-marten.lindahl@axis.com>
 <20211209205456.11027-2-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211209205456.11027-2-marten.lindahl@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 09 Dec 2021 21:54:53 +0100, Mårten Lindahl wrote:
> The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> does not support HS400 and has extended data read timeout.
> 
> Add compatibility string "axis,artpec8-dw-mshc" for ARTPEC-8.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> 
> v2:
>  - Change compatible string vendor prefix
> 
> v3 -> v4:
>  - Add Krzysztof's Reviewed-by tag
> 
>  Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
