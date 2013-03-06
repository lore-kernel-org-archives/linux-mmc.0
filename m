From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2 2/2] mmc: tegra: use mmc_of_parse to get the support
 of standard MMC DT bindings
Date: Wed, 06 Mar 2013 14:03:44 -0700
Message-ID: <5137AF30.80006@wwwdotorg.org>
References: <1361503420-16473-1-git-send-email-josephl@nvidia.com> <1361503420-16473-3-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361503420-16473-3-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 02/21/2013 08:23 PM, Joseph Lo wrote:
> Updating the sdhci-tegra driver to use mmc_of_parse to support standard
> MMC DT bindings. Then we can remove the redundant code that already support
> in generic MMC core.

Chris,

Are you OK with this patch? Let me know if you need a resend if you
don't have the email any more.

(it's at http://patchwork.ozlabs.org/patch/222451/ too)

This patch needs to go through the Tegra tree due to dependencies on
patch 1/2, which has to go through the Tegra tree to avoid significant
merge conflicts with other *.dts changes.

Thanks.
