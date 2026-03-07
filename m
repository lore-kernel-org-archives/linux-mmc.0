Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD133876B8;
	Sat,  7 Mar 2026 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772879854; cv=none; b=pCffgw5JPnS0Heml0v8H/Mc6F7iEjisIPl94KSBnse0YBoQTDBoPJPPqNapc80nbxKQNlDv7BgD/+riXAK/VwWANiGdrRZBQ3ekn1qOxoaaShlIEVqTSt2eu+M+B8IsVAnpA/zeYvnn4cfo3s87xSw3owA2ZV0kdPTZoOIx/bGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772879854; c=relaxed/simple;
	bh=wm4LIblvgKJNnIqDKjw21/GaoeWI2mGHymyPdxwm3do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s984T+kYZoVMcoDz5TcET/RtHohjYYskmyME6PIDcPn0S4gQTzxQdylCiU7LlS7yJbU21qfDg2W9Qj/wKUVz2JEboAiyoV0jmKAODLwCxDfSb+c9XRzQ5euhS6DrZ/TqzzCWiygqlmG5cg83Hxy574Vi0jE2p1GvoR0JO2jWEIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ka5PRuuw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ka5PRuuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA082C2BC86;
	Sat,  7 Mar 2026 10:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772879854;
	bh=wm4LIblvgKJNnIqDKjw21/GaoeWI2mGHymyPdxwm3do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ka5PRuuwTQNLtkGb5Y3yHPYIv7wprDa/pdjgaaDZwiB8vJ1f3rg7Kx4cg5Df6YL+h
	 BOvyvWKZAYXv2/JkVXTbFS39FStwW3+Ecumagub8BmyOvlsKQ0GnP2ojHKgCFf24iS
	 GHrHYWdsROF8SA2rvMCLxapunsuFoZQ4ypolHHUSQwjNEMSQv6lzmjAB7jMP338eJa
	 EuZSzZjaenXSnZCk2Wwb78tZJDd7Ye22mm5YdyXJxmbx2mWT8zsTb77q2lbY+JnCV+
	 9PA7U0ruzYQz+sPIHAXKYC9xRtSVoOH8ex+BmyxJu6LO66KAPwndFLbHlFBzDwT6Ia
	 uh/y8GfpyfnVg==
Date: Sat, 7 Mar 2026 11:37:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] arm64: dts: qcom: monaco: enable the inline
 crypto engine for SDHC
Message-ID: <20260307-wonderful-vehement-macaw-33b6fd@quoll>
References: <20260306093332.4193993-1-neeraj.soni@oss.qualcomm.com>
 <20260306093332.4193993-4-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260306093332.4193993-4-neeraj.soni@oss.qualcomm.com>

On Fri, Mar 06, 2026 at 03:03:32PM +0530, Neeraj Soni wrote:
> Add an ICE node to monaco SoC description and enable it by adding a
> phandle to the SDHC node.

No SoB, broken/missing DCO.

checkpatch also would tell you that.

Best regards,
Krzysztof

