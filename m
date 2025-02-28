Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF18276D35;
	Fri, 28 Feb 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773786; cv=none; b=dhtuKO1xy4CDBuf2pErh9OJVg7STkzKnUIGzamyRoouoRXth2H3s+Ynf77fEQYagxNNBHRAn7x5DonaMEmbIpC0d7ePSBV/qXNEYwGwXJTNYab6pBtuUjX0sGJhC1ws9xbB1iRrFfxIYjNCh4plRJzecvCURobTLVD8jRRYc1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773786; c=relaxed/simple;
	bh=dzQqklMAZNYfmJATCpqkIwNah5vVcjjWwjEhWtWubkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzaPum426HBz0ne65qfdMKC1Q/4aGY2QjW5yQBdjNJGS9/ax/9xclescwSr4RaT1aIq87J5pLGPEDSkbJDuUqtFAR595pW1efcatfSV8uLS67rueExqnaeKcKabwB0Prc6923TLl1o81oBJEdkxJeXg5mFLJluFOzPQKF+NYWyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAOczFQg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAOczFQg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D6DC4CEE2;
	Fri, 28 Feb 2025 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773785;
	bh=dzQqklMAZNYfmJATCpqkIwNah5vVcjjWwjEhWtWubkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAOczFQgs9pBBiUISu0r0SWsVgu8kYFsY1Wkng27PTVXjsNLrFM7brOWj9h2K5+z7
	 IE7lz9pyqKTcPGkYBJKlxQgqBK2Qd5MP2jPW69WbuACJMaF/EySaL66jtXvIROUsx1
	 qmb/k9JWxWdx9ICyNsdG5DfAJ39wV7RAYskskh7MR9Xz7weoEi9ZXHXyjBm2avwal5
	 fehpSl3krSm+3b97qnTzeeRGOCEy+Q6nR5rXWuaAI3x/zwJX+xJxfowN+4LU4v0e1d
	 asTr+0t4kYHl6HvBtRPJtWX8y8b8y5dQe0HFgml3UzRZX4/zWBQGVLY5SoUlf9MiaG
	 QW9ONIim5XFsw==
Date: Fri, 28 Feb 2025 14:16:23 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 03/15] dt-bindings: mmc: rockchip-dw-mshc: Add support
 for rk3562
Message-ID: <174077378239.3585541.5147136924937452066.robh@kernel.org>
References: <20250227111913.2344207-1-kever.yang@rock-chips.com>
 <20250227111913.2344207-4-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227111913.2344207-4-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:19:01 +0800, Kever Yang wrote:
> The dw-mshc core on Rockchip's RK3562 is the same as the one already
> included in RK3288. Extend the binding accordingly to allow
> 
> 	compatible = "rockchip,rk3562-dw-mshc", "rockchip,rk3288-dw-mshc";
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v3:
> - update commit msg
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

