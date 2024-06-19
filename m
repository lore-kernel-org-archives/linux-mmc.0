Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005C80624;
	Wed, 19 Jun 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718791171; cv=none; b=r3kAYArMNPkxZJ67aUCrJzyJXYL45eskegNlNoHu+5hpLcK7tZzhOU6Aa/Lwzkjce1UxVtzWEvDUWGsoMEZTfbu6VCCmJPCdcaOrtX3HAmV3tqPO1eK6COtvlc5vCDdADW7oVXn5bQb07KDFhWQaPRXuaEsa9UCPMGwHlKGXEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718791171; c=relaxed/simple;
	bh=rVkec0lmYTeD+HpXP+XLA09ezAGhgUX+iEtNr7e0C8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+9Ti1aT1ZXmaEqatj7YhydOQwG5VXSndCMwYP03E5JErh2hppVhcrHfPMRPI6lIgzCWjw0xhrsmcysMf7DOAELRWZtciy3uqdqZwctI8fjAMOWgVChl6H8xzQknb5o24POCX7dR9rGRygb2p9gw5OJXSQ+L3DfRv586X8T+pos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmO5PGXN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmO5PGXN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281A5C2BBFC;
	Wed, 19 Jun 2024 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718791170;
	bh=rVkec0lmYTeD+HpXP+XLA09ezAGhgUX+iEtNr7e0C8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GmO5PGXNDpdmKwsPGSiskI0naNkfBwnko/Cmwg3mM8rDLVKWfkATunk7ezM4pWM4D
	 orJsnpcjABl3Y335KrMajXI7BNqscmYGKgM0gczpaRIT+MAyX8AwaKWhO4a4GhNjom
	 1p44htm7sl+q3LN5hASpFpvKc7AAfIo5+4iIkjSHBI/n18zdp517sakDtxnDscFh6H
	 g5g7om0vzD/in16jyDsqjA1nHxWvojRqP+aG4SRRouta+64idNQ11uTg0e2cx3+3tf
	 XgcMsn7pXVa4NhCUwN7YQvVAFZlzjwtYue5NTnaYhe3WU21Yb/Ktis3XGt9xSmdao8
	 mFixNtK48uwbg==
Date: Wed, 19 Jun 2024 10:59:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: adrian.hunter@intel.com, aou@eecs.berkeley.edu, conor+dt@kernel.org,
	guoren@kernel.org, inochiama@outlook.com, jszhang@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
	paul.walmsley@sifive.com, robh@kernel.org, ulf.hansson@linaro.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com, haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com, tingzhu.wang@sophgo.com,
	Chen Wang <unicorn_wang@outlook.com>
Subject: Re: [PATCH v4 4/4] riscv: dts: add mmc controllers for Sophgo SG2042
 SoC
Message-ID: <20240619-tissue-cornmeal-b8fde286df94@spud>
References: <cover.1718697954.git.unicorn_wang@outlook.com>
 <e2d3b19e06fa29116b8032addc70c8dc1ec3866e.1718697954.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oARMAadtnvvW9ND+"
Content-Disposition: inline
In-Reply-To: <e2d3b19e06fa29116b8032addc70c8dc1ec3866e.1718697954.git.unicorn_wang@outlook.com>


--oARMAadtnvvW9ND+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


$subject: riscv: dts: add mmc controllers for Sophgo SG2042 SoC

Could you add a sopho: prefix in that please?

--oARMAadtnvvW9ND+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnKr+wAKCRB4tDGHoIJi
0uQYAQCLDnQ8kuVplcSQhCJRGya0nlVeK4NRhWCT2y1i+ALS/QEA3SIUtrg6cbYw
l1eeyKul0LIKuHtMo89emedzhuEbdQ8=
=WwOe
-----END PGP SIGNATURE-----

--oARMAadtnvvW9ND+--
