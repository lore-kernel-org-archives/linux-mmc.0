Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830FFC6379D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 19:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675E522265
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 19:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgKPT2F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 14:28:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40984 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbgKPT2F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Nov 2020 14:28:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id m13so19991489oih.8;
        Mon, 16 Nov 2020 11:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J5xc6rlfZ7HkVMV7Y3cl/fG8HMDEF4/W02PLjaicwzc=;
        b=bK2+aSY8RK1yAZ1UgQ2nsYRg89Mimi9sVRx5kv1NbN2N+4wxBsc2vjLkE6bkxPrM3L
         e0ytPy0JXcbDIhjd2V9i2JSgoBo9e5G4PlWVat6e3iHmXrGetJ2mNR89d6w4XzEf18Mg
         xktNQJkt/Kk8AkXuFkope2bFBhCjyojcHsG03otHvg4UZyOzJhgd1Oco0yD1vv4mMjh1
         e0Y5PHrbIEUSal+5f2hF+a3zOFoTVi0xLnDwqxOh0FIx+9i1387sp6KxGupmidgDRH7y
         pRxJBQUj0RHTZLtNVkFcpL3An+lpQC8Dq0DH1Ak8r7LsfUBlibIUVSEj5MJgDW4GssjN
         RqxA==
X-Gm-Message-State: AOAM533sT9LI1Vo6U/pnlg+lanPhF4nXTuUmY0fOUotomlHPQrhbGT53
        TxmwDjiFkHOEISIJIdofBg==
X-Google-Smtp-Source: ABdhPJx+VuHmhNuk88lWqmW72X8caft5bTSKDVs2hFRYpkVa4mGiEBKMSKP8OWiHJYpybYH5HkXiJw==
X-Received: by 2002:aca:3606:: with SMTP id d6mr146246oia.7.1605554883878;
        Mon, 16 Nov 2020 11:28:03 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w18sm5046800otl.38.2020.11.16.11.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 11:28:03 -0800 (PST)
Received: (nullmailer pid 1996222 invoked by uid 1000);
        Mon, 16 Nov 2020 19:28:01 -0000
Date:   Mon, 16 Nov 2020 13:28:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        irq-linux@rere.qmqm.pl,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Krishna Konda <kkonda@codeaurora.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add optional cqe off properties
Message-ID: <20201116192801.GA1991505@bogus>
References: <20201112075208.28183-1-wenbin.mei@mediatek.com>
 <20201112075208.28183-2-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112075208.28183-2-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Nov 12, 2020 at 03:52:06PM +0800, Wenbin Mei wrote:
> Add optional properties for cqe hosts which are used to set cqe off
> during suspend flow.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index b96da0c7f819..457c9a84b988 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -164,6 +164,13 @@ properties:
>      description:
>        enable SDIO IRQ signalling on this interface
>  
> +  cqe-off-in-suspend:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      After suspend, the mmc host is powered off by HW, and bring CQE register
> +      to default state, so we add the flag to re-init CQE register after resume
> +      back.

The driver change is before suspend, but this says on resume...

In any case, this should be implied by the SoC specific compatible.

> +
>    full-pwr-cycle:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -- 
> 2.18.0
> 
