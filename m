Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F6FC33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E5924656
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579103487;
	bh=mwQEY3Ww6br5KNOmSwVS7hUcvqZ+uw0UKLzziu3FWeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X450/2NyaFusGGHoYfGLcFfAqEgwEQIjBvwH/dPrD5zAKnxqJTvhrF7ubN0wbEpYy
	 rB0wOQ+SmLPkoe1uUv8hyMr6cdLy+rPmhPMrF3gqkQlw9wO+lFMwCtlYd1T7fTQkxS
	 ULBswnJK3UJ2pwJ0elzkQvMLSYfBdLye1ZK95BFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgAOPv0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:51:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38285 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOPv0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 10:51:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so14376167oth.5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2020 07:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XZ89QzBAoQ2DzrvbjynM5ltUEoPFqx0Q/mdX+QC5z3Y=;
        b=edtTcHVi9Gi/D6OwEM6GmzK7jbJgEwsc8fWaKxMroGjIlro6c3a6QPyddeuJPQfkI+
         kX0bT4fJAWfCDdjDfic53XTI+uwA1Qu23fD3WM3ZNL6voJDS13STL4uMJV64iD/uR1W3
         iFPmTlZlvXnZVhxT+75kKXJ1U02AIARAie8WY0ewsZMQqnPffHt8QjV9vcI5zzRm0d1B
         sbrodmmQfbXwii9itMZtxruyGTeLZO0I4NJ03CDwPsfPQVUmuSAx235bq10HzbaFGRMS
         GGzlwe6576eYGyMAcy1Vp6BVZEZlVXFax6mdVqLcaEVugBCjgsBBF80XM0WhtnGznJle
         k1XQ==
X-Gm-Message-State: APjAAAUkxr3PgmUmwqssMAdjsMCy2nYwXqjk58orVHzU3Fi0v3q2gx5b
        7TCZGfO1l3N5cVXoHRf8Q7SFIr8=
X-Google-Smtp-Source: APXvYqx92EJ4oTGUQ4ezrqrdiZprjdsdlV2QsY3/u2ybaqpV+k/A8NPW2NkZ9OCGwZz1GpUEY7Nh6w==
X-Received: by 2002:a9d:69ce:: with SMTP id v14mr3280768oto.248.1579103485206;
        Wed, 15 Jan 2020 07:51:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l1sm5756091oic.22.2020.01.15.07.51.23
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:51:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22061a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:40 -0600
Date:   Wed, 15 Jan 2020 09:42:40 -0600
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
Subject: Re: [PATCH V2 2/7] dt-bindings: mmc: fsl-imx-esdhc: add i.MX8MP
 compatible string
Message-ID: <20200115154240.GA15071@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jan 2020 13:33:17 +0800, Anson Huang wrote:
> Add compatible string for imx8mp
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
