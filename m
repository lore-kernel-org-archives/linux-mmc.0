Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA193DDB0A;
	Wed, 16 Sep 2026 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591037; cv=none; b=mkEUGPWlvSiK3p0LWMoGEXny8wL13KvnejVtXh8JGVCaOMclTNNjZjPWglUsrxUoPVOt7A+SXbYu4ftbx4Svb+QBibvg+8D0P85Z7MIq0epG5AfGNSDa0OlqraBFqcz19DJni67TsuKzpzmnUYFzipI46B9m/IfxZTW5YNSIZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591037; c=relaxed/simple;
	bh=pWP9pkOjKfVjpz6OztSz6zIOaZB/RmuwzEKNO7a84R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOSlye0Jab54BvH8n7KNAwDg53G4d5KY4uh15TaFB5RmDKM69DY2aqsoEZbBH6wm89x5b/jXYbMahadytGPxIyp6jVqhSM1JhMd/9imXO5LnDRYynVMDXxBhOQLGxaF0sy5bP1CkVjA89rsLGg8HgZYvl5OKj1R+gCw5kHJoLMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh5q2N24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh5q2N24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23B21F0089A;
	Wed, 16 Sep 2026 20:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591023;
	bh=6Q+WxJ3NRja0iBPcIiZmImtHqJDLGM4eQtUUFwXaPYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uh5q2N24aFNHTWnB3epmA4lJx/1BpqXxOK7L4BmjoHwTjr7WZBrDuBJbcer01hS7d
	 fcM/NqYm6+/NvJjcYh1n7uKGG6InZ0Hh0O9mHIBH8b0ZfYQMY64iHK1rzezMZw9mrm
	 ApKQvd4tcoBWBbvvSJpg7xSdTXor2cYCPgsd2jYXwfhFsNZv9B7lrFQAkhsc2MdS2X
	 mrG4ReyXYbmKH4HQkNLS0WuU3QTC2ldbvUqwGv+XZlVqBCIZEYf+gzh0kQ8YrYsDSS
	 qc7cWFEDnQLb9VisRvMzpLvgb7scq20xovhWsQVBFT6AWbmB4vmljcUiYO+ZKcIRrq
	 0FOGWqpT6HbWA==
Date: Wed, 16 Sep 2026 15:37:01 -0500
From: Rob Herring <robh@kernel.org>
To: Lucas Tanure <tanure@linux.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: amlogic,meson-gx-mmc: document
 the T7 pipeline clock
Message-ID: <20260916203701.GA1463751-robh@kernel.org>
References: <20260905153234.133217-1-tanure@linux.com>
 <20260905153234.133217-2-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905153234.133217-2-tanure@linux.com>

On Sat, Sep 05, 2026 at 04:32:31PM +0100, Lucas Tanure wrote:
> The SD/eMMC controllers of the T7 SoC are physically far from the
> NIC_MATRIX bus fabric, so the hardware design inserts a pipeline stage
> in the middle of the bus path to help timing closure. This stage is fed
> by its own gate clock and, when that clock is disabled, a controller
> that starts a DMA transfer can never complete it.
> 
> Allow a fourth clock entry, named "pipeline", and require it for the
> amlogic,t7-mmc compatible. The other controllers of this family keep
> the existing three clocks.

Did the SD controller not work without this clock? If it did, then this 
is an ABI break which is evident by the current warning in linux-next.

Rob
