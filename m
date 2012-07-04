From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci: A new flag SDHCI_NEEDS_RETUNING_TIMER
Date: Tue, 03 Jul 2012 20:46:34 -0400
Message-ID: <87vci45p5h.fsf@octavius.laptop.org>
References: <1340957852-28936-1-git-send-email-aaron.lu@amd.com>
	<1340957852-28936-3-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60002 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756556Ab2GDAqk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 20:46:40 -0400
In-Reply-To: <1340957852-28936-3-git-send-email-aaron.lu@amd.com> (Aaron Lu's
	message of "Fri, 29 Jun 2012 16:17:32 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

Hi,

On Fri, Jun 29 2012, Aaron Lu wrote:
> Add a new flag of SDHCI_NEEDS_RETUNING_TIMER to represent if the host
> currently needs retuning timer when driving the card inserted.

Minor changes:

Could we call it "SDHCI_USING_RETUNING_TIMER", then?  I don't think
NEEDS makes the use clear enough.

> @@ -1889,10 +1891,9 @@ out:
>  	 * try tuning again at a later time, when the re-tuning timer expires.
>  	 * So for these controllers, we return 0. Since there might be other
>  	 * controllers who do not have this capability, we return error for
> -	 * them.
> +	 * them. SDHCI_NEEDS_RETUNING_TIMER means the host supports re-tuning.

This comment seems wrong, or at least incomplete.  You've just described
in the commit message how the flag's not about whether the host supports
it, but is instead about whether it's currently in use by the card.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
