Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B727CC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Aug 2021 07:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 963FC6056B
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Aug 2021 07:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhHKHjA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Aug 2021 03:39:00 -0400
Received: from www.zeus03.de ([194.117.254.33]:33638 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235506AbhHKHi7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Aug 2021 03:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=cJhLM0w8xelHNY+NtuK+XG86hCLr
        bVL6hhxw6Nkx4uA=; b=N9ZslsZ2frHvx9+9dXFJnWBf3ERHXM+2CMH6CSsTfFPI
        MqEczSaGo6epHPe+HBpHZT7vQeGWQnjb0m/8zyEECLIMqsKN49oi7XOz9g9HpVAf
        9Z5rLmspL51SDCPKtZFFxThAaomVH1ftXoBhWtVUeUWaQLYZcXo8rm0HbZvWe7A=
Received: (qmail 2561430 invoked from network); 11 Aug 2021 09:38:33 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Aug 2021 09:38:33 +0200
X-UD-Smtp-Session: l3s3148p1@8EFytEPJPMYgAwDPXwY8AL9PxqFiRnVq
Date:   Wed, 11 Aug 2021 09:38:30 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-mmc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/4] bitmap: unify find_bit operations
Message-ID: <YRN+dmd0lKtYNe5N@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mmc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210719021755.883182-1-yury.norov@gmail.com>
 <20210719021755.883182-3-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/b49F6uIw+J2vpAL"
Content-Disposition: inline
In-Reply-To: <20210719021755.883182-3-yury.norov@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--/b49F6uIw+J2vpAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 18, 2021 at 07:17:53PM -0700, Yury Norov wrote:
> bitmap_for_each_{set,clear}_region() are similar to for_each_bit()
> macros in include/linux/find.h, but interface and implementation
> of them are different.
>=20
> This patch adds for_each_bitrange() macros and drops unused
> bitmap_*_region() API in sake of unification.
>=20
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

I fetched your bitmap-20210716 branch and tested it on a Renesas
Salvator-XS board with an R-Car M3-N SoC with some debug output added.
Still works and values make sense, so:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--/b49F6uIw+J2vpAL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmETfnIACgkQFA3kzBSg
KbaFWQ//RcyowROGCgtdqiVotoOwSBpocOqGVQAqLCl7wsSMcikuIt/D0NiQu37v
Cv0iGNjYcarcn3AL33EDywMyKAJS8LYXIyW75pH7Gc9tHmPeEZeJXEriKi+gT53Q
mJWlvngNQhIsPmtt1JMik7b2Qdl1R+S4AkS+lUVY7abj2pF9e7/IOPQ2hWKcaIK/
wzTfi5415Z4a7bB+JcHefmpkifGzMGu5DCSsaap/jEVVAgzO7WqFD4x9Oueh9ZtT
d1lHSB6CMMG6Iwb6ftDaG9OtLtmq0flmRqsqIMAhdJ/N7V6sEneNA/y0St6zTrx/
bE4v4OftO01EsLTqqvT//Gwq/GxEdl8/VoD7uH40phiOmu/w6UIQh3CHStRzbjpw
B/3jHXUO3llJso0MXr45C6/qHrKTNCZ27HDxcME7BO0LqnC4+nYOyNlGnQsax3Df
ACHAYTEaq/4VPrH3FKccsx+va0EaK3gdgvv2xTTbnUfOXp+FNaLqKHfC9Yj8duNE
GiVN9j01H0qNj1uTzgnkOav9xWNo9bErCPC2z6u/zCh44pXUhcOEMtuyxyLH1zgH
Lif9wOkhyOiCwT3I6wUepOPVfjcusa34Q1gKUOQjt3vpuSvOAK2P8WDDufSbeGMz
nhHNkASrn0+4ZGPHfqaFZBbPY37z3uiNRPbgyKFEP4UFqWSNR2Q=
=x/C1
-----END PGP SIGNATURE-----

--/b49F6uIw+J2vpAL--
