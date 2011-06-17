From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: UHS-I bus speed mode should be set last in UHS initialization
Date: Fri, 17 Jun 2011 14:44:57 +0800
Message-ID: <BANLkTiktPU3K4OaeFQmwO=jfF7RM1_zxwg@mail.gmail.com>
References: <000a01cc2a04$09c9d600$1d5d8200$@org>
	<6C03668EAF45B747AF947A1603D1B300015F91E376@SAUSEXMBP01.amd.com>
	<000001cc2aee$dd8a8e90$989fabb0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41259 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1FQGo6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2011 02:44:58 -0400
Received: by vxi39 with SMTP id 39so1747356vxi.19
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2011 23:44:57 -0700 (PDT)
In-Reply-To: <000001cc2aee$dd8a8e90$989fabb0$@org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: subhashj@codeaurora.org, "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Philip Rakity <prakity@marvell.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, "Lu, Aaron" <Aaron.Lu@amd.com>

On Wed, Jun 15, 2011 at 7:57 AM,  <subhashj@codeaurora.org> wrote:
> Hi Arindam,
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Nath, Arindam
>> Sent: Tuesday, June 14, 2011 12:00 AM
>> To: subhashj@codeaurora.org
>> Cc: Philip Rakity; zhangfei gao; cjb@laptop.org; linux-
>> mmc@vger.kernel.org; Lu, Aaron
>> Subject: RE: UHS-I bus speed mode should be set last in UHS
>> initialization
>>
>> Adding Philip and Zhangfei.
>>
>> Hi Subhash,
>>
>> Does your controller follow some non-standard steps for initialization?
>> I referred to Figure 3-14, section 3.9.4 of Physical Layer Spec v3.01,
>> and it shows the order, setting Driver Strength Select, Bus Speed Mode,
>> and then Current Limit. So please confirm back.
>
> Sorry, I don't know what do you mean by non standard steps for
> initialization. Nowhere in v3.01 spec, it is mentioned that Bus speed mode
> **must** be set before current limit. Figure 3-14 also doesn't indicate
> this.
>
> If you set the bus speed mode in sd_set_bus_speed_mode(), you are changing
> the host controller timings as well and if it's SDR50/SDR104 mode, then
> immediately after setting the host controller timing mode, we have to
> execute tuning sequence but here before executing tuning sequence, you are
> sending the CMD6 which involves the read data transfer from card which is
> bound to fail without tuning and it does fail with our host controller.
>
> Do let me know if this explanation make sense.

I think the concern does make sense.

Though Figure 3-14 and 4-6 describe Bus Speed Mode is selected ahead
of Current limit, the controller timing is changed in
sd_set_bus_speed_mode, which may cause following cmd6 fail.

However, the test here shows mmp2 does not care the sequence of
speed_mode and current_limit.

Thanks
