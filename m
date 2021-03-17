Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3B4C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC40F64EED
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Mar 2021 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhCQRQ2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:16:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54687 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230378AbhCQRP5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Mar 2021 13:15:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 21CD15C0046;
        Wed, 17 Mar 2021 13:15:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 17 Mar 2021 13:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm2; bh=DYx1bky6R0agW3EYEG35IrGtHvLURt049QRSMLuW1aA=; b=Rl9bmOoh
        vRcqguBmrPZHZxYyvxVJYS41idfV9QJicKUF3Pd5erlanD5rBdUPYreNnPuUdJfB
        jxoH7EwpTpU1JralDGXh8dTUE06u12czs/cETM2OPtQ6B+fXJULJp91OXWQ4t8yH
        0BPssgJ365DJyRbBpUmAEe9KnXqxdl924OYq2VMX0fvCmpUGiFb+uPG6scxGwacE
        GLzSSzL6Tq62iiT5yBRXVZmmjnDtC9/mW1mEsUwKU/dSpzPFLwl6DCD9cP3+yZLm
        kNoZo5Ife7fOjG9qzZsiO3yH6pMk8ioRRCYRozIzZgJjZw2JakbqzQAJepMx5NBr
        fMZ9BYnQaFROow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=DYx1bky6R0agW3EYEG35IrGtHvLUR
        t049QRSMLuW1aA=; b=t4uEt002ZldSPFNxDMK8mOpD4bg34ueo5MoK1dYO1IbvN
        7cjqQq7DtYIbbw2yFMQpEOYcKXAHsKRfh1IswhQVyLpttywPAj8vGVAgdrPtKOPF
        1ICyMXndB2rQcxwaBmNVU5GKaP1ECAQ1VmSLwnfHAsbmBksEY1xeHBnePJmd3rx/
        GbZdBGUIO6UngEUNeh43lJJNruMu5uNNz3LkMEPH6TIo0J4CkoyoEb7B72f8QoyJ
        5MkVBoST9q2BhTr13Mq/+DZJKi7hjOEvvyWYLKLZuqhp9DkzMrznjJmhRz5730qF
        3bnSpKjuXwj1cLZUmR9Ro3uImhwjUf9FCUnRvuPPQ==
X-ME-Sender: <xms:TDlSYJbY68b6vDjnDmNeGbyRlw6h0DKMdCJ4YdajfS8h5CJpZNXuDA>
    <xme:TDlSYLUaeuTJRTG02v3jQ8CSrWo4jcXLBYaN338hBCZTDy2jWVWbnXJKIIE8sejlk
    KafnJM-ZCb46KZor8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefgedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduhffggedtveeghedvueehieevjeegiedvvdelueduueektdeuveeuvdeghedt
    gfenucffohhmrghinhepphhinhgvieegrdhorhhgpdhkvghrnhgvlhdrohhrghenucfkph
    epledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TDlSYK9z4J6_66gYxAUc8DpDzRrcpQVruxLLAw41CgbwYn7cOgtOlg>
    <xmx:TDlSYM9_orNO2BsSYQiiViqp5QmLp2qRhHlkxYKCY6O2cU4F9eOMYA>
    <xmx:TDlSYCRBHLvPRvh8D8ZiCEZP0PBIVrckXknIM7VZ1Q504SGyztZ6BA>
    <xmx:TTlSYAuUKJfrCDo8EbzhrIqWvVdbNnfqkIg9G-_XnT8CSrKuoLsU0Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7BACD108005C;
        Wed, 17 Mar 2021 13:15:56 -0400 (EDT)
Date:   Wed, 17 Mar 2021 18:15:54 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Help with eMMC inline encryption
Message-ID: <20210317171554.a4vgihqfjq2xa5cb@gilmour>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dm3d6ropvvjujazk"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--dm3d6ropvvjujazk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Eric,

I've followed your work to integrate fscrypt for an eMMC, and now that
it's been merged started to write the support for the Allwinner H6 [1]
that has an encryption / decryption engine (EMCE, page 332) for the eMMC
controller (page 495).

I have some code that does most of the work to enable it and I'm at a
point where I can run xfstests (so the accesses seem to go through the
crypto engine, and they decrypt something), but the content of the files
are off compared to the software implementation.

My first guess would be to check how the key is setup in the hardware,
but it's where I'm not really sure what's going on. It looks from the
cqhci driver that the AES-XTS key has twice the size, and it's written
in two steps for some reason? [2]

Since the AES-XTS key size allegedly supported by the driver is 256 bits
but the key size is 64 bytes, the comment makes sense, but I'm not
really sure what is happening and what I'm supposed to be doing with
that key.

Thanks!
Maxime

1: http://files.pine64.org/doc/datasheet/pine-h64/Allwinner_H6%20V200_User_Manual_V1.1.pdf
2: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mmc/host/cqhci-crypto.c#n92

--dm3d6ropvvjujazk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYFI5SgAKCRDj7w1vZxhR
xf2rAQCW8LKuSndK8atuv2bxS9d63LCj7EPaLgGEyVEPXVgCQgD+PDPHDrnPb2hi
lE7CgbSy+fVS0BztUlI39mhGowJVygI=
=QB1c
-----END PGP SIGNATURE-----

--dm3d6ropvvjujazk--
