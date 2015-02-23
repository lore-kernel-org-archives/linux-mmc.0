From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] mmc: pwrseq_simple: fix error path in mmc_pwrseq_simple_alloc.
Date: Mon, 23 Feb 2015 09:27:36 +0100
Message-ID: <54EAE478.4040309@collabora.co.uk>
References: <20150221151516.1b3bc8ae@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:46072 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbbBWI1n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Feb 2015 03:27:43 -0500
In-Reply-To: <20150221151516.1b3bc8ae@notabene.brown>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NeilBrown <neilb@suse.de>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org

Hello Neil,

On 02/21/2015 05:15 AM, NeilBrown wrote:
> 
> From: NeilBrown <neil@brown.name>
> 
> The current error-path code (when gpiod_get_index() reports
> an error) can never free pwrseq->reset_gpios[0], but might
> try to tree pwrseq->reset_gpios[-1], which has unfortunate
> consequences.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> Fixes: 934f1f48330ed695927a51fa068dc5d673f2da19
> 
>

Right, sorry for the silly mistake.

Acked-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
