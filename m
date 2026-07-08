Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C124E3790;
	Wed,  8 Jul 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522656; cv=none; b=Bf6RV5rz7fUvABUyq6de++2FkUfsGDpl2exWSCvM1N5s1SeZucFrFrqspGdlYiWbClhPbNgMYLNYL8Am715kZ7VKLYN5mhBrcwwiQsx6cbqqteUp9eJNu8FS2btJLum+AR5z6lQK81IPRMR3yr7kzWuBDrnJfYoXOomIjuYy078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522656; c=relaxed/simple;
	bh=3AEfHQm10t69uz+TZveTx4hX6HDBmN5rN3exRE02FeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os2L4oleao3EGqjBV9+F2uvWJWkLiTnX6GTfReDKS7JflGiN4smjOhkzMVC+cj3n+UKSsnBpCBvLnMdHo5safsdTijrdIKByS+QTHCS9ZL1Q+qjJm9NBT0ZK0bnHA3KsqpZ7Y3pBLpaseqwNG/4psnDflTEZVFjWHZjL+As+zkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br8aoGyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br8aoGyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D512A1F00AC4;
	Wed,  8 Jul 2026 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783522655;
	bh=qoZ280uhy7JTGVkTvQaxSlDpOpz9ZrDz5L1tLvCiprI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=br8aoGydkb7csIpon1GqWw8aTALYLC9KWCh9PZD3GaKPomWHmt0jaMzgkw4cxhtN8
	 R88mV9PFowCj/H6iM0mPGnGv3qt663KJdDQb9GEf7BvXiiS+FWclL0x/NvGPz2SLKw
	 iqRWlZ/iFiOWF9e1Uk4j1fIB3aY2u9DXIhmzAxXDNW91fvhoViEbxNnqQJjFlvWn6D
	 2SKvqagaajD3dvZ2XGnkMPP1PnZNgam8Mrn0+TfR/ppBQtcJmx8VtRHg6VNeN2c9v7
	 73JpUuMR2LYJyyZaKaAxvNnNCGzuYTRIwd3SXsOQBvG1oQ0meD7ErxRW8gEWUJR1Ow
	 W7EImo64rugqw==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	monish.chunara@oss.qualcomm.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Imran Shaik <imran.shaik@oss.qualcomm.com>,
	Monish Chunara <quic_mchunara@quicinc.com>,
	Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
	Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
	Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
	Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
	Xueyao An <xueyao.an@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 0/5] arm64: dts: qcom: Add initial device tree support for Shikra
Date: Wed,  8 Jul 2026 09:56:35 -0500
Message-ID: <178352261652.2235436.7454171283560267964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
References: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 12 Jun 2026 22:57:36 +0530, Komal Bajaj wrote:
> Add initial device tree support for the Qualcomm Shikra SoC.
> Shikra ships in a SoM form factor; this series covers the CQ2390M,
> CQ2390S and IQ2390S SoM variants and their EVK boards.
> The series adds:
> - dt-bindings for the Shikra SoC, CQ2390M/CQ2390S/IQ2390S EVK boards
> - SoC base DTSI
> - CQ2390M SoM DTSI with PM4125 and PM8005 PMIC regulator definitions
> - IQ2390S SoM DTSI with PM8150 PMIC regulator definitions
> - EVK DTS files enabling UART and eMMC on the carrier board
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: arm: qcom: Document Shikra and its EVK boards
      commit: 62eaf922d773c89153fdc6f612d4783610a4391a
[2/5] arm64: dts: qcom: Introduce Shikra SoC base dtsi
      commit: 14a9b4bcc8dad3eee35faea4fde9ac31507e2ab3
[3/5] arm64: dts: qcom: Add Shikra CQ2390M SoM platform
      commit: 28ffbb18c21e8baf9bf4440e8ef949b1b7030a4e
[4/5] arm64: dts: qcom: Add Shikra IQ2390S SoM platform
      commit: 8dbf2a0283b1f7beb464b598cee37af69ed73640
[5/5] arm64: dts: qcom: Add Shikra EVK boards
      commit: 2ef5adff2d38698cad70cb779555c9c173f24d2e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
