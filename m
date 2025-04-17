Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8700DA926;
	Thu, 17 Apr 2025 19:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917556; cv=none; b=ssXUplkZ0H5rzgyTLHWndd4osnEIfkRbyr7fAQ/99pcCfGpf5LoAyVkSPB8kLMTP5JxAuxOc0enG0JYDNgl+aeBcS8wEAiFsINDoR3lKuewGRw6fOJcogBmcc9CpxFmr8nd6YGo7kJTy5Cx9leB1zEMCP4H5JFt9hpsPMBP6n+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917556; c=relaxed/simple;
	bh=/nj1y7uyNI0Hnabe58fvjjxo0vJvoqiHg99tGLJatBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evJjSTm+EYAN3uEMZqRbOWGG+P0P8r986iW9jJa1AJcayQJkP/p9RBi+7Yf+XZ6DCtV1pKtrVf1rqP1jpazBnAslk6QIS/Shj099rshfkq+zbKzNBYqFdVI96xoJGImDdzMPTAJjNO4UAcfoq+HBCCA/5E1iahPS403IsuLxJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=uanQeqYx; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="uanQeqYx"
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 03BDF1F92A;
	Thu, 17 Apr 2025 21:19:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1744917550;
	bh=/nj1y7uyNI0Hnabe58fvjjxo0vJvoqiHg99tGLJatBY=;
	h=Received:From:To:Subject;
	b=uanQeqYxqFvRax/3xVgk6FJqoBYuHcHoxtfhxY0qI8WkQnxQedkcq+ft0paGowzPf
	 eSUwM0LOXEiwm8f9c1A+3eJ3oC78++iF7Xwn6vD5vBcv1KQJi3s1IDsxdzvDN2zQH1
	 ME/IyObB2Gpo3hlBQKT7j0Q/9S37pCi4lamJPX4qyCUmSVSjo+jgVUQpipgi2WIW3Q
	 EMzJl0GO3K7eKjwbu6JDPnhxZSxEvDnw8YS8c0CEjkmXeYrOkr4k6QEvoNbyd5E6g9
	 8ig/j1kqcXKy3/rjMxEaIThKV1ViztAOfjuzX5YnwSytWrUcBnwlCLNieNM0YfcdS6
	 aZ2Foix3DSeIg==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
	id A8A237F823; Thu, 17 Apr 2025 21:19:09 +0200 (CEST)
Date: Thu, 17 Apr 2025 21:19:09 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Judith Mendez <jm@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Josua Mayer <josua@solid-run.com>, Moteen Shah <m-shah@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Hiago De Franco <hiagofranco@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: sdhci-am654: Add
 ti,suppress-v1p8-ena
Message-ID: <aAFULUo9BMf306s3@gaggiata.pivistrello.it>
References: <20250417182652.3521104-1-jm@ti.com>
 <20250417182652.3521104-3-jm@ti.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417182652.3521104-3-jm@ti.com>

Hello Judith,
thanks for the patch.

On Thu, Apr 17, 2025 at 01:26:52PM -0500, Judith Mendez wrote:
> This patch documents ti,suppress-v1p8-ena which is a flag
> used to suppress V1P8_SIGNAL_ENA in sdhci_am654 driver. This
> quirk is necessary to fix fail init issues across various
> types of SD cards tested on Sitara K3 SoCs.

bindings are supposed to describe the hardware, not the driver.

You should rephrase the commit message and the description of the property with
this in mind.

In addition, I think that the dt-bindings is supposed to be before the driver
patch in the series.

