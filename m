From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/5] SDIO: introduce API for special power management
 features
Date: Thu, 11 Feb 2010 12:32:51 -0800
Message-ID: <20100211123251.f77dbddd.akpm@linux-foundation.org>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
	<1265747366-6676-2-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46975 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755734Ab0BKUdZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2010 15:33:25 -0500
In-Reply-To: <1265747366-6676-2-git-send-email-nico@fluxnic.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-mmc@vger.kernel.org

On Tue, 09 Feb 2010 15:29:22 -0500
Nicolas Pitre <nico@fluxnic.net> wrote:

> +	BUG_ON(!func);
> +	BUG_ON(!func->card);
> +
> +	host = func->card->host;

It's a bit redundant to check for null and then deref the pointer - the
kernel will reliably oops on the NULL deref, which gives us the same
info.

I guess the BUG_ON is more useful in the case where a double-deref is
being performed, as it can otherwise be a bit hard to work out which
pointer was NULL.

