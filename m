Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E305386C3C;
	Tue, 12 May 2026 22:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778626168; cv=none; b=um4ZgwWU8AMprRajg8H1G3xbi4yHrbiqnW3g3ji0jXAD4KocDr+EF3sB7ZH3iHVpOMlSlEVxN+cpBHq0JUmrWr2Aiii/cEvsv/b8XE4iBqy89LT2C82lXjrMJN9nNbL6Lzh8FVu8XmPMEVEnKlNRbfMbfsogVsfd5RxF+xBvC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778626168; c=relaxed/simple;
	bh=RWEoYL90bzVZvVW45ld5wXheGmJKScbYfaB+fYsV3U8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acpwyHj3fCqU1bl4ruy2oKEInB1wIkF1MH8So2ICVuzcZ04AU6IUyFEaOYz7qd/WyjWRCczujCE450d9ywHID0yIZotg8r64DffThE8ez9bAsPjHTYDnE6ZhVVAJZy5KcOQDjFm89/3spsovOlj8+BRzkAMyZiFLQ4IsUH7+LA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWEDOZEC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWEDOZEC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1CFC2BCB0;
	Tue, 12 May 2026 22:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778626167;
	bh=RWEoYL90bzVZvVW45ld5wXheGmJKScbYfaB+fYsV3U8=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=OWEDOZECHVyJqPG+aU0Nm3YBqY4sRG1rPct0AmPVnHwsmmsLUMtHqMFZGMaHZMdCm
	 y90TatDejFsBHjE7PzCQdVoXPWoiientLzj2Eg8qbOm9eaYDOtKkv2Uqw2OvaIAbqd
	 9HcAJCtqGKjLcOIrE93b9HkzVM+E7M0ncInaZkuaOShO52CLxWMW0NYTL3N3p186wu
	 ZDvzTLsvHRwmrD17sHCrXtxNFrbI2srDCo5eAqLDlgsUbNBsGiaA/KGPngVvaF24r7
	 NUnRXgVMdgBrSW/Y/9EouJNuGb3tqFQoSvn3SqMosFyOPm5JgUtRXmwPRfNNX5x4ea
	 vkfmMtK0Pz/yQ==
Date: Tue, 12 May 2026 22:49:25 +0000
From: Yixun Lan <dlan@kernel.org>
To: Iker Pedrosa <ikerpedrosam@gmail.com>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Alexandre Ghiti <alex@ghiti.fr>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Troy Mitchell <troy.mitchell@linux.dev>, linux-mmc@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-riscv@lists.infradead.org, Ulf Hansson <ulfh@kernel.org>,
	Margherita Milani <margherita.milani@amarulasolutions.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Paul Walmsley <pjw@kernel.org>, spacemit@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v9 7/8] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
Message-ID: <20260512224925-GKJ3624147@kernel.org>
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
 <20260511-orangepi-sd-card-uhs-v9-7-ae48c0b2b2cf@gmail.com>
 <20260512054358-GKE3624147@kernel.org>
 <agNdTiFbwtllEw0Z@aurel32.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agNdTiFbwtllEw0Z@aurel32.net>

Hi Aurelien,

On 19:03 Tue 12 May     , Aurelien Jarno wrote:
> Hi Yixun,
> 
..
> > 
> > So, how about let's make it convention here, first device is emmc, second
> > is SD card, third is sdio device (haven't added yet).. We introduced emmc
> > early before this patch, so it stays unchanged which is nice for end user
> > 
> > Please apply this alias idea to all boards although I only comment in this
> > patch..
> 
> Having a stable naming is definitely a good idea.
> 
> What about boards that have no or optional emmc, like the Milk-V Jupiter 
> board? I plan to submit a patch for it, so I wonder if we still number 
> the SD card as mmc1 even if there is no emmc.
Yes, please

For Milk-V Jupiter, it has emmc slot despite plug the module in or not,
so it make sense to name it as mmc1, in other words, the board do support
emmc in the hardware level

For future board, if the board has no emmc feature design in, then I'd 
be fine with name it as mmc0 or mmc1, shouldn't be much difference..

-- 
Yixun Lan (dlan)
