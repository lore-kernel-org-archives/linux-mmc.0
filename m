From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH -mm] mmc: add ricoh e822 pci id
Date: Wed, 04 Aug 2010 20:13:50 +0300
Message-ID: <1280942030.16380.12.camel@maxim-laptop>
References: <20100804182057.6d1c14bb@dhcp-lab-109.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52223 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0HDRNx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Aug 2010 13:13:53 -0400
Received: by bwz1 with SMTP id 1so2510460bwz.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2010 10:13:52 -0700 (PDT)
In-Reply-To: <20100804182057.6d1c14bb@dhcp-lab-109.englab.brq.redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, CyberCastle@gmail.com, Gregg Lebovitz <gregg@lebovitz.net>

On Wed, 2010-08-04 at 18:20 +0200, Stanislaw Gruszka wrote: 
> From: CyberCastle@gmail.com
> 
> Signed-off-by: CyberCastle@gmail.com
> Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
> Tested-by: Gregg Lebovitz <gregg@lebovitz.net>
> ---
> Note Gregg tested patch with mmc-make-sdhci-work-with-ricoh-mmc-controller.patch
> and some other mmc patches from -mm tree backported to Fedora 13 kernel.
> 
>  drivers/mmc/host/sdhci-pci.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)

Just curios, can I see lspci for this device?
I was told that newer ricoh controllers that mine don't need that.
Nice to see that my patch works there.


Best regards,
Maxim Levitsky

