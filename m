Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014BC30149F;
	Fri, 24 Jul 2026 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931440; cv=pass; b=alvOo2bM8lTSV0xS1KLVG4T1WDS4Vq8I0TcS/BsbY3elqjay/oTZzrm2RnGxkVii8zO2QWMnWSFJQ2Sg5OHhaI6k2nB8Wec7tN8cdp462IP+t5+cGjNMYBSqMmRUchWLkqqzORmrV0y8yaF9CWrS+CUCkJC6aMoWOgVIe57uz+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931440; c=relaxed/simple;
	bh=DQH32El6cw4Ci0pnS0ptPdzMWl39sxUAj/u38lvyPGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbpoQUW+VADvyvp5BHvZt4k96eS1EkeLF4UwLD9qlo4MTgb0C5YaY8l05WJvd2l7HY+hpawxfksC89Gi7rmuIMXXfVCoVu18lTedShE9eCtBsOlht2mOYUPMIHD9DwIZMpXA6QtycazSR9jn3YHcSy13I54MjdPM3oiRT7JsyNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=g881cKnc; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="g881cKnc"
ARC-Seal: i=1; a=rsa-sha256; t=1784931435; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JO2fMn0Q+tl+QUwMFV7B+DlhbcS5M9u7LCGOqgrXtMxsjI37xnwfvWGFnSpwTT9dkYY4sVXq+d115+CB8pBb5rpYkstTbqQ6R6o1AA/4WhHw5DixtxLo/0dSKSOcKQwbhI6t3yMfDNX+Y9glchHGE46P0s/FVXcfE2cP9rMZCcg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784931435; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ezFqmnApLrstpqxs9JaxGJELyjuD4fmZx1ZFt5W3YfM=; 
	b=P+GFXiJup9RM/V2aMLo7+VAUNRXy2AukZhtO8n8C7hdB1NI7J35wfIbTAQH/T2qCZp7a3s6+718yweewH1SeYb5O/ZS9dnYTFEqPVFb9hqPQ6UfyaE3MayOnMhiHqZkHNx6lKoHjq+BJzkDV25XmqCT0eIj/9i9ff6pemnRzbdw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784931435;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ezFqmnApLrstpqxs9JaxGJELyjuD4fmZx1ZFt5W3YfM=;
	b=g881cKncRFZM0VUo5nFv75Q2JzeVS1rTA4V2AjYFu2bqrWEU+cvHn2yiHgkdN9R6
	CEoRE2/Gs2Pd0N0g9JJghIOX/olTXZ6Q82l74ea1PvuPXlouvblF5At50YOLfb05bZH
	3kB1t1KMfNv+/OuI5ThGmm7Mcx2bfBRPPkfbBwF4=
Received: by mx.zohomail.com with SMTPS id 178493143424377.11333325772819;
	Fri, 24 Jul 2026 15:17:14 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 90E9F181F16; Sat, 25 Jul 2026 00:17:10 +0200 (CEST)
Date: Sat, 25 Jul 2026 00:17:10 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mmc: core: Add mmc_delay_us() for microsecond
 precision delays
Message-ID: <amPkAhf_LiXGjzC3@venus>
References: <20260722205701.372789-1-jm@ti.com>
 <20260722205701.372789-3-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbwz7hh67i74nafw"
Content-Disposition: inline
In-Reply-To: <20260722205701.372789-3-jm@ti.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/284.919.37
X-ZohoMailClient: External


--xbwz7hh67i74nafw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] mmc: core: Add mmc_delay_us() for microsecond
 precision delays
MIME-Version: 1.0

Hi,

On Wed, Jul 22, 2026 at 03:57:00PM -0500, Judith Mendez wrote:
> Add mmc_delay_us() to support microsecond-granularity delays needed
> in MMC framework. It uses 25% margin consistent with  mmc_delay() for
> timing flexibility.
>=20
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - add patch 2/3
> ---

Looks like you should just use fsleep() from <linux/delay.h>.

Greetings,

-- Sebastian

>  drivers/mmc/core/core.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index a028b48be1644..55e9fb3bab9f7 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -73,6 +73,19 @@ static inline void mmc_delay(unsigned int ms)
>  		msleep(ms);
>  }
> =20
> +static inline void mmc_delay_us(unsigned int us)
> +{
> +	if (us < 1000) {
> +		usleep_range(us, us + (us >> 2));
> +	} else {
> +		unsigned int rem_us =3D us % 1000;
> +
> +		msleep(us / 1000);
> +		if (rem_us)
> +			usleep_range(rem_us, rem_us + (rem_us >> 2));
> +	}
> +}
> +
>  void mmc_rescan(struct work_struct *work);
>  void mmc_start_host(struct mmc_host *host);
>  void __mmc_stop_host(struct mmc_host *host);
> --=20
> 2.54.0
>=20
>=20

--xbwz7hh67i74nafw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpj5GEACgkQ2O7X88g7
+prZMxAAh815X1v+LlRjLLU6UcHD7YF72x1z5AQ8I2/g/Lst+PTKFD0X+n8NDDkp
ngZf4bq6FzeqjdJC0/KiCwfshgHHL7je05CGHd83sAZs0+DOqDp8n0YxhU6qX5W0
TQahJRWcKWUVHX83BOw7x4xS5pJaTEUTMKsmpJ9Yhakp0gmhGOdo2ObqWdU6u++q
PrMz/DBtkf6DPYTNZBsXSaVlgj8fGH5sktnOMWILbwlrEujQfjbkEtxgjnwJuuP4
Sw1D8ia7F9d5hCt5XybdaKJiQueDwcog9e17bsi9Kpzfgm8uKpEYK2P7O/p+iNG4
tlvCHsMdhgpnuavQO7CzaScA2r9SXroP54B/kIXjcGqqOqVy8KYXl1HOuSUzkYm/
CSIAk4FCgIIfrn0C5r0dTEyVzTENK+vpaglBq+D31uh+HaS6tmAErwnpTBxwtVAh
8P0hc9Yf5r99Es4kKG3zRc+pAt/TYeKKY4swCxHhpGMbojrFnPS7hVX4YO0kEHtn
BJUBr4yHQHpz7ZoZS/4MAMyyNgz1dN9fUeoipHnUaMhmgdZpyLcJB3pFiV30FlkO
TXsYASHMMfYSKBhSv7ofOdqaWt5fIz1feMlMyeo2XGJCIcLfbgNBmxzSkbA1Te8n
pxL7AoH+T1WL/NA6pFbAX46oDUuwzjnvnPdsqb8IeV9/OVZsjao=
=xwU+
-----END PGP SIGNATURE-----

--xbwz7hh67i74nafw--
