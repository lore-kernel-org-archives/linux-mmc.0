Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A31CC33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFD324679
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579102830;
	bh=LO6jBHx0Qg0IGkxsz1n8OGdlToRNahtGS8nMe738bSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=shEqKn9i+kaO97gB3/4RyrWc316m1HaYM146hFDOW2vU1sJDG2LqUdiEFLbrxuLmD
	 2PsiwMrrSFSlMZkqidTpMiw5xSyxqeoj9bT7r6RULrn4kg2FCyEgTk+f/WuPkZkinh
	 XEnX4RVbmPfoswWhZu/cJdEpelo4quxfg4Fd6T3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOPk3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:40:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43125 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgAOPk0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 10:40:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so16426056oth.10
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2020 07:40:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h8tviBIGxzG0M2SWVlzB/ZX7WYO/ibSFmw3TBS+98tw=;
        b=uP910g28bmPKkk3tlW+8HcbOC0lhjEpvubUlwcw+7XNl4pUJwvviMD1nWD5R9ilpZZ
         bHBCynU90+2eGqgkRJFuuWKj8pATRRBh2nGZBHC2T9vykPare9swEARaor8YQGr8Ybjb
         U8c+QUt/wzzKPD4mCHHwZ17VOP5u/6c1nAQEFiq+xpCsVrTPu7X/7mbx7pw6KcU4zGgq
         yGc5Jk7LeqYqCEbjh1NnIijHp9+FzvgkecHPG0S/zqAn39pyVB4koFlB5C3Zu05w/QEI
         xXeFZSA9ldxSTARPgyxco9oXxVswPj6bmt9Qp0kzwgwNya8ABW1b6Mt4+qDjteFpFGBT
         +tJg==
X-Gm-Message-State: APjAAAVcxaUMVtPgVK6IRliyZHT0hu1iwAGTLj9aX815Ltu4jETQvw1K
        xBnTvCweiOuefLQm0e+f8C06Wrk=
X-Google-Smtp-Source: APXvYqxGK7ln1qHpDtYMCFGozyouUGXTvW9Wxz2JCzOnYq+ByJOWHh+CKjGL6C7gPF79lgg+crB/VA==
X-Received: by 2002:a05:6830:1e46:: with SMTP id e6mr2994790otj.245.1579102825832;
        Wed, 15 Jan 2020 07:40:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm6554622otq.19.2020.01.15.07.40.23
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:40:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:40:22 -0600
Date:   Wed, 15 Jan 2020 09:40:22 -0600
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
Subject: Re: [PATCH V2 1/7] dt-bindings: fsl-imx-sdma: Add
 i.MX8MM/i.MX8MN/i.MX8MP compatible string
Message-ID: <20200115154022.GA10946@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jan 2020 13:33:16 +0800, Anson Huang wrote:
> Add imx8mm/imx8mn/imx8mp sdma support.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
