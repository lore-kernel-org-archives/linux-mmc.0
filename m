From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: dw_mmc: priv->sdr_timing set wrong
Date: Tue, 22 Oct 2013 14:02:34 +0530
Message-ID: <CAKuRcOLxnO0n8wVzJ=4WicvKDe3R=2Jvkg6B_v2NmNY3wDyZ+A@mail.gmail.com>
References: <CANEJEGt+kx3_EjgBGxkZ9TJec9ngf=FOcwhg2+eAtPY9-2xxCA@mail.gmail.com>
	<52661F16.3080602@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f45.google.com ([209.85.128.45]:55435 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988Ab3JVIcf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Oct 2013 04:32:35 -0400
Received: by mail-qe0-f45.google.com with SMTP id 8so4525918qea.4
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2013 01:32:34 -0700 (PDT)
In-Reply-To: <52661F16.3080602@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Grant Grundler <grundler@chromium.org>, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sonny Rao <sonnyrao@chromium.org>, ALIM AKHTAR <alim.akhtar@samsung.com>, Douglas Anderson <dianders@chromium.org>

On Tue, Oct 22, 2013 at 12:15 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Grant,
>
> Good catch..sdr-timing is set to wrong value.(set to ddr-timing)
> Do you have the plan that send the fixing patch at mailing?
Oops..
Grant, Thanks for pointing out this.I will prepare the fix and send soon.
>
> Best Regards,
> Jaehoon Chung
>
> On 10/19/2013 05:13 AM, Grant Grundler wrote:
>> Chris, Yuvaraj, Alim, Jaehoon,
>>
>> This patch is wrong:
>> https://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/commit/?h=mmc-next&id=e6c784eded7b39caeaf2e9206336fa1daeccfd09
>>
>> sdr_timing needs to come from the of_property "samsung,dw-mshc-sdr-timing".
>> Assignment of priv->sdr_timing needs to move back where it was before.
>>
>> Can one of you guys "just fix it" or do you need a patch from me (or Sonny)?
>>
>> (This came up during my review of eMMC patches that sonny is
>> backporting to ChromeOS-3.8 kernel and I'm not done yet - have a ton
>> more to do here.)
>>
>> thanks,
>> grant
>>
>
