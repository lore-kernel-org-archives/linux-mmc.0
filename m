Return-Path: <SRS0=NLoK=23=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A92C33C8C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 12:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0872B207FD
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 12:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jB1OWS4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFMHX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jan 2020 07:07:23 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32922 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgAFMHX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jan 2020 07:07:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id b6so49385450wrq.0;
        Mon, 06 Jan 2020 04:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YJ8ObsphXIMqq4t2scMWysS7urWGvx2sHzgqG5+yLKQ=;
        b=jB1OWS4SYqmJEL4h43T1uq6brrB6+so3FpQ8hhHkRlJIxgvbVjvzhRr7pQQuOWqYs0
         uU+N4ILwATRS99LqZRqLghYnaAODnPT/M1hEiDCrtHDQUcMf7w3cABI9JojXPq8l+ZAy
         K3AWGNoMyY92Rx1AuiARBXUD9HpIwYWaoI3pThGUT3nBCWHK3Hn1YJmdVX++rWXyDnD9
         il3MSAEJ126k8jf7EOQbkUqk7m4qwpiG9lB0M04JQAhydAzKV2nXxJxENsPN5B/69Itm
         xnqlMtUhpP6n0rsi0OmgbqoEtZh10z6Wv6ngzZAGhmDcPwCyhOVAP2imDVkq7U6GBTot
         MW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YJ8ObsphXIMqq4t2scMWysS7urWGvx2sHzgqG5+yLKQ=;
        b=qHOcTXTp1Swz5svFJBbvCabLMxRuzUnyM1Jf0laWDF0YlFl/WX0A4Ug96o2ksta+OT
         JtyFiDfv3MMwcZ8pHtnjA5796A8qqptonnHzlm635spoD0D4gOL2XkTJ8zbPuSnDbm1u
         rOW1u2TU6TH79XtJrA7Ok7OTnMTSjnh3IkapsADFz295bUrVWB20mNp0rUcFNVGR+45/
         qNtfBXPWvtnmUlhF6rat2wokCH12CizuIK/+Q1Gg+IskeOsBLg48Pplecm5iPWaJCdqX
         4ocBK6nI+g5u60sQflBVwrJhZUyA7DvfT9XUMMtVnJrFseCNxfmp4WSAqywzlG43Z/cr
         PI+Q==
X-Gm-Message-State: APjAAAUDTGEGOBM7vcOaBRa7U0K0BicUaYDcL59swqylVYOvxla+0RYT
        4cQeYFJpb/9lyrxnkZ7myyOaUKtB
X-Google-Smtp-Source: APXvYqzwr2V1RVlsNCwpTh4C7jztqbooDOqJf32DAATt4JVMFxuXRaM7za3OlRhbVCf5IM9BTuWt5g==
X-Received: by 2002:a5d:4805:: with SMTP id l5mr99575948wrq.3.1578312440574;
        Mon, 06 Jan 2020 04:07:20 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id a14sm76909238wrx.81.2020.01.06.04.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 04:07:19 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:07:18 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: tegra: fix SDR50 tuning override
Message-ID: <20200106120718.GA1955714@ulmo>
References: <245d569e4c258063dbd78bd30c7027638b30f059.1577960737.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <245d569e4c258063dbd78bd30c7027638b30f059.1577960737.git.mirq-linux@rere.qmqm.pl>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 11:30:50AM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> broke SDR50 tuning override. Use correct NVQUIRK_ name.
>=20
> Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> Depends-on: 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO reg=
ulator is present")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Oh my... good catch!

Reviewed-by: Thierry Reding <treding@nvidia.com>

I also ran this through our internal test system and all tests pass, so
also:

Tested-by: Thierry Reding <treding@nvidia.com>

I'm not sure if that "Depends-on:" tag is anything that's recognized
anywhere. It might be better to turn that into an additional "Fixes:"
line. Adding Greg to see if he has a standard way of dealing with this
kind of dependency.

Greg, what's your preferred way to handle these situations? I think the
intention here was to describe that the original error was introduced by
commit 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes"), but then commit
4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is
present") moved that code around, so this patch here will only be back-
portable until the latter commit, but should be backported until the
former.

I'm not sure it matters in this case because the latter went into v4.5
and the former went into v4.8, so we don't need this in v4.4 and v4.9
should already have all the prerequisites for this. But in general, do
you need anything special to model such dependencies, or is this simply
solved by requiring a manual backport if the fix stops applying cleanly
at some point?

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4TIvQACgkQ3SOs138+
s6H+5g//ewD6ClvPl0du1byTOEdWfabrVpphli3s2QOHTcU2hCzVni2FmhanPmJv
JaiCC5Lkpjtyl79nwzkmryZCzinU9bATc3/pVomHbGj1kmsOPONqDL5rmznRq7cC
nUkz+/rSREJs08yloieM3KOXifq6yLXw2UtLsKpGPDQudduOZh3iNXIOHEZRL6xb
yzYfpM5sgD4ODeJMAS4edPwoJdrfN2CAa5YsSJ0ej2L+ksfbzlGInaUB/grckjXM
+nbxnIvVB/CjiOrlc6xgG4itNdlZG/tSMIQGQA5CjUt4/YbZHTOgLsNE1TgDwUk3
cdezxh/j2YFg6Ms5wqKn1K82mRyskGYYoe44IA764h7Fah8Jwgu4wItMZqTCNf9U
52FCbOm4yWPtjS0b7Puoljwgx/GjWqg/uhYuIYk0O6Jt94Ujqfdys2eegHUj+9kn
pfKFo1pScU6JmlPRSRkmDo1w6Lmv3FNaxmVJX3qokmyaKyNSKkJJK17lE0onDPQK
kpuounvO8sgujDNGUfUDtD62YxBfWvaPIdBueOEC82uBwnr80Sfi8d8pGs7WVJOq
TEXCeZgPPaiXe2ijchdsnsh1ttUtwkPnIXtA2N86uMj1ULId+ZDwGhqWBrxi/GJR
W06WwDMgLGzHuREyxe468mydcI8ewAlziiQ26uQKW7MUn1DduJw=
=zL2P
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
