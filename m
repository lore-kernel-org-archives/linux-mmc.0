Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA44A02;
	Sat, 10 Jan 2026 02:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768011940; cv=none; b=cnUzBaHWIrFr5PFcyzX/ZtrGXK3AMJA7htnS099U2r+waoxuS+D9LznZuEGxC4qhxuz3HhxNwIw71FPoK7ZoiJP7GsYn9HuZUYtRV8y0t4xUsjSXLpKgd7NcxKgPsCJQF86clPBlpOIZIN8Ti2MQDxR/ZsNVWJpR1JIhuXo+Rtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768011940; c=relaxed/simple;
	bh=ue9P0DHp6hQsd2MCq0QDFjG6D1P+AJ9p0ypaECF8siM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=GniCsCKLc6KDCwzbjmbpwt6hBJT/3eqYnRy9LQUvhr1F0+L4mgWZP4vNLgnY1yIosAwVzV8sszQuexDmsZaDyhlYY3uQvZ/C6qQYuT/O5LNKKDh0+FgQM2h7VMY1N4g0Afi2Fl3lJfPjBHaHU/fNknN2ZqA1UpfrVYpfW22iLX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fd8PH/lv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fd8PH/lv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E03C4CEF1;
	Sat, 10 Jan 2026 02:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768011940;
	bh=ue9P0DHp6hQsd2MCq0QDFjG6D1P+AJ9p0ypaECF8siM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Fd8PH/lvq33dCfSIh454iKWbtElXcSEaA1CMLviXZifrjm96C7TxHYThyHIlsp/hF
	 lyqr+jiQ3N5pbufMW6LModJrncLZQnCXGUpjZdO0QrpBrsIOnc3mM89TxZmFFdmozi
	 lQDr0NH8AkX4jB+hW6Z3E9ydZgRMVCgFDpawCo5fS7FZ6FgKG8kTHNyg2MD1FV9ghn
	 s+4fubVK7xUm7OwGxJ7OlOnYi/NFCvZhYmh613rIr6uZnVRjb349wiwVl6l+usfg9U
	 3J40lebOOlvqle06aTOnJudTkzsE53CTmJ8pdzlIoABvkR0OEWL5A4//3bgbquhTpd
	 q8K1BzofdNEkg==
Date: Fri, 09 Jan 2026 20:25:39 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mmc@vger.kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, 
 linux-rockchip@lists.infradead.org, heiko@sntech.de, 
 devicetree@vger.kernel.org
To: Marco Schirrmeister <mschirrmeister@gmail.com>
In-Reply-To: <20260110010715.1610159-2-mschirrmeister@gmail.com>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <20260110010715.1610159-2-mschirrmeister@gmail.com>
Message-Id: <176801193939.232931.10116845812476923767.robh@kernel.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: rockchip-dw-mshc: add
 rockchip,disable-runtime-pm


On Sat, 10 Jan 2026 02:07:13 +0100, Marco Schirrmeister wrote:
> Add a new 'rockchip,disable-runtime-pm' property to allow boards to
> inhibit runtime power management. This is required for boards like the
> NanoPi R76S where the bus timing becomes unstable if the controller
> is runtime-suspended during idle periods.
> 
> Signed-off-by: Marco Schirrmeister <mschirrmeister@gmail.com>
> ---
>  .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml:110:1: [warning] too many blank lines (2 > 1) (empty-lines)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260110010715.1610159-2-mschirrmeister@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

