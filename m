Return-Path: <SRS0=abg9=DX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC17C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8701920848
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Oct 2020 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602865111;
	bh=Xb7Uaiy7eEHw3kMmpD515qhsljHRz5tgSIRBIfmrlZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vPi4JUFxxyfTkLQev6lJk3sRnZL1O8ZdOUadoYm8ASUdk3tfzrBx1K8A5dxwy+rpY
	 hSmT25xIMwddiswkWIcI1VsiJN1Zt+zgxmID5rMTawME2IVCMzciN0P5HxapMfNQqn
	 H9igepxNYgnYoWELgWDHJx+OKAtCipudWmkoauWo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409908AbgJPQSb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Oct 2020 12:18:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36158 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409855AbgJPQSa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Oct 2020 12:18:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id u17so3037400oie.3;
        Fri, 16 Oct 2020 09:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uISo57yfUZpTzroMJhAVgeLo1/yelMiKsufW7Z+pWqo=;
        b=m/FHxZAjzDw6+iURm5HXzRFnzv/1zD5JWvP2f4eMso4nTlQ4MTQKWoKUCdQnwaC5Bp
         kdn4Q215XDh2i4xVHqfNXVvYX3ydimglgp9yUpPBAJ0wnr9bH05fftUrdLQ3toyJ0cnp
         mleZ0bejFAOo0B/xSoTP47Kz60gOAjtzZEDsbnPBOp+Jh/W98/LvSlDBT7bSYZIOeR70
         i0FneXckXDOR3H8BJDp4F9t4RZc1ntPMvSOtnF904dQNcuOTiaWCnV05bzHzYTXogUuS
         fK4aflHqG2sGP0ExNU/rPI+A2n8YuhDZD8LQVIDbpNoqlr+qCWMDsjkTb0Bh1mGdDqoK
         ZObw==
X-Gm-Message-State: AOAM5314dMmyG5lv4Lnj+YgMVaB3cRqpU5GaUHwD5c8KuYXtMzlioHyp
        DOe4/Lx1oGbYrkbrYmVcsg==
X-Google-Smtp-Source: ABdhPJxXWV44wqWW/P4G+jW/m/jxEn6yv6aGQSaC4SmYzaJjQxINSxxLka7EviDs9inU1aAGasqeyA==
X-Received: by 2002:aca:aa08:: with SMTP id t8mr3126702oie.129.1602865110271;
        Fri, 16 Oct 2020 09:18:30 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u22sm1266354oor.13.2020.10.16.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:18:29 -0700 (PDT)
Received: (nullmailer pid 1517766 invoked by uid 1000);
        Fri, 16 Oct 2020 16:18:28 -0000
Date:   Fri, 16 Oct 2020 11:18:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream@mediatek.com, devicetree@vger.kernel.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 2/4] mmc: dt-bindings: add support for MT8192 SoC
Message-ID: <20201016161828.GA1517686@bogus>
References: <20201014030846.12428-1-wenbin.mei@mediatek.com>
 <20201014030846.12428-3-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014030846.12428-3-wenbin.mei@mediatek.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Oct 2020 11:08:44 +0800, Wenbin Mei wrote:
> MT8192 mmc host ip is compatible with MT8183.
> Add support for this.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

