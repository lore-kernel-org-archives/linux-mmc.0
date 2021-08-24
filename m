Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57F5C4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 03:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F9C600D0
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 03:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbhHXDIj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Aug 2021 23:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbhHXDFo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Aug 2021 23:05:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC5CC0612AD
        for <linux-mmc@vger.kernel.org>; Mon, 23 Aug 2021 20:04:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mq3so13256805pjb.5
        for <linux-mmc@vger.kernel.org>; Mon, 23 Aug 2021 20:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ftVLBcz2CA6HVw5Sak06NSKiX7H+vKeynT4dia9GcmU=;
        b=k+9ugNQMNP1T757zCmBjD0HZ4Cm6T3BE+v/X7Wxf65qXhZ4Y1Om/ZwreVVsFldU5ED
         26Au5VziBd3fTRw9qajnc5Q1bzTZtCXlNbNzYEhhdrLy0j6q3RP41Bfsx2Vet4JiZwHE
         HpssKarI+iW9nKfS+aZW4kug15wwleM1PIEsfGzs+E/ENGb7NoFhvlaUVQuCR3IWspbE
         1jdc92yTGvHUY8w5qgAHpd6F4jZjsLSyz7OphX6zYHG1h8uepViMakkTUt9Apji0AqlD
         h496UE7ulnKIyaYIIz+9WlMWKL7f+UCly0DgUoeMlhVK/OeculmtFoztQ69V1z3oNjW5
         BaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ftVLBcz2CA6HVw5Sak06NSKiX7H+vKeynT4dia9GcmU=;
        b=gKwvWZS1/+SVWsAXVX+oL0+S5VDem6IP8janHZj02Tywu5DW3hQNCzdYe2Fo1TRpMI
         Qka8oaEixCaJDUuyk0wwoPnZ2+XKnVjkpe7d17OxbV5UhWTtLaOv3m8ocbMYTEgXi5Nj
         D/zsaGB0+jJp2KvTUalDD0hwkc2EMfa1QIIfeCRlyFt4ox08D468Hv5GUmNepsLs5GZb
         LJEw+ChnGfoMFBasjvtWQIrz/9sBtAO0AfZemJQ7t6apyb+ThFFHjBluKG1akCLnwuJW
         UAKu6OSDw7EY6Nz7LB0rekpUF2bmCN1EJ/KY1GrGRqvNfChMllQUSKI45k6VBosWn6gd
         rC+A==
X-Gm-Message-State: AOAM5313J62lExXUzg5JF+XOR3TYC7rg1K1K36p+ec9QcLIqsYbuRZxm
        Z4SfsJ1LKDFYifqTh47Tr5QGNQxaPDqC3A==
X-Google-Smtp-Source: ABdhPJxgNZPrPk9tzmxpkCehrPdfFes88M8DqFhHlA/X7V8qZTGRmqZiqGy9NJMzzCPLtwobPdjSGw==
X-Received: by 2002:a17:902:e547:b029:12c:563c:4a03 with SMTP id n7-20020a170902e547b029012c563c4a03mr30922945plf.46.1629774264209;
        Mon, 23 Aug 2021 20:04:24 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id c12sm16184839pfl.56.2021.08.23.20.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 20:04:23 -0700 (PDT)
Date:   Tue, 24 Aug 2021 08:34:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v8 01/34] opp: Add dev_pm_opp_sync() helper
Message-ID: <20210824030421.3tjfjkx3c2silbnz@vireshk-i7>
References: <20210818062723.dqamssfkf7lf7cf7@vireshk-i7>
 <CAPDyKFrZqWtZOp4MwDN6fShoLLbw5NM039bpE3-shB+fCEZOog@mail.gmail.com>
 <20210818091417.dvlnsxlgybdsn76x@vireshk-i7>
 <CAPDyKFrVxhrWGr2pKduehshpLFd_db2NTPGuD7fSqvuHeyzT4w@mail.gmail.com>
 <f1314a47-9e8b-58e1-7c3f-0afb1ec8e70a@gmail.com>
 <20210819061617.r4kuqxafjstrv3kt@vireshk-i7>
 <CAPDyKFpg8ixT4AEjzVLTwQR7Nn9CctjnLCDS5GwkOrAERquyxw@mail.gmail.com>
 <20210820051843.5mueqpnjbqt3zdzc@vireshk-i7>
 <CAPDyKFo0rzHT4AhueWjyz9k2ZqUy8N6Od5pbr8sL_m0Jf2AwUg@mail.gmail.com>
 <085d1a2e-57b0-222e-c569-12f3c6bc8161@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <085d1a2e-57b0-222e-c569-12f3c6bc8161@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23-08-21, 23:24, Dmitry Osipenko wrote:
> It's not clear to me whether it will be okay to add a generic OPP syncing by clock rate or should it be a Tegra-specific helper. Viresh, what do you think about this generic OPP helper:
> 
> /**
>  * dev_pm_opp_sync_with_clk_rate() - Sync OPP state with clock rate
>  * @dev:	device for which we do this operation
>  *
>  * Sync OPP table state with the current clock rate of device.
>  *
>  * Return: 0 on success or a negative error value.
>  */
> int dev_pm_opp_sync_with_clk_rate(struct device *dev)
> {
> 	struct opp_table *opp_table;
> 	int ret = 0;
> 
> 	/* Device may not have OPP table */
> 	opp_table = _find_opp_table(dev);
> 	if (IS_ERR(opp_table))
> 		return 0;
> 
> 	/* Device may not use clock */
> 	if (IS_ERR(opp_table->clk))
> 		goto put_table;
> 
> 	/* Device may have empty OPP table */
> 	if (!_get_opp_count(opp_table))
> 		goto put_table;
> 
> 	ret = dev_pm_opp_set_rate(dev, clk_get_rate(opp_table->clk));
> put_table:
> 	/* Drop reference taken by _find_opp_table() */
> 	dev_pm_opp_put_opp_table(opp_table);
> 
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(dev_pm_opp_sync_with_clk_rate);

I am not sure why you still need this, hope we were going another way
? Anyway I will have a look at what you have posted now.

-- 
viresh
