Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE4C636C9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 14:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C77608FE
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 14:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238646AbhGUN5Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 09:57:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56586 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhGUN5Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 09:57:16 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D788A2255A;
        Wed, 21 Jul 2021 14:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626878271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eN44dIX8eTpjHono1WIQrZzm8Y1UwDC5+yNmFTgedG4=;
        b=wwkkTZicIkiUQYWl35KTgyWCTCMUwwUy9vZAPSLbLIK0lF4mO9+JdHpcSjlE3KcyZUYtzL
        5w2iPtrPd4fjWhEtXnmd065QALviRwUtxEErW2xC8Yv9h+PvSvmKAYk4LEMZqjgKqSwbRt
        eW0UhD2EECW4nr3emPQ8VT+9w7CjZg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626878271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eN44dIX8eTpjHono1WIQrZzm8Y1UwDC5+yNmFTgedG4=;
        b=kTKu7JQBgwLtaB2FnfyImXgleYuL9s6zE3rnn3mV+A1YPiCms9y7e/kXNZJ6bRbFyfB1Oh
        gvBoRt3Uevw1itAA==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id D00B0A3B87;
        Wed, 21 Jul 2021 14:37:51 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id BCD22446119; Wed, 21 Jul 2021 16:37:51 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
X-Yow:  How's the wife?  Is she at home enjoying capitalism?
Date:   Wed, 21 Jul 2021 16:37:51 +0200
In-Reply-To: <YPgwHcbK7XoXL/mD@smile.fi.intel.com> (Andy Shevchenko's message
        of "Wed, 21 Jul 2021 17:33:01 +0300")
Message-ID: <mvmpmvb68cg.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Jul 21 2021, Andy Shevchenko wrote:

> The driver has OF compatible strings and should be loaded automatically.

They are never being used.

# udevadm info /sys/devices/platform/soc/10050000.spi/spi_master/spi1/spi1.0
P: /devices/platform/soc/10050000.spi/spi_master/spi1/spi1.0
L: 0
E: DEVPATH=/devices/platform/soc/10050000.spi/spi_master/spi1/spi1.0
E: DRIVER=mmc_spi
E: OF_NAME=mmc
E: OF_FULLNAME=/soc/spi@10050000/mmc@0
E: OF_COMPATIBLE_0=mmc-spi-slot
E: OF_COMPATIBLE_N=1
E: MODALIAS=spi:mmc-spi-slot
E: SUBSYSTEM=spi

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
