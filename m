Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC6F370ADA;
	Wed,  1 Jul 2026 17:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925386; cv=none; b=B1qUzu5bsuaei+tmMCzYfZ9JSN/ay2qBcmqrGxFzwVwxPqk27DfvwfMkRsm2heg26XsDNMTXWyNG3FanTRyc5UAITYxj2N4jZeJwNU6KKh489u9t8rZiGXZiL8kyEo97M2Vys0IPreMY0DCmMgtNGOacLh+R0piaubxv5tm0o9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925386; c=relaxed/simple;
	bh=Ayeh5cwlNmAyr6iAkzZDlc0fFc73iNUdsmim0PGnNac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwRG+Wzd5dpaB1FHEXkawmHezvHhSmwHgMMaJPGhGilX40ODJkuwVI6Va+/I+eEpb+0G4G4mFi4tcOR2bPpq4M97VWNe9u1ukQRIA0R5S6ZpQ4gLuIRBbU+bK95nxNNhgffytCAe5M/swYqsYYvZW2xUuKnR/G2b0s3qlq+7/6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Vzf8l8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Vzf8l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 273321F000E9;
	Wed,  1 Jul 2026 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782925385;
	bh=Ayeh5cwlNmAyr6iAkzZDlc0fFc73iNUdsmim0PGnNac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l0Vzf8l8cEYmuVQId4BSIH8RN89lDFObUwiCje2GvWsJ4MMLGTzTbcRGmcEdqccEs
	 Cr5NPpG5jkJVykGGl3i4Wp/EHLZTZLQSq7rdNtL2V8AEhz/URJZi1BC/D5w/e6mc6E
	 Xz6xaGcoiOV47avbOF/2NMU93/wxzv427KfClf6T6QdXFSipEf8fYZRbE9XX5i3jsI
	 pRuZvS4wKVmeZCeZWh5wyhZKhKBi0TY/btg73gQcWoUfaH4GTGC4bb10JYD4jLJa+w
	 zTEJJ5Opi33oQtxJDY7cjACcGpyLBwTTXWMbFsNKgyZonDCkPYq6TnRfQbGDl245wm
	 dzhpvKB81U5cA==
Date: Wed, 1 Jul 2026 18:03:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>,
	Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wenbin Mei <wenbin.mei@mediatek.com>, kernel@collabora.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mmc: mtk-sd: Document extra clocks for
 MT8189
Message-ID: <20260701-baton-hug-877eacff8744@spud>
References: <20260701-mt8189-mmc-dt-bindings-fix-v1-1-e75f241a275b@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mPEXYlg63dNqM9Ep"
Content-Disposition: inline
In-Reply-To: <20260701-mt8189-mmc-dt-bindings-fix-v1-1-e75f241a275b@collabora.com>

--mPEXYlg63dNqM9Ep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 04:44:26PM +0200, Louis-Alexis Eyraud wrote:
> MT8189 SoC MMC Controller IP has 4 additional clocks.

I think "additional" is slightly confusing wording here, since you go on
to permit 6 not 11 (the binding already allows 7).

Not a big deak though,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--mPEXYlg63dNqM9Ep
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakVIRAAKCRB4tDGHoIJi
0m5ZAQDPDgv+aEUBLc5jd7ivTFD5RAfydjyVmNG7sWeRkLuObQEAoWlbrthLLsZz
3tjdnZ7FRZ4xtWaC8FMotDXsvQhpwgU=
=2df6
-----END PGP SIGNATURE-----

--mPEXYlg63dNqM9Ep--
