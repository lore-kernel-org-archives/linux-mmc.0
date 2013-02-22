From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH V2 0/2] mmc: tegra: use mmc_of_parse to get support of
 standard MMC DT binding
Date: Fri, 22 Feb 2013 11:16:18 -0700
Message-ID: <5127B5F2.40304@wwwdotorg.org>
References: <1361503420-16473-1-git-send-email-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1361503420-16473-1-git-send-email-josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 02/21/2013 08:23 PM, Joseph Lo wrote:
> The 2nd patch of this series depends on two patches below.
> 
> "mmc: provide a standard MMC device-tree binding parser centrally"
> (available on next-20130219)
> mmc: tegra: assume CONFIG_OF, remove platform data
> (available on next-20130220)

I think this version looks good. I'll apply it for 3.10 when I can.

Chris, once you can merge patches for 3.10, can you create a topic
branch that contains "mmc: provide a standard MMC device-tree binding
parser centrally" so I can merge it into the Tegra tree? Thanks.
