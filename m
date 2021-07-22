Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E482EC63793
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 12:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C998F6109D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 12:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhGVL5J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:57:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41116 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhGVL5J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jul 2021 07:57:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A09192039A;
        Thu, 22 Jul 2021 12:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626957463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1m+CfvaDK5C8e6mlOOeV2kSodv7cortzZU0gLSOIUo=;
        b=qNEZYTWvmWL3Ol/o+Zb3cjGl5Ezm2LXxJSuK2yzlXCS6153r2XoOTbLTJEI754Rcx+7J/w
        izRezrFLewxJ45n9r7tnvVLRxGHeh4aiLLfBvLZJAPiNs5ACFMImTwIlxkS8n4bmtVKdD5
        0j6LsbyeyTW99SAmHlffvsB0BvEpPk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626957463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1m+CfvaDK5C8e6mlOOeV2kSodv7cortzZU0gLSOIUo=;
        b=51tJlsFhGxgpiD3viQZcNR/eY/ODdnc2TKCHmU3PtQ+E0U5DcMwyZGhSQzmNmdZUxte5iI
        NmSWzhZ1moFLb7Dw==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 986C9A3B8E;
        Thu, 22 Jul 2021 12:37:43 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 855F1445C89; Thu, 22 Jul 2021 14:37:43 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
        <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
        <mvmlf5z66l9.fsf@suse.de>
        <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
        <mvmh7gn649v.fsf@suse.de> <YPhT1APE8QweDCoP@smile.fi.intel.com>
        <mvmczra64yj.fsf@suse.de>
        <CAHp75VfY-_xtRJyfez_4voDuOUcfJAfFjtnAipCt2_UA4wqbQg@mail.gmail.com>
        <mvm8s1y5zbz.fsf@suse.de>
X-Yow:  Vote for ME -- I'm well-tapered, half-cocked, ill-conceived and
 TAX-DEFERRED!
Date:   Thu, 22 Jul 2021 14:37:43 +0200
In-Reply-To: <mvm8s1y5zbz.fsf@suse.de> (Andreas Schwab's message of "Thu, 22
        Jul 2021 14:04:48 +0200")
Message-ID: <mvm4kcm5xt4.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Jul 22 2021, Andreas Schwab wrote:

> On Jul 22 2021, Andy Shevchenko wrote:
>
>> Compare the code of
>> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L649
>> vs.
>> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L56
>>
>> and
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L139
>> vs.
>> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L361
>
> Thanks, I think I now know how to fix it correctly.

In fact, the correct fix has already been installed in commit
3ce6c9e2617e ("spi: add of_device_uevent_modalias support"), which is
part of -rc1, just incomplete, which explains the inconsistency above.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
