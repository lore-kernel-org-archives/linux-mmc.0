From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: assume CONFIG_OF, remove platform data
Date: Tue, 19 Feb 2013 12:17:13 -0700
Message-ID: <5123CFB9.7020209@wwwdotorg.org>
References: <1360966039-24071-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1360966039-24071-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 02/15/2013 03:07 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> Tegra only supports, and always enables, device tree. Remove all ifdefs
> and runtime checks for DT support from the driver. Platform data is
> therefore no longer required. Rework the driver to parse the device tree
> directly into struct sdhci_tegra.

Chris,

If you can take this for 3.9, everything is simple. I understand it's
very late for that.

If this goes into 3.10, then there will be some dependencies. Can you
ack this patch so that I can take it through the Tegra tree? The reason
being: I know that Joseph Lo will be posting some patches to this file
that need to go through the Tegra tree due to device tree dependencies,
and the simplest way to resolve it is just to take all changes to this
file through the Tegra tree in 3.10. Thanks.
