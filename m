Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B79E2C21F3;
	Tue, 23 Dec 2025 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766499832; cv=none; b=lsIOC2uC+77+LaYEu4l+lX4lGwCXI+sq9GBJxqpNTcxIXHzizuIj2lXLhpVOtVexS1IP7b9Q60T2978iSaLfDy2K9w3DsSA8L0X4uSVDaz3LA+vhUZgDFcsVQuSES/UcwvHmO8N+gykmjU//0/L6DPj9DidAZlOh8+DK8gmZPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766499832; c=relaxed/simple;
	bh=Id/MQ+hS6mA/o9uWhl8mU6pLWx/xDznbKci2OLxUVLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGIW+KHHRkG+aOJZ/g/t+kf7AWb3Xm7Bq4Vk/37Qsbl+l8WDjjrlt+/0LxUTuyj16hUjfP15yfm/GZP2jtF/eAL88OPWDndsj0EMMRfpdFN6NvniXGNRj+8cjeCd4IpxlRQstAT+QiNofrYL4cTuK/NtWWxESR/Ui2IfI35LDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEcgACL8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEcgACL8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B362FC113D0;
	Tue, 23 Dec 2025 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766499830;
	bh=Id/MQ+hS6mA/o9uWhl8mU6pLWx/xDznbKci2OLxUVLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oEcgACL8LYIrAfV4GxuED7vv8b7L370QHoyLgkzJEM96uqk9YVABahcduo0rM8psP
	 e0+/3xRhL8khUckbZsshVyqARqZCCUm+utOMKihVZvgXCVChZPbaD9g9DT1IBrJAxj
	 ff8uJyZQMzZgFkQbi5PDK1wCxKUzrKRxyuXV8rK5d3+AEvKcWNlGatmtX9O4W+lMLk
	 7i7a+PbTX5OsGc/2xxcRHrxCZW5O+3WD3V79mS+nyc7ajKVNodNA055uxtBk0sf3nI
	 4W5ubSQvxLJWHoWxfGEpy37VfF4UrLagZW1ZPGl/VbvJ9ZHwluCTvoNSdAhQhJjLcn
	 b0LoFMlNL0Kbg==
Date: Tue, 23 Dec 2025 15:23:46 +0100
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
Subject: Re: [PATCH 1/8] dt-bindings: phy: axiado,ax3000-emmc-phy: add Axiado
 eMMC PHY document
Message-ID: <20251223-adder-of-imminent-recreation-ea90c0@quoll>
References: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com>
 <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251222-axiado-ax3000-add-emmc-host-driver-support-v1-1-5457d0ebcdb4@axiado.com>

On Mon, Dec 22, 2025 at 04:45:00PM +0800, Tzu-Hao Wei wrote:
> From: SriNavmani A <srinavmani@axiado.com>
> 
> Add device tree bindings for the Axiado AX3000 eMMC PHY. The bindings
> define the required properties for configuring the external Arasan

Ah, and also:

A nit, subject: drop second/last, redundant "document". The
"dt-bindings" prefix is already stating that these are documents.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

Best regards,
Krzysztof

