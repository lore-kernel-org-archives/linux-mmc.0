Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779BBC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 06:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D14520578
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 06:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598251149;
	bh=MyyKKdBO/+qD0f8RAKFRcTsyVNJvUS/6l/chUps8zKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rIze/wUpAV269YgmyHI94nqy2xpOwihqEZsj1rN4xtVOdfnM8+dXipcfy/i8+r8yK
	 Fo22SrPAq7+SxCF2LUykkK8h1oqjuYhjKVlQdP5SA5s2OWTEYDSkM2BbwNPtmpH6XK
	 8HJPHljwqGndGmXVomqLaFBBRvf9M8PBFl+uR7Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgHXGjI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 02:39:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35298 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHXGjI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 02:39:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id b17so6685476wru.2;
        Sun, 23 Aug 2020 23:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4XWaFvWmHT/RUrBudpI26Cm6Fut1CRVWYNLopidhfR0=;
        b=aKFOOdoCaiOcRMuXuTHdkuUjkTYpcEd3lnpAD0NXDAZPu+zheWkBx6XKN5gb/qdHoh
         cgmqvHh0YXTTNUY3BYzLi8IEXOJ3BSphPcWU2cTtI3g4pvI3KJWx3V0reHQBmYCmAdDa
         cVS9tSKgBhAeH4ZZMQ8fJ6Or3yQljCIXEuLl5rjBd59BRFtHHZhSAIResKbNgLxZpDY4
         /bJD9KHg+Nl3+CeqfaBk4/WGveSWEGVzw9yvgdo2LJwvxQWvlj4GfVtoKM7zj7Y/t8To
         8dc89o7tq8/LTvQFaRe9wXZk4lzquADGRzz9kzvJH9MGzLf6dI8GM16VS5ptyR6zrzBJ
         3bgw==
X-Gm-Message-State: AOAM532am0EIVxZ/dEe9MiqPEcCxVChA287ql52nJwxoIHQWMrMZt0XE
        A1ceRXG7cZbaW6gmPsz8EcI=
X-Google-Smtp-Source: ABdhPJyewo/egAIaWx2hIan9ejp0R57MKJAQtZl2+4y1UgdN/eYHM6xy28KSddVF059VY/eXTpmMmg==
X-Received: by 2002:adf:fc52:: with SMTP id e18mr4402374wrs.185.1598251145633;
        Sun, 23 Aug 2020 23:39:05 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id u7sm21278681wrq.89.2020.08.23.23.39.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Aug 2020 23:39:05 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:39:02 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Anson Huang <Anson.Huang@nxp.com>
Subject: Re: [PATCH 07/22] dt-bindings: serial: fsl-imx-uart: imx-pwm: Add
 i.MX 8M compatibles
Message-ID: <20200824063902.GB2497@kozik-lap>
References: <20200823161550.3981-1-krzk@kernel.org>
 <20200823161550.3981-7-krzk@kernel.org>
 <20200824054601.GF13023@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824054601.GF13023@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 24, 2020 at 07:46:01AM +0200, Sascha Hauer wrote:
> 
> The subject contains a "imx-pwm", presumably from the last patch.

Ah, copy-paste. Thanks for pointing this out.

Best regards,
Krzysztof

