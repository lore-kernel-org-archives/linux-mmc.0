Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C0C55ABD
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7934522245
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 19:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOMaLT3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKMT6F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Nov 2020 14:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKMT6E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Nov 2020 14:58:04 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFDC0613D1;
        Fri, 13 Nov 2020 11:58:04 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so10648334wmh.4;
        Fri, 13 Nov 2020 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8c6mMpG4fnCBautALH+i7qd41/YW/Zc3tdgyeWKN91Y=;
        b=qOMaLT3sPXbB2u1hfkyvVHBra9HtNjqMehFd8gzGjHmVdWCumUA/51H3M5AY3zKQbt
         dHFMVm1NzGYEzv1WfBJiLCFNMCLOtsegSX/R6Do/TL1AtF0vcgo2O9wS0lcFHZa3I/Nt
         qUItEjStg5dy8nKIbI6vfccV/VaSM9ZqXrCOkmNF/m+AGvFDtsqUhSLMc3BaEl8+38sx
         8EiXDQ8/Ag5eKgS+8jK7dZA4DsJC/S1pXORM6AZTN7vfB0wB7PyIycEH44z0dlH0hQy0
         T5LnoE3pVCz56WWhcS5ek/JKwbR2BNW3d+kun2oWv2nc6TWx9wAWHBhLPIXb6NqADpD8
         PalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8c6mMpG4fnCBautALH+i7qd41/YW/Zc3tdgyeWKN91Y=;
        b=aZgTvYXI8MxIhZpTAY+TPcdwSKJS2vRaK4TdjNkFGOlo6RMi9jeEl+7pqQWOPiVVjw
         k+t6GRrlUBBA1ZDvf+kUdZoVTBQVQ7CSPsif82Qu2nd2ahmrNoQI3N3NQ6MPAU0o3m1Q
         waTMPrf2UDO7K4V0JbMy95f+CyxpI/ZVfwQxLzLQHnfHKk2/0dT8K7dHzksyV+vBDV2r
         oHQKHBUZqCUKanM96xeAMpgS+EwNpXKFmvwFEDCwEWxCjMaX4Thys0JDTNKxoAjkWqSe
         qOsRQlLZBOqTxSZepMfnmkKTn4elyWEjeAltRfiYkTpdfMv389PTYjoOw+pIdB0YbHGh
         /Wyw==
X-Gm-Message-State: AOAM531hU0s54H5THyW7zbwJVVJQqTGrs8XX6YDCfbu23hCSuFfv36kA
        GPYA0Wb4xFB9m+Ge11T9W2o=
X-Google-Smtp-Source: ABdhPJzTIeUrzp8QTQMGW/fiMOcZSBNlKHo0ivjYCSoGFdMAZh3sZe8rEZFd5iiI5Ko7R8bElcwjwA==
X-Received: by 2002:a1c:658b:: with SMTP id z133mr3979879wmb.1.1605297482861;
        Fri, 13 Nov 2020 11:58:02 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id q12sm12521744wmc.45.2020.11.13.11.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 11:58:01 -0800 (PST)
Date:   Fri, 13 Nov 2020 20:57:57 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
Message-ID: <20201113195757.GB1416567@ulmo>
References: <20201113125354.3507-1-wsa+renesas@sang-engineering.com>
 <20201113163846.GF1408970@ulmo>
 <728ad4ee-c5a2-65a6-c037-689bc77acbdf@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <728ad4ee-c5a2-65a6-c037-689bc77acbdf@nvidia.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 10:34:27AM -0800, Sowjanya Komatineni wrote:
>=20
> On 11/13/20 8:38 AM, Thierry Reding wrote:
> > On Fri, Nov 13, 2020 at 01:53:30PM +0100, Wolfram Sang wrote:
> > > 'busy_timeout' is in msecs, not in jiffies. Use the correct factor.
> > >=20
> > > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > ---
> > >=20
> > > Not tested. Found by code investigation about 'busy_timeout'. A quick
> > > grep showed no other problematic code within the MMC host drivers.
> > >=20
> > >   drivers/mmc/host/sdhci-tegra.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > Sowjanya, can you take a look at this?
> >=20
> > Thierry
>=20
> Thanks Wolfram.
>=20
> Right cmd busy_timeout is in msec and we have to enable ERASE_TIMEOUT_LIM=
IT
> bit for more than 11s busy operations.
>=20
> So it should be MSEC_PER_SEC.

Great, thanks!

Acked-by: Thierry Reding <treding@nvidia.com>

And perhaps also:

Fixes: 5e958e4aacf4 ("sdhci: tegra: Implement Tegra specific set_timeout ca=
llback")

Not sure it's worth adding the latter because this has been in Linux
since 5.7 and I haven't heard of any issues.

Thierry

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+u5TgACgkQ3SOs138+
s6HXMA//VXVxIyrI9iRrAK3c3nz8EIcLCCavStR6XWdl1/M3jucv5G4/AExsT/ru
O3Px/g9BfgsA4P85LrOp6vj04+LTzsB41Pw4vN7glMndoLFs7uW9dqdCnqU8SL3X
tKxy/bo82QU1te3fQpYkuG1ztVnAf8cPs+bgN7iOhObTPhG0w+rq2Px0yJIYzZaL
6dX3QHevM4/SI5RbjIS3Y12jMC8uWsqKw2NsFGOJp0UYxjnvNP5sIBMqx+1IX9i/
piIoKedC+dJbZ5BAZ70nIottNY5xA/TshSJ67QD0EkEpbWAbj8HZrtY7iQE8UnP5
DZdurWDKq/+Ej+SferNO+FhN4gAhuQQJR3UTiEEwb66CfSvfyBHqi3UnluQUlDaJ
h9ind4KS9tQsvtKslN2IvchBcDrvOoCt7NRK01CBafWBZFxfLyaC6OYynq6etWUn
+4XeIC298Yd1PX4ckJymopcwjylncp+fDPR5OLx5lUu4ZJeV3QdEZ9bpIguVrlo9
HcogO1JdqNe/LGHV/HpaDpthigQC6/1E5h9sllSkDb6oIth9EI3J2UgXPQvvGlyF
/uBfa/R1c0yd1sIrCg1DUwNJy+GxhR5RC58K9cLjGd6Pj7lxeB03V1IM8WIb+rdi
Z4A/DndhJsnQgVcjWeQBN5MCSjys0RtszRMOUVQiAMOxPsMhVIM=
=YtkN
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
