Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1E0C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 16:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031D2073A
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579105839;
	bh=eBGLvhXJudq8c8ns1iD/SjohF++SLfZwoKDFp3HQgcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2TNbQK/eic0FdtynqTxmUAQ770Rpe/YsjSCRMoaIsczEjVmCkDD7Me7IK0vhZZMvK
	 18mTkgZXqzCOIMmzxkamJVPXeObtKM0d61UJ0+qU0JhUfetGXnfJbS5v3n0TH+Qvhu
	 EiuidbFsOG7juQ0RHiNdHotaTPbK83cQ0G0Y5Op0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgAOQai (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:30:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33391 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOQai (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 11:30:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so1115117oig.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2020 08:30:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUBHE4XJm85NFA8oPl1FMyCsYkpngZCS0u/hs5fFTfs=;
        b=mScLcGEFUtlMVSmGl6t1S4/twRpIkFZmkOz+LKolCYJ4F0klSMZpa2JBFeNPuIQKoT
         mra/jSo/mHgiSx4neKGJsdLl6m1nwQzJbE0fhbSooxZadeJanJZDOg+96tnr3S49cFer
         Gt4hXFF6o7H5QLti6qw2QTY6QHM5aEBhPfb32hm85+77B31I4htlnTJxEW34TVNlsZR7
         XeoREverTl1FZnCjigMuw/i2TQJWleWjlaGCSBC1V82baZ101XnQ+YhfrCm8sRPRLlnn
         6vtlE7LBTt1IJSDN42gE/xduxluOGNp6KXzFfbVdu6PvCqeznX1GYsJ+WwzDRV5Uycbh
         YVhA==
X-Gm-Message-State: APjAAAXEBgsB+WTiFSsRCuNS1eEx40jA7tXj9F/OL9Fw23gfTAVNJjGa
        oXyjYMk+/t4qi7ugsgEBe2GiEmU=
X-Google-Smtp-Source: APXvYqwh8JJWrukn3rMLR77+iL5dsCIdZN+rewL5FhCXTNsYFBLSXJHp2MYvMsMXI73GTweiJeS5sA==
X-Received: by 2002:aca:3846:: with SMTP id f67mr334637oia.61.1579104025627;
        Wed, 15 Jan 2020 08:00:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r205sm5826525oih.54.2020.01.15.08.00.25
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 08:00:25 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22093b
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:42:50 -0600
Date:   Wed, 15 Jan 2020 09:42:50 -0600
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
Subject: Re: [PATCH V2 3/7] dt-bindings: imx-ocotp: Add i.MX8MP compatible
Message-ID: <20200115154249.GA15419@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jan 2020 13:33:18 +0800, Anson Huang wrote:
> Add compatible and description for i.MX8MP.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
