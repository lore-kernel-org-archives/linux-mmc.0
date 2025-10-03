Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3960723DEB6;
	Fri,  3 Oct 2025 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759524266; cv=none; b=Z08ZZs8JdeuCn0Uii/nf8i7d7i8D+cOJXOFsKyCABI1G4vz4YyA9AIycEH1d7xRVhJoeJzo0ycx4csPx0/V3MqDyrhdAioKWbtXy/kxJS8zvY0mWamS01efjiKktPpvrcizr95hfg07FnfOGKJ+iz6nRrNaS2SeXuDyZuKef8mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759524266; c=relaxed/simple;
	bh=54FTAKHIcGVENuiw11l7Sv+5PeP644opcRULdrdTj1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtmbjlW6vYnquPgsC9veRj4bF5TrhdE5YqBuZLo7Lkc2kruFlWpzmPbMayvcRUmJECwDtxhcpEsHBvRWFrrIdFkAlh34YG0DiqGyp2pSFhwNv/8M+saGcmdZuG9dwz3OkvMDoukIn8MRbTr9MsFtn6jSUZkWdpBLjMqjO24KEcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7q2LwPN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7q2LwPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419BDC4CEF5;
	Fri,  3 Oct 2025 20:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759524265;
	bh=54FTAKHIcGVENuiw11l7Sv+5PeP644opcRULdrdTj1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7q2LwPNDbXvjHjRnXvx36WeZNGTODIuolwlQo5Dqt2rxOMq9O5AGLC1dVo6RgxHO
	 QuzChuBQrxbsV5sWYgWgYF/uKW7caIwbg1qMB9pCIGJ6w2D+koTs/BqtT7aNKzgJfQ
	 6itLFtDVrsGLd8C7PYftNHLNuOrqF5dJB1TcUqX87MuURgsK48K7jZbUTYeqIxPPZW
	 0MSxlCWxe4mOT0umGkVzgzH5N/4BtwrKcXx3ZogEUl4CGFCHu9uFcVUAXQh8LaIbfp
	 Q8DPvR1mZ/MrhjnLRAIuYuwkApF55a9ueDibizajlb/R1E8Pff6BeJl2O/+X48BaLx
	 NfJvR+sDLmu1w==
Date: Fri, 3 Oct 2025 21:44:20 +0100
From: Conor Dooley <conor@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org, adrian.hunter@intel.com,
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add support for BCM72116 and
 BCM74371 SD host controller
Message-ID: <20251003-appliance-unbend-6b74b95545cf@spud>
References: <20251002210426.2490368-1-kamal.dasu@broadcom.com>
 <20251002210426.2490368-2-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ielvYfLA4/Su2iIO"
Content-Disposition: inline
In-Reply-To: <20251002210426.2490368-2-kamal.dasu@broadcom.com>


--ielvYfLA4/Su2iIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ielvYfLA4/Su2iIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaOA1oAAKCRB4tDGHoIJi
0h9aAQCCTsMeWOs+cV7oDBxvmtOM2qgehIwmpGL2CnnAXKRk7QEArXDstpWr8c8G
WasCUqneltZCOUzT1SsXj20X9q1DzQY=
=MZV4
-----END PGP SIGNATURE-----

--ielvYfLA4/Su2iIO--
