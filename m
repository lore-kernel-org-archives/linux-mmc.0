Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EB11B0F0F
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732550691; cv=none; b=ShrimplyOAwt6B+jVpSFr8wZj+bUdHwFs7w1zi4vYSeZe5QS9PjKKaJYKUISjgWQ3KYP3OmPpX+MeUUS8oVDYvmBnGipxKgfbrWuahTsrbTNngBDeUCUsXzfScXVh3zA6pcBQBUhLrt2lr4f9FZ6Yj8dzECITDExb1HwUsF/ifQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732550691; c=relaxed/simple;
	bh=6CFh5dgw/+kkRtNfZ7eg887q6M4EimW8QRZYsTjsSPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzBBn5nQQF4DMx1aX+x6GQbufciW+QgDv/Y2IRNPvQu7NNkndVw/58hkDK/UDCuONmTJbsyV+thVm5+CX3jOcw0Q+9pvYinXa9eKxNuxzKqz3z/e0K2KuE41P3ufSdbt+hlbYflqTdbAhPjsX4Qq0sp22v3a1/uGALb8kT/3GIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=K6bFf+ic; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="K6bFf+ic"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=6CFh
	5dgw/+kkRtNfZ7eg887q6M4EimW8QRZYsTjsSPY=; b=K6bFf+iciJEoOobdrJul
	26vvcmdUg/1WsfcEmf/BBU/2VIny1OJys+0RVHIm0YOQqjTCrC5nr/Xf5TjfmrGW
	ASvT2SrI7U24t4CpUmxu0ynKeC7XX+OPQa+viEjpq61lT7EGhjClpqINxxqL+60c
	V2xAskOCP9JEsY5mEPByJ/J9C2+tAKUnTen9zs2dXks2lgUzP7GcvwEB/JO1slMm
	WTjM53tNfjVtpWl3aDeQy8LJ2XDPjvq1/MJLRl8t9mZbQkz6rN5/xCEA0hj3sqnC
	TGJapsf/IxMjKL5VKJKMjVgPMj8vJec1htyWZ1puW6IIKha6shfNqAq3uDmk43A1
	lg==
Received: (qmail 2524492 invoked from network); 25 Nov 2024 17:04:38 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2024 17:04:38 +0100
X-UD-Smtp-Session: l3s3148p1@nPi2474nXIwujnv7
Date: Mon, 25 Nov 2024 17:04:37 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Drop the MMC_RSP_R1_NO_CRC response
Message-ID: <Z0SgFaZ7bnxRcpij@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andy-ld Lu <andy-ld.lu@mediatek.com>, linux-kernel@vger.kernel.org
References: <20241125132311.23939-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJOMHlERs7YPqp6C"
Content-Disposition: inline
In-Reply-To: <20241125132311.23939-1-ulf.hansson@linaro.org>


--fJOMHlERs7YPqp6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 02:23:11PM +0100, Ulf Hansson wrote:
> The MMC_RSP_R1_NO_CRC type of response is not being used by the mmc core
> for any commands. Let's therefore drop it, together with the corresponding
> code in the host drivers.
>=20
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for TMIO


--fJOMHlERs7YPqp6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmdEoBUACgkQFA3kzBSg
KbaYdBAArDNZqKmTHtlEIG7p3t+UFnT0+3wiTH4OAqNn+Cm6MgD+VGZGyDdKcG0C
4hgilB//aZukkNCGgYPoXcW+oD+Qss9C1tRm6tXFsUIjQNjlJSBrjc5fweIGCDo9
Y7WibdGANrbibmhPaNin6LepIePb5AF557u1iA7pN12Qdtt5DoA8dPfZVZYVKUe8
EkQ0MtXv4Ykoz7S6HHC6XxPXVwreTWz61mGawaRgDPMWwayAysRZWUVFD9DeNQp9
VlyhsPa6HohqJDNwAMfanO5dEZG4sI0U13tPpTp0nuGDEAquZVM3/RpDukrUvONG
Z5/81EjDavB/DMgHFEAsEjrcoSaI9E8zsAt7nyALkOS/8Mz7/2BxuQptBsIh6Dxj
JO+iOZ7TFVMLbAdZNHrm9UVKc9QS56egcChp8YCw9n0ZP0/hFZ0jMd3P9CG6ry9z
ovvfP+YwIAFD5b7DPm5HO266PWxEYBvEZtsjRaa08tWg6L6RhrlObvcSYI9PCBFP
VS22uelS5wcWiPUhh5O3Fu9WXDGtzMJ10J+XjV6X8wcHBGScZFyF9dxviFTIqC8y
tsn38VkPguVycIthR9xHKbgFhk30vc+XP6O9S4FRqhZvilRspajjVY8ZNjmBEw+9
mwaiWaPCkuIVHm34jx/WTAYo22hf+1eViRKtHGDExGO5yVSeVh4=
=twUJ
-----END PGP SIGNATURE-----

--fJOMHlERs7YPqp6C--
