Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2E02777F9;
	Tue,  5 Aug 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754407490; cv=none; b=IFrBSmGnbKZakKIHXEIO/ViytwZvx+1jkCRuRevaNaiYZ6N7GEtyIO3YazMlxYnyIIURGIrO7YSYOACjQjVbMLemrjLsXT+3kpAZ6SCqKCD0n8jmpwj+1fhzsE3PBXqJns++MvwUR/qW9ykT6w3ZLW0fowpB9RkkvJ77RagvL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754407490; c=relaxed/simple;
	bh=97kct6PPabBUrzu7qy+1m0OjpYO0JiszZ63BiWMDoY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qufa2CdPNizQJv4Nc7eWVusnFjFHusv2w349hYsiAa/zALk1enLjvB+kxN1b90Zhj99ws3Ns1Y8ktsi4mi8/pITR46tnHal0fD/spkaXJ12wWKQbrgmQX/45uylPB3grX3V0Qe7OEJ91/El1QAs5+bbZOC6tScMnN6SafC8nXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2gQZZkB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2gQZZkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983ACC4CEF0;
	Tue,  5 Aug 2025 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754407490;
	bh=97kct6PPabBUrzu7qy+1m0OjpYO0JiszZ63BiWMDoY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2gQZZkBnklYg5klw9G8DgA4Iy/DzU85xwb99UpA/sTfAenk4gwUnfsTMZJTCmnk1
	 Cce5UdMPsItPZFpY0k8wcsRQ+cKc2sfgJ2kCMNLC3qw9ENMd8q3WQvMENz57gshMcI
	 9tPtWZwsu4WjlWEo/3foJhUZKWbAzyjgMEZSNTToJOOpu8MxMIFYGuF60g5oMbkIbS
	 GkWzgyyeaiQqfqmGY7dPufob8tp+hIxTy5hEdBCTEhKwerdY+gujgBJpUBsV8dHSzf
	 +vautmgSaFZ6bsTi/IpHKkcvJvzqBy3C/f1gjtF0WuaaAUqE20H/jOQ77e95oGSU/H
	 APLbkGIS0dd+A==
Date: Tue, 5 Aug 2025 10:24:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Karel Balej <balejk@matfyz.cz>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	David Wronek <david@mainlining.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/2] dt-bindings: mmc: sdhci-pxa: add state_uhs
 pinctrl
Message-ID: <175440748721.1807566.14795455362522050804.robh@kernel.org>
References: <20250801-pxav3-uhs-v2-0-afc1c428c776@dujemihanovic.xyz>
 <20250801-pxav3-uhs-v2-1-afc1c428c776@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801-pxav3-uhs-v2-1-afc1c428c776@dujemihanovic.xyz>


On Fri, 01 Aug 2025 16:14:15 +0200, Duje Mihanović wrote:
> On the pxav3 controller, increasing the drive strength of the data pins
> might be required to maintain stability on fast bus clocks (above 100
> MHz). Add a state_uhs pinctrl to allow this.
> 
> The existing state_cmd_gpio pinctrl is changed to apply only on pxav1 as
> it's unneeded on the other controllers.
> 
> Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
> ---
> Changes in v2:
> - Newlines between properties in if:
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.yaml         | 47 +++++++++++++++++-----
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

