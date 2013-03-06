From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2 1/2] ARM: dts: tegra: fix the activate polarity of
 cd-gpio in mmc host
Date: Wed, 06 Mar 2013 14:01:30 -0700
Message-ID: <5137AEAA.1020902@wwwdotorg.org>
References: <1361503420-16473-1-git-send-email-josephl@nvidia.com> <1361503420-16473-2-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361503420-16473-2-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 02/21/2013 08:23 PM, Joseph Lo wrote:
> The GPIO pin of SD slot card detection should active low.

I have applied patch 1/2 to Tegra's for-3.10/fixes branch.
