Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DA3A8FEA;
	Tue,  4 Aug 2026 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785876974; cv=none; b=S1Vf8YZkotgKvLLYm26uKxdLTQyILPTuCt1NDj5HjwwTlOyuygDu4n+fetcayO/DuJCOITxIwK9d4kJWtGa/t6wOgle4SgIrE4VXhSq4ubRVQITu6jRdyjuQ0kNlkzUV7cD6p/b64NbOvkdSy8mLAdOjUkwyk9rgJ5V72yMQt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785876974; c=relaxed/simple;
	bh=k1Z9fhkvKVYFys2XCflC1fL3SWy4IjTO3wY6DPJyU/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkDIXDEMZEBxiY7TEjNN/icswWG+a/H3wuVdx+/qquqW52ppXk9R3w4iVxXCUdP6SQMbU/14ibPgRBamTvYqCBybKLN73AZX2m27PO8SZ4SmT1f84y3/e6PiyG53F6rJ8ed1h0QqM603Q8avWZznlRy530DTlmRdPmbD44MkLxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+kux16e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+kux16e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DB41F000E9;
	Tue,  4 Aug 2026 20:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785876973;
	bh=9YOsQ+rBPn9d28sHnmoOeTmrbg2MpDZVI503soC2Rp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B+kux16eJU15JNcP1zldUFlNCiYDO+dsXny0CDOvofSvJ54VRQycPsZZssi73UxS0
	 1O/vv4VBcN9DjfIR1rrbDXpdzoencTOrxGv4zljhSTqyccd+g1aymRGIXDngmHISs/
	 YKZEnZpeWli4x4u3/SClzwH64PmwZL4Lx+B/M39zuyK8Pb9yYeCbr3V32tc54siarf
	 Mfqu7AfZip9jLAiLOhJOEflY3yavUNQ0q6vPmmTmKO14dpv/lqYwderFHPDWyKB9SU
	 9eDYJLY8WnufAG8xYZx7MhC9/O8Z/VH4unsbPAXrI/ZIK+eZeSrRlwsDh76IJZ25pW
	 31mAdVKYIKzfA==
Date: Tue, 4 Aug 2026 15:56:12 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Judith Mendez <jm@ti.com>
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: Add power-off-delay-us property
Message-ID: <178587697208.1941958.2441835897698700035.robh@kernel.org>
References: <20260722205701.372789-1-jm@ti.com>
 <20260722205701.372789-2-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722205701.372789-2-jm@ti.com>


On Wed, 22 Jul 2026 15:56:59 -0500, Judith Mendez wrote:
> Add power-off-delay-us property to MMC controller common.
> 
> This property shall be used to specify value of delay after
> deasserting power during MMC power cycles. Default for delay
> is 1000us but custom delay can be passed in to work around
> hardware issues such as slow RC discharge on MMC VDD rails.
> 
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - Change post-power-off-delay-ms to power-off-delay-us
> - Fixup dt property description
> - Fix check binding warnings and remove $ref
> - Fix minimum from 0 to 1us
> ---
>  .../devicetree/bindings/mmc/mmc-controller-common.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

