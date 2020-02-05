Return-Path: <SRS0=4knG=3Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AF4C35247
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 17:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8919921741
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 17:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580924976;
	bh=HEIYYcGr13hxh0JA3SJPegUXD5pWC7sQilxmcm/dJSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U5r+5v8zu6DEM3zGjSLeCzRYXxI2taC3YCHHa02SzpbZC7hzEKIugJxJPC43Rw3aN
	 0X/quyTtzwxbZJdFYIsW7VTJ3uhUPeJ/y4WiriYW8XK5xmEIxjF7Inf7JlGuMnWlJ4
	 Fk8uVv6/KAYQIshjLVl93Omf4evvrStGzjzWCnh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgBERtf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:49:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40726 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgBERtf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Feb 2020 12:49:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so3817368wru.7;
        Wed, 05 Feb 2020 09:49:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Lsfbnz3H38vTOletZ4EmB6C9KpZCxglql+qL3XIYGjo=;
        b=pjIRK2NY3jjzO8+3tsKZuZBX/0U6wTbDe3+IQcd6RDKD3JE2GTV49yu/u/6QaccMzC
         kDRNWmZVJtbAZYLzmzVnBGKbRCiIemBTcDLHibA/XmHGW9NpE8Uil/UKubUvSQ86cQbb
         IBBEe+crd0PMv8tWuLy1Ri1t15Sazz3ZXeHBQ2doooD7iDGERSH7tWW48ocs+YoJn3dN
         rbzpGL4ydNv+rQWc3QLh8jHB2xTrXO2H/I6bw77xLAU4PqDUmq/wvyuERe5Tq5ZPiKe7
         zShELQ2nwVCnxEtZ7m/XKMxuhNUNcimUHDDuzMyigyzYD9ilNWyqpuEdL+guqH37tP28
         Z34w==
X-Gm-Message-State: APjAAAUjtWQWCXxfBYAeT8KWVf/1OekCeOsQ9JRvPL5o1mFGgKkNqdH0
        EXKmp9AkjwgXrP+uwBZfIw==
X-Google-Smtp-Source: APXvYqybHL6/b3Oz5I7G0CLuDoP0nfLxsBDQ3ivJbNaQ7/MXHy/EygjBmjdA1/E6DvSGs4NYiVTZrg==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr28065695wrm.278.1580924973513;
        Wed, 05 Feb 2020 09:49:33 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id t1sm335850wma.43.2020.02.05.09.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 09:49:32 -0800 (PST)
Received: (nullmailer pid 29957 invoked by uid 1000);
        Wed, 05 Feb 2020 17:49:31 -0000
Date:   Wed, 5 Feb 2020 17:49:31 +0000
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        srinivas.kandagatla@linaro.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Ludovic Barre <ludovic.barre@st.com>
Subject: Re: [PATCH V2 5/9] dt-bindings: mmc: mmci: add delay block base
 register for sdmmc
Message-ID: <20200205174931.GA29922@bogus>
References: <20200128090636.13689-1-ludovic.barre@st.com>
 <20200128090636.13689-6-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128090636.13689-6-ludovic.barre@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 28 Jan 2020 10:06:32 +0100, Ludovic Barre wrote:
> To support the sdr104 mode, the sdmmc variant has a
> hardware delay block to manage the clock phase when sampling
> data received by the card.
> 
> This patch adds a second base register (optional) for
> sdmmc delay block.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
