From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH] OMAP4: MMC: fix power and audio issue, decouple USBC1
 from MMC1
Date: Wed, 28 Sep 2011 18:04:42 +0530
Message-ID: <CANrkHUZo+P2TOMUH9udX-oQ5o64vEpOQVefrEUs1VkPxZxbBQA@mail.gmail.com>
References: <1311276543-9374-1-git-send-email-bryan.buckley@ti.com>
	<CAF=Qhp0YO2zYnwo63ddhKZv-o+eXs2bQETrqF5wYU2EtKQ=Yqw@mail.gmail.com>
	<CAG_NtY8uCAQNOpGFYLSMTbQ-=WEmRmjFSau7a_41XEwhE0280Q@mail.gmail.com>
	<CANrkHUZP5+wqmA5yjmbF5LatJH9Z7eJ1T-KEHogpP2MFxWRz=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANrkHUZP5+wqmA5yjmbF5LatJH9Z7eJ1T-KEHogpP2MFxWRz=w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Buckley, Bryan" <bryan.buckley@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kishore Kadiyala <kishorek.kadiyala@gmail.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, Viswanath Puttagunta <vishp@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

Can you queue this patch ?

On Fri, Sep 9, 2011 at 7:34 PM, T Krishnamoorthy, Balaji
<balajitk@ti.com> wrote:
> On Fri, Aug 12, 2011 at 8:43 PM, Buckley, Bryan <bryan.buckley@ti.com=
> wrote:
>> On Fri, Jul 22, 2011 at 7:30 AM, Kishore Kadiyala
>> <kishorek.kadiyala@gmail.com> wrote:
>>>
>>> On Fri, Jul 22, 2011 at 12:59 AM, Bryan Buckley <bryan.buckley@ti.c=
om> wrote:
>>> > Remove OMAP4_USBC1_ICUSB_PWRDNZ_MASK during enable/disable PWRDNZ=
 mode for
>>> > MMC1_PBIAS and associated extended-drain MMC1 I/O cell. This is i=
n accordance
>>> > with the control module programming guide. This fixes a bug where=
 if trying to
>>> > use gpio_98 or gpio_99 and MMC1 at the same time the GPIO signal =
will be
>>> > affected by a changing SDMMC1_VDDS.
>>> >
>>> > Software must keep MMC1_PBIAS cell and MMC1_IO cell PWRDNZ signal=
s low whenever
>>> > SDMMC1_VDDS ramps up/down or changes for cell protection purposes=
=2E
>>> >
>>> > MMC1 is based on SDMMC1_VDDS whereas USBC1 is based on SIM_VDDS t=
herefore
>>> > they can operate independently.
>>> >
>>> > Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>
>>>
>>> Good catch,
>>>
>>> Acked-by: =A0Kishore Kadiyala <kishore.kadiyala@ti.com>
>>>
>>
>> Any other comments from anyone else? =A0Noticed that this commit isn=
't
>> in any upstream branches. This patch will fix issues with people who
>> want to use GPIO 98/99 AND MMC1 at the same time. =A0Would be good t=
o
>> have this fix upstream.
>>
> FWIW: Tested on OMAP4 Blaze
> Tested-by: Balaji T K <balajitk@ti.com>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
