From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 2/3] mmc: core: API for temporarily disabling
 auto-retuning due to errors
Date: Tue, 28 May 2019 13:21:59 +0200
Message-ID: <aa8e526f-b382-f3b7-74a5-e0fee09ae096@broadcom.com>
References: <20190517225420.176893-1-dianders@chromium.org>
 <20190517225420.176893-3-dianders@chromium.org>
 <05af228c-139b-2b7f-f626-36fb34634be5@broadcom.com>
 <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4f39e152-04ba-a64e-985a-df93e6d15ff8@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>
Cc: linux-rockchip@lists.infradead.org, Double Lo <double.lo@cypress.com>, briannorris@chromium.org, Madhan Mohan R <madhanmohan.r@cypress.com>, mka@chromium.org, Wright Feng <wright.feng@cypress.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Jiong Wu <lohengrin1024@gmail.com>, Ritesh Harjani <riteshh@codeaurora.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Avri Altman <avri.altman@wdc.com>, Martin Hicks <mort@bork.org>
List-Id: linux-mmc@vger.kernel.org



On 5/28/2019 12:04 PM, Adrian Hunter wrote:
> On 26/05/19 9:42 PM, Arend Van Spriel wrote:
>> On 5/18/2019 12:54 AM, Douglas Anderson wrote:
>>> Normally when the MMC core sees an "-EILSEQ" error returned by a host
>>> controller then it will trigger a retuning of the card.  This is
>>> generally a good idea.
>>
>> Probably a question for Adrian, but how is this retuning scheduled. I recall
>> seeing something in mmc_request_done. How about deferring the retuning upon
>> a release host or is that too sdio specific.
> 
> Below is what I have been carrying the last 4 years.  But according to Douglas'
> patch, the release would need to be further down.  See 2nd diff below.
> Would that work?

That makes sense. The loop is needed because the device can be a bit 
bone headed. So indeed after the loop the device should be awake and 
able to handle CMD19.

Regards,
Arend
