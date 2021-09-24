Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C40C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 21:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACEE6611C8
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 21:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244892AbhIXVfe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbhIXVfd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 17:35:33 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08075C061571;
        Fri, 24 Sep 2021 14:34:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id c21so1646854wrb.13;
        Fri, 24 Sep 2021 14:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=MRBy6HZZ6AjG5qDbA+iaWvTiMsIAwbuNCe4ZpR4MDlo=;
        b=FGgp4yIXsnEqLk4hE5ruR0jtKTgR60ER2xuWWdk4NgD/AAeZ0YjA3kLF2hCve1ybKO
         r9pMw/pbMrl+vdeDiH60t9MYKU/FdVWT5Tln9RdsGKUOUh7gFIftK3Y6n5PRFIyzXz7B
         W7Nd4vVjzU1FniGPFeF2pbAloULEEzJkV+/ZBZGHwIyBsUsmGK/bEFaCrbxKQ5uarIcq
         6S6vXCJfRGsuIcNr8S9/mOYBFn6Sta2nX3MKeBiOxq42sOij3q6mEAxzVnnJich14I7N
         94iUEzUr2JYt78D3b5D3Mr47HgYZJA2xTYK6HE2uZkY8y8t0S27+k2VJ/4boNWu4wZdz
         Z7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=MRBy6HZZ6AjG5qDbA+iaWvTiMsIAwbuNCe4ZpR4MDlo=;
        b=SmJ9ga5e8GLrNlKIjRiHM38xifoZ3ksr6Qv+YJSLUINiJqreshC9hHJWfrNRNTidfq
         qxDFbgHB0q6qKh6I2gsScM2MWJFblLSV7NO0XEtdrG+lQGO1b4H9WFiFEJ8tJAPp+mKp
         LD4sQCHVOIA11ljCeJr2UUqLwoGgKpDB46SwRT+OaKZUlge2HohM7aY60gLrx20bfRZH
         l0FVgx/2DG23Uta9pO6WAKO2cONfsE+O61igtC6Ll+9IIxwesQyTMkMzy+5WpVZi2s7p
         YkzVqxiO+c21ie3zErx7RgA0WPyX9ghcLOz8QxtDz2RObTuzaNlQ2foExCk5ZbM9lH3B
         FgMw==
X-Gm-Message-State: AOAM5329ZK5SOfSXccvTQC0sTFCQrXEM6Eul8sL2lUv27OtsjOwuevMY
        ZM8OZjK/3WYPqWVHMzvMTZ8=
X-Google-Smtp-Source: ABdhPJwhLyerFGPnVJTxqv7QFGodpS08is1707oNcB5WkJ0oJmBX4NQP3ABqW80eZQXIHRefk9LWCQ==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr2080973wmj.60.1632519238606;
        Fri, 24 Sep 2021 14:33:58 -0700 (PDT)
Received: from p200300e94717cf98c6353fa615697ce1.dip0.t-ipconnect.de (p200300e94717cf98c6353fa615697ce1.dip0.t-ipconnect.de. [2003:e9:4717:cf98:c635:3fa6:1569:7ce1])
        by smtp.googlemail.com with ESMTPSA id s10sm9257620wrg.42.2021.09.24.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:33:58 -0700 (PDT)
Message-ID: <37497369a4cf5f729e7b3e31727a7d64be5482db.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 23:33:56 +0200
In-Reply-To: <5072935e-d855-7029-1ac0-0883978f66e5@intel.com>
References: <20210917172727.26834-1-huobean@gmail.com>
         <20210917172727.26834-3-huobean@gmail.com>
         <fc14d8e1-9438-d4b0-80f4-ccf9055ab7d3@intel.com>
         <beda2d5ecc3c15e9bf9aa18383c22c2a90d31dab.camel@gmail.com>
         <93292ef4-8548-d2ba-d803-d3b40b7e6c1d@intel.com>
         <40e525300cd656dd17ffc89e1fcbc9a47ea90caf.camel@gmail.com>
         <79056ca7-bfe3-1b25-b6fd-de8a9388b75f@intel.com>
         <5a5db6c2eed2273a8903b5052312f039dd629401.camel@gmail.com>
         <5072935e-d855-7029-1ac0-0883978f66e5@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-09-24 at 16:26 +0300, Adrian Hunter wrote:
> On 24/09/21 4:08 pm, Bean Huo wrote:
> > On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
> > > > > >          sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> > > > > > }
> > > > > > The driver has detected that the hardware timer cannot meet
> > > > > > the
> > > > > > timeout
> > > > > > requirements of the device, but we still use the hardware
> > > > > > timer,
> > > > > > which will
> > > > > > allow potential timeout issuea . Rather than allowing a
> > > > > > potential
> > > > > > problem to exist, why can’t software timing be used to
> > > > > > avoid
> > > > > > this
> > > > > > problem?
> > > > > Timeouts aren't that accurate.  The maximum is assumed still
> > > > > to
> > > > > work.
> > > > > mmc->max_busy_timeout is used to tell the core what the
> > > > > maximum
> > > > > is.
> > > > mmc->max_busy_timeout is still a representation of Host HW
> > > > timer
> > > > maximum timeout count, isn't it? 
> > > 
> > > Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it would be
> > > 
> > > set to zero to indicate no maximum.
> > 
> > yes, this is the purpose of the patch, for the host controller
> > without
> > quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count
> > required by
> > device is beyond the HW timer max count, we choose SW timer to
> > avoid the HW timer timeout IRQ.
> > 
> > I don't know if I get it correctly.
> 
> Why can't drivers that want the behaviour just set the quirk?
> 
> Drivers that do not work with the quirk, do not have to set it.


Adrian,

We cannot add this quirk to every host driver. This is the difference
on the device side. In addition, I don't know what the maximum hardware
timer budget for each host is. Even if you use the same SOC, the
maximum time budget on different platforms may be different.

Assume that the maximum timeout time supported by the hardware timer is
100 milliseconds, but the maximum data transmission time required by
the device is 150 milliseconds. In most cases, data transfer will not
take so long. 150 is the maximum time under extreme conditions. This
means that the device just needs to complete a data transfer within
>100ms and keep the data line busy. If we still use the HW timer, it
will trigger a DATA LINE timeout interrupt.

This patch does not affect scenarios where the hardware timer meets the
max data transmission time requirements of the device. It will still
use the hardware timer. Only when the device changes, will it switch to
using the SW timer.

Bean

