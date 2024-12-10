Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B593B23312A;
	Tue, 10 Dec 2024 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733808490; cv=none; b=q+KsSiMBPx0xb3th3qwIqU7rAKpOrZcR9auLhoeqAVe2KUunYRg96RAdIQYmrJbWDZ9IPOHeRRrDPgcxzDJN8RbwuUh4lrQRSxQCdic8yPOMp7LCJL7wbgz1jKc6BPRHYfTu2MvLWuYlOqJiKM+QaMk8x6pcyF/PFandURwm/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733808490; c=relaxed/simple;
	bh=BEEpQrT/YNe0uS039pd6cvEKm7vNAQNBOCmtwTw3gMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDlHHTqxTViYqammjkLis8xzKqw4kYB96QmTpHDwJ+wuXbD53MreE7ySIqeiIbQHsprkNl89CQp33MgeZICvv4+VsIscgMlX+hPEdF9teVRIiUKqFmXRdSCLPAUPACSOdyUvqvuoK6GffyRi6Yan5nTGWYWDk7IcCLksSnwtkaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zpiWKH9L; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zpiWKH9L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OpKyHr2Bvr0DCtSbzhR4/78Zn86Rkx07+NKBx+P7V0A=; b=zpiWKH9Lm52ytsJhfpmHMz8Vyh
	Qv0vRPDWQX2P6U6azFylE+zgoqfWeaJng2WwyEz3E9kp5hnRPOqHETXHw+E/Yv/DR+IjBQaW/PS0b
	ERzhI8WIsAPAA39GkN4HvknguhR9jjoxmqVhdH3lw3urp/1zG3+46DdI3KoUYvBflGX0H6acQMBSO
	YG2lRo4kKWNSS5vs+ARhAPQLnvTdoYXfXZhsJ6tdnSF0YaYE38kkeiJ45cud6XFSF/L256kEiF5hx
	q5j/OER7mm5zeWgEd4FkapOK7EmeK3r7lUtTkuoTf5IMgNHHKtvbeaJtsRlG/GY2iIuCelIwJTxcC
	NT344poQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKsn3-0000000AHYJ-1b7T;
	Tue, 10 Dec 2024 05:28:09 +0000
Date: Mon, 9 Dec 2024 21:28:09 -0800
From: 'Christoph Hellwig' <hch@infradead.org>
To: Jangsub Yi <jangsub.yi@samsung.com>
Cc: 'Christoph Hellwig' <hch@infradead.org>, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	junwoo80.lee@samsung.com, sh8267.baek@samsung.com,
	wkon.kim@samsung.com
Subject: Re: [PATCH] mmc: Add config_host callback to set a mmc queue
Message-ID: <Z1fRaeTMz241A8FN@infradead.org>
References: <CGME20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c@epcas1p2.samsung.com>
 <20241106051347.969-1-jangsub.yi@samsung.com>
 <ZyxelKdmXXiSVL1g@infradead.org>
 <000001db30f4$4a749770$df5dc650$@samsung.com>
 <ZyzYnw0PgpyViFdf@infradead.org>
 <0b2e01db3410$a05f41c0$e11dc540$@samsung.com>
 <000001db4ac3$b5584260$2008c720$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001db4ac3$b5584260$2008c720$@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 10, 2024 at 02:23:55PM +0900, Jangsub Yi wrote:
> This is necessary to have separate policies for each device.
> I will also implement the host modifications related to this content 
> and try to upstream it. Please review the core modifications.

It is not reviewable without a user and your insistance to waste
everyones time for a patch that as is adds dead code is highly
offensive.  Stop it.

