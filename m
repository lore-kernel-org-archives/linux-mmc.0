Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0694C11F69
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D576361D05
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 07:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhF3Hpr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 03:45:47 -0400
Received: from www.zeus03.de ([194.117.254.33]:49870 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233076AbhF3Hpq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Jun 2021 03:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=6uK9DRoREtGPKrcTebOsNOSCc3It
        U31E6+dA2ivvjsg=; b=fJ4Op4AVm+MZ9evNRxgHugcY1w8o1mVU//3o9PGeYa2c
        uNfa0Os16UgYnkgb2G+MWxKPiw2UkssTNl853KA8f582OJQtE2oUEvNUTBapxbbr
        R1ZYlvtHGgUrnMyA/5LKQh3XywWgOvCO5AlHAcBhd9ZSOy37FsI0LDZF+AmePzk=
Received: (qmail 773742 invoked from network); 30 Jun 2021 09:43:17 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 30 Jun 2021 09:43:17 +0200
X-UD-Smtp-Session: l3s3148p1@eVAn4PbFsuIgAwDPXwaiAGDoJRk6bv4I
Date:   Wed, 30 Jun 2021 09:43:16 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH/RFC v2] mmc: host: renesas_sdhi: Refactor
 of_device_id.data
Message-ID: <YNwglKoAiGaSM1DW@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20210629102033.847369-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aVJdi43/g2klazS4"
Content-Disposition: inline
In-Reply-To: <20210629102033.847369-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--aVJdi43/g2klazS4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


>  [2]
>  I tested sdhi ch0. But, with and without this patch, sdhi ch2 doesn't work
>  correctly...

Same problem with the Lager board/r8a7790. I suppose this is the same
issue Geert was seeing during his regular tests.

But this has nothing to do with this patch. The probing of the SDHI
instances work fine.


--aVJdi43/g2klazS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmDcIJQACgkQFA3kzBSg
KbaTbA//SDJ5j7x46/1ifhEcf/QUPu//wg1cMGW3L0VHG/9ySIhspMmn9vh+IErx
5IKHBbr0HE3FwaoacB+H92i3Pr7Kgq/iQmlw2SxbCohUlQL9GqIITEaKQRne8yMa
0fZPWdvkggzHYnM3vUOSYFAsgI20JuTE8zFjfKa8mapqaz8lPYS3Q7OLl9AvOsBD
z66EAI6gypzl9Y29EZYkaAGQ2pd8YBxUeZ+FmgZgg1GsX0KuigmxtfgK42Tko7yw
xwI9OA62zW5FYADJYW3KEH1elAYvj8QZ8ILr+P5MDQjdvyHtzKakURY6jbAHZemt
Cs1rJcRGrRvNHxV8yqKmaEKWGYLMQSZsYX67nIS+vlzLCu08GitJxvyJ5UuhgNXa
ntDNV0dmOrcFio2mefL9GNTZIVg101EysYAX7PxVmEQ57Q+shQ3TatMP3xW/3raM
ZN6CjnyfKMUpPNnl8aFUcqyHG3JBmpXqslfgpA6Yi9a7VQydm6Ktty05KBXfTvrb
+sY0Xnn9tnwVh4wzpiUAgv7pM9xmL3+SyhDzYl/3ZwUasx5aDwWPd7QpBLpqlzWk
qEVFDpcZBNFPvC8aKMOEqQvC89rt3UJnSb6I0ZuLg5PanktrmuntsPMtltZtOgeD
SQ+COfjCyx77TmBlKtbVAQssnpwQS+9HJMdzApB9OWiEAYlbkeM=
=wzMZ
-----END PGP SIGNATURE-----

--aVJdi43/g2klazS4--
