Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB82C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE6C206C3
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FrGCbf8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgEVMwp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729399AbgEVMwf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:52:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D2C061A0E;
        Fri, 22 May 2020 05:52:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so12856786ejb.10;
        Fri, 22 May 2020 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IW2xLhRUUlaXc/xXfKfLY+pgA/EioOj4mjqACt8eku4=;
        b=FrGCbf8vqfs6yRsO3LWva1cQ9UCY+PeTTKQC+5Yb9HFmvsbYUbdHe0FAIsl7MEVhWo
         WsuX3wiBsOFuUJQyiX9/WtUw2S71NjCdzrFYW3UUzSf7GLeduG/1IHROB0bZVX2kkz4b
         zWLdaskaq4SYEZQwOJJiKYzunNr5bkLUdSDt5B5SvgebFg7bI5ER88SYr/HjYDt0zoho
         TdF3m/IVSDJgL6dsCgs+swSzZ3UQlsXH822gtRCHIRkQwqDpShtM+FlP5c4+LIoCjo8v
         SxFQeNb4mp4NQKxKuVwKj9/byGKhkvNo19ed9Oixqd4Mafmjuz0S5JfuOVeRr0xOln9l
         myXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IW2xLhRUUlaXc/xXfKfLY+pgA/EioOj4mjqACt8eku4=;
        b=TWsuA5xe0DtsLKWq6tS1JwmRFowfQrQdHqboG3mGtoPmx3V4mMQgJ7riNw3vSX5wnS
         FKcAb49Xtb1JQyYUqGmcqqT5m6Nyel1rAZ82/Nq/6UlDS20YvI0t8zNJouY1MgMrAXU8
         Pt68Y0a+mmiDxgL74OZnTUhysYU6McN9iUESU1QE05W/ftMf8QeHHxJt2h5JcQGMLwyy
         4wW7FdxZE3QWXk2OI//aJyOjyTwe+aRO56QbS661svg8Hj8iJmAvS9MEcAPVAVJXFu8j
         X6LQ7AjPmCMSUOi0lL/RKYORqaCEh5A4dnjXdON+GpPsC6DoMMgkROr7f+oR3OZxW/ih
         mYcg==
X-Gm-Message-State: AOAM531RxWL9ggmk6UL0JsCmldiQkeAmA591OgbGiG+D65odSFp8ySta
        4vUD73bVTT61XLMqVTQAqJ8=
X-Google-Smtp-Source: ABdhPJzSwHvYgtRMbq4x1v+PTgL38UkUiTqd/YBOqEVKptA8W95PLh+08krYfPjOGEXz5qhGQK6ciA==
X-Received: by 2002:a17:906:814b:: with SMTP id z11mr7522307ejw.531.1590151952998;
        Fri, 22 May 2020 05:52:32 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id b16sm8169566ejg.43.2020.05.22.05.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:52:31 -0700 (PDT)
Date:   Fri, 22 May 2020 14:52:30 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
Message-ID: <20200522125230.GH2163848@ulmo>
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
 <20200522122644.GE2163848@ulmo>
 <95d01fae-bf1f-28d1-2d11-8f5693646fa3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
In-Reply-To: <95d01fae-bf1f-28d1-2d11-8f5693646fa3@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2020 at 03:42:18PM +0300, Dmitry Osipenko wrote:
> 22.05.2020 15:26, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, May 20, 2020 at 01:08:57PM -0700, Sowjanya Komatineni wrote:
> >> When auto calibration timeouts, calibration is disabled and fail-safe
> >> drive strength values are programmed based on the signal voltage.
> >>
> >> Different fail-safe drive strength values based on voltage are
> >> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
> >>
> >> So, this patch avoids reading these properties from the device tree
> >> for SoCs not using pad controls and the warning of missing properties
> >> will not show up on these SoC platforms.
> >>
> >> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> >> ---
> >>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++---------=
---------
> >>  1 file changed, 33 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-t=
egra.c
> >> index 3e2c510..141b49b 100644
> >> --- a/drivers/mmc/host/sdhci-tegra.c
> >> +++ b/drivers/mmc/host/sdhci-tegra.c
> >> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(stru=
ct sdhci_host *host)
> >>  		autocal->pull_down_1v8 =3D 0;
> >> =20
> >>  	err =3D device_property_read_u32(host->mmc->parent,
> >> +			"nvidia,pad-autocal-pull-up-offset-sdr104",
> >> +			&autocal->pull_up_sdr104);
> >> +	if (err)
> >> +		autocal->pull_up_sdr104 =3D autocal->pull_up_1v8;
> >> +
> >> +	err =3D device_property_read_u32(host->mmc->parent,
> >> +			"nvidia,pad-autocal-pull-down-offset-sdr104",
> >> +			&autocal->pull_down_sdr104);
> >> +	if (err)
> >> +		autocal->pull_down_sdr104 =3D autocal->pull_down_1v8;
> >> +
> >> +	err =3D device_property_read_u32(host->mmc->parent,
> >> +			"nvidia,pad-autocal-pull-up-offset-hs400",
> >> +			&autocal->pull_up_hs400);
> >> +	if (err)
> >> +		autocal->pull_up_hs400 =3D autocal->pull_up_1v8;
> >> +
> >> +	err =3D device_property_read_u32(host->mmc->parent,
> >> +			"nvidia,pad-autocal-pull-down-offset-hs400",
> >> +			&autocal->pull_down_hs400);
> >> +	if (err)
> >> +		autocal->pull_down_hs400 =3D autocal->pull_down_1v8;
> >> +
> >> +	/*
> >> +	 * Different fail-safe drive strength values based on the signaling
> >> +	 * voltage are applicable for SoCs supporting 3V3 and 1V8 pad contro=
ls.
> >> +	 * So, avoid reading below device tree properies for SoCs that don't
> >> +	 * have NVQUIRK_NEEDS_PAD_CONTROL.
> >> +	 */
> >> +	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
> >> +		return;
> >=20
> > Hm... so what exactly is the difference between NVQUIRK_HAS_PADCALIB? I
> > think Tegra30 will also end up calling tegra_sdhci_set_padctrl(), but it
> > will then write the default (0) value for these drive strength. Is that
> > okay?
>=20
> It won't write 0, but skip the writing if values are 0. Technically T30+
> supports the customized strengths, but I'm not sure whether it was ever
> tested and whether it's really needed. I think Sowjanya said before that
> the default values are always okay for older SoCs.

Alright then, in that case:

Acked-by: Thierry Reding <treding@nvidia.com>

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7Hyw4ACgkQ3SOs138+
s6H8NQ//XJnXCnLkdDGEVXiHKU2dI5aUXGrAhE6Nq3oKQThB5B8FsjBT8mxtp0L5
trDoUSpMfIPsT/oWdEpFbpgtElLv16yoBAfkRwLkc88JdvIYlzcXXELMc8NDS70M
xVnyg8EALd3tvRnYn02WCljPB2Mg9varDaz/0luI9Fp+OxU7X6gWhbN69MstU7aD
o6iKMB94FwMDiJ6vZJmUeXmHFhalwS1rKHajcfX2QNw/AJo7+QY3K+LERviS1P7b
YeFV9s6j/w5xAa9y0lFIkxru7X56T5uEU9yZgmqr96wUnW0/h/GnCWtk6JTNDNP9
5NFLC8zme/zFSu6G54p+FSP2jo3lp++5VLTdr7pTDp9hJhm1yx87hABGCNLFCcO/
rIsOUrMmp1UC5t+6e4qZaX9u0DV/VjxTOF7I7+U8q9P/JeeHG4kJtAX5tRL5UiEK
qosNuEYUYyhflvop+W67Hkd9pbUp3yhGyJryrxhPwXLS+FLJpHQfV/1r83VqwppG
dSpiH0sl7+uCfc6j0CfgYvM7rEAD9t1M+CHI01wI1eORwQZ0RSIiaH+ez7w1bW8N
+8yHOW6M1TJK3+qfY5l/efZLXbzcY5BZlpk7A4KDt8CWfVZJGPXdiPG1vDEtV4/u
t91//K4eOTLXYbKjdOUoR+8tGsIpSj2XJZBu3uz7hSAPNTbT5JI=
=SKC9
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
