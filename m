From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv7 2/2] ARM: dts: unuse the slot-node and deprecated
 supports-highspeed for dw-mmc.
Date: Mon, 16 Jun 2014 08:56:10 +0200
Message-ID: <CAPDyKFo18wi-kZHsoF4k_U9G8jK9maRj0DNs=3ciqUuDfxAHcw@mail.gmail.com>
References: <1402633867-25155-1-git-send-email-jh80.chung@samsung.com>
	<1402633867-25155-3-git-send-email-jh80.chung@samsung.com>
	<CAPDyKFr46gaAnZc34ELv4GYaK+XjuiAcewTmgJU=iyC3WgxWVg@mail.gmail.com>
	<CAELcNGSOV2GD_uLO5HHuJgN2_pNoXtFrCmbPJh4RGc2pEaaYUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:58985 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbaFPG4L (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 02:56:11 -0400
Received: by mail-qa0-f52.google.com with SMTP id w8so7021187qac.11
        for <linux-mmc@vger.kernel.org>; Sun, 15 Jun 2014 23:56:10 -0700 (PDT)
In-Reply-To: <CAELcNGSOV2GD_uLO5HHuJgN2_pNoXtFrCmbPJh4RGc2pEaaYUA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jae hoon Chung <jh80.chung@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Heiko St.bner" <heiko@sntech.de>, dinguyen@altera.com, Mark Rutland <mark.rutland@arm.com>, Tushar Behera <tushar.behera@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 13 June 2014 15:31, Jae hoon Chung <jh80.chung@gmail.com> wrote:
> Hi, Ulf.
>
>
> 2014-06-13 20:14 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
>
>> On 13 June 2014 06:31, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> > dw-mmc controller can support multiple slots.
>> > But, there are no use-cases anywhere. So we don't need to support the
>> > slot-node for dw-mmc controller.
>> > And "supports-highspeed" property in dw-mmc is deprecated.
>> > "supports-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>>
>> This looks good to me.
>>
>> Though, you need to help me understand how to handle this patch.
>>
>> 1) Is it to consider as a fix for 3.16?
>
> Right..It's related with "mmc: dw_mmc: use the mmc_of_parse() instead of
> local parser"
> DW-MMC didn't parse the subnode, so it didn't set to correct bus-width.
>
>> 2 ) I am not sure if there are a dependency to patch 1 - if not this
>> patch is better suited for ARM SoC.
>
> It's not a dependency on patch 1.
> Let me know how i do, plz.

I would suggest you to re-send it to the ARM lits and the ARM SoC guys
and keeping the respective SoC maintainer on the to list of course.

Add a note that it's intended as fix for 3.16 and you may also add my
reviewed by tag.

Kind regards
Uffe
