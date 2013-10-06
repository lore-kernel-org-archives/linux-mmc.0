From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH 1/6] mmc: omap: Convert to devm_kzalloc
Date: Sun, 06 Oct 2013 20:41:14 +0300
Message-ID: <5251A0BA.5080109@bitmer.com>
References: <1378922517-3968-1-git-send-email-jarkko.nikula@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:46809 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753892Ab3JFRnX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 6 Oct 2013 13:43:23 -0400
In-Reply-To: <1378922517-3968-1-git-send-email-jarkko.nikula@bitmer.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Aaro Koskinen <aaro.koskinen@iki.fi>

Hi

On 09/11/2013 09:01 PM, Jarkko Nikula wrote:
> Signed-off-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  drivers/mmc/host/omap.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
I resent this set with a subject prefix "PATCH FIX+RESEND" since I found
a NULL pointer dereference case from this driver and I put a fix for it
first and rebased these 6 patches on top of it.

-- 
Jarkko
