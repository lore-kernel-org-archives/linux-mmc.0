From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 0/4] mmc: mmc: Improve reliability of HS200/HS400
 selection
Date: Fri, 6 Nov 2015 14:55:58 +0200
Message-ID: <563CA35E.20200@intel.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFoXaKdBzQnZNiqf-39+zECtGPY5M8S7_BL8eUkaoqKN9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58469 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932824AbbKFM7C (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 6 Nov 2015 07:59:02 -0500
In-Reply-To: <CAPDyKFoXaKdBzQnZNiqf-39+zECtGPY5M8S7_BL8eUkaoqKN9Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

On 06/11/15 13:03, Ulf Hansson wrote:
> On 28 October 2015 at 13:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Hi
>>
>> Here are some patches that improve the reliability of selecting
>> eMMC HS200 or HS400 mode.
>>
>> Generally the improvement is to match the host controller timing
>> setting with the card mode before sending commands.
>>
>>
>> Adrian Hunter (4):
>>       mmc: mmc: Improve reliability of mmc_select_hs200()
>>       mmc: mmc: Fix HS setting in mmc_select_hs400()
>>       mmc: mmc: Move mmc_switch_status()
>>       mmc: mmc: Improve reliability of mmc_select_hs400()
>>
>>  drivers/mmc/core/mmc.c | 93 +++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 69 insertions(+), 24 deletions(-)
>>
> 

Thanks for looking at the patches.

> Adrian, these patches looks good to me. I plan to queue them for 4.5
> but perhaps those should even go as fixes!?

4.5 is fine for me.  A quick check seemed to show the patches apply
cleanly back to 4.2, so I guess you could cc stable and then the patches
get exposure in next before going to stable.

> 
> Additionally, it would be great if someone could help testing this on
> a few platforms.

Yes, indeed.

