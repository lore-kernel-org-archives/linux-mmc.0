Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3D212D21;
	Thu,  7 Nov 2024 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992291; cv=none; b=LLzR6ARabUyS3iDKYwBAOxfBSzNPoH5Gz7B09fcnFA/OPDz/AFQNPV1nsycNku+M1YCsSPqL4qBq3cjVl7EjudC12pwRmVwuR1ZODWgxGkXnIZxLya9BwyrbdfrD8w46HiCMeAW92bJLwZZcpCiMR4ewgINsg2G18wrHl03+mlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992291; c=relaxed/simple;
	bh=lOH8IR6oNmISd8P9/400Syn+vXGVnV+xRyVybav+6/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWETVZ5IcSZQBG0gHo2MtH74viQwl2H1agyxn+9RW9crUDjsZEjWPAv6gceGeEbehM/+UwSkkRfhxbmY64vZdsZYgOZQ0wlFuzdW7I+r0+zHlUurKccSnr1EC8nbw6X1tb7xAieGqWpjTUPTFVkYXfgAC//Zb+WUkSIfEjt7MVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GcwXKl/0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GcwXKl/0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lOH8IR6oNmISd8P9/400Syn+vXGVnV+xRyVybav+6/4=; b=GcwXKl/0RlcOcFK2YRezBEjMK/
	ihG+29MixzmbaIkP/MKW4/lfJ0ns05vE0df3BbeJXE19wPpwYrPqp/c71VzLx3vSWiLtOJcJjw6Dj
	SYzT76y0U46dL1QQPL67hGwvx/91LMHBNbbr7vKmoo5ZJwPq/N7acY2AhZyQbtiq7Q7Npbz6RVMpH
	cl+7VdLLpEQ8fFOcwcrT1s69fQfeEzT64QKnfNr7BNnQYkO/Hi2/UZDnm8IOimisUlsc/CZZFdVfo
	5a9ziz/U9RJO+mKnEFnkmDNyQjpsCdTTQot3kjwQnFcPD1+uBfXU0PT00eJJBpTYKNKlVetJIaNSF
	4ItjoKEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t94AR-00000007OtG-1oXV;
	Thu, 07 Nov 2024 15:11:27 +0000
Date: Thu, 7 Nov 2024 07:11:27 -0800
From: 'Christoph Hellwig' <hch@infradead.org>
To: ??? <jangsub.yi@samsung.com>
Cc: 'Christoph Hellwig' <hch@infradead.org>, ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	junwoo80.lee@samsung.com, sh8267.baek@samsung.com,
	wkon.kim@samsung.com
Subject: Re: [PATCH] mmc: Add config_host callback to set a mmc queue
Message-ID: <ZyzYnw0PgpyViFdf@infradead.org>
References: <CGME20241106051403epcas1p29e983006930bd7b8364b1a1f858ad21c@epcas1p2.samsung.com>
 <20241106051347.969-1-jangsub.yi@samsung.com>
 <ZyxelKdmXXiSVL1g@infradead.org>
 <000001db30f4$4a749770$df5dc650$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001db30f4$4a749770$df5dc650$@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 07, 2024 at 06:06:11PM +0900, ??? wrote:
> Currently, there is no way to configure a request queue on the host side.
> Although there are various exported symbols in kernel/block/blk-settings.c
> that can be used to configure a request queue, users cannot utilize them
> as needed.

If you actually provided a user and didn't just try to offend the kernel
maintainers by submitting dead code I could explain you in detail why
youre idea is flawed.

