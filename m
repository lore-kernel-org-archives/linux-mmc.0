Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E25278E42;
	Thu,  8 May 2025 15:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716411; cv=none; b=R6DKSzzsHdDrNrtpKM9ZUWIYLfiA8aLytNyFkxQu0NjwUX4B5T1I9XbKtJDao6imOXBK8sOZvC95HBgic2KfxMyYLhZwlMwG0/NU29GIlkuccJPGTgFhTZT+iBWIfBdWSrJ1nIbUVQ6kagC/yKjjeuGTfI84tHlBOtGB3FSEO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716411; c=relaxed/simple;
	bh=egB+VJ9N3rDD59wubqFDZ1y/1JlSIMHjUrSaB1306Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxA13ZBk7OGoHxTtrd5CwUAIW7MWi8KomUAdPh0yVjQ3vB2vJwpcrByF0iglIg1nU34tatcdZ+6tfMg/alZbYvLZ3opBPdupmu/qEebpFPDJEjiDYZSeG2FB/IKQ2P9bSP4oObtftAXP+yFRnPLPiXM77lLZZ3f+aYxCHZLMU0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FByszaOY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FByszaOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1EEAC4CEE7;
	Thu,  8 May 2025 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746716409;
	bh=egB+VJ9N3rDD59wubqFDZ1y/1JlSIMHjUrSaB1306Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FByszaOYxRydTITw1Md8HdUlCWLQpiVbKYSulTEAncYob+ZtGd+Bn5bl9BnvYItcJ
	 /qCutB3qM5lDcHFKl9/Xu4uF+rnYMPoWjE0DkbdAovDOtNgzqkTdR+ogBLicQeg1BU
	 6Fm9i4GSc/98+0JnFLaizUwWUS8DyxtqpTS8bzrDaiit9kj0j+iXjqp/uXNy2vyGs5
	 SHUdBuVxZLI+Da5TrWBreFWS4qV3ufKbRzukc4arLIoHwOFivoy9QFNTkd8ELI5VQg
	 +fdzz7dZJENQvUDFW5cyFCzoXDq1IlgXbsae4MXRukyD2EMErumUK2JVRNoTpiA2Xe
	 8j5EhaLQ3Ubkw==
Date: Thu, 8 May 2025 16:00:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: loongson,ls2k-mmc: Add
 compatible for Loongson-2K2000
Message-ID: <20250508-polymer-bash-315e0a304f8d@spud>
References: <cover.1746581751.git.zhoubinbin@loongson.cn>
 <65c7d269776319ddfc951e94a2c4cc9bf572b75c.1746581751.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6NUEjZG1uAKmlXIx"
Content-Disposition: inline
In-Reply-To: <65c7d269776319ddfc951e94a2c4cc9bf572b75c.1746581751.git.zhoubinbin@loongson.cn>


--6NUEjZG1uAKmlXIx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 07, 2025 at 03:28:07PM +0800, Binbin Zhou wrote:
> Add the devicetree compatible for Loongson-2K2000 EMMC/SD/SDIO controller.
>=20
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--6NUEjZG1uAKmlXIx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaBzG9AAKCRB4tDGHoIJi
0vnMAQC3juxhbq+LTh0mJ4laW9UQNCA4eyiI2PRS0AGSGtfQwgD/ckFbuF3UN2fC
jBG2ttOZSe6Ed9CedKKJ+5GEO633ywA=
=1znE
-----END PGP SIGNATURE-----

--6NUEjZG1uAKmlXIx--
