Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B7F1854;
	Tue, 27 Aug 2024 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724644; cv=none; b=H6ivgErfM1fvy7glra18+sTWIrSYDKqdiVw3DIRey5884Ks/nkoZck0yyU9eI0a5177vTPwj4YSEFaoLzCvndHolbuH3OBr7yG4wa8whsGxSubZm6qdX0UA9fx3EpovLt+7F0LCYnVTnrGHyreTdbTNZSjBWTb3z9VWgnoG0YV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724644; c=relaxed/simple;
	bh=9j30gj+qp/C7SdKEpmSsJzayBMelBsPxi/9o36B59C0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IozvG4VykBSg1uvRUxHcPo3QbG51U5QDKrbJtLXFAyHU69eGCsgzguOnuYBifA2+Ym2NBHA9nOGiL2Yi30kv/st8yfugpq42aGuI04+K9cSKNfhqQETfkMZFP6yLM0DcRjNlI1GYkDWgQ4DiLJDpGna30QcJurvwA1GM87rh3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WztVIcGY; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WztVIcGY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1724724640;
	bh=9j30gj+qp/C7SdKEpmSsJzayBMelBsPxi/9o36B59C0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WztVIcGYX9waqgzvv+NSUHCtUC14eoRTRFdgWOsbLHv75norQcg8+AN7PsQ9Uc7Cv
	 tCLQZiECwGN6Os+WeHJUSxws2MziDvtu4TN82alu7WKKLlOTODSWpSxqIWeLrEL4Xf
	 +1NMhr1wxoqzXtyK3yDPKACznY8pmIUhdE+z1m+Bxq8USispFqAJYVYKSvDOUSjyQo
	 m/J4U0xtKdcECPJxVM1wmZWsfQZOJp4z3K/hokIlJefRDksWEy7hHtHcKKyZNNPrAK
	 ywMDoBUjddkaR1NOL2pd3YhsY+UdvEM09adBVKDk9iHYrFYMNNYoj4snfT3QvMb83k
	 yboVnh+I/waOg==
Received: from [192.168.68.112] (ppp118-210-185-99.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.99])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7C22665140;
	Tue, 27 Aug 2024 10:10:37 +0800 (AWST)
Message-ID: <9a810b982c7d9b3c2b6ea1feb560ee9cd8ffe113.camel@codeconstruct.com.au>
Subject: Re: [PATCH -next] mmc: sdhci-of-aspeed: fix module autoloading
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Liao Chen <liaochen4@huawei.com>, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au
Date: Tue, 27 Aug 2024 11:40:35 +0930
In-Reply-To: <20240826124851.379759-1-liaochen4@huawei.com>
References: <20240826124851.379759-1-liaochen4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-26 at 12:48 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
>=20
> Signed-off-by: Liao Chen <liaochen4@huawei.com>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>
