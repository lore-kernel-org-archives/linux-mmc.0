Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632A3C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 09:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468BC60FBF
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Sep 2021 09:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhI1Jlm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhI1Jll (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2021 05:41:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8A7C061575;
        Tue, 28 Sep 2021 02:40:02 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso2272821wme.0;
        Tue, 28 Sep 2021 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=kDkv9Rpe3a3jzGJpilYOh+kLID8MJzgQoAqFKyN7zzY=;
        b=dXhS1cV6qlYv0CDkxqkjmzcjKegIk7zJ2DYRCJ5Y2q+mvkKKsOFouo+tf4uBkvpFy2
         jh6h4d0uOPoobXjanz6zqU2DVyxq7Tvbog/H60y4DwcfR+KTxrRkPdLYgIzchj5RmVnm
         TQXZzvo+bfwifAQc4zDQNXULZR6DiRQ02ZgFhZ5QKj3SJ/8VDnOWmpZzsxtpTqEB0sxR
         oj/hN5Sqe+nF5mmDfljrM3rYK36/DNYBmxD5i+bYiiOSl92IuKa5NifBxMqGR/5uKfGO
         qJEfnQ0iqTr/6LQlwPPEPJDYcQ/TtMm2RgTed8p2D6M+05YUbad/8R2D1Aum9rpFKl1K
         EiJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kDkv9Rpe3a3jzGJpilYOh+kLID8MJzgQoAqFKyN7zzY=;
        b=AdzExY+jk7Bl1IEVyywDQxUqGkrTu7CV8OqteIjNZMdRL1goQMKFMKnNNGaHeog/hz
         e4tHPE2P5A2eR7zYphNlbj9+q0IqCztk2gIXJJH9TSpHqQmKaaXyzPwQZ5bde6DlpS5f
         frtKvFN/iUDV2sJ/4lgnI6udO8rdw3ue1uKqDUwoXD+ZK3fDoy8Lglm6JdNpRZ/gRmJ4
         VRrdb32xJ6mczhrYaZSH8Zfv4yKb5lcgyrBNAt1IIi8cXjA43aZ58Snv7KZCxCwCnb9P
         Sf0g2TYPeqTZ4XUikH7H35UHV190q9xAo6fpm7S95BjAG+gMaoxeRN7dWUVZjEq+6M3Y
         D/jQ==
X-Gm-Message-State: AOAM532HqCVfx3BuLC3+vhL3ZSc5DpPTrZJKuG2E5VOyWRBs9JX7GQTA
        wOrw/bUlR94DuD5/6E0NT9WneS8Tv6UQOQ==
X-Google-Smtp-Source: ABdhPJxbDvWQk8LU895jSojgwYxMgVF/DrgdEY1oIDfvjuuanKc8kPB1K795AZFfMtuK4Vw/wEnOjw==
X-Received: by 2002:a05:600c:4f54:: with SMTP id m20mr3766804wmq.96.1632822001067;
        Tue, 28 Sep 2021 02:40:01 -0700 (PDT)
Received: from p200300e94717cfac3e891446077632d6.dip0.t-ipconnect.de (p200300e94717cfac3e891446077632d6.dip0.t-ipconnect.de. [2003:e9:4717:cfac:3e89:1446:776:32d6])
        by smtp.googlemail.com with ESMTPSA id t126sm2117440wma.4.2021.09.28.02.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 02:40:00 -0700 (PDT)
Message-ID: <987cb93359dc95ce9fb387b755fadb0ab6eb98f9.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 28 Sep 2021 11:39:59 +0200
In-Reply-To: <37497369a4cf5f729e7b3e31727a7d64be5482db.camel@gmail.com>
References: <20210917172727.26834-1-huobean@gmail.com>
         <20210917172727.26834-3-huobean@gmail.com>
         <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
         <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
         <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
         <40e525300cd656dd17ffc89e1fcbc9a47ea90caf.camel@gmail.com>
         <79056ca7-bfe3-1b25-b6fd-de8a9388b75f@intel.com>
         <5a5db6c2eed2273a8903b5052312f039dd629401.camel@gmail.com>
         <5072935e-d855-7029-1ac0-0883978f66e5@intel.com>
         <37497369a4cf5f729e7b3e31727a7d64be5482db.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-09-24 at 23:33 +0200, Bean Huo wrote:
> On Fri, 2021-09-24 at 16:26 +0300, Adrian Hunter wrote:
> > On 24/09/21 4:08 pm, Bean Huo wrote:
> > > On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
> > > > > > >          sdhci_writeb(host, count,
> > > > > > > SDHCI_TIMEOUT_CONTROL);
> > > > > > > }
> > > > > > > The driver has detected that the hardware timer cannot
> > > > > > > meet
> > > > > > > the
> > > > > > > timeout
> > > > > > > requirements of the device, but we still use the hardware
> > > > > > > timer,
> > > > > > > which will
> > > > > > > allow potential timeout issuea . Rather than allowing a
> > > > > > > potential
> > > > > > > problem to exist, why can’t software timing be used to
> > > > > > > avoid
> > > > > > > this
> > > > > > > problem?
> > > > > > Timeouts aren't that accurate.  The maximum is assumed
> > > > > > still
> > > > > > to
> > > > > > work.
> > > > > > mmc->max_busy_timeout is used to tell the core what the
> > > > > > maximum
> > > > > > is.
> > > > > mmc->max_busy_timeout is still a representation of Host HW
> > > > > timer
> > > > > maximum timeout count, isn't it? 
> > > > 
> > > > Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it would
> > > > be
> > > > 
> > > > set to zero to indicate no maximum.
> > > 
> > > yes, this is the purpose of the patch, for the host controller
> > > without
> > > quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count
> > > required by
> > > device is beyond the HW timer max count, we choose SW timer to
> > > avoid the HW timer timeout IRQ.
> > > 
> > > I don't know if I get it correctly.
> > 
> > Why can't drivers that want the behaviour just set the quirk?
> > 
> > Drivers that do not work with the quirk, do not have to set it.
> 
> Adrian,
> 
> We cannot add this quirk to every host driver. This is the difference
> on the device side. In addition, I don't know what the maximum
> hardware
> timer budget for each host is. Even if you use the same SOC, the
> maximum time budget on different platforms may be different.
> 
> Assume that the maximum timeout time supported by the hardware timer
> is
> 100 milliseconds, but the maximum data transmission time required by
> the device is 150 milliseconds. In most cases, data transfer will not
> take so long. 150 is the maximum time under extreme conditions. This
> means that the device just needs to complete a data transfer within
> > 100ms and keep the data line busy. If we still use the HW timer, it
> will trigger a DATA LINE timeout interrupt.
> 
> This patch does not affect scenarios where the hardware timer meets
> the
> max data transmission time requirements of the device. It will still
> use the hardware timer. Only when the device changes, will it switch
> to
> using the SW timer.
> 
> Bean
> 

Hi Adrian,

Would you please review this patch again and is it possible to be
accepted?

Bean

