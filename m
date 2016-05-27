From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 1/2] mmc: dw_mmc: remove redundant of set_bit and
 clear_bit
Date: Fri, 27 May 2016 10:24:19 +0800
Message-ID: <cb3beb19-25a9-ec87-825c-bc485e5ba0f8@rock-chips.com>
References: <CGME20160526030828epcas1p16b97a230c35c2599a2b8fcada376c9de@epcas1p1.samsung.com>
 <1464232063-24841-1-git-send-email-shawn.lin@rock-chips.com>
 <57479A7E.3050103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.133]:33389 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932127AbcE0CYc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 22:24:32 -0400
In-Reply-To: <57479A7E.3050103@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

=E5=9C=A8 2016/5/27 8:53, Jaehoon Chung =E5=86=99=E9=81=93:
> Hi Shawn,
>
> On 05/26/2016 12:07 PM, Shawn Lin wrote:
>> dw_mci_get_cd have already dealed with these for
>> both of internal card-detect and gpio card-detect.
>
> s/dealed/dealt
>
> This patch looks good to me. Could you resend the patch? not RFC.
>

Ok.

> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>>  drivers/mmc/host/dw_mmc.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 829a6ee..cb30e91 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2616,10 +2616,7 @@ static int dw_mci_init_slot(struct dw_mci *ho=
st, unsigned int id)
>>  		mmc->max_seg_size =3D mmc->max_req_size;
>>  	}
>>
>> -	if (dw_mci_get_cd(mmc))
>> -		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>> -	else
>> -		clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);
>> +	dw_mci_get_cd(mmc);
>>
>>  	ret =3D mmc_add_host(mmc);
>>  	if (ret)
>>
>
>
>
>


--=20
Best Regards
Shawn Lin

