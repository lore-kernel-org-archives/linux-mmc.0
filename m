From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/3] arm/dt: Tegra: Update SDHCI nodes to match bindings
Date: Tue, 30 Aug 2011 12:26:16 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B3279E01@HQMAIL01.nvidia.com>
References: <1314731837-6985-1-git-send-email-swarren@nvidia.com>
 <m2hb4yso44.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <m2hb4yso44.fsf-mq7wBgpjGkdLDiiyqF6/jw@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Chris Ball wrote at Tuesday, August 30, 2011 1:20 PM:
> Hi Stephen,
> 
> On Tue, Aug 30 2011, Stephen Warren wrote:
> > Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> > Acked-by: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
> > ---
> > This is a repost of http://www.spinics.net/lists/linux-tegra/msg02117.html
> > I'm including it here since it's not in linux-next yet, and patch 3 depends
> > on it.
> 
> I assume I should wait for patches 1+3 to appear in -next via another tree
> before I merge patch 2 -- let me know if that's incorrect.

I don't think there's actually any need for that; initializing Tegra's
SDHCI from device-tree has never worked in mainline to date; it relies
on patch 1 being there. And if patch 2 was there without patch 3,
the worst that will happen is some port runs in 4-bit mode instead of
8-bit, which evidently works fine since I didn't even notice 8-bit
support was missing...

Thanks for checking though.

-- 
nvpublic
