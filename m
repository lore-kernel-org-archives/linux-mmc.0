From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Add support for setting parent clock
Date: Mon, 20 Mar 2017 20:31:20 +0000
Message-ID: <5556520b-d972-f40c-db84-43583b6dad9b@nvidia.com>
References: <1489660364-17698-1-git-send-email-jonathanh@nvidia.com>
 <693f9e04-b2b0-4d11-1359-0364961687e9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <693f9e04-b2b0-4d11-1359-0364961687e9-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


On 20/03/17 19:22, Adrian Hunter wrote:
> On 03/16/2017 12:32 PM, Jon Hunter wrote:
>> It is common for SD/MMC host controllers to set the parent clock that
>> drives the SD/MMC interface in order to support various operating
>> speeds. Typically, this is performed by calling common clock framework
>> APIs such as clk_set_rate(). The problem is that these APIs may sleep
>> and must not be called from within atomic sections and therefore, these
>> functions cannot be called within the existing 'set_clock' SDHCI
>> operator because they are called from within the context of a spinlock.
>> Add a new 'set_parent_clock' operator for the SDHCI driver that is
>> called early during the SDHCI 'set_ios' before the spinlock is aquire to
>> give the platform driver the opportunity to set the parent clock rate.
> 
> I just posted a patch to remove the spin lock from set_ios().  Does that help?

Yes it does, thanks!

Technically, the only other place this could occur is in
sdhci_request_done() because this also calls ->set_clock() with the
spinlock held. However, this is only called if
SDHCI_QUIRK_CLOCK_BEFORE_RESET is set, which is only currently true for
a device in sdhci-pci-core.c and this one just uses the normal
sdhci_set_clock() routine. 	

Cheers
Jon

-- 
nvpublic
