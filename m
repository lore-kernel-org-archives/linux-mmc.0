From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write support
 for sd card
Date: Fri, 27 Oct 2017 09:46:32 +0800
Message-ID: <b7acd6a7-6a17-47be-5659-bf5c264d7552@rock-chips.com>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com>
 <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
 <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
 <20171026110316.GD12640@hc>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.131]:46409 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdJ0Bqk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2017 21:46:40 -0400
In-Reply-To: <20171026110316.GD12640@hc>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Jan,

On 2017/10/26 19:03, Jan Glauber wrote:
> On Thu, Oct 26, 2017 at 12:46:02PM +0200, Ulf Hansson wrote:
>> On 26 October 2017 at 03:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>> Hi, Ulf
>>>
>>> On 2017/9/27 11:40, Shawn Lin wrote:
>>>>
>>>> Per SD specification version 4.10, section 4.3.4, it says "pre-erased
>>>> (ACMD23) will make a following Multiple Block Write operation faster
>>>> compared to the same operation without preceding ACMD23". ACMD23 is
>>>> mandatory for all sd cards and the spec also says "Command STOP_TRAN
>>>> (CMD12) shall be used to stop the transmission in Write Multiple Block
>>>> whether or not the preerase (ACMD23) feature is used."
>>>
>>>
>>> Ping... :)
>>
>> Hi Shawn,
>>
>> Actually I was waiting for confirmation from Jan about his tests.
> 
> The patches worked for me but I'm not sure I've actually tested ACMD23.
> Do I need to trigger ACMD23 somehow?

Thanks for testing!

You need a card which doesn't support CMD23 and try to write something
to the card to see if it works well. But given that it's not
easy to identify whether a card support CMD23, I suggest to hack the
code for force all SD cards to use ACMD23.


Could you kindly try this on top of this series? And do some write test
for the SD cards.

@@ -2210,9 +2210,9 @@ static struct mmc_blk_data 
*mmc_blk_alloc_req(struct mmc_card *card,

         if (mmc_host_cmd23(card->host)) {
                 if ((mmc_card_mmc(card) &&
-                    card->csd.mmca_vsn >= CSD_SPEC_VER_3) ||
-                   (mmc_card_sd(card) &&
-                    card->scr.cmds & SD_SCR_CMD23_SUPPORT))
+                    card->csd.mmca_vsn >= CSD_SPEC_VER_3))
+                   //(mmc_card_sd(card) &&
+                    //card->scr.cmds & SD_SCR_CMD23_SUPPORT))
                         md->flags |= MMC_BLK_CMD23;


Thanks.


> 
> --Jan
> 
>> However, overall the series looks reasonable to me.
>>
>> Kind regards
>> Uffe
> 
> 
> 

