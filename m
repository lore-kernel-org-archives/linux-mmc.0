Return-Path: <SRS0=6MuA=74=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D591C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Jun 2020 16:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C37B2078E
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Jun 2020 16:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592239309;
	bh=Sg9pbTBM29sML7ioDwEww4Qaaa7omQvS8yZyfbKVLPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A+0wH6aoxGEbl5WK/s97NIBc7eAN5JTPi/pdMJudfRe/llOkDuSKzYm1GVUFBOPZw
	 5/zxA28MN/FVhrx8y+8MAWMIBGyTzl0vGttG5Z1KvH64n2V6dj5s56KzrQq47Zabfi
	 CTJXKRVAhSNcT5c98+9R7Qg+gyOF1qMDP3/gM6yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgFOQlo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:41:44 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37841 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730985AbgFOQlm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2020 12:41:42 -0400
Received: by mail-il1-f195.google.com with SMTP id e11so15914850ilr.4;
        Mon, 15 Jun 2020 09:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Urph/U1UKzR1PGfVK4c+aNc5CstzpffUrGS0jzQZrg=;
        b=NWOFhuynPH9TBcqI22lYfH9Y8BplE/rJ/75sF3nhHZSWGc5lGXlSw6WCVnOsyE4N8c
         Rd6x+5IJZDc/mxrsyFf3FWwIl5eWbZfoaP5aB5H/63K04kCz04OY+UETq7F6kELlgxVL
         YltXUe9cSlkktKV4p5JTpHDups5wDgIy2gCIFZG9FN1WBX5/SHb5iqWTB1GxDRvwomfd
         fmPf5DOld6I9iV4FWVj1yWZAbnSDHbdC3JkxugL0eLWoN8uGpJstj6e6KPDOwJYHbBUC
         x1Qrwkrox+WBidDYUNPGT6PaZqWa5ax/oWIrymrFNl4Hx08dpQ0e2zEGuCdfPaCc5Fvr
         sYDA==
X-Gm-Message-State: AOAM533ACBNglswbY2qrmTzcJBtw8xkXK3IScFisCSJloUYlLWpG098d
        7kAB1B0Hi3ylx+GpGyJA6g==
X-Google-Smtp-Source: ABdhPJzR+1azivHuOTLfcrjgVgEufsot5KpaUT3Obr+FfX/SVPDRyiHptwaIbAJrewGwD3KKNi3pSA==
X-Received: by 2002:a92:c985:: with SMTP id y5mr27865848iln.50.1592239300220;
        Mon, 15 Jun 2020 09:41:40 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id k185sm8463534ilk.16.2020.06.15.09.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 09:41:39 -0700 (PDT)
Received: (nullmailer pid 1922706 invoked by uid 1000);
        Mon, 15 Jun 2020 16:41:38 -0000
Date:   Mon, 15 Jun 2020 10:41:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     festevam@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Linux-imx@nxp.com, ulf.hansson@linaro.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, kernel@pengutronix.de, mpa@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org
Subject: Re: [PATCH V2 3/3] dt-bindings: mmc: Convert mxs mmc to json-schema
Message-ID: <20200615164138.GA1922410@bogus>
References: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
 <1591234886-15351-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591234886-15351-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 04 Jun 2020 09:41:26 +0800, Anson Huang wrote:
> Convert the MXS MMC binding to DT schema format using json-schema
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- add "unevaluatedProperties: false".
> ---
>  Documentation/devicetree/bindings/mmc/mxs-mmc.txt  | 27 ----------
>  Documentation/devicetree/bindings/mmc/mxs-mmc.yaml | 58 ++++++++++++++++++++++
>  2 files changed, 58 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/mxs-mmc.yaml
> 

Applied, thanks!
