Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF54AC4708C
	for <linux-mmc@archiver.kernel.org>; Tue,  6 Dec 2022 16:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiLFQuE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiLFQth (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2022 11:49:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5019B103B;
        Tue,  6 Dec 2022 08:49:33 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id m19so11624166wms.5;
        Tue, 06 Dec 2022 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EyXZfRg87HbcHT02i5mCcXdi496dRd0fvYL07ZXEvE=;
        b=kCZnx9gFbQCVQMSE1Q+ES8idpWPt7Vz2Oo3DbVGXceFZ9Vok+640T0EPoJto7J7a1j
         Mby4l2NEafqOtjZsXGiQi9qZ46Yq/C1gPrp7QMNBuPfcAn5FroH5gcP+dZuOrGqjShg5
         72a06iLQYytVu7vIt8Omlq1b23Qjb28fPvgTCPae1R1SWp5ie/SIJ68eRCsZ2MfSnqnE
         wriGYa85ccISiZCizxp9tEB6YwpaEDOI4WvJ3ERqOXKY+g2gwnXQjO6O92YAfRKWLCjh
         4+DF8khU0KniLs4jUXAvC6sawvKrpAuXpLwqnjcNfpaWA/e3SJQPeAb6fS8axZi4JZKQ
         LqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EyXZfRg87HbcHT02i5mCcXdi496dRd0fvYL07ZXEvE=;
        b=05AI84Cjtt63S9qWasFlb8PuFfixxmTyUf32oislIjktC7xJUv8w7pSMieKoOZbR66
         iDvCifoOtHdE0IibCmvIezaHvuajrKeVY8+0D/BcYxEe33AAa0+y5lQUhm2Ax09egRFP
         tpcwklEXwUzurH9pEPU/WT1ggNcQ554gNnXQTt9fnj/Ub2/d4zXrzlr1F/UTMgvqpElv
         A8y7+NeBiDD3HF4647sxdmgyim+opfzLWC8GT+G2yXonD1nptm5OFOd07uaWy8FYaZuH
         p5VypdXVx6CXdi0bJubakVfZZi9zPyTCwgMLkh0vPrkTt1Y9oyd4qg+7+kT8nSBS0JSN
         /5/g==
X-Gm-Message-State: ANoB5plmt7hj8KbhDBBX7AsIggFgTOIgrSGLzomF6nO8OJrerMDE9UR6
        H96HuhU1dwKCiZG7YmI4VI1K2PWUhlQ=
X-Google-Smtp-Source: AA0mqf6OwEBYyWxX8dEN9fljnlTeUSAYW9ad/NXT7wHCuKRYInaser8Y6WAiAPU2l1z+HeELEAdRNQ==
X-Received: by 2002:a05:600c:a4f:b0:3d1:f298:5fde with SMTP id c15-20020a05600c0a4f00b003d1f2985fdemr383472wmq.171.1670345371742;
        Tue, 06 Dec 2022 08:49:31 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b003b47b80cec3sm28310667wms.42.2022.12.06.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 08:49:31 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:49:29 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v12 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id()
 helper
Message-ID: <Y49ymcvbdpiJkHIY@orome>
References: <20221202152644.29450-1-thierry.reding@gmail.com>
 <20221202152644.29450-3-thierry.reding@gmail.com>
 <0df4bfa7-4e76-b6b2-c8cf-a0776ec0fbfa@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uq55OuK5Wlr58DNv"
Content-Disposition: inline
In-Reply-To: <0df4bfa7-4e76-b6b2-c8cf-a0776ec0fbfa@arm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--uq55OuK5Wlr58DNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 07:03:09PM +0000, Robin Murphy wrote:
> On 2022-12-02 15:26, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >=20
> > Access to the internals of struct iommu_fwspec by non-IOMMU drivers is
> > discouraged. Many drivers for Tegra SoCs, however, need access to their
> > IOMMU stream IDs so that they can be programmed into various hardware
> > registers.
> >=20
> > Formalize this access into a common helper to make it easier to audit
> > and maintain.
>=20
> In many ways I'd be happier if this could go somewhere in include/soc/teg=
ra/
> rather than the generic IOMMU API header, but I see the argument for keep=
ing
> fwspec usage close to home as well, so no overwhelming preference one way=
 or
> the other. Mostly I'd just like to get something landed so that all those
> other drivers can be cleaned up as well, and I reckon this counts as good
> enough.

Yeah, given Joerg's comment about potentially hiding struct iommu_fwspec
better from others at some point in the future, I figured it'd be better
to have this in a more central location.

> Unless Joerg has a stronger opinion,
>=20
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Thierry

--uq55OuK5Wlr58DNv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOPcpkACgkQ3SOs138+
s6ESNQ//W5ZAWVWsRdDhvLZX8+FPqCDJ7Fd3h3kcdUq9BItKXWBpM+xUWz6rtDlH
+MSh7I2Lwi4nM0lYSLhv4kw2VD4neCtmBfpBa5AWdNyw+79KruUPWZa11qm+6Xhq
B60h3zFItM4fMmElflkLwG+g6ZnOsT2ASwwU178DYbFk+v60PIp2SQ4r91YBfQhF
9IW4NF80q0A05c9/r1k67CQzVM8Pk4mJ28Ni27jMMNjwt9EjDqQwY9JMZbjTwv/l
SF93vK0G7eZnjjSFjXBS5qT5tn6H7YXVd+D65hq8oVzVfkFXH1yunezqFGOkgJs7
nfL2pyQtS8emcuHBxJEnC1Bd4VgdOg/mJjTV/MsgsaKFQvsb5SbzRD8MGGlFY47D
xiKD2fIP1+cpbQUkX6HJGFIQ+XSjFKNqZN50FdJ+0VQtf3qhW1jmDC9pPivrytAf
dW50DVf0by1b7ha7rDzwaKwfc6CY5X5mud+evSc/DQTnHApjU0ikTXxDN9ESbKgQ
j0viVZLL6ZVcSF912uup9Ywyk7jiERzRoeeeZKZbERKsREWCeDluxa79I3jQUX7Z
MZxgPGYahEyASUCw1cq8LkYOS0ChWyT1KK+qYXe1s004T7sE3oY/zIFQQqikYCc6
Ay26iES1iQ0VXjNXjmnYOXRw0z53GpDuxVyfGlVqdNeLrNMDUvQ=
=YmHk
-----END PGP SIGNATURE-----

--uq55OuK5Wlr58DNv--
