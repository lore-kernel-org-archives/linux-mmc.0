Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9001CC433C1
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9646198D
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 15:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCVPxu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 11:53:50 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:58161 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231332AbhCVPxZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Mar 2021 11:53:25 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4CED0170A;
        Mon, 22 Mar 2021 11:53:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 Mar 2021 11:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm2; bh=P
        DSaTyhXXR7JaqWkOq73ugr1KZtiWXLzc+7kCsW/1cM=; b=csWqTdXGmDo4wBjMS
        jsIZTe8Avp6SevWFEz2FydNFMUTpBtZ/sSG0RxzmRTFy1w6AVBLSPoZdnoYvPP4B
        JbQmYgWYSoBUX8NUlHuHxmIBbC/g/9VgJfDidLomG0/RzkSxo5lHPr0AwgDB8G45
        WGNcY1UnbED5a5IT+SuoEXO0wHHtHePQQAjMlQX+WF8/nyDjYvmh5nrMWV76c2UE
        ltIVTR82rwAa1K9ATS/rteSEboDAL7BYr+Sdn8smWTVi8XIN2PmjCCVeynzaIMng
        ySNHVTVGCw6mtQB7IOYHyfMRrUhL5ismHBVnOKJiYZML3+WGBDGyGGfRN2WE9LEN
        yPGaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=PDSaTyhXXR7JaqWkOq73ugr1KZtiWXLzc+7kCsW/1
        cM=; b=truZjCL8Jh3I4oxlO4EEzqwyOSA2IbErmvsZuYg1Nf4IG15B3qpo4GYVK
        hrjphLnHQpX07pMk4Alr8GvHMPFC/yDnj1lvKhrTrbWwdWgW89RSNVI00SZcCyeK
        LXUlf+97HnkVd0llMnr19mGOZdknfe5Te+nIYJ1VyHUZHlV2xEOgrFl81jyVDIIY
        fsFfcXI7kZCNl0PoDJRo2iOJHW71utS6VwMGTtnk2xMrm70mM18s5HJrXbgC+HWJ
        Uka5keDMyW6106qd5IUqM6tGZSYk34g7cS86UF7WU43W38Cc9uWFdzNeu5/Krsn/
        NiC/7dhu93LFc+t+cKpy0V3tFeklQ==
X-ME-Sender: <xms:cb1YYNN7NI8qAqU4j9YKo9Bz2CVjiSkrEMN7BuiEPcQih7vZlH9fiw>
    <xme:cb1YYP9mEol-EmgDJr-ads80unY8mTLdBTQe7wYL6WYMpsA3ZwaGC7JsJEnPDJyUX
    Gwf001_9_O3iKUvMQo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeekgfduieefueelgfehieevtdeuheekgfelhfeuieeihefftdevveekgfek
    geeftdenucffohhmrghinhepphhinhgvieegrdhorhhgpdhkvghrnhgvlhdrohhrghenuc
    fkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:cb1YYMRM0_HTN4AJqsXVVNs7UcddkiRlI7lEvmsBKxTXH6vKTrq2_w>
    <xmx:cb1YYJszg8_NljoQmxeQCBuydBh2nnXwKIUqSJBD097M6DI90P2hmg>
    <xmx:cb1YYFf_YXTS2o6tz_gAuOlBG2JwkYW1EXjJq88A2Vs7LOOtia8-qw>
    <xmx:cb1YYFm-i2XS6yM7apPXxfxy100RTieokxHdXMQvkZ7HxQjDrrSvQQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4D908240423;
        Mon, 22 Mar 2021 11:53:21 -0400 (EDT)
Date:   Mon, 22 Mar 2021 16:53:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Help with eMMC inline encryption
Message-ID: <20210322155318.yg4u634a7fxg2yiq@gilmour>
References: <20210317171554.a4vgihqfjq2xa5cb@gilmour>
 <YFJLipl1CzTJ/B7/@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YFJLipl1CzTJ/B7/@sol.localdomain>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Eric,

Thanks for your answer

On Wed, Mar 17, 2021 at 11:33:46AM -0700, Eric Biggers wrote:
> On Wed, Mar 17, 2021 at 06:15:54PM +0100, Maxime Ripard wrote:
> > Hi Eric,
> >=20
> > I've followed your work to integrate fscrypt for an eMMC, and now that
> > it's been merged started to write the support for the Allwinner H6 [1]
> > that has an encryption / decryption engine (EMCE, page 332) for the eMMC
> > controller (page 495).
> >=20
> > I have some code that does most of the work to enable it and I'm at a
> > point where I can run xfstests (so the accesses seem to go through the
> > crypto engine, and they decrypt something), but the content of the files
> > are off compared to the software implementation.
> >=20
> > My first guess would be to check how the key is setup in the hardware,
> > but it's where I'm not really sure what's going on. It looks from the
> > cqhci driver that the AES-XTS key has twice the size, and it's written
> > in two steps for some reason? [2]
> >=20
> > Since the AES-XTS key size allegedly supported by the driver is 256 bits
> > but the key size is 64 bytes, the comment makes sense, but I'm not
> > really sure what is happening and what I'm supposed to be doing with
> > that key.
> >=20
> > Thanks!
> > Maxime
> >=20
> > 1: http://files.pine64.org/doc/datasheet/pine-h64/Allwinner_H6%20V200_U=
ser_Manual_V1.1.pdf
> > 2: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/drivers/mmc/host/cqhci-crypto.c#n92
>=20
> An AES-256-XTS key is 64 bytes; however, internally, the XTS algorithm di=
vides
> it into two AES-256 keys.  AES-256-XTS implementations usually take the k=
ey as a
> single 64-byte value; however, some require that users specify the two ha=
lves
> separately.  Also, some implementations use incorrect naming, like callin=
g the
> first half of the AES-256-XTS key the "key" and the second half the "salt=
".
>=20
> Looking at section 3.15.4 in the document you linked to, that looks to be=
 the
> case here.  You probably need to write the 64-byte AES-256-XTS key to
> EMCE_KEY0..7 and EMCE_SALT0..7.

I've added the second part into the "salt" registers, and I'm still
getting the same result: the test generic/592 fails with a mismatch.

> If the ciphertext still doesn't match, you'll need to check the other thi=
ngs
> that you could be going wrong, including:
>=20
>   * Endianness and order of the key words.  For example, if the hardware =
expects
>     the key words in big endian byte order and/or the key words in reverse
>     order, you'll need to take that into account when writing the registe=
rs so
>     that the hardware understands the intended 64-byte AES-256-XTS key.

Thanks for the suggestion, however any combination of little/big endian
and natural/reverse order doesn't change the outcome.

>   * Mapping of DUN (data unit number) to IV.  It should be little endian.=
  For
>     example DUN 1000 should result in the hardware using exactly the IV
>     u8 iv[16] =3D {0xe8, 0x03, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}.
>=20
>   * Data unit size.  The hardware must use exactly
>     data_unit_size bytes for the AES-256-XTS message size, and it must in=
crement
>     the DUN by exactly 1 after each data_unit_size bytes encrypted/decryp=
ted.
>     Note, fscrypt uses 4096 bytes for data_unit_size.

Indeed, I somehow missed that you were setting the DUN in
cqhci_crypto_prep_task_desc, and I'm guessing that's where my issue
lies: it doesn't look like there's any field to set the DUN in the
controller, which doesn't make much sense to me.

The documentation is pretty short, but it looks like it might be
inferred from the MMC commands arguments (the Access Mode bit in the MMC
controller, page 517). Would that make sense?

Thanks
Maxime
