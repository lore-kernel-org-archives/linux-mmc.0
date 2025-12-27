Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD831A06A;
	Sat, 27 Dec 2025 12:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766839850; cv=none; b=bvs+Ggj8xnsfa2N2fQID2gCfm9pdL92//sYps62jDEpYd+hr5eDY9XuLPmYFWIPIep/W8gJk8nBn6VjFJpVOEQDK16jdIzTzIS9o1DnnI1xr6xL6NovBroRE+mNJ3mnLiWXRen0SGe5VHKcBgLZLQdstUe8OhkCfUoYFKLypYYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766839850; c=relaxed/simple;
	bh=NoIiabkLSrEfm+Wn2XfQIhp2qSUkWHgkyhkvdmrWEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/oDJCoOTqb1VZSPHM1SfCk5ioNZig7AmRtHg/c+6Eqv0PQ+dTWwRUzNvpNaDagZdPeX7u1jn0kmnRv31Tal5SyQfCIy23J/HKiU49LgAyglgeJ0UpiLgNUttLF8L+TRbdXJUWizidbhWnTsYsWZrl+uEGu4Zy3zJJGt/7tlCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czEyINwS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czEyINwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A08BC4CEF1;
	Sat, 27 Dec 2025 12:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766839849;
	bh=NoIiabkLSrEfm+Wn2XfQIhp2qSUkWHgkyhkvdmrWEUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czEyINwSV/6DJ3pY5shcwPoPwK3alLx1nRFTnjf5SW768UJ26RrFupOJEwMaQcI6P
	 vCoutClLn8Fez7ZsXkieVXWo2ksY4a+IQ7cPjOtX0j92J3ENCWpHQSlwGb8Jgo2lOS
	 gO5LDAxGuHIbrMloAymOBazQyBpdL0/lnCR0kT7dUPVhuFSk+LRu5KYnU2n+D0JeY6
	 5eF79SRu+y3116Ip/NiZ0ls+hz1u3H5ONZxDDVCVyddmOk98r39U16eByR2+PWvbqh
	 7R19EYGNWrRbCXtE9bw/qy4zhsmexDq7O5rNqt9NwZGIwn4Pmcz/dBeMT1/qK8g38+
	 vGJjzkPoF3UXg==
Date: Sat, 27 Dec 2025 13:50:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tzu-Hao Wei <twei@axiado.com>
Cc: SriNavmani A <srinavmani@axiado.com>, 
	Prasad Bolisetty <pbolisetty@axiado.com>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Harshit Shah <hshah@axiado.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 5/8] dt-bindings: mmc: axiado: Add axiado eMMC variant
Message-ID: <20251227-industrious-mammoth-of-culture-ff9dbe@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-5-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:45:04PM +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add device tree binding variant for the Axiado AX3000 Arasan eMMC
> controller. This variant identifies the specific eMMC controller
> implementation used on the AX3000 SoC and enables the appropriate
> driver configuration.
> 
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>

Incorrect DCO chain.


Best regards,
Krzysztof

