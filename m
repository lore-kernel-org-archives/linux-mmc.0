From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: host: sdhci-tegra: cleanup ifdefs
Date: Wed, 06 Mar 2013 14:09:16 -0700
Message-ID: <5137B07C.1040700@wwwdotorg.org>
References: <1361385317-6020-1-git-send-email-rklein@nvidia.com> <1361385317-6020-4-git-send-email-rklein@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361385317-6020-4-git-send-email-rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 02/20/2013 11:35 AM, Rhyland Klein wrote:
> The structs wrapped with the SOC ifdefs are small enough where having
> them always there shouldn't be a big overhead. Removing the ifdefs
> also makes the code a little cleaner.

Chris,

I think patches 3 and 4 of this series can go through either the MMC
tree (I checked there are no conflicts with the MMC patch I have to take
through the Tegra tree), or the Tegra tree (since I'm taking another
Tegra MMC patch though there), both without any dependency issues.

It's your call. Let me know if you want me to take them through the
Tegra tree with an ack. Or, if you want to take them through the MMC
tree that's fine too. If you need them reposted to see the content, let
me know, or they're at:

http://patchwork.ozlabs.org/patch/222136/
http://patchwork.ozlabs.org/patch/222138/

Thanks.
