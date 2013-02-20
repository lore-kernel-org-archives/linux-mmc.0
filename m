From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: dts: tegra: fix the activate polarity of cd-gpio
 in mmc host
Date: Wed, 20 Feb 2013 09:59:23 -0700
Message-ID: <512500EB.1070802@wwwdotorg.org>
References: <1361343902-15223-1-git-send-email-josephl@nvidia.com> <1361343902-15223-2-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361343902-15223-2-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 02/20/2013 12:05 AM, Joseph Lo wrote:
> The GPIO pin of SD slot card detection should active low.

Thierry, Lucas, can you please check if the same change should be made
to all the Avionic Design and Toradex boards? I assume MMC CD should be
active low on all of them. Once you've confirmed this, Joseph can respin
this first patch, and perhaps we can get it into 3.9/stable as a
bug-fix. Thanks.
