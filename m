From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Extend sysfs with OCR register
Date: Tue, 12 Jul 2016 11:53:50 +0200
Message-ID: <CAPDyKFo7wVfRroVLui2b_oUBbMjYGFg8FMMW6vXF3pXtSw1a7Q@mail.gmail.com>
References: <20160704115818.35614-1-prtvar.b@gmail.com> <CAPDyKFqTSRupW+qWFWP=5xwQMWU79NFWTxipwButc8D_jFw05g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqTSRupW+qWFWP=5xwQMWU79NFWTxipwButc8D_jFw05g@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Bojan Prtvar <prtvar.b@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linus Walleij <linus.walleij@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <aisheng.dong@nxp.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Gwendal Grignou <gwendal@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 6 July 2016 at 18:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 4 July 2016 at 13:56, Bojan Prtvar <prtvar.b@gmail.com> wrote:
>> Make operation conditions register (OCR) easily accessible from user space.
>>
>> Signed-off-by: Bojan Prtvar <prtvar.b@gmail.com>
>
> Thanks, applied for next! Amended the changelog with the explanation
> why this change is wanted.

I just realized that the OCR register is also available for SD cards.

Could you perhaps cook a patch which adds this to sysfs for SD cards as well!?

Kind regards
Uffe

>
> Kind regards
> Uffe
>
>> ---
>>  Documentation/mmc/mmc-dev-attrs.txt | 1 +
>>  drivers/mmc/core/mmc.c              | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
>> index caa5557..8163eca 100644
>> --- a/Documentation/mmc/mmc-dev-attrs.txt
>> +++ b/Documentation/mmc/mmc-dev-attrs.txt
>> @@ -28,6 +28,7 @@ All attributes are read-only.
>>         preferred_erase_size    Preferred erase size
>>         raw_rpmb_size_mult      RPMB partition size
>>         rel_sectors             Reliable write sector count
>> +       ocr                     Operation Conditions Register
>>
>>  Note on Erase Size and Preferred Erase Size:
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 5d438ad..1848334 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -727,6 +727,7 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>>  MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
>>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>> +MMC_DEV_ATTR(ocr, "%08x\n", card->ocr);
>>
>>  static ssize_t mmc_fwrev_show(struct device *dev,
>>                               struct device_attribute *attr,
>> @@ -762,6 +763,7 @@ static struct attribute *mmc_std_attrs[] = {
>>         &dev_attr_enhanced_area_size.attr,
>>         &dev_attr_raw_rpmb_size_mult.attr,
>>         &dev_attr_rel_sectors.attr,
>> +       &dev_attr_ocr.attr,
>>         NULL,
>>  };
>>  ATTRIBUTE_GROUPS(mmc_std);
>> --
>> 2.8.0.GIT
>>
