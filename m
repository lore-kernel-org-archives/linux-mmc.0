Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB9331214;
	Sun, 11 Jan 2026 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768124505; cv=none; b=PqGwPvIgKTXpYaQ/ZFxKmcfL4mfc5S+MZEmeY24AcTaI5R8TCqg5xPgEXyihsRki6HUBwGkdjsBBz8V1Oa5eqfPOC/ggaDk6OpTXYYHXUuKPsYz78fgWSYQO5KQFrCcqdBs1Xc0PdmhnC+QjKclq+OZDunigEzMyW78Y27tM5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768124505; c=relaxed/simple;
	bh=+TuUJhJ2yQsU60k2jmWlPomv8SG7G2UBq1YcJ30ostc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGXf7jX8u+bG12uDm1XwymTFBA7V7bai0UwSESYKgsmk6wYmup4Xc/A7jc0f6cUObuhu5QOt+UHa6qgdD42zdsjt08FE91AFup/VD4hjG7+/6Ffxfinqa/lrwt5PqZLzBAUHQU8MX7Uz+QCUrmBtBrsLUb6QcaXw4MfB1LQsz10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3sgumNE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3sgumNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F452C116C6;
	Sun, 11 Jan 2026 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768124505;
	bh=+TuUJhJ2yQsU60k2jmWlPomv8SG7G2UBq1YcJ30ostc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3sgumNEkLFv6olReQSEPNWaivLlKJr84QX6oc7VD2c9MCMzAHlkriDKjmNsolKlK
	 riRd35xrS4wGdjpi4DuGG6O0aG03qHKvHzUZNjhsjnXhhj9C7vmkZJ7R2q9QCLO781
	 o6caaz5gfwUZ0qRi0lRuXUcUab+YhyX+IQb8GVcrUpEnMfJ5+Kg24nASsxuB+3BcdT
	 QmITz8hhbfUwDNMKEQPC+xxd/d77OMDcgHywT35mK9WuLfLJlhMs7T+xQ5JFD8dkA0
	 YQ0XGFT7WizVkwO6lwi13XY9stE3bvP32d1M7Ng9JzxbD2zVmbJTYZa8JvnIvRbeuw
	 vm8pUzHj87dag==
Date: Sun, 11 Jan 2026 10:41:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marco Schirrmeister <mschirrmeister@gmail.com>
Cc: heiko@sntech.de, ulf.hansson@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-rockchip@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: rockchip-dw-mshc: add
 rockchip,disable-runtime-pm
Message-ID: <20260111-melodic-chestnut-coua-73e6ec@quoll>
References: <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <20260110010715.1610159-2-mschirrmeister@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110010715.1610159-2-mschirrmeister@gmail.com>

On Sat, Jan 10, 2026 at 02:07:13AM +0100, Marco Schirrmeister wrote:
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
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index acb9fb9a92cd..41f2644ca2ef 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -100,6 +100,14 @@ properties:
>        If not specified, the host will do tuning for 360 times,
>        namely tuning for each degree.
>  
> +  rockchip,disable-runtime-pm:
> +    type: boolean
> +    description:
> +      Inhibit runtime power management. This is required for boards

What is runtime power management? Like Linux PM? If anything phrased
like that is it is a clear no go. Bindings describe hardware.

> +      where the bus timing becomes unstable if the controller is
> +      runtime-suspended.

You described the desired Linux feature or behavior, not the actual
hardware. The bindings are about the latter, so instead you need to
rephrase the property and its description to match actual hardware
capabilities/features/configuration etc.


Best regards,
Krzysztof

