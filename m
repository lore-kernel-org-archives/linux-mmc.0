From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: SD card reader problems on Cherry-Trail
Date: Tue, 10 Oct 2017 12:22:28 +0300
Message-ID: <17f28f0f-ab5b-3095-4d52-8908bee409b4@intel.com>
References: <CAL9uMOGXVgHP8iNdZbEWv3pSRjZ++hhswu6c+ZiPydGiw9SPEw@mail.gmail.com>
 <CAPDyKFpoHGKGhDyYRTdWMPTxOM0GLNDQjMTDThX5mvFDyVTwnw@mail.gmail.com>
 <CAL9uMOGog77MDUhVisEDcbSFXANGNfzecee1PzgXdwvZwexmUA@mail.gmail.com>
 <32d4293d-7e9d-8f0d-966f-235a8283182f@intel.com>
 <CAL9uMOHbx4+bEfaiX-NP5q_OzUqbo0O-fb4_oSPQGs0h4tOdtQ@mail.gmail.com>
 <CAL9uMOEk83d2Ua6v9FSKPBpb33KGEj6ExYo_FBiC_sF1VPkMgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:1915 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756011AbdJJJv2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Oct 2017 05:51:28 -0400
In-Reply-To: <CAL9uMOEk83d2Ua6v9FSKPBpb33KGEj6ExYo_FBiC_sF1VPkMgQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Carlo Caione <carlo@endlessm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 10/10/17 12:22, Carlo Caione wrote:
> On Thu, Oct 5, 2017 at 10:26 AM, Carlo Caione <carlo@endlessm.com> wrote:
> 
> /cut
>>>> - Reproduced with the latest master on linus repo (4.14.0-rc3)
>>>> - No idea if this is a regression or not. This is a new hardware we
>>>> are trying to enable and I have never seen it working fine (I should
>>>> blindly try some old kernel)
>>>> - Windows is working fine so not an HW issue
>>>> - CPU is x5-Z8350
>>>
>>> Can you provide an acpidump?
>>
>> DSDT https://paste.fedoraproject.org/paste/DXlkVidxM7U9LS2OpqvLGQ/raw
> 
> Hey Adrian,
> any idea about this issue?

Yes, but it is complicated so I don't have a patch ready just yet.
