Return-Path: <SRS0=DxaD=D4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5015C388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 17:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC6002224E
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="TN/dz09I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503482AbgJUR3z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503481AbgJUR3z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2020 13:29:55 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A9C0613CE;
        Wed, 21 Oct 2020 10:29:55 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id CEDBD22EEB;
        Wed, 21 Oct 2020 19:29:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1603301388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=temgK5vVQG9U2QWr7A/AJokaFqROaQiMWwV8Ob+suB4=;
        b=TN/dz09IA9vm+/fSjtqWq5A+oC26StzoZYB/RDr2CIQpBbV8Yn3UMx8JN6UWm/13XYAGty
        2iGvSFgmp1XQr7jKCScUIHdy97ClxqhvYgW/vplpEigRJFEEyspzuW5F8FHVz+HI2Rdnjp
        iR+C2/CQx+VK4jmZFI8XFNobidfFYC0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Oct 2020 19:29:47 +0200
From:   Michael Walle <michael@walle.cc>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set timeout to max before tuning
In-Reply-To: <CAPDyKFrLtYmPpVumSMr0TAqSWx8+vc2Hzhfw-14aiJudPw7xeA@mail.gmail.com>
References: <20201015231149.9333-1-michael@walle.cc>
 <CAPDyKFoMmsYhwvNDdprtWiY+EMjXQx5uFvn4+fHmCG8zj6aryQ@mail.gmail.com>
 <7051c929a585bf7b1f62561f0ea91193@walle.cc>
 <CAPDyKFrLtYmPpVumSMr0TAqSWx8+vc2Hzhfw-14aiJudPw7xeA@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <63b574bbda356f93fe706301416195a7@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Am 2020-10-21 17:04, schrieb Ulf Hansson:
> On Fri, 16 Oct 2020 at 14:50, Michael Walle <michael@walle.cc> wrote:
>> 
>> Am 2020-10-16 12:53, schrieb Ulf Hansson:
>> > On Fri, 16 Oct 2020 at 01:12, Michael Walle <michael@walle.cc> wrote:
>> >>
>> >> On rare occations there is the following error:
>> >>
>> >>   mmc0: Tuning timeout, falling back to fixed sampling clock
>> >>
>> >> There are SD cards which takes a significant longer time to reply to
>> >> the
>> >> first CMD19 command. The eSDHC takes the data timeout value into
>> >> account
>> >> during the tuning period. The SDHCI core doesn't explicitly set this
>> >> timeout for the tuning procedure. Thus on the slow cards, there might
>> >> be
>> >> a spurious "Buffer Read Ready" interrupt, which in turn triggers a
>> >> wrong
>> >> sequence of events. In the end this will lead to an unsuccessful
>> >> tuning
>> >> procedure and to the above error.
>> >>
>> >> To workaround this, set the timeout to the maximum value (which is the
>> >> best we can do) and the SDHCI core will take care of the proper
>> >> timeout
>> >> handling.
>> >>
>> >> Signed-off-by: Michael Walle <michael@walle.cc>
>> >
>> > Sound like this should be tagged for stable, right?
>> 
>> Yes, but I was unsure about that. I didn't find a lot of Fixes: tags 
>> in
>> the history of this driver (eg. for errata etc.)
>> 
>> I could repost a v2 with a fixes tag if you like.
> 
> If this is regression and you can point to a specific commit it fixes,
> then please yes!

That would be commit ba49cbd0936e ("mmc: sdhci-of-esdhc: add tuning
support"). But as of today it isn't much left of that original code.
So I don't know if adding that fixes tag will help a lot. Correct me
if I'm wrong.

-michael
