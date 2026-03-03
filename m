Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC903A8735;
	Tue,  3 Mar 2026 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564811; cv=none; b=XEZ7+HIDtwJx1VdUu1vSqQW+THcjtZ58yDg1j/s0Ai6P4QRLOw6CKR3qxM1Pvd32ntS7MrfrX6IPyMVgNJSLrs4YahvVmkaoslPPd2HJ6aW72d7rHcr5kCUEBWMWYTpiHJijoBT0GO8VsLyVr9tusw01eGfN6CEiEARwjHTOVGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564811; c=relaxed/simple;
	bh=o6SqLoLouGO5bXslSs/4F7gpfo57naGALRlZ1K+ZiU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbL6cmRCguzx4PtQgxO+VJ1053FuPLR+jvyijJpfv1nHi7LZFfm7cBeV7VvanRFkOzaw0JYFKUrV924YS8aiexYWpT/eXqH9uLe/K14H7YsqnTJLpIzWcIES5hBHFaUfTSRPqvjJRQ3Szwml8VwABbUzTWfBUfpDP54VrP3njbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9PPqUIF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9PPqUIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F552C116C6;
	Tue,  3 Mar 2026 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772564811;
	bh=o6SqLoLouGO5bXslSs/4F7gpfo57naGALRlZ1K+ZiU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9PPqUIFRLeeMpLf+XS9BN9LZAJTe1QWd1uFaPEnJie1rK3xaon2kvnwE6x05Gore
	 oxOkYRoitAgJeTVv4+VBD2FPfQTQRexNOJaYYAq89sGkGOELs+/NiHz299w8XhNhYi
	 yNyK2F38+EO46b/EBQEFlkLRXDKBCWZoy/TVE8ZvdW5+zpziTzin1MTaQmxXWaNRlK
	 UnaYbM0s/f+iM5+XMJJB5Sc6VL3CyZnGamgbtf1L5lsKJu5ZjqQUvlAODMWXRC58tz
	 EGyhhzH13w/id3QjGdj1a/dkjgfw3i2ziSdtDEGZb/5PraiMPcQG+oHlIRNnqDy5/T
	 lemKe0rdoJDZQ==
Date: Tue, 3 Mar 2026 19:06:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: loongson,ls2k0500-mmc: Add
 compatible for Loongson-2K0300
Message-ID: <20260303-saint-cubicle-67cbf5909ef2@spud>
References: <cover.1772529875.git.zhoubinbin@loongson.cn>
 <5fd555050c62d1bd7dc4f7fc15f93dd48a8a40c3.1772529875.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IODElQvcItTdZo/x"
Content-Disposition: inline
In-Reply-To: <5fd555050c62d1bd7dc4f7fc15f93dd48a8a40c3.1772529875.git.zhoubinbin@loongson.cn>


--IODElQvcItTdZo/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--IODElQvcItTdZo/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaacxRwAKCRB4tDGHoIJi
0jS9AQDSc9WSVw08r08VcFLqfqMDbJZEfc37cMAgPngoYWMkzwD/WpD9cKhcf2Xs
1QGC6wUDULr1fUlifiDcPUOa44LDBA0=
=wT3X
-----END PGP SIGNATURE-----

--IODElQvcItTdZo/x--
