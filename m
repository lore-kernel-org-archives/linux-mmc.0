Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A14C433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 05:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6204207EA
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 05:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599111555;
	bh=jAExD5YbN4NOCVCuOzux7zGEA6oKWHOZzpnXunrpQVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yUXyJdjK53s9gLGgehM5Amw0crPlxbLidQ/O28IV4VyoDG9stJxWTzthdc8qP52me
	 E0ld6X3wU6hbWl/et/TV5UPKG9ywHQ6r30HHybOhquU/d0pfV85wpHo7C79te7h8Y0
	 vs0JQUy6BGUsXVxFc4zZXqaPFk2TpdA5n6JWaMDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgICFjO convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:39:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43331 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgICFjN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 01:39:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id k15so1688051wrn.10;
        Wed, 02 Sep 2020 22:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cjA1SpxFdTarFmkqi5x6o7EpaRfJ1ZdEWfLV8+qCoTw=;
        b=V+e64THtvZwl6wLV93JIn1EdEkTh1VPnryR3TOQEGt4WzvLsbO6inJ2oX8a++/xoEy
         mNQLte6fMa4OOU0yWQ63y+L1FGV7ADlhiy5IVpoQwAH4fnxrF7P4WtilxOOF3w9erxSa
         wb7CZa03p4kCv8k/jgSTo6BB2cRFhEpYY17BoIUUuFVyCBzAiqLRmwSHhiOabh82891e
         0mWvMOuaBv0okUxmvrllL7oOPA+yYpMbIENJv+3XtNsjL/WkRPs4FPv88ZEVxWibEDI3
         WykMIli6GsR1VRkmAGvI0oyvmfm++ufZ4+oG93qhxnIE8Ucbr/Kwfb/go5swpALo48bY
         sM0g==
X-Gm-Message-State: AOAM530qPh+JIhfbPsfh7QeR38Otae1sa9q18ODD68wMuSLigSOH/cwK
        Ar2kRi1Z7nUdfdKu3lhc/yg=
X-Google-Smtp-Source: ABdhPJzzxouJj0AiVAoYVXd6GYxpjH3humJ0K6tdJJ+HM3g/hLmKJVkO4jJwfiALZiApJbZ3FqXwiw==
X-Received: by 2002:a5d:540a:: with SMTP id g10mr377991wrv.138.1599111550768;
        Wed, 02 Sep 2020 22:39:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.106])
        by smtp.googlemail.com with ESMTPSA id q8sm2590564wrx.79.2020.09.02.22.39.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 22:39:09 -0700 (PDT)
Date:   Thu, 3 Sep 2020 07:39:05 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?TWljaGHFgsKgTWlyb3PFgmF3?= <mirq-linux@rere.qmqm.pl>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 11/11] mmc: host: Enable compile testing of multiple
 drivers
Message-ID: <20200903053905.GA14577@kozik-lap>
References: <20200902193658.20539-1-krzk@kernel.org>
 <20200902193658.20539-12-krzk@kernel.org>
 <20200902213227.GE1624@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200902213227.GE1624@qmqm.qmqm.pl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 02, 2020 at 11:32:27PM +0200, Michał Mirosław wrote:
> On Wed, Sep 02, 2020 at 09:36:58PM +0200, Krzysztof Kozlowski wrote:
> > Multiple MMC host controller driver can be compile tested as they do not
> > depend on architecture specific headers.
> [...]
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -178,7 +178,7 @@ config MMC_SDHCI_OF_AT91
> [...]
> >  config MMC_MESON_GX
> >  	tristate "Amlogic S905/GX*/AXG SD/MMC Host Controller support"
> > -	depends on ARCH_MESON && MMC
> > +	depends on MMC
> > +	depends on ARCH_MESON|| COMPILE_TEST
> [...]
> >  config MMC_MOXART
> >  	tristate "MOXART SD/MMC Host Controller support"
> > -	depends on ARCH_MOXART && MMC
> > +	depends on MMC
> > +	depends on ARCH_MOXART || COMPILE_TEST
> [...]
> 
> You can drop 'MMC' from depends as the whole tree is under 'if MMC' already.

Right, thanks for feedback.

Best regards,
Krzysztof

