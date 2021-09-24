Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15540C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDC0B60F4C
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 13:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbhIXNao (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 09:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346353AbhIXN3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 09:29:51 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777CEC110F27;
        Fri, 24 Sep 2021 06:08:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d6so27222411wrc.11;
        Fri, 24 Sep 2021 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=L8DrcJ04fYBbAqwtjuYGZedbkhprKkVzLxtRv6jljE0=;
        b=Fg0aYxo6+s+uELekjWngwheQHMypDTpbQlYyXvo0UGErxffAUdW2lo8a1UIEmawOcI
         DuHMG2ugBNusVVheZn1ZT2E97qpU8/kIKkF1gH/2nWjQwrEMyM/3MkIafdBaKb0sQ0q0
         QCj1GGladdTX38GzUcupi0P3D5B+qOP1pVNtRyGaLxL4Yj1aPXWpVuUV6Q6KGRdu+vvm
         zSfPS00oHas5qXG8Ws6z8B9U9uWb5Q/TnotFUvqOLuRiBE2k6kdSbThzsDwFiiogM6Nt
         PUqg00pOgnrB3DG/Cj1XP4T7aIm2OQUz+jF3E+cfWJhjeR7LESts2GBTDyt6X3fbt9AP
         D2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L8DrcJ04fYBbAqwtjuYGZedbkhprKkVzLxtRv6jljE0=;
        b=6qjtpXVj/9Z7bk2yOYYxpvTBqjQfhXzs635QvEfRhMDrUzwMhQQ6XFUidfOE1cNhfi
         lKbD/M/s8YKVIjr7AyGnS7nC/uRB4sFL+UAWT1u3BdhoXEA0yPNaJmKK1JQ7dEzA4Yjq
         qyaIGBQMs8YE0FdjLKeWRihaCKqYMnMBmjd63CZqqK+Zvy+hjPcQq3Xw1IXdQKoQeTsz
         V38GFKsAKNkcTp1NhKbYO4xfXPiWMFPVQ0bdmQrWQJ96BjtlzywiXDLMP1I2Qbp0QTM0
         KiAvIYdyxhRO49nl0iNOKSlMgvvvMSK8RCchUsG3sUrCo0PX+P74zniCxqUJSK+ZhsHj
         6O0g==
X-Gm-Message-State: AOAM530WWLajuqhBZotd+PK2HSDbAtgkGb0f72SYOKvBmcXDiwlGgrtB
        1aWINOLvLibY3x6ZmIbb8B0=
X-Google-Smtp-Source: ABdhPJwmnD2H0Y7Q9bPtkbMy9wEasRf5Qn8rOk8pUDhDpYPD+IKOdWCKpyJ8EFc2yzKoqOrmtp3qbA==
X-Received: by 2002:a05:600c:3585:: with SMTP id p5mr2075440wmq.110.1632488890092;
        Fri, 24 Sep 2021 06:08:10 -0700 (PDT)
Received: from p200300e94717cfc52fe6da3ec1ed0822.dip0.t-ipconnect.de (p200300e94717cfc52fe6da3ec1ed0822.dip0.t-ipconnect.de. [2003:e9:4717:cfc5:2fe6:da3e:c1ed:822])
        by smtp.googlemail.com with ESMTPSA id g143sm12478865wme.16.2021.09.24.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:08:09 -0700 (PDT)
Message-ID: <5a5db6c2eed2273a8903b5052312f039dd629401.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 15:08:08 +0200
In-Reply-To: <79056ca7-bfe3-1b25-b6fd-de8a9388b75f@intel.com>
References: <20210917172727.26834-1-huobean@gmail.com>
         <20210917172727.26834-3-huobean@gmail.com>
         <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
         <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
         <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
         <40e525300cd656dd17ffc89e1fcbc9a47ea90caf.camel@gmail.com>
         <79056ca7-bfe3-1b25-b6fd-de8a9388b75f@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
> > > >          sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> > > > }
> > > > The driver has detected that the hardware timer cannot meet the
> > > > timeout
> > > > requirements of the device, but we still use the hardware
> > > > timer,
> > > > which will
> > > > allow potential timeout issuea . Rather than allowing a
> > > > potential
> > > > problem to exist, why can’t software timing be used to avoid
> > > > this
> > > > problem?
> > > Timeouts aren't that accurate.  The maximum is assumed still to
> > > work.
> > > mmc->max_busy_timeout is used to tell the core what the maximum
> > > is.
> > mmc->max_busy_timeout is still a representation of Host HW timer
> > maximum timeout count, isn't it? 
> 
> 
> Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it would be
> 
> set to zero to indicate no maximum.

yes, this is the purpose of the patch, for the host controller without
quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count required by
device is beyond the HW timer max count, we choose SW timer to avoid the HW timer timeout IRQ.

I don't know if I get it correctly.

Bean

