From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v6] mmc: dw_mmc: Add IDMAC 64-bit address mode support
Date: Thu, 16 Oct 2014 20:11:35 +0900
Message-ID: <543FA7E7.5030009@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE21B3336B2@IN01WEMBXB.internal.synopsys.com>
 <CAGOxZ51fzvoqUQ7=8312iLyu4jwgmskkaysgXQHju-E5EM5gNQ@mail.gmail.com>
 <CAFp+6iFQ=MU-R-mYLeL0=H5fVWkxVu5s4ineh3RcSExCUNAjCA@mail.gmail.com>
 <543F6A93.1070008@samsung.com>
 <705D14B1C7978B40A723277C067CEDE21B333F07@IN01WEMBXB.internal.synopsys.com>
 <CAFp+6iEXMNzaEgcpFE_vCYj6xwPLJvLzBhA5NFrfnEt1kSyk8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45501 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbaJPLLj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Oct 2014 07:11:39 -0400
In-reply-to: <CAFp+6iEXMNzaEgcpFE_vCYj6xwPLJvLzBhA5NFrfnEt1kSyk8Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>

On 10/16/2014 08:09 PM, Vivek Gautam wrote:
> Hi Prabu,
>=20
>=20
> On Thu, Oct 16, 2014 at 4:09 PM, Prabu Thangamuthu <Prabu.T@synopsys.=
com> wrote:
>>
>> Hi Jaehoon, Vivek, Alim,
>>
>> Thanks for your review comments.
>>
>> On Thu, Oct 16, 2014 at 12:20 PM, Jaehoon Chung <jh80.chung@samsung.=
com> wrote:
>>> Hi, Prabu.
>>>
>>> On 10/15/2014 09:05 PM, Vivek Gautam wrote:
>>>> Hi Prabu,
>>>>
>>>>
>>>> On Tue, Oct 14, 2014 at 5:41 PM, Alim Akhtar <alim.akhtar@gmail.co=
m>
>>> wrote:
>>>>> Hi Prahu,
>>>>> Thanks for a quick re-spin o the patch.
>>>>> One last comment, this is more of a information seek.
>>>>> On Thu, Oct 9, 2014 at 1:09 PM, Prabu Thangamuthu
>>> <Prabu.T@synopsys.com> wrote:
>>>>>> Synopsys DW_MMC IP core supports Internal DMA Controller with 64=
-bit
>>> address mode from IP version 2.70a onwards.
>>>>>> Updated the driver to support IDMAC 64-bit addressing mode.
>>>>>>
>>>>>> Tested the features in DW_MMC core v2.70a and v2.40a with HAPS-5=
1
>>> setup and driver is working fine.
>>>>>>
>>>>>> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
>>>>>> ---
>>>>>> Change log v6:
>>>>>>         - Updated with review comment.
>>>>>>
>>>>>> Change log v5:
>>>>>>         - Recreated the patch against linux-next as this patch i=
s
>>>>>> required for another patch
>>>>>> http://www.spinics.net/lists/arm-kernel/msg357985.html
>>>>>>
>>>>>> Change log v4:
>>>>>>         - Add the dynamic support for 32-bit and 64-bit address =
mode based
>>> on hw configuration.
>>>>>>         - Removed the CONFIG_MMC_DW_IDMAC_64BIT_ADDRESS macro.
>>>>>>
>>>>>>  drivers/mmc/host/dw_mmc.c  |  195
>>> +++++++++++++++++++++++++++++++++++---------
>>>>>>  drivers/mmc/host/dw_mmc.h  |   11 +++
>>>>>>  include/linux/mmc/dw_mmc.h |    2 +
>>>>>>  3 files changed, 170 insertions(+), 38 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/host/dw_mmc.c
>>> b/drivers/mmc/host/dw_mmc.c
>>>>>> index 69f0cc6..c3b75a5 100644
>>>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>>>> @@ -62,6 +62,24 @@
>>>>>>                                  SDMMC_IDMAC_INT_FBE | SDMMC_IDM=
AC_INT_RI | \
>>>>>>                                  SDMMC_IDMAC_INT_TI)
>>>>>>
>>>>>> +struct idmac_desc_64addr {
>>>>>> +       u32             des0;   /* Control Descriptor */
>>>>>> +
>>>>>> +       u32             des1;   /* Reserved */
>>>>> What is the default value of these _Reserved_ descriptors? As the=
se
>>>>> are pointers, do you thing initializing then to zero make sense?
>>
>> We don't think it's required to assign zero to reserved des field as=
 mobster core not going to use this field's for any operations unless u=
ser has modified it.
>> Also it's working fine in our test set-up without initializing them =
to zero.

Right, it's not required to assign zero to there. And It's working fine=
, because it's not used or referred anywhere.
Just Recommend to initialize to zero.
Actually, i don't understand why des1 is reserved..

>>
>>>>
>>>> I think the default reset value of these descriptors will depend o=
n
>>>> how dwmmc is integrated in h/w and how these descriptors are then
>>>> configured.
>>>>
>>>> So it makes sense to initialize these descriptors to zero before u=
se.
>>>> We have seen on our exynos7 system, that we need to initialize the
>>>> descriptors des1 and des2 to zero before we use them further.
>>
>> It looks like exynos7 is using this reserved fields for some other p=
urposes. To make it generic, we will initialize the reserved fields to =
zero.
>>
>> Does exynos7 requires des2 (Buffer sizes) also to be initialized to =
zero?
>=20
> Yes, we need des2 to be initialized to zero.
> One question however, do we have some default reset value set to thes=
e
> descriptors ? If yes then how can we check this value ?

I knew it doesn't have the reset value for descriptors.

Best Regards,
Jaehoon Chung

> I just tried printing the value of des1 and des2 in dw_mci_translate_=
sglist()
> where we are assigning these descriptors.
>=20
>>
>>>
>>> I agreed with Vivek and Alim's comment.
>>>
>>> And I think you can fix the below compile warning.
>>>
>>> drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_idmac_init=E2=
=80=99:
>>> drivers/mmc/host/dw_mmc.c:542:21: warning: right shift count >=3D w=
idth of
>>> type [enabled by default]
>>> drivers/mmc/host/dw_mmc.c:547:3: warning: right shift count >=3D wi=
dth of
>>> type [enabled by default]
>>> drivers/mmc/host/dw_mmc.c:575:3: warning: right shift count >=3D wi=
dth of
>>> type [enabled by default]
>>>
>>> I will check this patch with 2.70a and other version.
>>>
>>
>> We will fix the warnings and post the new patch.
>>
>> Regards,
>> Prabu Thangamuthu.
>>
>=20
>=20
>=20

