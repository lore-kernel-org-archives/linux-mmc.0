From: Atul Garg <agarg@arasan.com>
Subject: Re: [PATCH V6] mmc:host:sdhci-pci:Addition of Arasan PCI Controller
 with integrated phy.
Date: Wed, 3 Jan 2018 10:06:28 -0800
Message-ID: <CAEJoYxG3nmZB=yEMeWAcN5edTOm7je_R=26ugLEv0g6TkRU7TQ@mail.gmail.com>
References: <1514938282-3794-1-git-send-email-agarg@arasan.com> <da228a50-26ac-6055-61e0-38524da106bc@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35572 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751007AbeACSG3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 13:06:29 -0500
Received: by mail-io0-f172.google.com with SMTP id 14so2939915iou.2
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2018 10:06:29 -0800 (PST)
In-Reply-To: <da228a50-26ac-6055-61e0-38524da106bc@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: linux-mmc@vger.kernel.org, KISHON VIJAY ABRAHAM <kishon@ti.com>, "Kattekola, Ravikumar" <rk@ti.com>, "Menon, Nishanth" <nm@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com, linux-kernel@vger.kernel.org

Hi Sekhar,
Thanks please see reply below.


On Wed, Jan 3, 2018 at 1:30 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> On Wednesday 03 January 2018 05:41 AM, Atul Garg wrote:
>> The Arasan Controller is based on a FPGA platform and has integrated phy
>> with specific registers used during initialization and
>> management of different modes. The phy and the controller are integrated
>> and registers are very specific to Arasan.
>>
>> Arasan being an IP provider, licenses these IPs to various companies for
>> integration of IP in custom SOCs. The custom SOCs define own register
>> map depending on how bits are tied inside the SOC for phy registers,
>> depending on SOC memory plan and hence will require own platform drivers.
>>
>> If more details on phy registers are required, an interface document is
>> hosted at https: //arasandotcom/NF/eMMC5.1 PHY Programming in Linux.pdf.
>
> Please fix this link (no space after : and arasan.com instead of
> arasandotcom etc).

When we had the actual link some of the people emails were rejecting
including the linux lists due to being an https link when emails were
replied. Any idea so that it can be acceptable to email servers/lists
or if we were doing something wrong?


>
>>
>> Signed-off-by: Atul Garg <agarg@arasan.com>
>
> Apart from the comments given by Adrian, looks good to me.
>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
>
> Regards,
> Sekhar

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
