From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCHv2 1/1] mmc: core: export emmc revision via sysfs
Date: Fri, 24 Mar 2017 09:59:52 +0900
Message-ID: <CAH9JG2UYdhT3RevK+w_2OzFL9VBf4z1o112tofpyOzns2NJ8Sw@mail.gmail.com>
References: <20170323001849.20332-1-jinqian@android.com> <CAPDyKFrU7tUoRxwkF_e9x4nF+7z8ufxxpckYx_W8yDkmG=797w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrU7tUoRxwkF_e9x4nF+7z8ufxxpckYx_W8yDkmG=797w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jin Qian <jinqian@android.com>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Uri Yanai <uri.yanai@sandisk.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Pratibhasagar V <pratibha@codeaurora.org>, Gwendal Grignou <gwendal@chromium.org>, Dong Aisheng <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 23, 2017 at 6:03 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 23 March 2017 at 01:18, Jin Qian <jinqian@android.com> wrote:
>> Extend sysfs to access ext_csd revision information.

it can be used secure erase feature for each revision. so it's helpful
to support at sysfs node.

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>
>> Signed-off-by: Jin Qian <jinqian@android.com>
>> ---
>>  drivers/mmc/core/mmc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 7fd722868875..08c62c9bec48 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -779,6 +779,7 @@ MMC_DEV_ATTR(manfid, "0x%06x\n", card->cid.manfid);
>>  MMC_DEV_ATTR(name, "%s\n", card->cid.prod_name);
>>  MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>>  MMC_DEV_ATTR(prv, "0x%x\n", card->cid.prv);
>> +MMC_DEV_ATTR(rev, "0x%x\n", card->ext_csd.rev);
>
> We have "product revision" in CID, we have "CSD structure/spec
> version" in CSD and some other related in EXT_CSD.
>
> To make it clear what "rev" is about, I suggest we follow Jaehoon
> suggestions. Let's name it "ext_csd_rev".
>
>>  MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
>>  MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
>>         card->ext_csd.device_life_time_est_typ_a,
>> @@ -836,6 +837,7 @@ static struct attribute *mmc_std_attrs[] = {
>>         &dev_attr_name.attr,
>>         &dev_attr_oemid.attr,
>>         &dev_attr_prv.attr,
>> +       &dev_attr_rev.attr,
>>         &dev_attr_pre_eol_info.attr,
>>         &dev_attr_life_time.attr,
>>         &dev_attr_serial.attr,
>> --
>> 2.12.1.500.gab5fba24ee-goog
>>
>
> Kind regards
> Uffe
