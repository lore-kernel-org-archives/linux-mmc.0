Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C219C636C9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 16:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B2161245
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 16:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhGUPZN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 11:25:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhGUPZN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 11:25:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AB74E1FEC6;
        Wed, 21 Jul 2021 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626883548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXaVdmdVOspBLf87DTyZrv0DC3rht0alDNBSCfEl0Bc=;
        b=mYIGcLsHlGiWr9qAhll63WTrpruY8jZwExieXsSmllqWCbd+2rwQD3nfRFukmDKO/ZG+Vu
        7FgoYX4oa+evS/8QRdDcaUgBhXKdWIgG4kvQ+O6XzzacUNcWGuXn+lri4AT23lsNhe7ARl
        vcn9Mg49s/asy9HsS6mHIlAc4DRrbkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626883548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UXaVdmdVOspBLf87DTyZrv0DC3rht0alDNBSCfEl0Bc=;
        b=uUPsuQBvUB/sD56TtsPeKrtSwMOpAE9Ed3ICp8CfZHvMFgu9Ndmp6UzM2i7HgdyicESJZ4
        IRCzh6pMg24yK/DQ==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 95314A3B88;
        Wed, 21 Jul 2021 16:05:48 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 87991446119; Wed, 21 Jul 2021 18:05:48 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
        <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
        <mvmlf5z66l9.fsf@suse.de>
        <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
X-Yow:  Intra-mural sports results are filtering through th' plumbing...
Date:   Wed, 21 Jul 2021 18:05:48 +0200
In-Reply-To: <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
        (Andy Shevchenko's message of "Wed, 21 Jul 2021 18:45:00 +0300")
Message-ID: <mvmh7gn649v.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Jul 21 2021, Andy Shevchenko wrote:

> What is your DT excerpt for it?

arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts:

&qspi2 {
	status = "okay";
	mmc@0 {
		compatible = "mmc-spi-slot";
		reg = <0>;
		spi-max-frequency = <20000000>;
		voltage-ranges = <3300 3300>;
		disable-wp;
	};
};

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
