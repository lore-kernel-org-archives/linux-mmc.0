From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/7] mmc: at91_mci: use DMA buffer for read
Date: Tue, 2 Mar 2010 13:34:34 -0800
Message-ID: <20100302133434.761df661.akpm@linux-foundation.org>
References: <9535dc8dfe4476a0314b9513fb9d37862faa731d.1267209149.git.nicolas.ferre@atmel.com>
	<0374bbdf963e39fc012ad7885f9036c00dbb4079.1267209149.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54017 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752552Ab0CBVfl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2010 16:35:41 -0500
In-Reply-To: <0374bbdf963e39fc012ad7885f9036c00dbb4079.1267209149.git.nicolas.ferre@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wolfgang.mues@auerswald.de, avictor.za@gmail.com

On Fri, 26 Feb 2010 19:39:32 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> +		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);

It's a feature of kunmap_atomic() that it will accept a pointer to any
location in the page.  So the subtraction isn't strictly needed.

And if the subtraction is removed, the (void*) cast can also be removed.

