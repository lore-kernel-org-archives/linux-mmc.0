From: Rob Herring <robh@kernel.org>
Subject: Re: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding doc for
 Arasan SDHCI.
Date: Wed, 20 Jan 2016 09:05:22 -0600
Message-ID: <CAL_JsqLAwzFc2X2UKF5scYuf_h3xNcLibnMLhFnKZR_=0=JR8w@mail.gmail.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
 <1453213055-35563-4-git-send-email-lakshmis@xilinx.com> <20160119171611.GA2708@rob-hp-laptop>
 <4FF8F58FAA9D5D4193D4E554E4352C5902C527B7@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37367 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932744AbcATPFr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Jan 2016 10:05:47 -0500
In-Reply-To: <4FF8F58FAA9D5D4193D4E554E4352C5902C527B7@XAP-PVEXMBX02.xlnx.xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lakshmi Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc: Michal Simek <michals@xilinx.com>, Soren Brinkmann <sorenb@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>, "Emil P. Lenchak" <emill@xilinx.com>, Tobias Klauser <tklauser@distanz.ch>, Sudeep Holla <Sudeep.Holla@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, Jisheng Zhang <jszhang@marvell.com>, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, Scott Branden <sbranden@broadcom.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Haibo Chen <haibo.chen@freescale.com>, Marek Vasut <marex@denx.de>, "ludovic.desroches@atmel.com" <ludovic.desroches@atmel.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Jan 19, 2016 at 11:51 PM, Lakshmi Sai Krishna Potthuri
<lakshmi.sai.krishna.potthuri@xilinx.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Rob Herring [mailto:robh@kernel.org]
>> Sent: Tuesday, January 19, 2016 10:46 PM
>> To: Lakshmi Sai Krishna Potthuri
>> Cc: Michal Simek; Soren Brinkmann; Ulf Hansson; Kevin Hao; Emil P. Lenchak;
>> Tobias Klauser; Sudeep Holla; Adrian Hunter; Jisheng Zhang; Ivan T. Ivanov;
>> Scott Branden; Vincent Yang; Haibo Chen; Marek Vasut;
>> ludovic.desroches@atmel.com; Pawel Moll; Mark Rutland; Ian Campbell;
>> Kumar Gala; Suman Tripathi; Shawn Lin; devicetree@vger.kernel.org; Harini
>> Katakam; linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Lakshmi Sai Krishna Potthuri; Anirudha Sarangi; Punnaiah Choudary Kalluri;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [LINUX PATCH 4/5] Documentation: mmc: Updated the binding
>> doc for Arasan SDHCI.
>>
>> On Tue, Jan 19, 2016 at 07:47:34PM +0530, P L Sai Krishna wrote:
>> > This patch adds broken-mmc-highspeed property to the binding doc for
>> > Arasan SDHCI.
>> >
>> > Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
>> > ---
> <snip>
>> > -
>> > +  - broken-mmc-highspeed: Indicates to force
>> > +                           the controller to use in standard speed.
>>
>> We already have the inverse of this with "cap-mmc-highspeed".
>>
>> The only potential problem is it will need to be added to existing DTs if you
>> start disabling high speed by default. Maybe that's not an issue for users of
>> the Arasan driver.
>>
>
> It might be an issue for other users.
> I know that it will be an issue for older Xilinx SoC (Zynq), for ex.
>
>> Otherwise, you should determine this with a more specific compatible string.
>>
>
> Since this feature might be broken on any SoC, I thought it would be
> good to provide a dt property.
> Using a compatibility string will offer no flexibility as per board or silicon.

I've thought about this some more. Since this is an override of the
SDHCI capabilities register, I'm okay with this property. However, it
should be common to all SDHCI controller and handled in the core SDHCI
code. Another way this could be handled is directly provide an
override value for the capability register in the DT. Then we don't
have to provide a property for every capability bit.

Additionally, the Arasan binding needs to have SOC specific compatible
strings. IP vendor strings alone have been proven often to be
insufficient.

Rob
