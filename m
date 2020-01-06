Return-Path: <SRS0=NLoK=23=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6F2C33C8C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 13:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3C02081E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jan 2020 13:37:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnuawsnT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAFNhJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:37:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34351 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgAFNhI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jan 2020 08:37:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id c127so11979851wme.1;
        Mon, 06 Jan 2020 05:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QOQNIAmP2EwBVCavZ0lFmSFnjBVk76326QHH2Q3kcmU=;
        b=VnuawsnTf0Cd7zf4BmAy2YZKMN8+T2U2fEnGwrY7kdoQTrvBcljDa3+5uGsf5J07XH
         wPvqtMi6exEC2pfkHwRNTimcbZTq6Wcny0eaccgE5xhSlGuAHyS/f5lu77WQnHMSVgtn
         tRJRdS/zH+Ljx+KA6O85HOKMRCFvFMYoyUtZGfUipMbkJvD4FWqv7/P50/fAK5iZncT5
         Q8ZEwPCTlT6R++dghR8MX75pnY86JlOwSJlwilVsmb8dvoirMCNJ8/zwuoRRyPVEY8MS
         vPtcm/nlmMRXTOTom3L4CohdSPHaupLVC6B6zy/Ynxdr5accUgX91F3UCxjM7c1r6fr9
         Woxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QOQNIAmP2EwBVCavZ0lFmSFnjBVk76326QHH2Q3kcmU=;
        b=uBoMH6TfIJzH5myS4dviGu5kSjBHWhnuDvcXDFzC9PuKyCYC8ng53GNBwfTS8XqDpJ
         6EroxGjn/wj5r1Ehj1Yyw+Eyjrmof06DKJQQDBYsU5tr1XouScQXx59LguANIxJ60d0V
         bDYbOpVSYr4CJ80Qr64zzATk6g6jgEJaJwsXbCrprUnfUoVe8DvtLteNEXgQVj9ILSTS
         xNwlCYdWCgWQAxBB2cpESP0PX/xoCI0dL04MdIAqwy09mbNojMkpQEpLimSK1KEK9Alc
         Yv8shYEZbaN1A16EYUEgvqY578lCCrhZ4e93ozwWulw8Rex4uK+kOdPYyWnzEgGDTelm
         bz/g==
X-Gm-Message-State: APjAAAUQfT8+ZDwho3d2cjcmU69tci4koBp69SnPMsRWGd77Uz1L2Rft
        5CXGsaFBQOl3WDKP2F3RSsm3sVCv
X-Google-Smtp-Source: APXvYqxVJYPFzO8K7RFO9Mbkl9yf3DcX5Yyfc46eQahs0rjbrZh4wXbwJ5UoOs/3egJCUyIihU7gEw==
X-Received: by 2002:a1c:5f06:: with SMTP id t6mr34830155wmb.32.1578317825517;
        Mon, 06 Jan 2020 05:37:05 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id d16sm77467856wrg.27.2020.01.06.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:37:04 -0800 (PST)
Date:   Mon, 6 Jan 2020 14:37:03 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lucas Stach <dev@lynxeye.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: tegra: fix SDR50 tuning override
Message-ID: <20200106133703.GE1955714@ulmo>
References: <245d569e4c258063dbd78bd30c7027638b30f059.1577960737.git.mirq-linux@rere.qmqm.pl>
 <20200106120718.GA1955714@ulmo>
 <20200106122745.GA3414443@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20200106122745.GA3414443@kroah.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2020 at 01:27:45PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 06, 2020 at 01:07:18PM +0100, Thierry Reding wrote:
> > On Thu, Jan 02, 2020 at 11:30:50AM +0100, Micha=C5=82 Miros=C5=82aw wro=
te:
> > > Commit 7ad2ed1dfcbe inadvertently mixed up a quirk flag's name and
> > > broke SDR50 tuning override. Use correct NVQUIRK_ name.
> > >=20
> > > Fixes: 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes")
> > > Depends-on: 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO=
 regulator is present")
> > > Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> > > ---
> > >  drivers/mmc/host/sdhci-tegra.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Oh my... good catch!
> >=20
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> >=20
> > I also ran this through our internal test system and all tests pass, so
> > also:
> >=20
> > Tested-by: Thierry Reding <treding@nvidia.com>
> >=20
> > I'm not sure if that "Depends-on:" tag is anything that's recognized
> > anywhere. It might be better to turn that into an additional "Fixes:"
> > line. Adding Greg to see if he has a standard way of dealing with this
> > kind of dependency.
> >=20
> > Greg, what's your preferred way to handle these situations? I think the
> > intention here was to describe that the original error was introduced by
> > commit 7ad2ed1dfcbe ("mmc: tegra: enable UHS-I modes"), but then commit
> > 4f6aa3264af4 ("mmc: tegra: Only advertise UHS modes if IO regulator is
> > present") moved that code around, so this patch here will only be back-
> > portable until the latter commit, but should be backported until the
> > former.
>=20
> The stable kernel rules document says how to handle this, but the
> "depends on" commit id in the comment to the right of the stable@k.o cc:
> line in the changelog area.

That only mentions "static" prerequisites needed by the patch, but what
if the prerequisites change depending on version?

Could I do something like this:

	Cc: <stable@vger.kernel.org> # 4.4.x: abcdef: ...
	Cc: <stable@vger.kernel.org> # 4.9.x: bcdefa: ...
	Cc: <stable@vger.kernel.org>

Would that mean that the patch is selected for all stable releases
(because of the last line with no version prerequisite) but when applied
for stable-4.4 the abcdef patch gets pulled in and for stable-4.9 the
bcdefa dependency is applied before the patch?

I suppose this is perhaps a bit of an exotic case, but it might be good
to document it specifically because it might be fairly rare. I can draft
a change if you think this is useful to add.

Thierry

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4TN/0ACgkQ3SOs138+
s6Gf6A/8DvUkX7G3C3SRLThd/KInbrXQTvY5GaqwhZeQCwWJc+qXeyxc4SSbHOig
90ipVBR0VmEtT5ti3g365UWoQf0hxFZ/+0nIU105pjbtCJ1JwUtF2mvBvRJ3906D
fTtqJeb6FvdAVAeweLiifczATkfFQHqOy3k+ChfKyAauaDoBi/eErkwYFWvMywZo
oLxEBMjiSdbPUxqJnzhEuoq64aGHxqsqOulRSvalGfAUwaFJCsqXx0zsW4TXMWwv
q0Nm5qSnZ5zXVeNX2xHIXv+L7/a9FBFp4E5wY/awZvqH8EZIH3Ms6tlkwitG1WsW
HHtjlJ1wgGPMeqoDBIkfoQLm+i8kDiei83fsQR3aIr+SR0RBVt8aisb4v/Jz4FMY
TGiOY4ugVe8tQUUQlydJ3Wc5tN33/8kqYBDlxTLb6U5kYvapDg86S9ejWIUk3Qdj
IhejPfTn14qSookBpUpAWp1C4uvAKiqEeVxf0hb1TJXP3ZekfVpOQSj71Poj4ybz
X872X94OKhBJFvv654mMB34WfQ3WePQC0PqAU1Z8usrQAAWWUl6cvonD2LWKr6jK
6YOoFuFHL6fhZoyahVvVAuYhX8HjJnCsP5k0HYc/enDHICTW5a1U2B0dSOpbHpjQ
ZUjyyLiMaY14zDVzIVWJp7U5dT9YVks3cN9h2BqZ0RRzKdDBeBA=
=GeZw
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
