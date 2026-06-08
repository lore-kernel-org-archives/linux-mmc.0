Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE66364EB7
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917525; cv=none; b=Y+FZZJcK03jdqs+3TSfBUliuzPQwim+nk1PfThZEx+Ki2B7JkatWi7fWGLfCywn480WzVYUjhLYQ1qOwcXO/Ye+j6r79T5N0OYjFu67/9jX+ubv2UCwwJBr3w4xYyLxvvy76xPwAga/94wM3PVwh/9Z3T3z2KBcplQnLORd+eVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917525; c=relaxed/simple;
	bh=pFMAGQPvDoEOfbv6xk4LPNtyK0BZmw1e8x0Y/MFQuBY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmgFZUPjQRr5q8fsUE+w2pSJ3Pw8kj08O1gt7OAWRjexFO38srdk9hr3O0eA/j156uRPP26RdrBwMGl0UM40VZo8+eXaCjZieqWZzAQQ92oDi840y0OTjfewU8MaVmdHisf+uNMlZEWKWeYbHmZs+cH+zavxgh+8pirEYG4iFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/erb8Xt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/erb8Xt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9A31F00899
	for <linux-mmc@vger.kernel.org>; Mon,  8 Jun 2026 11:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780917523;
	bh=pFMAGQPvDoEOfbv6xk4LPNtyK0BZmw1e8x0Y/MFQuBY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=h/erb8Xt0IiBnt5uzTjO6qSZh/4cdyjspm9xTnppXWhOAYs1EE8YVBvDK+ldNqakT
	 c6uSakP62TFkAIRhg9NlSBU9w3g2xjLlmUL0t/TXf3ov7jpxrQkM0AoB82zgoh7idT
	 RFA+u9DWZQ7q13474f4nFuQJBqaH/zXaBzXb1c/cLISKlPynpMiHeRuLG2nSOI3SH6
	 LwGh4JQuLLPjJ5zc0jAFOwzsU1jyGtdNRoj7ZnlNNEBj55GfJWqGrXuwRqyCOeadYE
	 7IJYVGMvtyEaWVlwKzc2Gl8axhPa/I0ioRnKxM/mnoqOORek77220U7fvRzlmDSiKj
	 ci7eNvKgI7zGg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39677242021so41015261fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Jun 2026 04:18:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxMSonNJWNq/C1Ua5pyGy/MWZupviQBiOwHKxnQMLCcQc7HNTOu
	0GIrxIJlSx4eAAw47c3ArM6Om0y3PnEnejQ8WwHljvhc/1b8gGd2eRW71ixUQzF3Fti0eSJSF0b
	ZNwhXy5BZbaMJNvaCTz0RzrjhXIsbCFK1upBp9sEgPA==
X-Received: by 2002:a05:651c:1583:b0:396:9dde:b5e6 with SMTP id
 38308e7fff4ca-396d0752a58mr36949311fa.5.1780917521671; Mon, 08 Jun 2026
 04:18:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:18:40 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 04:18:40 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608-block-as-nvmem-v3-1-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com> <20260608-block-as-nvmem-v3-1-82681f50aa35@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 04:18:40 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeHJMKuEm-aAqwoaq_vGcQm-oOX+9dFrp1kijZYWFnX5A@mail.gmail.com>
X-Gm-Features: AVVi8CektcE6gMbY10cEVnuX6KgxnarlC2iBfMp83fSayBsh06aH5Rgenq9H1t4
Message-ID: <CAMRc=MeHJMKuEm-aAqwoaq_vGcQm-oOX+9dFrp1kijZYWFnX5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] dt-bindings: mmc: Document support for nvmem-layout
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, daniel@makrotopia.org, Ulf Hansson <ulfh@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 12:50:38 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Add support for an nvmem-layout subnode under an eMMC hardware
> partition. This allows the partition to be exposed as an NVMEM
> provider and its internal layout to be described. For example,
> an eMMC boot partition can be used to store device-specific
> information such as a WiFi MAC address.
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
