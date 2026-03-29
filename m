Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3028FFF6;
	Sun, 29 Mar 2026 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774776047; cv=none; b=Ap6i4ENp9uHLYXM2LsJBhrPSQjCgETh1GCqpRhrEEwcp7yrZHkpEaMCzZtUf8+ji+id1HMjNcD3aRWFUWh3EdgRqqCop0Q5gGLtCb20xWCiqVeIQXkhS2CEGQnYwBMrmPCFYV10k4HqvOjmzgmhAwdBAHU0+92GBi6IlE54YQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774776047; c=relaxed/simple;
	bh=IzsenYqkDV3+9tNmaGCCPfebzIIP3eioMbhuiFIrBPA=;
	h=Message-ID:Date:MIME-Version:In-Reply-To:To:Cc:From:Subject:
	 Content-Type; b=mFOLbVF14sUrxzt+FABzXE+Q/JeABSoXOZ9ehiqrZZsWQuuXVy0qjTaJgrfwCQ48hsEBa4haoHNFvi+ma8EgQnPNjDaclNVSGjHXBRb+ZpEHFvkmPOgKyrri+5fSm60kH/h0EwySHFw/0r0/LvVk8qpzf0N1/d7oj79FZGT0Hj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr; spf=pass smtp.mailfrom=online.fr; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=online.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=online.fr
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id B96594CFF3;
	Sun, 29 Mar 2026 11:20:33 +0200 (CEST)
Received: from [10.0.0.2] (unknown [82.65.243.93])
	(Authenticated sender: legoll@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8F1D319F5C6;
	Sun, 29 Mar 2026 11:20:01 +0200 (CEST)
Message-ID: <55c580a0-61cd-435e-bff0-f5f54cbe6948@online.fr>
Date: Sun, 29 Mar 2026 11:20:01 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Trevor Gamblin <tgamblin@baylibre.com>
From: Vincent Legoll <legoll@online.fr>
Subject: Re: [PATCH v4 1/8] mmc: sdhci-of-k1: enable essential clock,
 infrastructure for SD operation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I applied this series on top of cbfffcca2bf0622b601b7eaf477aa29035169184 
(linux mainline from yesterday) and successfully booted the resulting 
kernel from an SD card on an OrangePi-RV2 (with the vendor u-boot from 
the SPI flash).

So if you want, you can add my: Tested-by: Vincent Legoll 
<legoll@online.fr> # OrangePi-RV2 to the relevant patches from this 
series Thanks Regards

