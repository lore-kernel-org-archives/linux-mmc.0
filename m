Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7445674D;
	Sun, 29 Sep 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727639017; cv=none; b=lO42o8x+sgVE5X6ypxMDuRIQvGWZ55E/+T1hcrQcU1i+tLmLAoR0Yfrqo+jyz6YDYDqX3ikUIPCaHqSu5RjQ48KWv20nz2dvH0NtfBQyZ7SyUbwGiVKAtAPwG6d1PiVzERSBrj9yVmCqwKbO/Sh17RtUFXkldkS5M4esKfoQSV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727639017; c=relaxed/simple;
	bh=JZJbpVSx0mMG1zR8DkFBR/ky8MfiIq4krp/rxfSlOTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViBTa6yHXLmDfS8oUqscIlUd8CfX80ypPXkN9XQl12qx9VvCuNX3eXiovr38m7GP75NnqGP4rg1NYp1GiMm1y3cYC3tiXq9aFr80PKTRrlH7KGGJ4gDOSkTo+j17eWgnaJgzqv3I8Mw2YTaTN6HwIL7sib1SKcFMxR+9G7/8ybU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjhVpAHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjhVpAHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED143C4CEC5;
	Sun, 29 Sep 2024 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727639016;
	bh=JZJbpVSx0mMG1zR8DkFBR/ky8MfiIq4krp/rxfSlOTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tjhVpAHq9/GQYbbyOHYhJJXwbmYYlaZ594gzA6aEndCVRvFOF/qxSAO1C2hP3vXyb
	 ls9eabDUzE4lEldEQpSiwsFrhlpPldo1FXg4o/6GsZOSrqzsjRwWp/hQNOvwyHp38R
	 CtKRmSvAOCoXU1qyr4DB/XgCpBknpdJJAgC7iLqBb0gyIs6TRmUlVzYww4eklEqFMX
	 WssP7qRUmz8Jf6qBByxJHnASC8BPeYIVacxk45nb76xkTYqUyFOS0hd1evST8t2loy
	 z9UhQZPX9Q6yNGh4PkA644cie6uBOJMcfSKu5wpO0Wp1z+wUZJkhHZzLxdzpgXKsdO
	 p894pmbDU1i6g==
Date: Sun, 29 Sep 2024 21:43:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, wenbin.mei@mediatek.com, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dt-bindings: mmc: mtk-sd: Add support for MT8196
Message-ID: <wuhrl54ojj4sjbk3qbm5jjgeupznbs4uhfedogmucjhvnbjbeh@vwvpeuiwgwli>
References: <20240929074558.2076-1-andy-ld.lu@mediatek.com>
 <20240929074558.2076-3-andy-ld.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240929074558.2076-3-andy-ld.lu@mediatek.com>

On Sun, Sep 29, 2024 at 03:44:06PM +0800, Andy-ld Lu wrote:
> Extend the devicetree bindings to include the MT8196 mmc controller
> by adding the compatible string 'mediatek,mt8196-mmc'.

Your entire two-line sentence, says the same as commit msg and is pretty
obvious from the diff. Say something useful instead, like describe the
hardware differences.

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

