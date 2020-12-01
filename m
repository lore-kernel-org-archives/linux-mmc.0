Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B816C63777
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 01:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A8A20857
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 01:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731270AbgLABkI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 20:40:08 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37203 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731265AbgLABkI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 20:40:08 -0500
Received: by mail-io1-f66.google.com with SMTP id k3so12969ioq.4;
        Mon, 30 Nov 2020 17:39:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qLB3vdKxy2vcnjvV215mG3854zoOabRvrGls/BFjR9k=;
        b=eNtbuEvh2vgqH9YU1+DHlFJZep8JS+0piddU+c/cwxFN8bntJShGnLSZbgWO9aOyTv
         m4bVndpE6jnUbB2mZkVuwXxvtVfRtLfE4QZnS0GHtuIYcnD801J8h0b4OcGRNU700fOI
         2ERPyNAclsHyXqbg30urQuITsyPxh0Heu8lmBQxouaD23tKh+U4mcCm5uZG41L5122/q
         yL4tji0SpsDcMfry5T6MEnZKPh806MxlNrRz1mGhGIobFaGvdqckT2y+ce5xTuv3sDmU
         xjuROrWRC8QfFy1n7lw+omDlOhgpIgr+Ov9IlRNX62LHOao4GPAAAfJjAJqb+jpz0bvA
         g+xg==
X-Gm-Message-State: AOAM531LaQJqqWykS5nbN/kjbxEM0g+FAL1JZRImI3ew19en3sxz/HWJ
        wqG7BLDPDHhAC7EvKEKutw==
X-Google-Smtp-Source: ABdhPJz9iPtK4j1t628YSI3FSb+ajoN791OPOAa3Pr28N/9TL0CxnKjD2t1UM35YjHjiH+VH2/2hWg==
X-Received: by 2002:a5d:84c4:: with SMTP id z4mr583147ior.26.1606786767618;
        Mon, 30 Nov 2020 17:39:27 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id y8sm200692iln.12.2020.11.30.17.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 17:39:26 -0800 (PST)
Received: (nullmailer pid 3447641 invoked by uid 1000);
        Tue, 01 Dec 2020 01:39:25 -0000
Date:   Mon, 30 Nov 2020 18:39:25 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v4 02/18] dt-bindings: arm: fsl: add imx8qm boards
 compatible string
Message-ID: <20201201013925.GA3447610@robh.at.kernel.org>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
 <20201126105900.26658-3-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126105900.26658-3-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Nov 2020 18:58:44 +0800, Dong Aisheng wrote:
> Add imx8qm boards compatible string
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
