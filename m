From: Harish Jenny K N <harish_kandiga@mentor.com>
Subject: Re: [PATCH v3] mmc: Export host capabilities to debugfs.
Date: Mon, 5 Mar 2018 19:18:26 +0530
Message-ID: <9c263aee-7780-9ac9-7433-d4a5ca445f16@mentor.com>
References: <1520242120-2924-1-git-send-email-harish_kandiga@mentor.com>
 <CAPDyKFqL0tE3fdODbpo5Ci1_e=RbOfxZkTXKQ4XWo4FKHzwMiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqL0tE3fdODbpo5Ci1_e=RbOfxZkTXKQ4XWo4FKHzwMiw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, avri.altman@wdc.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vladimir Zapolskiy <Vladimir_Zapolskiy@mentor.com>
List-Id: linux-mmc@vger.kernel.org



On Monday 05 March 2018 05:43 PM, Ulf Hansson wrote:
> On 5 March 2018 at 10:28, Harish Jenny K N <harish_kandiga@mentor.com> wrote:
>> From: Abbas Raza <Abbas_Raza@mentor.com>
>>
>> This patch exports the host capabilities to debugfs
>>
>> Signed-off-by: Abbas Raza <Abbas_Raza@mentor.com>
>> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>
>> Changes in v3:
>> - Removed typecasting of &host->caps to (u32 *)
>>
>> Changes in v2:
>> - Changed Author
>>
>>  drivers/mmc/core/debugfs.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index c51e0c0..570c9e4 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -289,6 +289,9 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>>
>>         card->debugfs_root = root;
>>
>> +       if (!debugfs_create_x32("host_caps", S_IRUSR, root, &host->caps))
>> +               goto err;
>> +
> This isn't the correct place to created the node(s). Please move this
> to mmc_add_host_debugfs().
>
> Moreover, I suggest you export both caps and caps2 in the same change,
> there is no need to have two changes for that - and finally name the
> nodes to "caps" and "caps2".

Addressed your review findings in v4 patch.

Thanks,
Harish Jenny K N
