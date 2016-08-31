From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Wed, 31 Aug 2016 10:40:09 -0600
Message-ID: <bf1fbc57-913f-c0d7-b8f0-0176461a52aa@wwwdotorg.org>
References: <20160831162324.15480-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831162324.15480-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 08/31/2016 10:23 AM, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> According to the TRM, the SD/MMC controller on Tegra124 supports 34-bit
> addressing, but testing shows that this doesn't work. On a device which
> has more than 2 GiB of RAM and LPAE enabled, buffer allocations can use
> addresses above the 32-bit boundary.
>
> One way to work around this would be to enable IOMMU physical to virtual
> address translations for the SD/MMC controllers, but that's not easy to
> implement without breaking existing use-cases. It's also not obvious why
> 34-bit addressing doesn't work as advertised. In order to fix this for
> existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.

Acked-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
