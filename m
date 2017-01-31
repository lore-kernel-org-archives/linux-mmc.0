From: Ravikumar <rk@ti.com>
Subject: Re: [PATCH 0/3] mmc: host: omap_hsmmc: miscellaneous fixes
Date: Tue, 31 Jan 2017 16:04:32 +0530
Message-ID: <757e7b0d-d8ec-8c95-041a-46578cf45cf5@ti.com>
References: <1485771118-13748-1-git-send-email-rk@ti.com>
 <CAPDyKFp2rda+DHS1CWRiXxdVNQVc=R3DjEaLmPhPzTzrjwsVpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFp2rda+DHS1CWRiXxdVNQVc=R3DjEaLmPhPzTzrjwsVpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kishon <kishon@ti.com>
List-Id: linux-mmc@vger.kernel.org



On Tuesday 31 January 2017 03:45 PM, Ulf Hansson wrote:
> On 30 January 2017 at 11:11, Ravikumar Kattekola <rk@ti.com> wrote:
>> A few issues have been identified during mmc testing and following
>> set of patches fixes a couple of them related to
>> *timeout handling and ceb error handling*
>>
>> Tested on DRA75X PG 2.0 Rev H EVM
>>
>> Kishon Vijay Abraham I (1):
>>    mmc: host: omap_hsmmc: use generic_cmd6_time to program timeout value
>>      for CMD6
>>
>> Ravikumar Kattekola (2):
>>    mmc: host: omap_hsmmc: reset cmd line on ceb error
>>    mmc: host: omap_hsmmc: avoid possible overflow of timeout value
>>
>>   drivers/mmc/host/omap_hsmmc.c | 29 +++++++++++++++++++----------
>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> --
>> 1.9.1
>>
>
> Assuming that you target 4.10 rcs for this and you want me to add a stable tag?
These are not critical fixes so can be queued for next , go to 4.11.
> Kind regards
> Uffe
Thanks and Regards,
RK
