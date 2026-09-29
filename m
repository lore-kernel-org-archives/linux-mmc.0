Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDA1443C07;
	Tue, 29 Sep 2026 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651791; cv=none; b=YhwErAaMZl3uIgi+g77dEJqx/K3jNmigNWGjgoz+qlF7uoP/UmgID4Bz1nDx0LmYeQrWE1LeYax9o63CplL3ESTgQPgCBHc8ej0dMlIbnMMBHXy94HbyFuAyn2pBJn1ifu2LTMZNH5O4mdsy9pLcDDF++mQytM16wN/Tn+dYKr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651791; c=relaxed/simple;
	bh=FhKS573eypf9ACHhX4eCBPBBT42THTnvtGEfkXUVxsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T73NXutCSEcMK1eJEO2mYWw+pPcyTNazI5O+GRLnPk3QGdCKnbQ4a3cRQ9dU3Bt57h3wlfpaqfI5wAu9pb2W55QfbzEw8GNy9i4DgQdq9dRdLJzCabXNQ0MXOt2SB4i5Eho6FQK9moLHFA5Ak8xT6Ph2HAL2uQEmApar9rtFWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIkkvw/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIkkvw/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ED21F00898;
	Tue, 29 Sep 2026 03:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790651782;
	bh=xLqPBDxX/z5XHXrJJdZYoBFeEYJMYZzsdkw/9Q/j/aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dIkkvw/gHCeGIbWDg/aQJly4PgmeIcc+zAbpFeTgJeWMHrNyhfklT1lN44r0pFK1G
	 VBigjES+oCQcbXpNVWTdBXqBRwEuyysFkCW3wGFQEfaTtVILBVLA4OL2ixxtNC3cvm
	 LZMImjvkFVNnDAbFj7mHeEElVxPy4zIYyewqgb90/aBRkU8ETIlpU5gB+eooBmGslV
	 FMzNygAzn4POwWALHllgrPHEnz57/ykYCjrrWS3pWOebnK2P8Xkj8Y9Gv39yON3VIl
	 Jtm/Dkfv6Kn1jUAQD2GlrljiaGXbaAZVEvtwNIQo6G+0UC5cbuSLYFX8c4CGvekbcZ
	 PwpUbQ/mLTy+w==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Kernel Team <kernel@oss.qualcomm.com>,
	Monish Chunara <monish.chunara@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Nitin Rawat <nitin.rawat@oss.qualcomm.com>,
	Pradeep Pragallapati <pradeep.pragallapati@oss.qualcomm.com>,
	Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Subject: Re: (subset) [PATCH V4 0/2] arm64: dts: qcom: Shikra SD Card support
Date: Mon, 28 Sep 2026 22:15:12 -0500
Message-ID: <179065170886.2673486.3376256399465170072.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804122054.3462145-1-monish.chunara@oss.qualcomm.com>
References: <20260804122054.3462145-1-monish.chunara@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 04 Aug 2026 17:50:52 +0530, Monish Chunara wrote:
> This is v4 of the Shikra SD Card support series.
> 
> This series adds SD card support for the Shikra platform.
> 
> The first patch adds the SDHC2 controller node and the necessary pinctrl
> configurations to the base Shikra SoC dtsi. The second patch enables
> this support on the Shikra EVK (CQS, CQM, and IQS variants) by defining
> the regulator supplies and the card detection GPIO.
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: Enable SD card for Shikra EVK
      commit: 87494196c2f551710b4ae90ea78912d4d3abcc6b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
