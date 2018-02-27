From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: update kernel-doc comments for dw_mci
Date: Tue, 27 Feb 2018 12:28:06 +0100
Message-ID: <CAPDyKFp7Aik0U49cFZGMamw8xe+=yakGjfuMgbvgFrQA-t=VXQ@mail.gmail.com>
References: <20180222194525.28947-1-alexey.roslyakov@gmail.com>
 <CGME20180223014048epcas5p293b090a79d10de2653428d6fec57a203@epcas5p2.samsung.com>
 <f87c7d91-8b26-bf63-5323-5c60b00c81e4@rock-chips.com> <a3f948c2-f443-63d1-ff3e-51751bc83982@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a3f948c2-f443-63d1-ff3e-51751bc83982@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Alexey Roslyakov <alexey.roslyakov@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 February 2018 at 07:30, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/23/2018 10:40 AM, Shawn Lin wrote:
>> Hi Alexey,
>>
>> On 2018/2/23 3:45, Alexey Roslyakov wrote:
>>> cur_slot and num_slots has been removed from struct dw_mci in 42f989c002f2.
>>> Unfortunately, inline documentation was not updated so far.
>>>
>>> Fix @lock field documentation in Locking section.
>>> Move @mrq field of struct dw_mci_slot mention closer to it
>>> description, so no one could miss this slightest detail.
>>>
>>> Couple of code style fixes as a bonus.
>>>
>>
>> Thanks for updating these.
>>
>> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> Thanks! Will apply this with Shawn's Reveiwed-by tag.

Dear Jaehoon, I picked this up for next and by adding your ack. Tell
me if you have objections!

[...]

Thanks and kind regards
Uffe
