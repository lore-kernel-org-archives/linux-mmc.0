From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCH 1/1] mmc: core: export emmc revision via sysfs
Date: Wed, 22 Mar 2017 17:23:57 -0700
Message-ID: <CA+yUs=yJtjpFENQuz55AEjEHtR3GQ=zm-=MHnTyS45JGTPEkLA@mail.gmail.com>
References: <CGME20170321220337epcas2p2439e1bf9ecbf4140f23fe7e2bdfcd831@epcas2p2.samsung.com>
 <20170321220200.23145-1-jinqian@android.com> <e2a14f9b-aa91-81a7-275f-67c03dd7f179@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e2a14f9b-aa91-81a7-275f-67c03dd7f179@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Uri Yanai <uri.yanai@sandisk.com>, Dong Aisheng <aisheng.dong@nxp.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Pratibhasagar V <pratibha@codeaurora.org>, Gwendal Grignou <gwendal@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Removed redundant signoff.

export rev to collect some statistics on how many devices are running
with which mmc revision.

Other attr name seems follow cid.<name> or ext_csd.<name>.

Thanks,
jin


On Tue, Mar 21, 2017 at 3:17 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi,
>
> On 03/22/2017 07:01 AM, Jin Qian wrote:
>> Extend sysfs to access ext_csd revision information.
>>
>> Signed-off-by: Jin Qian <jinqian@google.com>
>> Signed-off-by: Jin Qian <jinqian@android.com>
>
> I think you can choose one of them for signed-off tag.
>
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
> I'm not sure but if someone want to know ext_csd revision information, attribute name might be more clearly.
> e,g) ext_csd_rev?
>
> It's my preference. :)
>
> Best Regards,
> Jaehoon Chung
>
>>  MMC_DEV_ATTR(pre_eol_info, "%02x\n", card->ext_csd.pre_eol_info);
>>  MMC_DEV_ATTR(life_time, "0x%02x 0x%02x\n",
>>       card->ext_csd.device_life_time_est_typ_a,
>> @@ -836,6 +837,7 @@ static struct attribute *mmc_std_attrs[] = {
>>       &dev_attr_name.attr,
>>       &dev_attr_oemid.attr,
>>       &dev_attr_prv.attr,
>> +     &dev_attr_rev.attr,
>>       &dev_attr_pre_eol_info.attr,
>>       &dev_attr_life_time.attr,
>>       &dev_attr_serial.attr,
>>
>
