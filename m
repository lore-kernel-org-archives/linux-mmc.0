From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: SD card reader problems on Cherry-Trail
Date: Thu, 19 Oct 2017 14:27:59 +0300
Message-ID: <da406254-fa55-c33e-ec08-6dc749bd5903@intel.com>
References: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
 <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
 <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com>
 <32d4293d-7e9d-8f0d-966f-235a8283182f@intel.com>
 <CAL9uMOHbx4+bEfaiX-NP5q_OzUqbo0O-fb4_oSPQGs0h4tOdtQ@mail.gmail.com>
 <CAL9uMOEk83d2Ua6v9FSKPBpb33KGEj6ExYo_FBiC_sF1VPkMgQ@mail.gmail.com>
 <17f28f0f-ab5b-3095-4d52-8908bee409b4@intel.com>
 <CAL9uMOGxtTv0xogL14njR=+-d-4OsAbu=v=ZK4pNiSNjt0=Hdw@mail.gmail.com>
 <CAL9uMOE=jkDYu0rSDNMQa__2thnOu+T9UvU7SD6MqRmr_9X6PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:37799 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbdJSLev (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Oct 2017 07:34:51 -0400
In-Reply-To: <CAL9uMOE=jkDYu0rSDNMQa__2thnOu+T9UvU7SD6MqRmr_9X6PQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>

On 19/10/17 14:19, Carlo Caione wrote:
> On Tue, Oct 10, 2017 at 10:31 AM, Carlo Caione <carlo@endlessm.com> wrote:
>> On Tue, Oct 10, 2017 at 11:22 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> On 10/10/17 12:22, Carlo Caione wrote:
> 
> /cut
>>> Yes, but it is complicated so I don't have a patch ready just yet.
>>
>> Alright, can you explain a bit what's the problem?
>>
>> Thank you for looking into this,
> 
> Hey Adrian,
> any news (or just some more information) about this issue?

The patches I just sent should help a bit:

	https://marc.info/?l=linux-mmc&m=150841011918586

There is also a dependency on the I2C adapter, so you need
CONFIGF_I2C_DESIGNWARE_BAYTRAIL=y but sdhci-acpi still needs to be taught to
wait for the I2C adapter to initialize.  I am still working on that.
