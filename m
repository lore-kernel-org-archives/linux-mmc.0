Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F677372676;
	Tue,  3 Mar 2026 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772576883; cv=none; b=Alg/sayAvjLK3TphDWTMhoV1kWJW7zI+oqq5e6jmBbsTvmn4hLiMHiqING22QjvwwifFk4XHnUBFOk27ks4FlSeu7091KqpdHorE17L8Co7qZ6p24TcczdlOp3BCsHHFc3AKstxh+mCq5HACC8X6V853SjTv14tEyUWXHL8qGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772576883; c=relaxed/simple;
	bh=h+MB5FEoZuD+ObXgiTN2r18cSRl2AQklGvm8fstFmSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly6+Enrimwl1UUDY5IGHviubJXQdiAW63wnJ2gu8ElXj+Z62O4Usvd0bJSJc6pjDMVb5VIV81czCOMf9y5uOTNPFa2eNOAJjYLKaoFVpGqT94sMCcvTlB5Q/YWgqjzw/nAtE9Kw1uq1j74+PhOUQcijGWWbcFHOAQa7zs5u9kQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2+xQMzV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2+xQMzV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB3EC116C6;
	Tue,  3 Mar 2026 22:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772576882;
	bh=h+MB5FEoZuD+ObXgiTN2r18cSRl2AQklGvm8fstFmSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B2+xQMzVkzxSmK97R5uyX0710fC2BS5mmL0zXKOzhhQhFXaaTyw+uHGX2l8iQ13bo
	 v1Vbr8eGAdaM0qR3yoILry64iGddqsLSZWL0II9nqzE9B/5TcaPgJdddl+lsOrLI8y
	 F2gRvJ5fxbWJ2aS1qeJNfuM6R7vIWTxeeg/LXRSoZC3bMbG+7fWmiPiNH/e/4UtAO2
	 e9YORGzOrk6jQ+e7XoePD5qj/sHE3nmE5p/H/7K8fBneBOlO6v9PmiKkuFpvINwD7r
	 0Yle/A2Ju2NwhRrM2aWa1lVF1KzlXXfhn6Jffr5Q27rCR4fkD/IBTn9Iigqf0jPMmz
	 Nei0CJblySrVA==
Date: Wed, 4 Mar 2026 06:28:00 +0800
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] dt-bindings: mmc: spacemit,sdhci: add AIB voltage
 switching registers
Message-ID: <20260303222800-GKC289813@kernel.org>
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-1-89c219973c0c@gmail.com>
 <20260302-crewman-faster-9fd00b62e30c@spud>
 <20260302223803-GKB289813@kernel.org>
 <CABdCQ=Nd9ZW6OBnAiuki=2+DhVraW19bh_m8=LLQGUKN8TkEdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABdCQ=Nd9ZW6OBnAiuki=2+DhVraW19bh_m8=LLQGUKN8TkEdQ@mail.gmail.com>

Hi Iker,

On 14:51 Tue 03 Mar     , Iker Pedrosa wrote:
> El lun, 2 mar 2026 a las 23:38, Yixun Lan (<dlan@kernel.org>) escribió:
> 
> Thanks for the pointer! I missed that these had already landed in
> mainline. I'll rebase the series, drop the redundant properties and
> patch [5/10], and send a v2 shortly.
> 
Please wait a little bit longer before sending next version, give me or
other people more time for reviewing, as a quick test, this series will
break emmc driver as tested on bananapi-f3 board, I suspect it's probably
duo to clock related issue, but want to confirm later..

Btw, I was also preparing sd part driver, mainly target K3 SoC, but since
they are mostly same IP, the driver can be shared..

-- 
Yixun Lan (dlan)
