From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v4 3/3] mmc: sdhci-pci: Do not set DMA mask in enable_dma()
Date: Mon, 14 Mar 2016 12:15:51 +0900
Message-ID: <CAAVeFuJS6E8f3y710+Hu52HvZp7PgwfHjbvL5FMeHz9LZ7sDYA@mail.gmail.com>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
 <1457316477-8153-4-git-send-email-acourbot@nvidia.com> <56DED13E.9060106@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:34093 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932411AbcCNDQM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Mar 2016 23:16:12 -0400
In-Reply-To: <56DED13E.9060106@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Mar 8, 2016 at 10:18 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 07/03/16 04:07, Alexandre Courbot wrote:
>> DMA mask will already be set by sdhci_set_dma_mask(), which
>> is equivalent to the removed code since pci_set_dma_mask()
>> expands to its DMA-API counterpart.
>>
>> There should also be no reason to set the DMA mask after probe.
>
> Let's run that by the PCI mailing list just to be sure.  The patches for
> reference:
>
>         http://marc.info/?l=linux-mmc&m=145731654328126&w=2
>         http://marc.info/?l=linux-mmc&m=145731654328128&w=2
>
> change the sdhci-pci driver to set the DMA mask once during probe instead of
> every time during resume.  Is there any reason a PCI device driver might
> need to set the DMA mask every time during resume?

Not seeing much reaction for this patchset. PCI being the only
possible point of contention, can we maybe roll it into -next and see
what happens?
