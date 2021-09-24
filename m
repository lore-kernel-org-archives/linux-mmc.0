Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44632C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 11:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2277261164
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 11:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343597AbhIXLrb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 07:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbhIXLra (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 07:47:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF31C061756;
        Fri, 24 Sep 2021 04:45:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i23so26701848wrb.2;
        Fri, 24 Sep 2021 04:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/0j9nbgsdZbL0omEY1qL679LVqCMTV/VffKv5oBSsjU=;
        b=aSa45hd+S3Fv4JUSFQ+a3kgyKy5NX9AGa0CJIDVYWneSLwqkbiGb/QdRzY0bbT5fCx
         I5O4NVZz0Uu5SXECHchsCiEDV+0pF1h0jDRjGsHHd/MMUIcEO2XWJ0sgaG+TVFCHJlbA
         LLN0zDYzeBL8vywSI/Lv/8QqoeQIQxcLsdqRdvAYHEs8WJggfxFMXa4dFgl4w4H1sZ1E
         x/gqlahyDWoB8y9TvhZM5C6tp7AK5IHa3ZR+468h9O+WQjC1vNg+c+pJH31tebmvMgir
         RkFo3J81bVSyJa2ikn2M/7W76P6DXmnBIoUh/vomkTMw77kg74sfka5XJ4newu0u3Kvo
         F/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/0j9nbgsdZbL0omEY1qL679LVqCMTV/VffKv5oBSsjU=;
        b=yxJLI5/irlzxY5WDCwWHocLWI6EP+5B5thoRGTGDKYPgEd31kZv3dYWdDqEr9FEk2u
         TAWyfqLUv9A39Gn0mPGmK/L7QP5L/mXvswQugSHM7eRfw06gZXn4aJrtME/0d+Re4ozj
         B9pXLnokHdQCxAbD0y/clkBy/TorALK5fbqNlHySsQBi2CFPkT5w6cIQEo2jU2XX4pHC
         P2VyPsW/OjN/WF22a6+c2VyD21gvnKB8W/5eUGaExDpx8ebroXOn1nX7PNdLxdk4uUjS
         jwfM+zisZA5iaAuJLieUdiaR4xeraU3IgHzgllgOme+AygEdIE9vW+JsTbrIe1adFNps
         Y0Lg==
X-Gm-Message-State: AOAM533o3+2ITK6K5cm5tthd48oKCmxpGFZZvccGnHx1nHCZgy3KcIoO
        5bGRqDBuOn9NkS1Zf6GTJXOz45LHOtnaiQ==
X-Google-Smtp-Source: ABdhPJzb83WVQz4xAx2zTEdtFMOpdwV8pBiewli/yezfwpfrrb9fSHQRbv32+HAgzGOsiDEBNZ8JnA==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr1645157wmk.116.1632483955458;
        Fri, 24 Sep 2021 04:45:55 -0700 (PDT)
Received: from p200300e94717cfc52fe6da3ec1ed0822.dip0.t-ipconnect.de (p200300e94717cfc52fe6da3ec1ed0822.dip0.t-ipconnect.de. [2003:e9:4717:cfc5:2fe6:da3e:c1ed:822])
        by smtp.googlemail.com with ESMTPSA id c4sm8157259wrt.23.2021.09.24.04.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 04:45:55 -0700 (PDT)
Message-ID: <40e525300cd656dd17ffc89e1fcbc9a47ea90caf.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 13:45:54 +0200
In-Reply-To: <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
References: <20210917172727.26834-1-huobean@gmail.com>
         <20210917172727.26834-3-huobean@gmail.com>
         <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
         <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
         <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-09-24 at 13:07 +0300, Adrian Hunter wrote:
> On 24/09/21 12:17 pm, Bean Huo wrote:
> > On Fri, 2021-09-24 at 08:29 +0300, Adrian Hunter wrote:
> > > > If the data transmission timeout value required by the device
> > > > exceeds
> > > > the maximum timeout value of the host HW timer, we still use
> > > > the HW
> > > > timer with the maximum timeout value of the HW timer. This
> > > > setting
> > > > is
> > > > suitable for most R/W situations. But sometimes, the device
> > > > will
> > > > complete
> > > > the R/W task within its required timeout value (greater than
> > > > the HW
> > > > timer).
> > > > In this case, the HW timer for data transmission will time out.
> > > > Currently, in this condition, we  disable the HW timer and use
> > > > the
> > > > SW
> > > > timer only when the SDHCI_QUIRK2_DISABLE_HW_TIMEOUT quirk is
> > > > set by
> > > > the
> > > > host driver. The patch is to remove this if statement
> > > > restriction
> > > > and
> > > > allow data transmission to use the SW timer when the hardware
> > > > timer
> > > > cannot
> > > > meet the required timeout value.
> > > 
> > > The reason it is a quirk is because it does not work for all
> > > hardware.
> > > 
> > > For some controllers the timeout cannot really be disabled, only
> > > the
> > > 
> > > interrupt is disabled, and then the controller never indicates
> > > completion
> > > 
> > > if the timeout is exceeded.
> > 
> > Hi Adrian,
> > Thanks for your review.
> > 
> > Yes, you are right. But this quirk prevents disabling the hardware
> > timeoutIRQ. The purpose of this patch is to disable the hardware
> > timeout IRQ and
> > select the software timeout.
> > 
> > void __sdhci_set_timeout(struct sdhci_host *host, struct
> > mmc_command
> > *cmd)
> > {
> >         bool too_big = false;
> >         u8 count = sdhci_calc_timeout(host, cmd, &too_big);
> > 
> >         if (too_big) {
> >                 sdhci_calc_sw_timeout(host, cmd);
> >                 sdhci_set_data_timeout_irq(host, false); // disable
> > IRQ
> >         } else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
> >                 sdhci_set_data_timeout_irq(host, true);
> >         }
> > 
> >         sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> > }
> > 
> > 
> > The driver has detected that the hardware timer cannot meet the
> > timeout
> > requirements of the device, but we still use the hardware timer,
> > which will
> > allow potential timeout issuea . Rather than allowing a potential
> > problem to exist, why can’t software timing be used to avoid this
> > problem?
> 
> Timeouts aren't that accurate.  The maximum is assumed still to work.
> mmc->max_busy_timeout is used to tell the core what the maximum is.

> 



mmc->max_busy_timeout is still a representation of Host HW timer
maximum timeout count, isn't it? 

Bean

