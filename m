From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RFCv2 01/10] mmc: core: Add support to read command queue
 parameters
Date: Tue, 22 Nov 2016 09:58:25 +0200
Message-ID: <e18147ff-ac6b-a48f-4487-18ebd51bbc99@intel.com>
References: <1467033757-32498-1-git-send-email-riteshh@codeaurora.org>
 <1467033757-32498-2-git-send-email-riteshh@codeaurora.org>
 <CACRpkdYDfdCoZUOryjVX4byu2BFx9KZx7YKoFG9wESDpaKtirg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2289 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752817AbcKVID3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 22 Nov 2016 03:03:29 -0500
In-Reply-To: <CACRpkdYDfdCoZUOryjVX4byu2BFx9KZx7YKoFG9wESDpaKtirg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ritesh Harjani <riteshh@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Asutosh Das <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Sujit Reddy Thumma <sthumma@codeaurora.org>, kdorfman@codeaurora.org, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, venkatg@codeaurora.org, Shawn Lin <shawn.lin@rock-chips.com>, Subhash Jadavani <subhashj@codeaurora.org>

On 21/11/16 17:34, Linus Walleij wrote:
> On Mon, Jun 27, 2016 at 3:22 PM, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> 
>> From: Asutosh Das <asutoshd@codeaurora.org>
>>
>> eMMC cards with EXT_CSD version >= 8, optionally support command
>> queuing feature as defined by JEDEC eMMC5.1. Add support for probing
>> command queue feature for such type of cards.
>>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> [subhashj@codeaurora.org: fixed trivial merge conflicts]
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Even if we don't merge the specific mechanism provided by the
> rest of the patches, this patch just make us know more about
> the capabilities of the hardware we're running on, which is good.

I think SW CMDQ is a better starting point:

	https://marc.info/?l=linux-mmc&m=147729857722285

It cleans up the queue thread a bit:

	https://marc.info/?l=linux-mmc&m=147729857222281&w=2

And introduces queue semantics:

	https://marc.info/?l=linux-mmc&m=147729863322314&w=2

