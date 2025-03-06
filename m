Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726D28F1;
	Thu,  6 Mar 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741269625; cv=none; b=rstG7GrnyRpmo9UxYRtXcMnXkvBlBJU8DLt79U2nkcMpMpYH9jyv8cNSDJWUWfqSx2q+jGbzak4URbCxB8lD7vZk6ULMyNukd66eUnEQtUqRUedleJsZlSCUkbpnX8jBJIIoCBWRv4x+PJ1gJaw4n/GnpTr8GDwGQMmpiBnzZvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741269625; c=relaxed/simple;
	bh=MX91utLsuHl/Mi5AdWERdY/2ktfYjHMbQfX9saG1XSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H6Fw3GTWZ/iQnBAR3BHIvWdbhTAaKRW45aXsjuu8iFP1d0MhlWs8/24KnPf+6eK1hV1CqyvAXgMJt5k1weRaCIU09o8PVEnr0FFTllQSWTxRBM7re+w75BHAM+a+ytfLU3sBXARL9DCscOnwe0CU9f4ezderpEKGaEshf0FntJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.215.89])
	by smtp.qiye.163.com (Hmail) with ESMTP id d2ca3002;
	Thu, 6 Mar 2025 22:00:14 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: ziyao@disroot.org
Cc: amadeus@jmu.edu.cn,
	conor+dt@kernel.org,
	cristian.ciocaltea@collabora.com,
	detlev.casanova@collabora.com,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 7/8] arm64: dts: rockchip: Add SDMMC/SDIO controllers for RK3528
Date: Thu,  6 Mar 2025 22:00:09 +0800
Message-Id: <20250306140009.384469-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305194612.47171-1-ziyao@disroot.org>
References: <20250305194612.47171-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEhMVktMQhodSkhOQx1OQ1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKTlVDQllXWRYaDxIVHRRZQVlPS0hVSktISk5MTlVKS0tVSk
	JLS1kG
X-HM-Tid: 0a956bc1c0ea03a2kunmd2ca3002
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODo6Cyo4STIDNjM9N0JRDTwZ
	LB8wChpVSlVKTE9KSU1CTUpOTEJOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpOVUNCWVdZCAFZQUpNTEw3Bg++

Hi,

> +		sdio0: mmc@ffc10000 {
> +			compatible = "rockchip,rk3528-dw-mshc",
> +				     "rockchip,rk3288-dw-mshc";
> +			reg = <0x0 0xffc10000 0x0 0x4000>;
> +			clocks = <&cru HCLK_SDIO0>,
> +				 <&cru CCLK_SRC_SDIO0>,
> +				 <&cru SCLK_SDIO0_DRV>,
> +				 <&cru SCLK_SDIO0_SAMPLE>;
> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +			fifo-depth = <0x100>;
> +			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>,
> +				    <&sdio0_det>, <&sdio0_pwren>;

The sdio module is usually "non-removable", no need det,
and pwren may be other gpio (use mmc-pwrseq). So it should
be `pinctrl-0 = <&sdio0_bus4>, <&sdio0_clk>, <&sdio0_cmd>;`

> +			resets = <&cru SRST_H_SDIO0>;
> +			reset-names = "reset";
> +			status = "disabled";
> +		};
> +
> +		sdio1: mmc@ffc20000 {
> +			compatible = "rockchip,rk3528-dw-mshc",
> +				     "rockchip,rk3288-dw-mshc";
> +			reg = <0x0 0xffc20000 0x0 0x4000>;
> +			clocks = <&cru HCLK_SDIO1>,
> +				 <&cru CCLK_SRC_SDIO1>,
> +				 <&cru SCLK_SDIO1_DRV>,
> +				 <&cru SCLK_SDIO1_SAMPLE>;
> +			clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> +			fifo-depth = <0x100>;
> +			interrupts = <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			max-frequency = <150000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sdio1_bus4>, <&sdio1_clk>, <&sdio1_cmd>,
> +				    <&sdio1_det>, <&sdio1_pwren>;

Same here.

> +			resets = <&cru SRST_H_SDIO1>;
> +			reset-names = "reset";
> +			status = "disabled";
> +		};

Thanks,
Chukun

-- 
2.25.1

