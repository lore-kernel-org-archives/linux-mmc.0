Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E06C433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F9961972
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhCVRDX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 13:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230055AbhCVRCz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 13:02:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 842B461994;
        Mon, 22 Mar 2021 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616432574;
        bh=j2HO5OoqkEm2x2kfPv94BhXXYbFtTBBchdYGLintigg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DcAY5hbM4pnCPz3JJslqsQb64iEAai0K2nYeOiiJuMWkMEj2X8TFhDGvRNBeOTqs1
         Y/l3dFscasJdVG2F7blggHRSqf7px7BWP63ho0ephkHJpTsPm3nVmcZ8T3xvLT2r7P
         0YWvDvn9/ffbYApRkRa81Z8szaeKQM57d4/UGKVlTYdXshpL3x7FEhhXOhLC2r7Kwr
         pXOvvJJDWHGTEYkSprIwwSK2kKngvoowaG+5qCIKhb+9iE6mEK/S2r3GLiCJ5Ta+KE
         xXJU9HBl0KAsUFH5ZFVhOQ0B0GSixoYEpZ+usqyNDfsV/FdUAmfQHK9d70OODK9HF5
         uANJN0DrSUl1w==
Date:   Mon, 22 Mar 2021 10:02:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Help with eMMC inline encryption
Message-ID: <YFjNvGAu8M/+ERCo@gmail.com>
References: <20210317171554.a4vgihqfjq2xa5cb@gilmour>
 <YFJLipl1CzTJ/B7/@sol.localdomain>
 <20210322155318.yg4u634a7fxg2yiq@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322155318.yg4u634a7fxg2yiq@gilmour>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Mar 22, 2021 at 04:53:18PM +0100, Maxime Ripard wrote:
> 
> Indeed, I somehow missed that you were setting the DUN in
> cqhci_crypto_prep_task_desc, and I'm guessing that's where my issue
> lies: it doesn't look like there's any field to set the DUN in the
> controller, which doesn't make much sense to me.
> 
> The documentation is pretty short, but it looks like it might be
> inferred from the MMC commands arguments (the Access Mode bit in the MMC
> controller, page 517). Would that make sense?
> 

If your hardware has no way to specify a starting DUN (or starting IV) for each
request, then presumably it automatically chooses IVs based on the location of
the data on-disk.

This way of IV generation is problematic for several reasons, and it doesn't
match the UFS and eMMC standards.  So blk-crypto and fscrypt don't support this
type of hardware.

- Eric
