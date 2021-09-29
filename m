Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB83C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 10:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A32B461458
	for <linux-mmc@archiver.kernel.org>; Wed, 29 Sep 2021 10:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbhI2Kuo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 29 Sep 2021 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbhI2Kun (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Sep 2021 06:50:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AFBC06161C;
        Wed, 29 Sep 2021 03:49:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b192so1478541wmb.2;
        Wed, 29 Sep 2021 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1l5LtWOaWC+o5KfF/CfNEqOXQ8wWntrdwzid9XcF44w=;
        b=PtebRYJPO5PV3NRZT7jOshnH+XgVjcD94eTA1+mKzO0youjuhqgBaeL/RHWmiAGHeh
         Xhpro0ebFhXOS2M7WA8BdunwL5GGtui8BaNLHbBAn6qUwdb/KtmHPkb2N3/gHaHDcNSn
         6oMRBJC2YtmmysL+wJIVmTiPuuvK2cWk95ehFP909M6LbjFI8Xx0fagBuPDk9BVJk4YI
         MeyW+JihJBw7AtOBrTJvSKGUw8lUlL0XRYV7iO6Y4rkru2tOl35dq8KSRcHmkTnFpQ9P
         QrUvQCqJhpPbCOet9wSO5nAA9Cew/+fMbqbdoq0uqol/uZyO77GAHsvNTYn8JWdLVo9c
         mkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1l5LtWOaWC+o5KfF/CfNEqOXQ8wWntrdwzid9XcF44w=;
        b=eB+db3cYfc1XAWJR7v5mbxBlmVX1X2ORMq1z0KBxRLAtudkgMURWlCtQCDGMIgv6an
         4iTSeNYf/KbNrk85qmqa94xrqDhft8S+aBue3dU987L/13l/h7OPQcUA79jZaoIDdfz6
         dW93Yyss1gYkcHwdwtiNDUEkBx+62p/llV8XQzKqNxTZIlJG0RwUq4q+LWzOTVc9E3Pg
         z63yhKULDHOLz04/jg1KhEX/Pb0rOGymBP7Mh+z8x16ds0X/R31d6K2zQ/xJdmHxLKzD
         LR0O1/DsGhh5wbzZ3X7KiRst9XLnf9C14SNWFp0Zv2AFQyLjTbEIQNPuQDWxrKPCwWbP
         svyw==
X-Gm-Message-State: AOAM530pdiWYDl56xYhFctAcD9iu7oZqL8yYP813HhMsXnZETHvyyzRV
        1E01rtFwEj/gOVanHPbPU4Q=
X-Google-Smtp-Source: ABdhPJz0K8JalogSCCIh8OfIp6YcddnFfLH2S9bfH+2ffrlSIXVO3E+ErVPaI/r1dvqshz5rd3hN8w==
X-Received: by 2002:a7b:ca58:: with SMTP id m24mr6218926wml.0.1632912541629;
        Wed, 29 Sep 2021 03:49:01 -0700 (PDT)
Received: from p200300e94717cfe0c260d0cee5f47376.dip0.t-ipconnect.de (p200300e94717cfe0c260d0cee5f47376.dip0.t-ipconnect.de. [2003:e9:4717:cfe0:c260:d0ce:e5f4:7376])
        by smtp.googlemail.com with ESMTPSA id o7sm2329839wro.45.2021.09.29.03.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 03:49:01 -0700 (PDT)
Message-ID: <296607ef57f3fb632107997f4edca99a5722beab.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Sep 2021 12:49:00 +0200
In-Reply-To: <32b753ff-6702-fa51-2df2-32ff1d955a23@intel.com>
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
         <32b753ff-6702-fa51-2df2-32ff1d955a23@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Tue, 2021-09-28 at 13:18 +0300, Adrian Hunter wrote:
> On 25/09/2021 00:33, Bean Huo wrote:
> > On Fri, 2021-09-24 at 16:26 +0300, Adrian Hunter wrote:
> > > On 24/09/21 4:08 pm, Bean Huo wrote:
> > > > On Fri, 2021-09-24 at 15:17 +0300, Adrian Hunter wrote:
> > > > > > > >          sdhci_writeb(host, count,
> > > > > > > > SDHCI_TIMEOUT_CONTROL);
> > > > > > > > }
> > > > > > > > The driver has detected that the hardware timer cannot
> > > > > > > > meet
> > > > > > > > the
> > > > > > > > timeout
> > > > > > > > requirements of the device, but we still use the
> > > > > > > > hardware
> > > > > > > > timer,
> > > > > > > > which will
> > > > > > > > allow potential timeout issuea . Rather than allowing a
> > > > > > > > potential
> > > > > > > > problem to exist, why can’t software timing be used to
> > > > > > > > avoid
> > > > > > > > this
> > > > > > > > problem?
> > > > > > > Timeouts aren't that accurate.  The maximum is assumed
> > > > > > > still
> > > > > > > to
> > > > > > > work.
> > > > > > > mmc->max_busy_timeout is used to tell the core what the
> > > > > > > maximum
> > > > > > > is.
> > > > > > mmc->max_busy_timeout is still a representation of Host HW
> > > > > > timer
> > > > > > maximum timeout count, isn't it? 
> > > > > 
> > > > > Not necessarily.  For SDHCI_QUIRK2_DISABLE_HW_TIMEOUT it
> > > > > would be
> > > > > 
> > > > > set to zero to indicate no maximum.
> > > > 
> > > > yes, this is the purpose of the patch, for the host controller
> > > > without
> > > > quirk SDHCI_QUIRK2_DISABLE_HW_TIMEOUT, if the timeout count
> > > > required by
> > > > device is beyond the HW timer max count, we choose SW timer to
> > > > avoid the HW timer timeout IRQ.
> > > > 
> > > > I don't know if I get it correctly.
> > > 
> > > Why can't drivers that want the behaviour just set the quirk?
> > > 
> > > Drivers that do not work with the quirk, do not have to set it.
> > 
> > Adrian,
> > 
> > We cannot add this quirk to every host driver.
> 
> I was suggesting only the ones for which it works.
> 
> >  This is the difference
> > on the device side.
> 
> It is the host controller that has the problem, not the device.
> Hence the quirk.
> 
> > In addition, I don't know what the maximum hardware
> > timer budget for each host is.
> 
> mmc->max_busy_timeout is calculated by sdhci.c, or the driver can
> override the maximum count via ->get_max_timeout_count() or the
> driver
> can override mmc->max_busy_timeout.
> 
> With the quirk, sdhci.c will usually set mmc->max_busy_timeout to
> zero.
> That allows timeouts greater than the hardware can support, and then,
> with the quirk, the driver will switch to a software timeout when
> needed.
> 


According to your above statement, do you mean that the eMMC host
controller does not support the scenario where the data transmission
timeout value required by the eMMC device is greater than the capacity
of the eMMC host hardware data transmission timer? Unless the eMMC host
vendor accepts their eMMC host accepts the use of SW timers in this
case (adding quirks)?


> However, that won't work for every host controller, because some do
> not
> provide a completion interrupt after the timeout, even if the timeout
> interrupt is disabled.  

Do you mean that if we disable the hardware timer/timeout interrupt and
use the software timer, the eMMC host controller will not trigger a
completion interrupt? Even before the SW timer expires, the data
transfer between the host and the eMMC device is complete? Is this what
you mean?


> That means they should set mmc->max_busy_timeout
> to the hardware value.  Hence the quirk is needed to tell the
> difference.
> 

This means this quirk is for eMMC host can privode the completion
interrupt in case HW timer is disabled?  


> > Even if you use the same SOC, the
> > maximum time budget on different platforms may be different.
> 
> The mmc core calculates timeouts based on the relevant standards and
> values provided by the device itself.


Yes, but the eMMC standard does not define the maximum timeout value.
Different eMMC will have different timeout values.

> 
> > Assume that the maximum timeout time supported by the hardware
> > timer is
> > 100 milliseconds
> 
> I realise it is an example, but 100 milliseconds is a bit low. Legacy
> host controllers have always had to deal with standard SD card and
> MMC card timeouts.  SD card write timeout of 500 milliseconds for
> instance.


Yes, this is just an example. I have several platforms, they are TI,
NXP, Intel and Qcom. The timeout time of the hardware timer is
different, the greatest one is 1.3s, some are less than 500ms.

> 
> > but the maximum data transmission time required by
> > the device is 150 milliseconds. In most cases, data transfer will
> > not
> > take so long. 150 is the maximum time under extreme conditions.
> > This
> > means that the device just needs to complete a data transfer within
> > > 100ms and keep the data line busy. If we still use the HW timer,
> > > it
> > will trigger a DATA LINE timeout interrupt.
> > 
> > This patch does not affect scenarios where the hardware timer meets
> > the
> > max data transmission time requirements of the device. It will
> > still
> > use the hardware timer. Only when the device changes, will it
> > switch to
> > using the SW timer.
> 
> Which is what the quirk does.  So I am very confused why the quirk is
> no goo

Because I don't know what the maximum volume of the real hardware timer
of each host controller is. And different hosts have different timer
capacities. Meanwhile, the eMMC devices have different data
transmission timeout between the different density/series as well.


Would you please confirm your three points above? If they are true, I
agree we cannot disable hardware timers and use SW tiner on some
platforms.

Thanks in advance.

Bean


