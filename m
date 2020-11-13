Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A44C61DD8
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EEE21D79
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Nov 2020 16:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQt8BuHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKMQiz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKMQiz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Nov 2020 11:38:55 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1676C0613D1;
        Fri, 13 Nov 2020 08:38:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so10622285wrx.2;
        Fri, 13 Nov 2020 08:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7VIBAmdP5LKt4UcRev2wiyNsfG9vRxHlo9pi7um3T0c=;
        b=tQt8BuHuo6RdcYlW1SaEGGkhMqakY9bwdPd+91vhx3cbKYmXEp4SzeSZh9tXuoFLf4
         TbbOCyqeKAO5pIZ6h1DTZZScsZZKq5O8zb57RDlpKElA0w5j8FAlakXAjDZXqFqx4/Ai
         /VGhzoanl6yukMiD81ztIle41oysTRZt9fB0ARssOhNDPRt/w7O03b69F2RemQgVcgZW
         TR45kTVcASm9Ie3nEInwEv8curngsVooteXyXZuPNmrlTNU56EYyyckmE0PuYOgjdSoF
         nUqnjdOX0LBlmYgJA280jpnbVX1pg0Ni9JXEXjCASeH72rzRci27f8a3M17kNIzDBxM0
         fq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VIBAmdP5LKt4UcRev2wiyNsfG9vRxHlo9pi7um3T0c=;
        b=unpVVaYQgWrbiod8cyppstB95UZ9u/+Dy+m71LlBdqcSSHW0XEL08alFDSvJZIAis0
         ZvOHhKW6kmdDCFJJc8z6bqms0G1gT76rkJlugX9u2uB2SBahAoboLUQclztE2SCPLW32
         Lb8DUZ6Sjg/z6B1V8THRFwSnxwYzl17YPW5w6NsEBuUmN5V4xBo8YPDn617ZPwlOYWxO
         yiRzQwauJT3g5htrqKtKkNj6nrlUegnViC2pYKnNGpC8HUbHZyZYKI7MB2f5Hmetcj1w
         bev89rqUQVTb8PoiJcUz93SKFuJNh3+R2N6jGXBUkFM0bbY715A8P3pliHRaK8mFqzBr
         56Bg==
X-Gm-Message-State: AOAM533Wk/074a1LIwVhaNP7+5YC16iakphSpXKrLpdX1nUNZymZ3l+y
        wGGGVZB//GDtZ0sHnyVmHyE=
X-Google-Smtp-Source: ABdhPJwUb1+d9IeIiOxZ1tYoyMViHHmgVDmS1295GYm89OxD5CVRiJoSt8P+jPiySHYT0v+l/mb/mg==
X-Received: by 2002:adf:9043:: with SMTP id h61mr4549118wrh.237.1605285528664;
        Fri, 13 Nov 2020 08:38:48 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id e6sm11016314wme.27.2020.11.13.08.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:38:47 -0800 (PST)
Date:   Fri, 13 Nov 2020 17:38:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: Re: [RFC PATCH] mmc: sdhci: tegra: fix wrong unit with busy_timeout
Message-ID: <20201113163846.GF1408970@ulmo>
References: <20201113125354.3507-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NGIwU0kFl1Z1A3An"
Content-Disposition: inline
In-Reply-To: <20201113125354.3507-1-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--NGIwU0kFl1Z1A3An
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 01:53:30PM +0100, Wolfram Sang wrote:
> 'busy_timeout' is in msecs, not in jiffies. Use the correct factor.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>=20
> Not tested. Found by code investigation about 'busy_timeout'. A quick
> grep showed no other problematic code within the MMC host drivers.
>=20
>  drivers/mmc/host/sdhci-tegra.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Sowjanya, can you take a look at this?

Thierry

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index ed12aacb1c73..ad0dc3adc7d1 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1272,7 +1272,7 @@ static void tegra_sdhci_set_timeout(struct sdhci_ho=
st *host,
>  	 * busy wait mode.
>  	 */
>  	val =3D sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> -	if (cmd && cmd->busy_timeout >=3D 11 * HZ)
> +	if (cmd && cmd->busy_timeout >=3D 11 * MSECS_PER_SEC)
>  		val |=3D SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
>  	else
>  		val &=3D ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
> --=20
> 2.28.0
>=20

--NGIwU0kFl1Z1A3An
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+utpYACgkQ3SOs138+
s6EL3Q/+KjC67yKAk+Cv4Ln+9XgFhFVyGeLSU/YYOCx3gzDztv+sUcKHvJ+f9w3q
WDqNP9M/JmjcPsKsnaIE015E2+3HRZ7XEs3alaznUenkewpv6baElYQvoViy/g+r
txpjNc83lLEOGA7tMGHLf0ZhBH0JvpjLdsbix1oBdqTkVUA3Dm8O/vzfuG01aVTQ
FemMFfN8ip18TDjwFFWuKHUsUB0uRns8i4RtaFRYi7SqsLOXN8H2rpW2odMbSqVl
/umM9q9LN76iAVOrbTBQS2bpIa0dJIeu2W53YPUZJGzJS42DFMRqlZCXBfz3ULye
fOUzC/aNaethRY2/hJ+QM7ljtmbaSPMSycfMqPTBqOYdP4+kavWRJQVZJLI9tLtJ
5VubrnUbkDzKjH9cZwbi+qFbriq8p+qnG2O5of575Ozpxfg3MyTY18sm8E74Umdv
XScpxV7ibp9LTHKRQaILPCnyCxKOeolwDQ9bJaLsFo1/rK6mlmQNUvQtYiCymrb2
wbYr9+F2HT7OMj3AF6CuDIo33qxyfc4ygCIZBCNuNCdRaYWTfa0qxnxw7gthTJSA
r8y08QDS53a66FG+Lri6je7mVSgvx57jVpTlfN4/VOX11YlQ84mY0pf5VlnCGvLn
zVR68G40Ic85HOn0ebL60nvKR2gub0r0xDYpg/N1cqYBT9kcbWM=
=66fU
-----END PGP SIGNATURE-----

--NGIwU0kFl1Z1A3An--
