From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-bcm-kona: Use sdhci_pltfm_unregister instead of open coded
Date: Wed, 25 Sep 2013 22:06:15 -0400
Message-ID: <87ob7g2v6w.fsf@octavius.laptop.org>
References: <1379404772.12080.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34117 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab3IZCGY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 22:06:24 -0400
In-Reply-To: <1379404772.12080.1.camel@phoenix> (Axel Lin's message of "Tue,
	17 Sep 2013 15:59:32 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Christian Daudt <csd@broadcom.com>, linux-mmc@vger.kernel.org

Hi Axel,

On Tue, Sep 17 2013, Axel Lin wrote:
> This avoid duplicated implementation and also fixes missing iounmap() and
> release_mem_region() calls in sdhci_bcm_kona_remove().
> sdhci_pltfm_init() calls request_mem_region() and ioremap(), thus we need to
> call the corresponding iounmap() and release_mem_region() calls in
> sdhci_bcm_kona_remove().
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks, pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
