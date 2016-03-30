From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH] mmc: block: Support the fixed index for mmcblk with
 aliases nodes
Date: Wed, 30 Mar 2016 08:15:30 +0800
Message-ID: <56FB1AA2.8050005@rock-chips.com>
References: <56FA5C56.9080009@samsung.com> <20160329184920.29a240fc@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:50491 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbcC3APp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2016 20:15:45 -0400
In-Reply-To: <20160329184920.29a240fc@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

=E5=9C=A8 2016/3/29 18:49, Jisheng Zhang =E5=86=99=E9=81=93:
> Hi Jaehoon,
>
> On Tue, 29 Mar 2016 19:43:34 +0900 Jaehoon Chung wrote:
>
>> This patch is just RFC. I want to know opinions.
>>
>> Now, index of mmcblk is allocated in accordance with probing time.
>> If want to use the mmcblk1 for some device, it can use alias.
>>
>> aliases {
>> 	mmc0 =3D &mmc0;	/* mmcblk0 for eMMC */
>> 	mmc1 =3D &mmc2;	/* mmcblk1 for SD */
>> 	mmc2 =3D &mmc1;	/* mmcblk2 for SDIO*/
>> };
>
> I like this feature and we do need it. In the past, we have to put em=
mc dt node
> before the sd node, but on our platform, the register base of sdhc ho=
st for emmc
> is higher than the one for sd, putting emmc dt node before sd looks a=
 bit
> strange, but we have no better solutions.
>

:) That is also what I suffered currently. I have to prepare two
seperate firmware with two diff fstab files to assign the mount point
since sometime I need to boot from sd, but sometimes from emmc....
With this patch, I only need to dtc a new dtb... quite simple.

> Thanks,
> Jisheng
>
>>
>> If there are no corresponding values, it might be allocated with
>> existing scheme.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>   Documentation/devicetree/bindings/mmc/mmc.txt | 11 +++++++++++
>>   drivers/mmc/card/block.c                      | 17 +++++++++++++++=
+-
>>   2 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documen=
tation/devicetree/bindings/mmc/mmc.txt
>> index ed23b9b..e37ea29 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -71,6 +71,10 @@ Optional SDIO properties:
>>   - wakeup-source: Enables wake up of host system on SDIO IRQ assert=
ion
>>   		 (Legacy property supported: "enable-sdio-wakeup")
>>
>> +Aliases (Optional):
>> +- If you want to use the fixed index for block device like mmcblkX,=
 should be
>> +represented in the aliases node using following format "mmc(X)".
>> +(X is an unique number for the alias.)
>>
>>   MMC power sequences:
>>   --------------------
>> @@ -145,3 +149,10 @@ mmc3: mmc@01c12000 {
>>   		interrupt-names =3D "host-wake";
>>   	};
>>   };
>> +
>> +Example with aliases nodes:
>> +
>> +aliases {
>> +	mmc0 =3D &mmc0;	/* Fixed to mmcblk0 for &mmc0 */
>> +	mmc1 =3D &mmc2;	/* Fixed to mmcblk1 for &mmc2 */
>> +};
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index 3bdbe50..6a40de5 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/capability.h>
>>   #include <linux/compat.h>
>>   #include <linux/pm_runtime.h>
>> +#include <linux/of.h>
>>
>>   #include <linux/mmc/ioctl.h>
>>   #include <linux/mmc/card.h>
>> @@ -2190,6 +2191,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(=
struct mmc_card *card,
>>   {
>>   	struct mmc_blk_data *md;
>>   	int devidx, ret;
>> +	int idx =3D 0;
>>
>>   	devidx =3D find_first_zero_bit(dev_use, max_devices);
>>   	if (devidx >=3D max_devices)
>> @@ -2209,7 +2211,20 @@ static struct mmc_blk_data *mmc_blk_alloc_req=
(struct mmc_card *card,
>>   	 * index anymore so we keep track of a name index.
>>   	 */
>>   	if (!subname) {
>> -		md->name_idx =3D find_first_zero_bit(name_use, max_devices);
>> +		if (card->dev.parent->parent->of_node)
>> +			idx =3D of_alias_get_id(card->dev.parent->parent->of_node,
>> +					"mmc");
>> +
>> +		if (idx < 0)
>> +			md->name_idx =3D find_first_zero_bit(name_use,
>> +					max_devices);
>> +		else {
>> +			if (test_bit(idx, name_use))
>> +				md->name_idx =3D find_first_zero_bit(name_use,
>> +						max_devices);
>> +			else
>> +				md->name_idx =3D (unsigned int)idx;
>> +		}
>>   		__set_bit(md->name_idx, name_use);
>>   	} else
>>   		md->name_idx =3D ((struct mmc_blk_data *)
>
>
>
>


--=20
Best Regards
Shawn Lin

