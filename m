Return-Path: <SRS0=oKGY=AH=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775EC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 14:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB6F2080C
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Jun 2020 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593182358;
	bh=3p9mdRB4uLRHfM5ED4x+A+enypba1du86Fnnn5R3oN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WkXXN9jjkZr3+6eNUlC+RKWfq7v+5HqY8vNuCCLEnFu8zlXW7M/i3vMBVJ4St8VqV
	 lda5eTd+LW6WDYYsrO66PsyhOqMyWHn9E4EQOTwgDhdRGkj7M2Axr9HUqAF62819U/
	 5yhyqm44rfUQPCnG3BK+g0WnolHyvqTyJ4lgJ+Hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgFZOjR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgFZOjR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 26 Jun 2020 10:39:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA69E2070A;
        Fri, 26 Jun 2020 14:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593182357;
        bh=3p9mdRB4uLRHfM5ED4x+A+enypba1du86Fnnn5R3oN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9LufMZjZpUsdOj5NZxZ7ZHzlf/GCD0ggoYB4HMhANZKUAxOlqxXLJcwYUioz50Eu
         pfGx2oI2JYvKW/SgrMNXZsvlwzW1GmfJs63bjSWffsymfxeHQWYE/8jhVbvPzH2LIE
         uiyqv9sHqhMFowmcIctUfVlLn9BpzXzDX4ZL2Kjw=
Date:   Fri, 26 Jun 2020 15:39:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, lgirdwood@gmail.com,
        geert+renesas@glider.be, magnus.damm@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH/RFC v4 2/4] regulator: fixed: add regulator_ops members
 for suspend/resume
Message-ID: <20200626143914.GE5289@sirena.org.uk>
References: <1593163942-5087-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1593163942-5087-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <1593163942-5087-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Cookie: You can't get there from here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 26, 2020 at 06:32:20PM +0900, Yoshihiro Shimoda wrote:

> +static int reg_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
> +
> +	return !priv->disabled_in_suspend;
> +}

This is broken, the state of the regualtor during system runtime need
have no connection with the state of the regulator during system
suspend.

> +static int reg_prepare_disable(struct regulator_dev *rdev)
> +{
> +	struct fixed_voltage_data *priv = rdev_get_drvdata(rdev);
> +
> +	priv->disabled_in_suspend = true;
> +
> +	return 0;
> +}

According to the changelog this is all about reflecting changes in the
system state done by firmware but there's no interaction with firmware
here which means this will be at best fragile.  If we need to reflect
changes in firmware configuration I'd expect there to be some
interaction with firmware about how it is configured, or at least that
the configuration would come from the same source.

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl72CJIACgkQJNaLcl1U
h9DtxAf/SHBTf/bf1KLIMtfn3QpvX8tAKMTkjKxxLt5uDi44mIbHupi++154iR0i
PijYvg619uBRWLzS9hvuE0kM5xaILhuYjbL/dOcbIdNTNEMopThp9hK+AnuVqqbW
m58nR81OX59/+BIe+B4VvH2c/TstwLGn0hKFeCjEpwvN+Weood3jAhawMgx9Q4hc
kfs632t8Ubsm1/ZtwFZmtKhF+6eikUXQ2Qd6qTtLHkHhaLEw82M86iwv3rxRukei
aVdIYUPqZ6bFX6mrYLQ4iJd1e9HjEV3HERenkk+eb+VEHsx/TPEaHhnBBcqRX7dO
6PaaiNsguoaIt+08oLgu8LtkrBFPYA==
=/fkR
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
