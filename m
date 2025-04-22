Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14D27F4F3;
	Tue, 22 Apr 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326679; cv=none; b=fRkxrqW1RbY0H8jLuvxV9JCV4XFV6z5xUWIjdURa+elozAF03cn34660LncPovCpukd0T7Hh835rI624aO4E/izs0ogSQospHTza1AsI7tCEqFVwIT5rMF+C2FIa8nl+AHazyQ74vTRSbI3OEg9DXHQ2A4BV3f6eGdG294b9GaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326679; c=relaxed/simple;
	bh=Buydnb1brQCrsBzxnIknrnGlVBoKaOGAXT1ccRwyggI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c854AzBGVGTTFxEl+lGnAlqGtGEmf8RCukndwzMaN5kCytxjQ63ecymd5MQTujGw53r5KZP3UpnChp+31i1tcqcgO21sDzDx9aEfISFM94eDvdY0jYxrPm+HC7pE2s3yfgaHaRf33JnGa1rZtKGP77V04qiZ/00sM2sKxwARZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2VmMNRC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2VmMNRC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB40AC4CEEA;
	Tue, 22 Apr 2025 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745326679;
	bh=Buydnb1brQCrsBzxnIknrnGlVBoKaOGAXT1ccRwyggI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2VmMNRCEi7WJqMCrt1WOFMqEACAdFXVqYhH1tnD8F68yfdH5gYdOyyfSBaEynjMd
	 9T9J8BTU/uK8gkV9Yt8zkY7NZJ9NEtqukT1WflcOFH9t8IBPHY8fobqpD3TRlV40S4
	 jMiwhvj9ztrJeAnvkXV23Gk1ErPE5IgAGBobG/7labrGqdAJo0Qe1DDdW6zifYMch5
	 Ox/tUuGl5MgpVuhMBrsoBTcltLu/myjNJd0VD4VDExRg61FnHFTXBku9492Bq7OR8V
	 a9RDLwdhKb6yey+pCwZ3FnqZ13MAFBHEzQFPg1o8lHJUNmeZx6ukRcGJ7JJ5iBJcRf
	 jHFOvwZEqQBYQ==
Date: Tue, 22 Apr 2025 07:57:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: add compatible string
 fsl,ls1021a-esdhc
Message-ID: <174532667655.964585.15839963824167551286.robh@kernel.org>
References: <20250417151300.3570021-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417151300.3570021-1-Frank.Li@nxp.com>


On Thu, 17 Apr 2025 11:13:00 -0400, Frank Li wrote:
> Add compatible string fsl,ls1021a-esdhc for LS1021a SoC.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

