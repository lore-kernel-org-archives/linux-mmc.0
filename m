From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] mmc:host:sdhci-pci: Addition of Arasan PCI controller
 with integrated phy.
Date: Wed, 27 Sep 2017 22:10:40 -0500
Message-ID: <95186e1f-98dc-1a9b-15a9-03911fd2012f@ti.com>
References: <1506452394-23655-1-git-send-email-agarg@arasan.com>
 <424b095f-08ec-96a5-b0b2-3fdc6f7a06ad@rock-chips.com>
 <CAEJoYxGzZVCJ32KqVLjLc00qOM06Rj30pPm5TrVJUB3o9ZOW+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEJoYxGzZVCJ32KqVLjLc00qOM06Rj30pPm5TrVJUB3o9ZOW+A@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Atul Garg <agarg@arasan.com>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: rk@ti.com, adrian.hunter@intel.com, kishon@ti.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

On 09/27/2017 02:27 PM, Atul Garg wrote:
> On Sep 26, 2017 8:55 PM, "Shawn Lin" <shawn.lin@rock-chips.com 
> <mailto:shawn.lin@rock-chips.com>> wrote:
>     On 2017/9/27 2:59, Atul Garg wrote:

[...]

>         ---
>            drivers/mmc/host/sdhci-pci-core.c | 372
>         ++++++++++++++++++++++++++++++++++++++
> 
> 
>     Fundamentally maybe you need a sdhci-pci-arasan.c
> 
>     And the arasan PHY isn't new here as sdhci-of-arasan already added
>     arasan PHY support for eMMC 5.1, but just with different register
>     layout and content. So could you also use generic PHY framework?
> 
> 
> Thanks. We are doing two things adding support for Arasan PCI SDHC and 
> PHY specific code to it integrated via a window in same PCI address 
> space (extended).
> 
> If we correctly understand, you are suggesting to take the PHY code 
> out as a PHY driver module similar to phy/rockchip/ and use those 
> functions from phy framework within the sdhci-pci-core?

yes, it might allow some reuse possibly as well.


-- 
Regards,
Nishanth Menon

PS: please switch to plain text.
