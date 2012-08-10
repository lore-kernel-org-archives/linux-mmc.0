From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 10 Aug 2012 13:27:47 +0000
Message-ID: <201208101327.47789.arnd@arndb.de>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51406 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab2HJN2A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Aug 2012 09:28:00 -0400
In-Reply-To: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On Friday 10 August 2012, Chunhe Lan wrote:

> +static inline void mmc_delay(unsigned int ms)
> +{
> +	if (ms < 1000 / HZ) {
> +		cond_resched();
> +		mdelay(ms);
> +	} else {
> +		msleep(ms);
> +	}
> +}

I would actually question the point in this function to start with: The
decision whether to call mdelay() or msleep() should only be based on
whether you are allowed to sleep in the caller context. The idea of


	cond_resched();
	mdelay(ms);

sets off alarm bells, and I would always replace that with msleep().

	Arnd
