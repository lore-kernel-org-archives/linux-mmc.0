Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3430676E;
	Wed, 10 Jun 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078736; cv=none; b=GvQO6VVTsge6T4AvqvzGx/MAH2w5e+CJmzTG8YvifSPN0VvGmu6wTqreVezHsdzpCUA8jtCx79Jhy+pdxVYxv/k9vBo4xkZyRg9Lf/E20DZulOrh8j9Z0bHZjeCfwwT4iNneYQgKvkXClgu850DE0cDB5mkQUTMyhtJuB3GzJkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078736; c=relaxed/simple;
	bh=Bku6vmbnfsIPF3upfNi33A0lpAy6UNfcQHI8Xaj7jk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGXazB/ZmJHdl5moDoxSYi2yGQSicZfT4rFwIEu4eqxqJyb31Yswt37wHQ7WT6ynDSeihufiF6rETYjkAm+t4Mqzu2z3Ptla/Xsm52naLo8E8LrhDCWBMiW6r8c6aA1ZiQ/ane4uim2EudcUTY5VBn8haStT04eKn2V30CYZ80E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AVc9mwDe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AVc9mwDe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SUBiUHt/0iiIKa8WSEzuAV3b4OE0sNSco6iZTF/7BsU=; b=AVc9mwDezYfcqmBMiqIwUCYUoM
	Q7WdYxiJugJww1//sevc6nVN3YNGEIb1ab91J5FltT9bMo6KZKb9chMrSpLN+21EaPtwzcdK5FJhH
	+TdA+GLaIdZE928yP4zk/+QF20dc/7uoTpRzXl9spIgb/+zWebK53U5SHIK6LIvjui2E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXDwI-006wZA-Ak; Wed, 10 Jun 2026 10:05:30 +0200
Date: Wed, 10 Jun 2026 10:05:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
	shenwei.wang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
	nico@fluxnic.net, adureghello@baylibre.com, ulfh@kernel.org,
	linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
	linux-spi@vger.kernel.org, olteanv@gmail.com
Subject: Re: [PATCHv2 1/4] net: fec: do not use readl()/writel() for ColdFire
Message-ID: <caa2a34c-5a73-4075-9f7f-77b30673a4e2@lunn.ch>
References: <20260609142139.1563360-1-gerg@linux-m68k.org>
 <20260609142139.1563360-3-gerg@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609142139.1563360-3-gerg@linux-m68k.org>

On Wed, Jun 10, 2026 at 12:12:58AM +1000, Greg Ungerer wrote:
> Modify the FEC driver to not directly use readl() and writel() to access
> hardware registers but instead local fec_readl() and fec_writel() methods.
> This allows for different architecture users of this driver to have
> different underlying access functions - to support both little and big
> endian hardware.
> 
> The FEC hardware block in ColdFire SoC parts is accessed big-endian.
> The usual kernel readl()/writel() IO memory access methods are defined to
> access little endian data. Change access for ColdFire to use __raw_readl()
> and __raw_writel() access methods - which do not modify or swap bytes
> on access.
> 
> The FEC driver works today because the m68k architecture io.h has a
> kludge in the definitions of the readl() and writel() functions for
> ColdFire that allow big-endian access if the address of the register to
> access is within the SoC's internal peripheral registers. This is being
> fixed in the near future to define readl() and writel() correctly - with
> no byte swapping. Thus the motivation for this fix here.
> 
> __raw_readl()/__raw_writel() access methods are used instead of the more
> commonly used ioread32be()/iowrite32be() here because those are broken too,
> because of the current readl()/writel() kludge. They are implemented in
> asm-generic/io.h in terms of readl()/writel().
> 
> Note that even when readl() and writel() are fixed on ColdFire they will
> not be the right thing to use within the FEC driver on ColdFire hardware.
> 
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
