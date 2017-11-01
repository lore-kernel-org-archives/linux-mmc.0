From: Carlo Caione <carlo@endlessm.com>
Subject: Re: SD card reader problems on Cherry-Trail
Date: Wed, 1 Nov 2017 02:38:50 +0000
Message-ID: <CAL9uMOGOpPLxbAiNgOowZPaUHAwAho1toVQVmpfVJpB+ekQP3g@mail.gmail.com>
References: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
 <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
 <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com>
 <32d4293d-7e9d-8f0d-966f-235a8283182f@intel.com> <CAL9uMOHbx4+bEfaiX-NP5q_OzUqbo0O-fb4_oSPQGs0h4tOdtQ@mail.gmail.com>
 <CAL9uMOEk83d2Ua6v9FSKPBpb33KGEj6ExYo_FBiC_sF1VPkMgQ@mail.gmail.com>
 <17f28f0f-ab5b-3095-4d52-8908bee409b4@intel.com> <CAL9uMOGxtTv0xogL14njR=+-d-4OsAbu=v=ZK4pNiSNjt0=Hdw@mail.gmail.com>
 <CAL9uMOE=jkDYu0rSDNMQa__2thnOu+T9UvU7SD6MqRmr_9X6PQ@mail.gmail.com> <da406254-fa55-c33e-ec08-6dc749bd5903@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:46353 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932210AbdKACiv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Oct 2017 22:38:51 -0400
Received: by mail-vk0-f47.google.com with SMTP id k123so601340vkb.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Oct 2017 19:38:51 -0700 (PDT)
In-Reply-To: <da406254-fa55-c33e-ec08-6dc749bd5903@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>

On Thu, Oct 19, 2017 at 12:27 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 19/10/17 14:19, Carlo Caione wrote:
>> On Tue, Oct 10, 2017 at 10:31 AM, Carlo Caione <carlo@endlessm.com> wrote:
>>> On Tue, Oct 10, 2017 at 11:22 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>> On 10/10/17 12:22, Carlo Caione wrote:
>>
>> /cut
>>>> Yes, but it is complicated so I don't have a patch ready just yet.
>>>
>>> Alright, can you explain a bit what's the problem?
>>>
>>> Thank you for looking into this,
>>
>> Hey Adrian,
>> any news (or just some more information) about this issue?
>
> The patches I just sent should help a bit:
>
>         https://marc.info/?l=linux-mmc&m=150841011918586
>
> There is also a dependency on the I2C adapter, so you need
> CONFIGF_I2C_DESIGNWARE_BAYTRAIL=y but sdhci-acpi still needs to be taught to
> wait for the I2C adapter to initialize.  I am still working on that.

Sorry for the late reply. I tried those patches but they didn't help
much, still having problems with some SD cards.
What's the status of this issue? (currently not subscribed to
linux-mmc, sorry. BTW, could you please put me on CC if the discussion
/ patch submission is still going on about this problem?)

Thank you very much,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
