From: Ben Chuang <benchuanggli@gmail.com>
Subject: Re: [PATCH V6 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x support
Date: Fri, 30 Aug 2019 09:15:13 +0800
Message-ID: <CACT4zj_nzknKWt8yhk8KxDVE0WB27_FosPxu6NUQ5vxanc7CVw@mail.gmail.com>
References: <20190827003335.2494-1-benchuanggli@gmail.com> <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
 <20190828134714.GA30547@people.danlj.org> <7fcd0fd5-97cb-1dab-7477-666838478541@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7fcd0fd5-97cb-1dab-7477-666838478541@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Michael K. Johnson" <johnsonm@danlj.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 29, 2019 at 9:22 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 28/08/19 4:47 PM, Michael K. Johnson wrote:
> > On Wed, Aug 28, 2019 at 04:13:03PM +0300, Adrian Hunter wrote:
> >> On 27/08/19 3:33 AM, Ben Chuang wrote:
> >> Looks good, one minor comment
> > ...
> >>> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> >>
> >> Arguably CONFIG_MMC_SDHCI_IO_ACCESSORS needs to be removed altogether. i.e.
> >> making the accessors always available.  So for now, I'd prefer to select
> >> MMC_SDHCI_IO_ACCESSORS:
> >>
> >> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> >> index 14d89a108edd..c3bd967d8a1a 100644
> >> --- a/drivers/mmc/host/Kconfig
> >> +++ b/drivers/mmc/host/Kconfig
> >> @@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
> >>      depends on MMC_SDHCI && PCI
> >>      select MMC_CQHCI
> >>      select IOSF_MBI if X86
> >> +    select MMC_SDHCI_IO_ACCESSORS
> >>      help
> >>        This selects the PCI Secure Digital Host Controller Interface.
> >>        Most controllers found today are PCI devices.
> >
> > Unless I'm missing something, this seems like a separate patch;
> > are you asking for it first, as a predecessor to the GLI patch?
> >
>
> No, it is fine with this patch.

I will remove CONFIG_MMC_SDHCI_IO_ACCESSORS from sdhci-pci-gli.c and
add add `select MMC_SDHCI_IO_ACCESSORS` in Kconfig.
Thank you.
