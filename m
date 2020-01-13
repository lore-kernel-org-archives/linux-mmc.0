Return-Path: <SRS0=rMqt=3C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4048CC33CA9
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FADE214AF
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Jan 2020 21:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578952211;
	bh=4bLAkwPUPzdXlAHdorU0yNPmSzIzFNXzZyF9iMgLKIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QxnsJIWmKWGM+/EGgR29n9GGHonE+Qoc5Z2Fa8x+apFszLBJQRP49yWvZG/E+8LOI
	 /RJqyHTXO0OmPSDGZrDlCSVyOjThsWq5QSixlFY9gRSF9+G9nwpFqwZ+6LWEtMstiZ
	 pBfhKdTGYcrJG10xx3E9In08jSXLWZuYcJatBV84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgAMVuK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Jan 2020 16:50:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35801 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgAMVuK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2020 16:50:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id k4so9854873oik.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2020 13:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pxveT8kmVAy+6NNs/m6VYBrLz6raLXBMbZxaVD7AKwA=;
        b=CrVjje8OQVeq4mFBu+s973BXsmJ5yQmUp19BkmcUxmyrWnwV3c0zlpJOZv01rTsRZ5
         rVMfxC/phM0XJ9FVcg5lUvTC00K8dJqrOjDzmzExLjEYmMTY22YcyfT0wFrxqkY7gXcO
         0D+UL9c2D4qJUnlSpEsFeM51JZ1vHrDbPOWzOsQW8n7IB/w03L3/a4p/jY5gP/6FbgL2
         hZFHfFhIPwQ1OIzsOCHfYtXV9f9j291HsDJRYdPkXePg7X6X0IGKBJcOOvhfYoYFNsVQ
         9IE0y61FXrivqlqaPJeNpmbpg/rRSd55m76Hde20cgxkCuZjogXAYR1j9yAIh3Bc9h+l
         10vw==
X-Gm-Message-State: APjAAAUuVlRnyZsNyYN8kcg/vVedW+/BilLKvqEIQc+1AwC9jG+vf7xT
        ke5Gg55/gpIEpdgdDTuvLCvQf0A=
X-Google-Smtp-Source: APXvYqyglyxO4HX7FUHBH89d+xm39F8dzaIHURZc5TSVFnyrEKmik3aeTS5/VaALC41g3Gd5WZNhVw==
X-Received: by 2002:aca:c08b:: with SMTP id q133mr13660291oif.46.1578952209264;
        Mon, 13 Jan 2020 13:50:09 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s83sm3933751oif.33.2020.01.13.13.50.08
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 13:50:08 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22198d
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 15:47:36 -0600
Date:   Mon, 13 Jan 2020 15:47:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, vkoul@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        rjones@gateworks.com, marcel.ziswiler@toradex.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        richard.hu@technexion.com, angus@akkea.ca, cosmin.stoica@nxp.com,
        l.stach@pengutronix.de, rabeeh@solid-run.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V2 7/7] dt-bindings: arm: imx: Add the i.MX8MP EVK board
Message-ID: <20200113214736.GA12301@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-7-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-7-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jan 2020 13:33:22 +0800, Anson Huang wrote:
> Add board binding for i.MX8MP EVK board.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change.
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
