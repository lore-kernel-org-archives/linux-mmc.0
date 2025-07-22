Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73451A95E;
	Tue, 22 Jul 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163737; cv=none; b=kKBQvDQ5TWcoSev9qGNBmCWjgGG3A6T5sWOg5oH5q+jfXVUVQc2Oj/SWC3jIfo3gcOfrMSOb2YBl96QU/+UTKbqzqSGldVGaEiXXuQa1zEbSow6nq32/bQvshCa7xjhsPqoRn5z617XnIILRpRNch9wFQ5XYOGV1J7xe9MbDgW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163737; c=relaxed/simple;
	bh=l/0OsvYofge5c4bJ/WhXHB5C7C4a0lIqW5O3AdsN4t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFFDdvxVOV2FnZoIUz77WJg7Cn5xibmC4slRcF3DL6u/JhZKgTwju3tQ8UYS1sfE0CbawfEZPBF8Xej6mPZJN4T1ptR389Y4nRCNl24tIyEQB7UkJUPYBMXLHiVp1In9J+NLGZq13U4+yVxbdUQ+qWNLmR1DK4RIzvUahZb3oRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4nkcuhdt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4nkcuhdt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c1Lb3QwoDITMVjOupCQzzGFQccs9zBYHjaNIMWTJnDo=; b=4nkcuhdtKT3GeZWRASSWmSTE2r
	yywRjTyr/9p2c/myPnJ2scTXPpWdygIQiRDEUd9NsyKnWUPOpdIjiloSJLagrceS37hXFw7mVsIqH
	MSIG7G6F3K5EDUjwhymf2OyayFNS5jVT9VhbhH2WjH9CgqBiB5BEYzxsSGB3iQEi6wPVqROWfFH5o
	PaaYUGJXqPg2NXkm98p412BbZhksDXD4Lm7aQDqDMOV7Hhbn3VJR0C/JGNDadQcsnhodbv9BpfOLE
	gof4Jbsx4RcM+gwiIqFoamMudl4S0SH186f8/D0eJwrCABIkRflPdeiqhEBh54aLpaYtIfEgbPhCe
	Xqzx2mKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ue5yP-00000001NGf-3iuF;
	Tue, 22 Jul 2025 05:55:34 +0000
Date: Mon, 21 Jul 2025 22:55:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sayali Lokhande <quic_sayalil@quicinc.com>
Cc: ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com,
	avri.altman@wdc.com, adrian.hunter@intel.com,
	shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V1 1/1] mmc: sdio: Export an API to reinit the SDIO card
Message-ID: <aH8n1RNBmorMq9X9@infradead.org>
References: <20250721094328.6556-1-quic_sayalil@quicinc.com>
 <20250721094328.6556-2-quic_sayalil@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721094328.6556-2-quic_sayalil@quicinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jul 21, 2025 at 03:13:28PM +0530, Sayali Lokhande wrote:
> Some SDIO client drivers, manage external power to the SDIO card.
> In such cases, the card may be power-cycled independently of the
> MMC core's runtime PM state.
> Currently, reinitialization of the SDIO card is tied to the runtime
> PM resume path. However, if the card is powered off and on again before
> the autosuspend delay expires, the runtime suspend/resume callbacks are
> not triggered, leaving the card in an uninitialized state.
> 
> To address this, export sdio_reinit_card() so that client drivers can
> explicitly trigger reinitialization after powering the card back on,
> ensuring proper device state regardless of runtime PM behavior.
> 
> This change enables more robust handling of power-managed SDIO devices
> in scenarios where runtime PM is disabled or insufficient.

This seems to lack an actual users.

If we keep getting these malicious add unused export patches from
certain companies over and over we'll really have to start consider
banning them from kernel development.

