From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] SDHCI: Change AMD SDHCI quirk application scope
Date: Fri, 5 Jun 2015 15:52:30 +0200
Message-ID: <20150605135230.GJ3679@pd.tnic>
References: <1433428437-6067-1-git-send-email-Vincent.Wan@amd.com>
 <20150604153220.GA4521@pd.tnic>
 <CAKT61h8E3=gvO=ZfFDPhBuWsWuPnGCxtxYa-izSOJk=RWKyUtQ@mail.gmail.com>
 <20150605092001.GB3679@pd.tnic>
 <CAKT61h8kN33D03jV7pJ7b25p9M6JSPm2WxLgh4DhJxnteHQnrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKT61h8kN33D03jV7pJ7b25p9M6JSPm2WxLgh4DhJxnteHQnrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: Wan ZongShun <Vincent.Wan@amd.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Wan ZongShun <linux@mcuos.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 05, 2015 at 06:01:56PM +0800, Wan ZongShun wrote:
> The KERNCZ is new AMD SB/FCH generation name, like HUDSON2 is old FCH
> generation.
> We will adopt 0x790b as device ID since from this KERNCZ gereration.

True story. Strange name that.

> The i2cpiix4.c driver and eMMC driver both will use this device ID
> macro, Do you think I should submit two patches synchronously? like
> patch1: change i2cpiix4 driver to use PCI_DEVICE_ID_AMD_KERNCZ_SMBUS,
> patch2: for eMMC quirk in sdhci-pci.c?
> 
> And then the PCI_DEVICE_ID_AMD_KERNCZ_SMBUS can be go into pci ids.h?

If you have all those patches ready, you could do a first patch adding
the PCI ID to pci_ids.h only.

Then follow with the different driver changes, i.e. sdhci-pci.c,
i2cpiix4, and so on and make it clear in the 0/n message that they all
depend on the first one.

Or something along those lines.

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
