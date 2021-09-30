Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4DEC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAB9617E6
	for <linux-mmc@archiver.kernel.org>; Thu, 30 Sep 2021 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348640AbhI3IgX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 04:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348460AbhI3IgX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 04:36:23 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C88C06161C;
        Thu, 30 Sep 2021 01:34:40 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d26so8681354wrb.6;
        Thu, 30 Sep 2021 01:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1MGjEXt+mHWPJ7e7eWTU+rgmp7Dl3F/DDFe0m5/KLbs=;
        b=KF5fbPUefyfAyzwK2ggDY8z6NLn5wN6Ha9Q/AoFuO3EE1oewP+7x6qilUA8Xysexm4
         z6c1VlKvMkej1CfwYRZn2KcLff5GHvkUI+rEr3h9S/t73/qbULV61Nq1jAFtroKXgJR5
         rzD1J6puPj2D0T7ZYSW1c2zJEWzuYz0Ip+ZxrWRM+AJ2ZKa9TWzeTtBuRmeHVANIR7S/
         wBge8k3Z5P1tVQvqTV5+QzRJWTYB0IyIFjwAm5X/WhrG9LqLMYt5rxgvaJGscKS6tNdw
         btPytnIeW3uHBTczGOVgdU7VF5U9JmlL3/IDAdDCY8QzXEYDDgWtQvF4QsQ9giK60BbD
         jNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1MGjEXt+mHWPJ7e7eWTU+rgmp7Dl3F/DDFe0m5/KLbs=;
        b=PVfV9sE3EU0UbxZvd/eLHls8pGx9eYsh6rHdwSW2lnTvD87AFdIuBOhpQVyiciqOP9
         6b6GcFJTy/qeP5Ov1FBIVWNOMs6krUGR5QCivMK3OR1Mk8PzKsNxvoC7bDx0LumgpBdk
         9vgr9T31ZtD03pI1PQ4e6DHaamYyY/KryW0wcVifPrO3HHWg5mtFnk/x9mSn/THpIhoq
         iMAPvGm+lfqFX8i8CIdHH5Q3f2S22to0L/pgmNfbEqNmmZLuLF+o20a4j350/tdiYVGq
         RkpSURE9ZEsfok8qVJoir4Y8/Za79+G7IKJVfRnPZ6W/A2tEvYjA036QcBJwSCBGKgx/
         mC2A==
X-Gm-Message-State: AOAM5315DNzna0HSy/VjHDDqmNQqnvVYotxAmvghIpZoY3fpVPNPb0Eq
        xInkjBHttsxa070UuJRfg74d/C2fdPkFKw==
X-Google-Smtp-Source: ABdhPJzw8ajD+3XQP+d7eR9pL2NH0i9kr09quDmXsk+D2n48gPg2+l9t3mHI791+Vx0Kd2G6WTkn1g==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr4669675wrs.155.1632990879526;
        Thu, 30 Sep 2021 01:34:39 -0700 (PDT)
Received: from p200300e94717cf3f837b83e464a227b5.dip0.t-ipconnect.de (p200300e94717cf3f837b83e464a227b5.dip0.t-ipconnect.de. [2003:e9:4717:cf3f:837b:83e4:64a2:27b5])
        by smtp.googlemail.com with ESMTPSA id k11sm2274178wrn.84.2021.09.30.01.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 01:34:39 -0700 (PDT)
Message-ID: <3078b365b5ddfad198a5c8a097f2e7edb9730e2c.camel@gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci: Use the SW timer when the HW timer
 cannot meet the timeout value required by the device
From:   Bean Huo <huobean@gmail.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <beanhuo@micron.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Sep 2021 10:34:38 +0200
In-Reply-To: <b7fd4a22-65f6-d1c4-675c-5930452a1fea@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,


Thanks.
I want to give a short conclusion  for our discussion:

Based on your information, these sounds disable of HW timer timeout
interrupt will make eMMC host controller malfunction, in another word,
the disable of timeout interrupt will make the eMMC host cannot
correctly provide the completion interrupt. And unless only when the
SOC vendor signals that their SOC supports that the host side SW can
disable this HW timeout interrupt, as TI does.

I studied the SDHCI Spec, and tried to see if there is this kind of
support statement, but not been found yet. I will check with other SOC
vendors.

I have one more question, if you know, please give me your information.

I did testing on HW timer bahevior in case CQE is on.  Currently, we
always set the HW timer with the maximum timeout value if CQE is on.
Based on my testing, the HW timer will never timeout when we enable
CQE. I changed the HW timer value to be lower, it is the same result.
Do you know that the HW timer will be inactivated in case CQE is
on?  but its timeout interrupt is still enabled.

Kind regards,
Bean

