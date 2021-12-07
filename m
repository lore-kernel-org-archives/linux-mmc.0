Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445EEC433EF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Dec 2021 09:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhLGJoS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Dec 2021 04:44:18 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:36976
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229485AbhLGJoS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2021 04:44:18 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6D3663F1F7
        for <linux-mmc@vger.kernel.org>; Tue,  7 Dec 2021 09:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638870047;
        bh=7CSWGrt6fvofgfSt2AEImcKHomEx+COW1Egj1pWf4eg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=bmPr9PwPzkoeaVa6M9pn2nIA8M/mNubG9X6I9XSTYnVNFYT90tMSo9T8DT6EmP5q1
         vYmESsUWpWN3BQ1O7xa42dGQHVmHsxUz/aBOQ6bIpQe9M6V7p7nu4RRhbufeSsbJHs
         U+90iVSsMLsIONU9KAGtyXNwah/UsxmtCMVAOZ9YxE1n/IoX3p1cveVxEUWidadW8R
         IrvSXDlwFAwjFMCyYeGsEevHa77E262hUE/aAvBBR/aPfq5TfNBbNi/aerRviH56Pr
         Om1vk+U0I2vmdYA6a6uNcKKWrptzCCnt1adXOAOM4BEaH5g2P9cz23z2Ff3hxiG1Rs
         ynNW8NpFj6X6Q==
Received: by mail-lj1-f199.google.com with SMTP id q64-20020a2e2a43000000b00218c94eab9bso4316515ljq.18
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2021 01:40:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7CSWGrt6fvofgfSt2AEImcKHomEx+COW1Egj1pWf4eg=;
        b=5I0OaOKkUOS1ki/A5i4aQfvZQYb+SfET/j+rd7K6rN1ZQ6lWgcuR98I0MsCCf+tJ9w
         IIYLHpENcQx0BepdLJOLPxilxRR5avA16JVQELGEZhu6UC5T0kGrnnzWYC1JG+aEt50M
         DFkQwtrKAajfgEX86geNEDCYOXHckdd6BD9FWcyJZQ63f6COiLJBCgA8q4dSqsyyGFdw
         Wj1n2qZgwD1+ZZtxeOWyYuqq0PYrDqJkLnuGkdsNb02pqMi2fIr+4b4AgwBlfwGZ7EW5
         7SiEYggpfbu4Yi6SDouoGwCwug/EsK5idmYynRYvs1LEZIlAQ9b3LJujQXKl7bD0JM+E
         OQmw==
X-Gm-Message-State: AOAM533noTEGbK+YcvgdoUGcnQnpdfWtcwZFSnDcOfsuINvNhfgjZAcJ
        hOs62/pFk60zYLV2FCeQq3xuUlGC2mHWjrxYL8GFUS9pGalx5JM89sXXTUf4Traa8vxEcfapI+N
        H69bNGxVOYuUGxHKjGBIbwX+vQ92uYvjMQtO1Dw==
X-Received: by 2002:a2e:b742:: with SMTP id k2mr42256386ljo.107.1638870046675;
        Tue, 07 Dec 2021 01:40:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRdcrfzbvimMwkeuVfULbIfxDL3rJ1tOLR+96tOIKmVrzRmCTfgrfu0jng1eGwC4aY0+onTQ==
X-Received: by 2002:a2e:b742:: with SMTP id k2mr42256364ljo.107.1638870046485;
        Tue, 07 Dec 2021 01:40:46 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id s4sm1594356ljp.73.2021.12.07.01.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:40:46 -0800 (PST)
Message-ID: <8dae2a2d-4f48-ab31-7a12-292167db1ac9@canonical.com>
Date:   Tue, 7 Dec 2021 10:40:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v2 2/4] mmc: dw_mmc-exynos: Add support for ARTPEC-8
Content-Language: en-US
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211206142929.26729-1-marten.lindahl@axis.com>
 <20211206142929.26729-3-marten.lindahl@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206142929.26729-3-marten.lindahl@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 06/12/2021 15:29, Mårten Lindahl wrote:
> The ARTPEC-8 SoC has a DWMMC controller that is compatible with the
> Exynos 7 version v2.70a. The main differences from Exynos 7 is that it
> does not support HS400 and has extended data read timeout.
> 
> This patch adds compatibility string "axis,artpec8-dw-mshc" for
> ARTPEC-8, and DW_MCI_TYPE_ARTPEC8 is added to the dw_mci_exynos_type.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Change compatible string vendor prefix
> 
>  drivers/mmc/host/dw_mmc-exynos.c | 47 ++++++++++++++++++++++++--------
>  1 file changed, 36 insertions(+), 11 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
