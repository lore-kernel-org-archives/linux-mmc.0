Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FBAC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4282073D
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 12:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7V07Whf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLJMwQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 07:52:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40472 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbfLJMwP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 07:52:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so19941724wrn.7;
        Tue, 10 Dec 2019 04:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eP+biOEoPLLzGzoIDWqyl2DL6smvH4qJE/Q2QegbMVs=;
        b=h7V07WhfzAKAE9G9y+Q+ZXDJVQ7r3ubI3/9KFgnD7+JpLLkhJU+UsYYDPigaZFqjg1
         ad90wDKcE1pQGqbJctp9HPu6YFwAiYZEJKItJvhAwXeh1X+ROapFF3jA8WmS8kKFf4Mt
         wk8EbwJkUghl9ilZcPQpamIYrjTImAgB3bGMeSMtyGRvwlsM6lC3zjOjXrmZa/yido03
         64LlXuadoD1rT+NPcXhpqUsRPYBEICjhjRVDGxLzaroyfap9rX7eTV05iPm3mUTSfFrS
         BLrXwrGAj82O3DRqCjEA6OeFKdPKqfN2Gn9WmO3WGQm8oarIrImSCT3wywEVeuGAbYPs
         qSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eP+biOEoPLLzGzoIDWqyl2DL6smvH4qJE/Q2QegbMVs=;
        b=HSirKafVLqgdVrDei06+FxwaYgPPqo5t/8coElmdSZl6IODUQmEXZ5WvHiI2+s+Qfq
         IfDcg622q0wvfHeFmgfx3grIXRTKK89qaXgZWjLJmocFNHLtV05qA+cjqS2ThJsaoZe4
         WeKin8OAh7LGaHEg7vYv+RPm2zaxYz7zWb9Td1PiUCCx5crZKvRC1j/l7O+5uF1r7ZtS
         633LmJoIGicGAtPPeuy/xd+KXaDX2W0nPxRwdtrywP+aMPhLh3/UKzlxvdxuwMkidM9X
         9StUAg8t+FIOtuGdKglda6R3TkZXPaFjG4w10FlpnKUQnEurno7ri/vSbKsGPApvsM9U
         tdjA==
X-Gm-Message-State: APjAAAUsC6a5c8Y2W/gdD8XNl/epUqbdHF7hh0tRUB9Eu6awUm4aUS+e
        wqa+MqVeZoPTnALexRp7mvg=
X-Google-Smtp-Source: APXvYqxItXYjICBNePYjyaPa8NX4kDtRSRvG7S+SO2ZAkjnxV70FvYFFJei5TlQ50iJb3Vwk+gk3LQ==
X-Received: by 2002:a5d:480f:: with SMTP id l15mr3117484wrq.305.1575982332070;
        Tue, 10 Dec 2019 04:52:12 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id m3sm3172993wrs.53.2019.12.10.04.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 04:52:10 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:52:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] sdhci: tegra: Add workaround for Broadcom WiFi
Message-ID: <20191210125208.GD2703785@ulmo>
References: <20191210014011.21987-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AkbCVLjbJ9qUtAXD"
Content-Disposition: inline
In-Reply-To: <20191210014011.21987-1-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--AkbCVLjbJ9qUtAXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2019 at 04:40:11AM +0300, Dmitry Osipenko wrote:
> All Tegra20 boards that have embedded Broadcom WiFi SDIO chip are affected
> by a problem where WiFi chip reports CCCR v1.10, while it should v1.20.
> In a result high-speed mode isn't enabled for the WiFi card and this
> results in a malfunctioning SDIO communication.
>=20
>  brcmfmac: brcmf_sdio_readframes: read 304 bytes from channel 1 failed: -=
84
>  brcmfmac: brcmf_sdio_rxfail: abort command, terminate frame, send NAK
>=20
> Downstream kernels are overriding card's CCCR info in SDHCI driver to fix
> the problem, let's do the same in upstream.
>=20
> The change is inspired by omap_hsmmc_init_card() of OMAP's HSMMC driver,
> which overrides card's info for the TI wl1251 WiFi.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

This seems like the wrong place to do this. If this is specific to this
WiFi SDIO chip this should be handled at the SDIO card or function
level. It seems like the SDIO infrastructure doesn't currently allow
this because the OF nodes are attached to the card after
mmc_sdio_init_card(), whereas it seems like the quirk is already needed
during mmc_sdio_init_card().

That said, I think we could have some common code that's executed as
part of mmc_attach_sdio() (and before mmc_sdio_init_card()).

Actually, it looks like we already have something like that.
mmc_sdio_init_card() calls mmc_fixup_device() with sdio_fixup_methods
after doing some very basic initialization. Do you know if things start
to go wrong before or after that point? It might be worth looking at
that SDIO fixup array and add something that would override the CCCR
support. That would fix things in a more generic way rather than
requiring every host controller driver to duplicate this quirk.

Thierry

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegr=
a.c
> index 7bc950520fd9..2ad87da98f2c 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -1501,6 +1501,32 @@ static int sdhci_tegra_add_host(struct sdhci_host =
*host)
>  	return ret;
>  }
> =20
> +static void sdhci_tegra_init_card(struct mmc_host *mmc, struct mmc_card =
*card)
> +{
> +	if (card->type =3D=3D MMC_TYPE_SDIO) {
> +		struct device_node *np =3D mmc_dev(mmc)->of_node;
> +
> +		np =3D of_get_compatible_child(np, "brcm,bcm4329-fmac");
> +		if (np) {
> +			dev_info(mmc_dev(mmc), "found bcm4329\n");
> +
> +			/*
> +			 * All Tegra20 boards that have embedded BCM4329
> +			 * chip need to enable high speed for SDIO, otherwise
> +			 * further communication with the card doesn't work
> +			 * well.
> +			 *
> +			 * Later BCM43xx chips do not need this workaround,
> +			 * but there is no good way to differentiate chip's
> +			 * version at this stage and it doesn't cause any
> +			 * harm for the later chips.
> +			 */
> +			card->cccr.high_speed =3D 1;
> +			of_node_put(np);
> +		}
> +	}
> +}
> +
>  static int sdhci_tegra_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *match;
> @@ -1545,6 +1571,8 @@ static int sdhci_tegra_probe(struct platform_device=
 *pdev)
>  		host->mmc_host_ops.execute_tuning =3D
>  				tegra_sdhci_execute_hw_tuning;
> =20
> +	host->mmc_host_ops.init_card =3D sdhci_tegra_init_card;
> +
>  	rc =3D mmc_of_parse(host->mmc);
>  	if (rc)
>  		goto err_parse_dt;
> --=20
> 2.24.0
>=20

--AkbCVLjbJ9qUtAXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3vlPYACgkQ3SOs138+
s6EEig/9G0UHUk7Bmvo/1xi3zh1yjTsm5ZG90FSCRQnrnd1QEHZ7beKfoyHh1ZyX
YQLtTtZN0f5d6kAr69+1HTqUR22+AsM5XY5zWjWyUsySiPKwbx/hKcPl+PeHGPlS
oUjEI3R9oq6XRlaOFYdFKO1l4JfUbO6SvPvCDLnf/SbiQm6qx9mfc21sYj9eyoA2
XNlcJVthp5S/E3VcyNMx4YArblHPtrKRaZW4KnfboauU7PJwfwgCCn14FD/muF+M
kKusUMsYKNWGvu9VofWyr2kg0Ms76nvzKbQJfgZNJejm+BzwcsJvqGasyGOI9mSp
h0+ldVUl1mgGa+90iY9cpEE7AarfX0lfvX2ZFBOkmQP+LiG7/kMaxkNFTyKl+Nz8
3+VUhEq3BIc64lv4k1/yiVcI6kdozo+Aa4gREaR23VpiXzRhT+q1uVoHxVg5MoEN
YtN/LXuBXczfZHUnpmb1/pZKYGhF4DPrzLWqxS/xaKlWdw6Sjb/WPpYj9DOhLysG
eVtYN7o8f1E22dEPOcV8PCa7X6SLMG6eY2PRS+QFQJdz/gbYEJDNsrE6n9zqcd5r
Izun4caxrjgCZGszzsnavN61vRkxmJu9cFyl4s9knv8vnj6P3IN5bDpW5wOo9hVu
PiwVybFkXCqO3mt0Zu4r4xkzlcbKRi7IxYLrdCceWI78zLvP128=
=3qZu
-----END PGP SIGNATURE-----

--AkbCVLjbJ9qUtAXD--
