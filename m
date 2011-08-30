From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] arm/dt: Tegra: Update SDHCI nodes to match bindings
Date: Tue, 30 Aug 2011 15:31:28 -0400
Message-ID: <m2d3fmsnlb.fsf@bob.laptop.org>
References: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
	<m2hb4yso44.fsf@bob.laptop.org>
	<74CDBE0F657A3D45AFBB94109FB122FF04B3279E01@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B3279E01-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
	(Stephen Warren's message of "Tue, 30 Aug 2011 12:26:16 -0700")
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc@vger.kernel.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra@vger.kernel.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Aug 30 2011, Stephen Warren wrote:
> I don't think there's actually any need for that; initializing Tegra's
> SDHCI from device-tree has never worked in mainline to date; it relies
> on patch 1 being there. And if patch 2 was there without patch 3,
> the worst that will happen is some port runs in 4-bit mode instead of
> 8-bit, which evidently works fine since I didn't even notice 8-bit
> support was missing...

Ah, okay.  I've merged patch 2 to mmc-next for 3.2, then, and will keep
an eye on what happens with the arch patches.

Thanks,

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
