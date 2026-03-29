Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3044D35F61D;
	Sun, 29 Mar 2026 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774785236; cv=none; b=S+z7cjacYoC//kuzy51xv4YilqLEXJeTOapY0KtBYhUV7wlYab8Bm5yTELq+W1lT+NgJCYVrOKeeW/7TUr2zQ4FjpcDWQk8voWioO+Jm7iyN0fa/TMlAKi6j1I3yBGyo4bFy1mO/PcQ/jctwp+TgvoKaQf10XkxTHB5ezyNClps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774785236; c=relaxed/simple;
	bh=N+pyk1yZYmIcdFnfaEI6OThM9jG7Px+mkLTdB3oW6cE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LOlgziQpai7e1RWjBZr9b2PBF9CXIpGkiCzXWFd2Ajj149O8Fz3p3tMfygbRg3vwBjBsS2KWZ/uxgoKKrWCwG9VqZrIrkHEWCfusJt23NvKBSSkleZ5sBTf6TA9D3sNQQ8HQbXjGUBexQKMo/O2SJylxOyx5AT/6lLNATeEJE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
	(Authenticated sender: legoll@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0486F19F57E;
	Sun, 29 Mar 2026 13:53:28 +0200 (CEST)
Message-ID: <66856fb8-3316-4231-8800-90e52de6d906@online.fr>
Date: Sun, 29 Mar 2026 13:53:28 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] mmc: sdhci-of-k1: enable essential clock,
 infrastructure for SD operation
From: Vincent Legoll <legoll@online.fr>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>
References: <55c580a0-61cd-435e-bff0-f5f54cbe6948@online.fr>
Content-Language: en-US
In-Reply-To: <55c580a0-61cd-435e-bff0-f5f54cbe6948@online.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/29/26 11:20, Vincent Legoll wrote:
> I applied this series on top of 
> cbfffcca2bf0622b601b7eaf477aa29035169184 (linux mainline from 
> yesterday) and successfully booted the resulting kernel from an SD 
> card on an OrangePi-RV2 (with the vendor u-boot from the SPI flash).
>
> So if you want, you can add my: Tested-by: Vincent Legoll 
> <legoll@online.fr> # OrangePi-RV2 to the relevant patches from this 
> series Thanks Regards


Same for series applied on next-20260327:


Tested-by: Vincent Legoll <legoll@online.fr> # OrangePi-RV2


P.S.: Sorry for the formatting, struggling with thunderbird.


