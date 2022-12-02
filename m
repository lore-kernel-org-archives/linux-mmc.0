Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FCC47088
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 10:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiLBKbd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiLBKbc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 05:31:32 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4947CD794;
        Fri,  2 Dec 2022 02:31:30 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id q7so7134602wrr.8;
        Fri, 02 Dec 2022 02:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KvgUfNpdMcFxHhxrlgAHm4uvOAPzStVRED37n6KGgiI=;
        b=m4JDzPQOkix/9GxEAi05h8mv42QfaInlw0Z7/bk4Urqiqw1ZQaYwdEd8Y+ahIzmrmJ
         NJ9yGU8JpGkpCCapOomj4+8JV+b6DLvoMI5YkkKhf4EacitAlxKsoIiDUpou3EXDgrcZ
         cbhkBnE3uFTYNlJOa5kEEA/eAdfTWLsAmxty8Ufk77Dw0F2jVOnAhVbMKZAfMS+YGHsX
         dSCDzuNpbvAcr3Z1ncdcSMnP3nlbJepmwcTlj5u0a3oS+Zvb1rzTszHqmGEjqSgM5LBB
         GpJ6ecNPa1HOkCbgz2vMhoYw2STE5vuBtTwpIGtk2qb4IHEtgcsG4xMba9a6cxsoLCCx
         lCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KvgUfNpdMcFxHhxrlgAHm4uvOAPzStVRED37n6KGgiI=;
        b=hOkgn8AhcX5glw1ZZY9U8jFYsoLfar+M3H+KTz/BruPTYptYQWDS1T/GIdCpnJWLlP
         VEzlN/ZmP4zXCVzzFW/s6K6aCbK4qUumy6bBVOVMm5zVzUCrebLtYDxXHa+STAclhnjq
         YM0SGxTYuzEBCLMIsZQXJUfY92kuLgNg8k0WBOXsRh0FesS7HUn+D/mAMoWCT1BnnHwR
         A9xJj63UrNNQIgo/423cM80gzi4g2OrSdjjb0pvvMba/85X3W9kGUPFAu7ol1B0Qr4T4
         Hezjt0V8sB2+/JhN4/VPmunF2cbeEYEk9SX+wwi6LT3A8FWaCSceTGrn9atEIRm+6ax3
         wE8w==
X-Gm-Message-State: ANoB5plsjElGKm89Y0Esjl8HFGNPwzjtJmvB5HPknn+vPiX9sW+Qzph4
        oG1rjjjxmJFbV9KZfWRNxfc=
X-Google-Smtp-Source: AA0mqf4QyKQFKKf4gVWAD0H/+L6fVA196KAa7LwQdaLEZgckwEwO+Giq3/j7J3zR2ZH0ROMM3OGLiQ==
X-Received: by 2002:a5d:58f4:0:b0:241:e7dd:db14 with SMTP id f20-20020a5d58f4000000b00241e7dddb14mr31187254wrd.271.1669977089263;
        Fri, 02 Dec 2022 02:31:29 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d6346000000b00242442c8ebdsm1664094wrw.111.2022.12.02.02.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 02:31:28 -0800 (PST)
Date:   Fri, 2 Dec 2022 11:31:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id()
 helper
Message-ID: <Y4nT/+M4QKLSDLVC@orome>
References: <20221117182720.2290761-1-thierry.reding@gmail.com>
 <20221117182720.2290761-3-thierry.reding@gmail.com>
 <CAPDyKFpGs4TvkV5FKnfpQH45qAiwhJfSiP60P2vMSX30GsMkQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KIAa2XeY7nh6QIyw"
Content-Disposition: inline
In-Reply-To: <CAPDyKFpGs4TvkV5FKnfpQH45qAiwhJfSiP60P2vMSX30GsMkQQ@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--KIAa2XeY7nh6QIyw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 09:08:17AM +0100, Ulf Hansson wrote:
> On Thu, 17 Nov 2022 at 19:27, Thierry Reding <thierry.reding@gmail.com> w=
rote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Access to the internals of struct iommu_fwspec by non-IOMMU drivers is
> > discouraged. Many drivers for Tegra SoCs, however, need access to their
> > IOMMU stream IDs so that they can be programmed into various hardware
> > registers.
> >
> > Formalize this access into a common helper to make it easier to audit
> > and maintain.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  include/linux/iommu.h | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index dc5e6f5c14fc..f0d72acad7db 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -1186,4 +1186,25 @@ static inline u32 iommu_sva_get_pasid(struct iom=
mu_sva *handle)
> >  }
> >  #endif /* CONFIG_IOMMU_SVA */
> >
> > +/*
> > + * Newer generations of Tegra SoCs require devices' stream IDs to be d=
irectly programmed into
> > + * some registers. These are always paired with a Tegra SMMU or ARM SM=
MU, for which the contents
> > + * of the struct iommu_fwspec are known. Use this helper to formalize =
access to these internals.
> > + */
> > +#define TEGRA_STREAM_ID_BYPASS 0x7f
> > +
> > +static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u=
32 *stream_id)
> > +{
> > +#ifdef CONFIG_IOMMU_API
> > +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +
> > +       if (fwspec && fwspec->num_ids =3D=3D 1) {
> > +               *stream_id =3D fwspec->ids[0] & 0xffff;
> > +               return true;
> > +       }
> > +#endif
>=20
> It's totally up to iommu maintainers to decide, but I personally would
> prefer to replace the below part with a stub function, defined when
> CONFIG_IOMMU_API is unset.

Yeah, that's what I had done originally, but then it felt a bit at odds
with Robin's request to move this into a central location. Ultimately
the result is the same and this has the benefit of standing out a bit
more as unusual.

I don't feel strongly, though, so if Joerg and/or Robin want to see this
split up into an implementation and a stub, I can do that.

Thierry

--KIAa2XeY7nh6QIyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmOJ0/wACgkQ3SOs138+
s6Fz7BAAqJ9pushN1DCSiKJWg6tFR67Gt1XpljD61M5+CJaD88R2mW7PFa0h8zdg
5/K4j2dBJ9BvJ4XiIjNDwEFkqvhFuWWpauUCN9kzYrjuIdhN5/IyGeGLCAFIUxIF
xsH/R8Sb88tMUiYpGVER58YqnagQsOcQMSIJSu5/rixSD7e8yKdPUWO/+3m5D9YV
Hw4hkT2wSZNL6aZRJv4ckl7rG2Mx9KrIlH/vSCCEEgE+S3DVhCL9df8/40Uy+la7
DHazcGhAyFkuIr4I/YAu0hKGFun8LSftH6l2Fx3e87myvldRDtWLVlGC6lHwYGD+
IAwOJz0tQMjUWw7GUqm8zQeNYZz8hLqy1cE7r5FFiN/3oYhhmQDzY8wOJFqNgQB+
VzpbgWQ9EGTyQkHUlNZI5uSvySZgajv5UTzAK/Pp45W3ACmaP7+bQL+6sgRACZGG
vBdkuYNFJ1Sf/mRB2CnwQxcLko2wGBDZPS38eOvMxxMiotnaRw8eGta1NFbCxjDq
jUb7SaHMK4CuJX7ybKaO6UymGZUJw2GVte8YDT1hU/aTJg1UOjaFqkSf1a3OumQZ
Pm8QTQzHCgUEz9SRBsyBb4DIlREHt3QpbyxbT5qPbLglYAWchZYzaFK8OF/H8gXZ
6AkjH2vduL0qu2tx3B0vINsTGhcy1+WcjQdkYRGFwd/1gn6LFYQ=
=bXw4
-----END PGP SIGNATURE-----

--KIAa2XeY7nh6QIyw--
