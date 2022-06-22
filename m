Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDFDC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jun 2022 05:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356045AbiFVFJ4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jun 2022 01:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347664AbiFVFJz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2022 01:09:55 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1103435878;
        Tue, 21 Jun 2022 22:09:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id E3129809F;
        Wed, 22 Jun 2022 05:04:54 +0000 (UTC)
Date:   Wed, 22 Jun 2022 08:09:53 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org,
        Yegor Yefremov <yegorslists@googlemail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-omap: Fix a lockdep warning for PM runtime
 init
Message-ID: <YrKkIRyhHnVcCyZt@atomide.com>
References: <20220617040300.30321-1-tony@atomide.com>
 <173521c9-2e5c-8301-1dcf-b6f692866ef2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173521c9-2e5c-8301-1dcf-b6f692866ef2@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

* Adrian Hunter <adrian.hunter@intel.com> [220617 06:20]:
> On 17/06/22 07:03, Tony Lindgren wrote:
> > We need hardware enabled early in probe to detect capabilities, but must
> > not call sdhci_runtime_resume_host() until sdhci_setup_host() has been
> > called. Let's check for an initialized controller like we already do
> > for context restore.
> 
> Begs the question: why not prevent runtime pm until after sdhci_setup_host().
> Maybe expand the commit message explanation a bit?

Sure will add some comments for why sdhci_omap_set_capabilities() is needed
before sdhci_setup_host() and post v2.

Thanks,

Tony
