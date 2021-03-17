Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B1C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 18:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9627F64F40
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 18:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhCQSe2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Mar 2021 14:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232756AbhCQSeC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 Mar 2021 14:34:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E779264DE0;
        Wed, 17 Mar 2021 18:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616006042;
        bh=+fMEHGLGuabxejiA0sEOBD3V33S07PtRgTIZ1OoGhrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LogfO5fxOPtR6FCCAvEpFfyoubfyyc22b0w0Hkn7CG8HNy3I/T9j4BLJTOhg+Qk0z
         y8Uv48n8bwdZX+saXs3EI08SAbyMVIeyw8GyoPTs2sVWQaSc5CB3a7j8SRSSn61dQC
         akX5obKL3momdYzhsPL1pXv2LZZQb6G88cQ7jn7/H8FMjSaaIu56MMpAZC8FDZVRgU
         hq3af2T7Jk42oRVU91G1ddh5+D7msBNr0MeunWgqTTrx3mXZ3j8+HMzlCpv25zCEe5
         9zulFSEXyYKLHolzUnRx6JE1r2XHS9bIWrMDlNlDmmg3YljeaJmje58Vkch6RPJtKd
         B9JyKLkUOdGnQ==
Date:   Wed, 17 Mar 2021 11:33:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Help with eMMC inline encryption
Message-ID: <YFJLipl1CzTJ/B7/@sol.localdomain>
References: <20210317171554.a4vgihqfjq2xa5cb@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317171554.a4vgihqfjq2xa5cb@gilmour>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Mar 17, 2021 at 06:15:54PM +0100, Maxime Ripard wrote:
> Hi Eric,
> 
> I've followed your work to integrate fscrypt for an eMMC, and now that
> it's been merged started to write the support for the Allwinner H6 [1]
> that has an encryption / decryption engine (EMCE, page 332) for the eMMC
> controller (page 495).
> 
> I have some code that does most of the work to enable it and I'm at a
> point where I can run xfstests (so the accesses seem to go through the
> crypto engine, and they decrypt something), but the content of the files
> are off compared to the software implementation.
> 
> My first guess would be to check how the key is setup in the hardware,
> but it's where I'm not really sure what's going on. It looks from the
> cqhci driver that the AES-XTS key has twice the size, and it's written
> in two steps for some reason? [2]
> 
> Since the AES-XTS key size allegedly supported by the driver is 256 bits
> but the key size is 64 bytes, the comment makes sense, but I'm not
> really sure what is happening and what I'm supposed to be doing with
> that key.
> 
> Thanks!
> Maxime
> 
> 1: http://files.pine64.org/doc/datasheet/pine-h64/Allwinner_H6%20V200_User_Manual_V1.1.pdf
> 2: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/cqhci-crypto.c#n92

An AES-256-XTS key is 64 bytes; however, internally, the XTS algorithm divides
it into two AES-256 keys.  AES-256-XTS implementations usually take the key as a
single 64-byte value; however, some require that users specify the two halves
separately.  Also, some implementations use incorrect naming, like calling the
first half of the AES-256-XTS key the "key" and the second half the "salt".

Looking at section 3.15.4 in the document you linked to, that looks to be the
case here.  You probably need to write the 64-byte AES-256-XTS key to
EMCE_KEY0..7 and EMCE_SALT0..7.

If the ciphertext still doesn't match, you'll need to check the other things
that you could be going wrong, including:

  * Endianness and order of the key words.  For example, if the hardware expects
    the key words in big endian byte order and/or the key words in reverse
    order, you'll need to take that into account when writing the registers so
    that the hardware understands the intended 64-byte AES-256-XTS key.

  * Mapping of DUN (data unit number) to IV.  It should be little endian.  For
    example DUN 1000 should result in the hardware using exactly the IV
    u8 iv[16] = {0xe8, 0x03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}.

  * Data unit size.  The hardware must use exactly
    data_unit_size bytes for the AES-256-XTS message size, and it must increment
    the DUN by exactly 1 after each data_unit_size bytes encrypted/decrypted.
    Note, fscrypt uses 4096 bytes for data_unit_size.

- Eric
