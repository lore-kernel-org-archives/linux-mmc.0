From: Atul Garg <agarg@arasan.com>
Subject: Re: [PATCH] mmc:host:sdhci-pci: Addition of Arasan PCI controller
 with integrated phy.
Date: Mon, 9 Oct 2017 13:15:17 -0700
Message-ID: <CAEJoYxGpG7xDS7z9DVCrm5cc8XWuyWFqUJBZkbFgT8qD3MpOJw@mail.gmail.com>
References: <1506452394-23655-1-git-send-email-agarg@arasan.com>
 <424b095f-08ec-96a5-b0b2-3fdc6f7a06ad@rock-chips.com> <CAEJoYxGzZVCJ32KqVLjLc00qOM06Rj30pPm5TrVJUB3o9ZOW+A@mail.gmail.com>
 <95186e1f-98dc-1a9b-15a9-03911fd2012f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95186e1f-98dc-1a9b-15a9-03911fd2012f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "Kattekola, Ravikumar" <rk@ti.com>, adrian.hunter@intel.com, KISHON VIJAY ABRAHAM <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, "Nori, Sekhar" <nsekhar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 27, 2017 at 8:10 PM, Nishanth Menon <nm@ti.com> wrote:
> On 09/27/2017 02:27 PM, Atul Garg wrote:
>>
>> On Sep 26, 2017 8:55 PM, "Shawn Lin" <shawn.lin@rock-chips.com
>> <mailto:shawn.lin@rock-chips.com>> wrote:
>>     On 2017/9/27 2:59, Atul Garg wrote:
>
>
> [...]
>
>>         ---
>>            drivers/mmc/host/sdhci-pci-core.c | 372
>>         ++++++++++++++++++++++++++++++++++++++
>>
>>
>>     Fundamentally maybe you need a sdhci-pci-arasan.c
>>
>>     And the arasan PHY isn't new here as sdhci-of-arasan already added
>>     arasan PHY support for eMMC 5.1, but just with different register
>>     layout and content. So could you also use generic PHY framework?
>>
>>
>> Thanks. We are doing two things adding support for Arasan PCI SDHC and PHY
>> specific code to it integrated via a window in same PCI address space
>> (extended).
>>
>> If we correctly understand, you are suggesting to take the PHY code out as
>> a PHY driver module similar to phy/rockchip/ and use those functions from
>> phy framework within the sdhci-pci-core?
>
>
> yes, it might allow some reuse possibly as well.
>

Thanks , We looked at some options and spent time in evaluating
instead of phy model ( it probably works when you have SOC arch) we
see sdhci-pci-arasan.c file creation similar to sdhci-pci-o2micro.c is
feasible we have tested the changes and will be releasing next version
of patch. This minimizes the changes in sdhic-pci-core files to
minimal number of lines by just adding the controller support and
keeps the arasan specific code separate.
>
> --
> Regards,
> Nishanth Menon
>
> PS: please switch to plain text.

-- 
ATTENTION: 

The information contained in this message may be legally privileged and 
confidential.  It is intended to be read only by the individual or entity 
to whom it is addressed or by their designee. If the reader of this message 
is not the intended recipient, you are on notice that any distribution of 
this message, in any form, is strictly prohibited by law.


If you have received this message in error, please immediately notify the 
sender and/or Arasan Chip Systems, Inc. by telephone at (408) 282-1600 and 
delete or destroy any copy of this message.
