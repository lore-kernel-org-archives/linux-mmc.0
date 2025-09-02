Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5232F76E;
	Tue,  2 Sep 2025 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756850654; cv=none; b=RdsZ19Ls+lvr+SmzGB9jVETGpNWoLQ1h0WY1+HwY3/mwO6VYpaFRvj5fr29a6XTRVvmvk7x+O25MlOpJBVpwvLB1cQu6EAmlpu3zhA2eT+OJ2/s8OM2wy4FaB1Fg4y4I2dAzmpyj8+7vUS+eADTZHli7AYfP6devsxlgGSbaP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756850654; c=relaxed/simple;
	bh=BD6Zne3XZGwUDgfH6AtniwohdQGaDqOKcXDVAIWcE40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lrBGcyVNMvuIiQqmHANI6RpgodN9BEUwP6N+okor3rT03eKcuPSF8kga3Xdyl8vlv7GyctHJYIr3Un4jnGRrpM3TxzFHhGu+vReXqEzXmeEaYX+fkNQvBhKmVzRSoroP6eP48j29cfPfWrawnbLmR6bma3BtuVa1e18T2vxVKC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=n4M9BdW1; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="n4M9BdW1"
DKIM-Signature: a=rsa-sha256; bh=BD6Zne3XZGwUDgfH6AtniwohdQGaDqOKcXDVAIWcE40=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1756850541; v=1; x=1757282541;
 b=n4M9BdW1+TWwHpSDIo9huyAfD1siBMhJZAp6y1vXcZc4drhit1TKZxQlSF3J5rJOWMehtiLm
 FjI0RZiaCIHPoZ5fYL0v1DIYETeCEpbYUI+ixE/HitY9n4t7u6dGD1D/NNJEjsZyu0WlXAbtQt5
 qoMz+hrgTTlk8e9a+1L5XcVRqQpXStxYiEW+PXBTRjO3xysEI54R0e/AIU95ftk25RihrwAyPeB
 FMx4eFuT64EDqOFZjJJNI3o7Yz5USA08fOytprjr/PQ1VXQZFHcJsqvWqZHCzPRMrwwdxa9XBbR
 HkIMDqYPXQsZiC0Wu+NhtrTwvTX/fllr4rC6hKLNFOzZA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id bd5db0db; Wed, 03 Sep 2025 00:02:21 +0200
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Karel Balej <balejk@matfyz.cz>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 Karel Balej <balejk@matfyz.cz>
Subject: Re: [PATCH v2 0/3] samsung,coreprimevelte enhancements
Date: Wed, 03 Sep 2025 00:02:19 +0200
Message-ID: <4689450.LvFx2qVVIh@radijator>
In-Reply-To: <20250828095028.24503-1-balejk@matfyz.cz>
References: <20250828095028.24503-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Thursday, 28 August 2025 11:49:01 Central European Summer Time Karel Bal=
ej=20
wrote:
> Hello,
>=20
> here are a few patches adding some of the stuff that have accumulated
> since the support for the samsung,coreprimevelte smartphone was first
> introduced and before it made it into the mainline tree.

LGTM, with the exception of 2 tiny formatting mistakes with the pin arrays =
in=20
sdh1-pins-0 and sdh1-fast-pins-1. I'll merge the series and fix these next=
=20
week if there are no other comments.

Reviewed-by: Duje Mihanovi=C4=87 <duje@dujemihanovic.xyz>

Regards,
=2D-
Duje


