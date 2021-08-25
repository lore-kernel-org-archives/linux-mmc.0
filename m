Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0428C432BE
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BE861222
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 08:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239344AbhHYIoT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbhHYIoT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 04:44:19 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B96C061757;
        Wed, 25 Aug 2021 01:43:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z9so35116684wrh.10;
        Wed, 25 Aug 2021 01:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zUmFDHqZ0Q3WxpEfUpWX476kiHcEeInO7lHUzdflDWo=;
        b=k8PzlGsAphn4WEDJKn65ujM/HNNd3Dxr6uq8S+7YcKg8sBFwOO1fQnr0Frhmj2ql9f
         Yvz6hgvoCWhSMSiU1jXSV68oI+IOqWX3ccfm4Oe462e0xEhiDtFQUM9NyBBdQ5tHDWqc
         uz//uLqfzrESsQY3ImHQYxRcjohE5t7vMY4tv9JxEMHNBOjo0v0942QCJVY30xKQ45Wl
         THjNgUSebonsNLu8w2aPHdregLzQL2UKRgh3+8k8AtSX1ULMwfeerYUYdqrq60ZRusSU
         ZPvLffD7hHe6Kn3KJ1dHRqN+b/ueyJx0s6yH4lfKefKeqNi0F3BXGE0392WTDp7c6jkH
         bXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zUmFDHqZ0Q3WxpEfUpWX476kiHcEeInO7lHUzdflDWo=;
        b=lpHJAhTDOaAiU7RjjLXnadOtuoMYk4l8ue903TJF6/sVYXCYPrAG92qUv0JxpTSWDM
         PnKeG7kmrDb7H81WcqHzgaJyd6LHLtYh4k8kcmXeWUWokZSPhbeUw/CPLtIFEmWK3EWI
         aa1liWDUqypG0Bf4T9TPstrgSCnIumzbKtk8d76vIolwB5bLP95QzViBvWhbzT8TRzEf
         bW6/efwOmA+Y+pqcjz+Zyy2YFQoAJ7o+2Z2qhITwgUHGuCTfk2u3Gm6CF2Fkt5GUhPuk
         0G72XCJpYKtkX6KawEGpKv0vQdEeQBqieEz3zaDBBsFvncq5qjwFgH5pJuEErc4Oh0e4
         SMGQ==
X-Gm-Message-State: AOAM533+nCqoI5CP9E+ypkY/JF6g1EBtABjOMkunSkYei68DCLWcOZbR
        7x8Oqky2X6cVZYVoW6wRlkQ=
X-Google-Smtp-Source: ABdhPJwJKck/zWbcc1t+3q/jJstxA2vTfT+n1VmldE3E29GY5UytssOrLIACln0YeIdwgsJuIe4IJQ==
X-Received: by 2002:a5d:40c9:: with SMTP id b9mr6646225wrq.212.1629881012172;
        Wed, 25 Aug 2021 01:43:32 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec31.dynamic.kabel-deutschland.de. [95.91.236.49])
        by smtp.googlemail.com with ESMTPSA id a3sm20232294wrx.38.2021.08.25.01.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 01:43:32 -0700 (PDT)
Message-ID: <9e78ecd5b79ed7f0ca91021799e6e7396c458094.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Let BKOPS timeout readable/writable
 via sysfs
From:   Bean Huo <huobean@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Date:   Wed, 25 Aug 2021 10:43:31 +0200
In-Reply-To: <CAPDyKFrQLDiamWZGzDDoA0EeRhR+VaeWuUHiu9EAMqDrQT-5CA@mail.gmail.com>
References: <20210817224208.153652-1-huobean@gmail.com>
         <20210817224208.153652-3-huobean@gmail.com>
         <CAPDyKFrQLDiamWZGzDDoA0EeRhR+VaeWuUHiu9EAMqDrQT-5CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2021-08-24 at 16:33 +0200, Ulf Hansson wrote:
> On Wed, 18 Aug 2021 at 00:42, Bean Huo <huobean@gmail.com> wrote:
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > For special cases, the application in the userspace wants to change
> > BKOPS operation timeout value, also, wants eMMC back to
> > R1_STATE_TRAN
> > after BKOPS timeouts. A fixed BKOPS timeout value(120s) is no
> > longer
> > feasible, therefore, it is better to let the user controls its
> > timeout
> > value.
> 
> I am not fond of exporting tweakable timeout values through sysfs.
> Primarily because it's ABI and it becomes difficult to change.
> 
> Can you perhaps explain in more detail when you want to have a
> different timeout?
> 
> Perhaps we can do something similar as we currently do for
> mmc_santize(), where we allow userspace to pass the cmd-timeout?
> 
> Kind regards
> Uffe
> 
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > 

Hi Ullf,
Thanks for your review. 

Actually, taking the first patch "MMC: core: Issue HPI in case the
BKOPS timed out" is good enough in the most of cases. And the current
120s timeout for the manual BKOPS is also enough, we don't need to
change this timeout value through sysfs.

Kind regards,
Bean

