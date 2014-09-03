From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: sdhci-esdhc-imx : cannot read eMMC
Date: Wed, 3 Sep 2014 16:42:18 +0800
Message-ID: <CAA+hA=ShpZP58eomv6_RM=1RzMCN3HnFuDvB3BQ13sgBk9WbUQ@mail.gmail.com>
References: <CAL8zT=gJtnyGSnVz+YWW3Z1LPXPp-Oe3SsGqvBvV=2LBpZ-t9Q@mail.gmail.com>
	<CAL8zT=gpiV9OMToH80Qr5B7HUUbVDp0m_WK9PaCvuaMGwrBSJA@mail.gmail.com>
	<CAA+hA=QQ=AYnKts0cq0VpWkWUyt-r1v-LxCk1pQiyo=CFSCurA@mail.gmail.com>
	<CAL8zT=hNtBJHTBa_PVyv4mtM6JgFMENiqMTBCT_xVZerU+SMDQ@mail.gmail.com>
	<CAA+hA=Q46kf3ETpEzGFfW_yzoSDo8f7hG0iR2wF9n=LuMMjFfA@mail.gmail.com>
	<CAL8zT=jWVk_zq_CCb86yEOFivXYTnXDNYq5weYm0_sCA0mdckg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:46694 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbaICImT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Sep 2014 04:42:19 -0400
Received: by mail-qa0-f41.google.com with SMTP id m5so7499351qaj.0
        for <linux-mmc@vger.kernel.org>; Wed, 03 Sep 2014 01:42:18 -0700 (PDT)
In-Reply-To: <CAL8zT=jWVk_zq_CCb86yEOFivXYTnXDNYq5weYm0_sCA0mdckg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Sep 3, 2014 at 4:40 PM, Jean-Michel Hautbois
<jhautbois@gmail.com> wrote:
> 2014-09-03 10:39 GMT+02:00 Dong Aisheng <dongas86@gmail.com>:
>> On Wed, Sep 3, 2014 at 4:25 PM, Jean-Michel Hautbois
>> <jhautbois@gmail.com> wrote:
>>> 2014-09-03 10:15 GMT+02:00 Dong Aisheng <dongas86@gmail.com>:
>>>> Hi JM,
>>>
>>> Hi Dong,
>>>
>>>> On Tue, Sep 2, 2014 at 11:10 PM, Jean-Michel Hautbois
>>>> <jhautbois@gmail.com> wrote:
>>>>> 2014-09-02 11:20 GMT+02:00 Jean-Michel Hautbois
>>>>> <jean-michel.hautbois@vodalys.com>:
>>>>>> Hi there,
>>>>>>
>>>>>> I start a new thread, as I have done lots of test and this will be clearer.
>>>>>> I have problems reading and writing eMMC on my i.MX6 board with 3.17-rc3.
>>>>>> Sometimes I don't have read errors explicitly in dmesg, but fdisk has
>>>>>> no effects.
>>>>>> I activated MMC debug in my config file, and here is an extract of
>>>>>> mmc0 register dump and all mmc1 part.
>>>>>> On Freescale kernel, I confirm it works well with the same board and
>>>>>> sample, I can write a partition on mmc1.
>>>>>
>>>>
>>>> My iMX6Q SabreSD board seems ok.
>>>> What board did you use?
>>>> What reading/writing problems did you meet?
>>>> I did not see errors in your log.
>>>> Can you paste the error log?
>>>
>>> This is a custom board.
>>> You are right, activating debug seems to make the problem disappear...
>>> I have CRC errors and my CMD signal is quite bad when this is happening.
>>> I asked an HW engineer to look at this.
>>>
>>> I also double checked the pads, and added the
>>> MX6QDL_PAD_NANDF_ALE__SD4_RESET pad, but the reset signal is always
>>> down when doing this, when it should go down then up...
>>>
>>
>> The sdhci-esdhc-imx driver does not implement hw_reset support via
>> eMMC reset pin.
>
> OK, that is what I thought, let's add it then :) ?

Yes, this feature needs to be added.

Regards
Dong Aisheng

> JM
