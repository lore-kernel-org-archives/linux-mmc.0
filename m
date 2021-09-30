Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D0EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 09:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939176135D
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 09:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348335AbhI3JD4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 05:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbhI3JD4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 05:03:56 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03321C06176A;
        Thu, 30 Sep 2021 02:02:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r11-20020a1c440b000000b0030cf0f01fbaso1302924wma.1;
        Thu, 30 Sep 2021 02:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=c2OSJ6Tm3I/BxFfLkZIog1e1qFWXewkgksb+5KT2Xvc=;
        b=A4Gt/a1nQ9nrrJesOtMirBZKp0LHciM8gh2s1VZp1gyDU0caOgCUa64rJUjRdgZIxT
         pQ2wA6EsNkmU5XHcTtAxnfafA8IZNfcX+L7binT1C+bAiic3UxQeDC/BuT/QH++AdbLN
         LOziOPqx+uDKw8R+rFP7fOrfvGPz0m/rJUB3kQ/r8/BTeu4Rw9vwDwR9kOJjQUFCPNA6
         UXnG+Xv9LDtela8wI8W6ti5hy47yJ2pnteh7E0xcV1dM0TXvB97HedqspRsGdXZVfKqA
         QwSt3tIki5yA7kbzbWK6EUp3O41KteIO3eOy6AXxvikUtHR4OUWHLYLnOeN/vmnVf6mc
         Uxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=c2OSJ6Tm3I/BxFfLkZIog1e1qFWXewkgksb+5KT2Xvc=;
        b=Mr3GLIpVEvxjQbeFOgbM77VWVSbzU/T1NL5HMuSrMI9QKG6rHpAki1YBowLbAyR3uy
         1oKRIZoY3MjU+ZnbqIwIpxtkHpGz9EOb7vs5ajEzPM0vdSWavIyXrooo49kxeMJoEugN
         MGFe5Q1b5g5PoNoyZhe5AeBCjerkcyEUVHXU9WGt6VBos5alJNQCXBs647jgf1yt5diT
         FBAy1uhy4Zg/QWtSkC2PpMjyNThLtw9kjmY+wgfaDNvDBkxYl6EDZZGrLuy+S3SN+MF+
         MQ3KGZvCzVD6TiODeNQTqnSYTS42U5jNQ4dk8IcsL8dugVoOTEJSmwo5u5ucg34l4dt6
         mXhA==
X-Gm-Message-State: AOAM531huAbKfNT6PPsaA/2bDUZKY+loudZH5W37lMHYvSYHcOJuH+g1
        Av0D1CBVz7nARPFnj/OLe8E=
X-Google-Smtp-Source: ABdhPJw0ezSMQ5DejodJ+DOIdh1ODEy5YoRsLzPnaBMAuXsMdFJM6y1b7oLJS9XtV5uwJE6iExuVHA==
X-Received: by 2002:a1c:ac86:: with SMTP id v128mr4161574wme.3.1632992532241;
        Thu, 30 Sep 2021 02:02:12 -0700 (PDT)
Received: from p200300e94717cf3f837b83e464a227b5.dip0.t-ipconnect.de (p200300e94717cf3f837b83e464a227b5.dip0.t-ipconnect.de. [2003:e9:4717:cf3f:837b:83e4:64a2:27b5])
        by smtp.googlemail.com with ESMTPSA id d129sm4271268wmd.23.2021.09.30.02.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 02:02:11 -0700 (PDT)
Message-ID: <c697fa8a72125bee811c6b78813d976afe132c5f.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Sep 2021 11:02:11 +0200
In-Reply-To: <6d57e6bd-24ba-f07e-678c-691f202549d5@intel.com>
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
         <296607ef57f3fb632107997f4edca99a5722beab.camel@gmail.com>
         <b7fd4a22-65f6-d1c4-675c-5930452a1fea@intel.com>
         <3078b365b5ddfad198a5c8a097f2e7edb9730e2c.camel@gmail.com>
         <6d57e6bd-24ba-f07e-678c-691f202549d5@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 2021-09-30 at 11:59 +0300, Adrian Hunter wrote:
> On 30/09/2021 11:34, Bean Huo wrote:
> > Hi Adrian,
> > 
> > 
> > Thanks.
> > I want to give a short conclusion  for our discussion:
> > 
> > Based on your information, these sounds disable of HW timer timeout
> > interrupt will make eMMC host controller malfunction, in another
> > word,
> > the disable of timeout interrupt will make the eMMC host cannot
> > correctly provide the completion interrupt. And unless only when
> > the
> > SOC vendor signals that their SOC supports that the host side SW
> > can
> > disable this HW timeout interrupt, as TI does.
> > 
> > I studied the SDHCI Spec, and tried to see if there is this kind of
> > support statement, but not been found yet. I will check with other
> > SOC
> > vendors.
> > 
> > I have one more question, if you know, please give me your
> > information.
> > 
> > I did testing on HW timer bahevior in case CQE is on.  Currently,
> > we
> > always set the HW timer with the maximum timeout value if CQE is
> > on.
> > Based on my testing, the HW timer will never timeout when we enable
> > CQE. I changed the HW timer value to be lower, it is the same
> > result.
> > Do you know that the HW timer will be inactivated in case CQE is
> > on?  but its timeout interrupt is still enabled.
> 
> No I don't know how different CQE handle timeouts.

Thanks anyway.

Bean

> 
> > Kind regards,
> > Bean
> > 

