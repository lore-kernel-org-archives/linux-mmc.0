From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 3/3] mmc: sdhci-pci: Do not set DMA mask in
 enable_dma()
Date: Mon, 14 Mar 2016 15:00:36 +0200
Message-ID: <56E6B5F4.6090602@intel.com>
References: <1457316477-8153-1-git-send-email-acourbot@nvidia.com>
 <1457316477-8153-4-git-send-email-acourbot@nvidia.com>
 <56DED13E.9060106@intel.com>
 <CAAVeFuJS6E8f3y710+Hu52HvZp7PgwfHjbvL5FMeHz9LZ7sDYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuJS6E8f3y710+Hu52HvZp7PgwfHjbvL5FMeHz9LZ7sDYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14/03/16 05:15, Alexandre Courbot wrote:
> On Tue, Mar 8, 2016 at 10:18 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> On 07/03/16 04:07, Alexandre Courbot wrote:
>>> DMA mask will already be set by sdhci_set_dma_mask(), which
>>> is equivalent to the removed code since pci_set_dma_mask()
>>> expands to its DMA-API counterpart.
>>>
>>> There should also be no reason to set the DMA mask after probe.
>>
>> Let's run that by the PCI mailing list just to be sure.  The patches for
>> reference:
>>
>>         http://marc.info/?l=linux-mmc&m=145731654328126&w=2
>>         http://marc.info/?l=linux-mmc&m=145731654328128&w=2
>>
>> change the sdhci-pci driver to set the DMA mask once during probe instead of
>> every time during resume.  Is there any reason a PCI device driver might
>> need to set the DMA mask every time during resume?
> 
> Not seeing much reaction for this patchset. PCI being the only
> possible point of contention, can we maybe roll it into -next and see
> what happens?

+Rafael

Rafael, can you offer any thoughts on this:

PCI drivers that want to use DMA might call pci_set_master() in the pm
resume callback.  Some drivers (like sdhci-pci) also, presumably out of
convenience, set the DMA mask at the same time.  The question is: is it OK
instead to set the DMA mask just once during probe, or is there some other
reason the DMA mask needs to be set every time during resume?
