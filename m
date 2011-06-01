From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/2] sdio: add quirk for spurious SDIO IRQ
Date: Wed, 1 Jun 2011 11:59:25 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106011157000.30544@xanadu.home>
References: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54306 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab1FAP72 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 11:59:28 -0400
Received: by qwk3 with SMTP id 3so2654967qwk.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jun 2011 08:59:28 -0700 (PDT)
In-Reply-To: <1306918113-23872-1-git-send-email-per.forlin@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, Daniel Drake <dsd@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

On Wed, 1 Jun 2011, Per Forlin wrote:

> From: Per Forlin <per.forlin@linaro.org>
> 
> Daniel Drake reported an issue in the libertas sdio client that was
> triggered by the sdio_single_irq functionality. His SDIO device seems to
> raise an interrupt even though there are no bits set in the CCCR_INTx
> register. This behaviour is not supported by the sdio_single_irq feature nor
> the SDIO spec. The purpose of the sdio_single_irq feature is to avoid the
> overhead of checking the CCCR_INTx registers, this result in no error
> handling of the case if there is a pending IRQ with none CCCR_INTx bits set.
> 
> This patchset adds a quirk to support this spurious IRQ issue and also report
> a warning if an SDIO interrupt is raised but none CCCR_INTx bits are set.

Given that the issue can be fixed locally to the libertas driver, I'd 
suggest not merging this series until truly unfixable issues come up, as 
Daniel said.


Nicolas
