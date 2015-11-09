From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: mmc: Improve reliability of HS200/HS400 selection
Date: Mon, 9 Nov 2015 13:43:11 +0100
Message-ID: <CAPDyKFrhogSjmGhe5nBDDfv-VQhgfvBHi+LedKdz6OpaOqView@mail.gmail.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFoXaKdBzQnZNiqf-39+zECtGPY5M8S7_BL8eUkaoqKN9Q@mail.gmail.com>
	<563CA35E.20200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35554 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbKIMnM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 07:43:12 -0500
Received: by ykek133 with SMTP id k133so261564811yke.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2015 04:43:11 -0800 (PST)
In-Reply-To: <563CA35E.20200@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

On 6 November 2015 at 13:55, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 06/11/15 13:03, Ulf Hansson wrote:
>> On 28 October 2015 at 13:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> Hi
>>>
>>> Here are some patches that improve the reliability of selecting
>>> eMMC HS200 or HS400 mode.
>>>
>>> Generally the improvement is to match the host controller timing
>>> setting with the card mode before sending commands.
>>>
>>>
>>> Adrian Hunter (4):
>>>       mmc: mmc: Improve reliability of mmc_select_hs200()
>>>       mmc: mmc: Fix HS setting in mmc_select_hs400()
>>>       mmc: mmc: Move mmc_switch_status()
>>>       mmc: mmc: Improve reliability of mmc_select_hs400()
>>>
>>>  drivers/mmc/core/mmc.c | 93 +++++++++++++++++++++++++++++++++++++-------------
>>>  1 file changed, 69 insertions(+), 24 deletions(-)
>>>
>>
>
> Thanks for looking at the patches.
>
>> Adrian, these patches looks good to me. I plan to queue them for 4.5
>> but perhaps those should even go as fixes!?
>
> 4.5 is fine for me.  A quick check seemed to show the patches apply
> cleanly back to 4.2, so I guess you could cc stable and then the patches
> get exposure in next before going to stable.
>
>>
>> Additionally, it would be great if someone could help testing this on
>> a few platforms.
>
> Yes, indeed.
>

I queued up them for fixes and added a stable tag. They will be tested
in linux-next for a while, before I decide to send a PR.
I also added Alim's tested by tag, thanks for helping out testing!

Thanks!

Kind regards
Uffe
