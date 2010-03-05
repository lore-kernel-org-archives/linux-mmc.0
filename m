From: Albert Herranz <albert_herranz@yahoo.es>
Subject: Re: + sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers.patch
 added to -mm tree
Date: Fri, 05 Mar 2010 23:18:11 +0100
Message-ID: <4B918323.6030103@yahoo.es>
References: <200909132245.n8DMj6l2007798@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp128.mail.ukl.yahoo.com ([77.238.184.59]:46332 "HELO
	smtp128.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754348Ab0CEWYz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 17:24:55 -0500
In-Reply-To: <200909132245.n8DMj6l2007798@imap1.linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-mmc@vger.kernel.org

akpm@linux-foundation.org wrote:
> The patch titled
>      sdio: pass whitelisted cis funce tuples to sdio drivers
> has been added to the -mm tree.  Its filename is
>      sdio-pass-whitelisted-cis-funce-tuples-to-sdio-drivers.patch
> 

Hi,

Are there any objections to this patch?

It's been in -mm now for nearly 6 months. AFAIK there's no report against it, and it fixes problems for at least 2 drivers:
- the Nintendo Wii SDHCI controller (for which the patch was cooked)
- the Silex's SX-SDWAG SDIO Wi-Fi card (http://marc.info/?l=linux-mmc&m=126624571025203)

Thanks,
Albert
