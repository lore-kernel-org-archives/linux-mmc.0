From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Mon, 28 Nov 2011 20:59:00 +0900
Message-ID: <4ED37784.6030004@samsung.com>
References: <4EB11B6B.2010909@samsung.com>
 <CAFEEs1=yF3u-xL6OnEMTfqYx6HgOaePYkhC7iOJi-=z9TjPfmw@mail.gmail.com>
 <CAELcNGQEm073tFsmSgbKzBfx=oYjZDX=EdbgWQOMZEBscsobTw@mail.gmail.com>
 <CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
 <CAELcNGTddwX6HtR5vJ+wQChyN5a=mU3Wbd5Hg_EqY72xR7k8dA@mail.gmail.com>
 <CAFEEs1mKBUqi8HJK3unRh7KMraethMATTTf8Fn6WB2L+ZUqO9g@mail.gmail.com>
 <4EC096A3.4070309@samsung.com>
 <491f3d5b2d7e3949fdba902e1c98e26b.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:64515 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190Ab1K1L7E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2011 06:59:04 -0500
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LVD00CCODA3W240@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Nov 2011 20:59:02 +0900 (KST)
Received: from [165.213.219.108] by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LVD00E3IDADZ960@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 28 Nov 2011 20:59:02 +0900 (KST)
In-reply-to: <491f3d5b2d7e3949fdba902e1c98e26b.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Per Forlin <per.lkml@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

Hi Kostya

On 11/28/2011 06:39 PM, Konstantin Dorfman wrote:

> Hello Jaehoon, Per
> 
> I have experimented with eMMC v4.41 card and BKOPS feature and want to add
> info on EXT_CSD_BKOPS_EN[163] field. See below.
> 
>> Hi Per
>>
>>>>>>>>
>>>>>>>>        if (card->ext_csd.rev >= 5) {
>>>>>>>> +               /* check whether the eMMC card support BKOPS */
>>>>>>>> +               if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>>>>>>>> +                       card->ext_csd.bkops = 1;
>>>>>>>> +                       card->ext_csd.bkops_en = 1;
>>>>>>> What if the card has not enabled bkops? This bit could be unset.
>>>>>>> card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
>>>>>> When card is supported the bkops, bkops_en bit is set by default...
>>>>>>
>>>>> How do you know if the bkops_en is really enabled in th ext_csd?
>>>>> It could be unset in the ext_csd, right?
>>>>
>>>> In emmc4.5 spec, if card is supported the bkops, bkops_en is set by
>>>> default.
>>> If bkops_en is set by default it should be in the the ext_csd too,
>>> right?
>>> It should be safer to trust the value of ext_csd[EXT_CSD_BKOPS_EN] in
>>> this case I think.
>>
>> If we want to ensure whether bkops_en bit is set or not, your approach is
>> right.
>>
>> Best Regards,
>> Jaehoon Chung
> 
> First of all protocol state:
> ------------------------------
> 7.4.57 BKOPS_EN [163]
> This field allows the _host_ to indicate to the device if it is expected
> to periodically manually start background operations by writing to the
> BKOPS_START field.
> 
> ...In order for the device to know if host is going to periodically start
> background operations, host shall set bit 0 of BKOPS_EN (EXT_CSD byte
> [163]) to indicate that it is going to write to BKOPS_START periodically.
> The device may then delay some of its maintenance operations to when host
> writes to BKOPS_START.
> ------------------------------
> 
> My card supports BKOPS (by reading Bit 0 of BKOPS_SUPPORT (EXT_CSD byte
> [502]), but BKOPS_EN[163] is not set. So I suppose, original code to set
> BKOPS_EN[163] is needed, otherwise card will never delay its maintenance
> operations.


Ok...i will add the code for setting BKOPS_EN bit in patch-v4.
Thanks,
Jaehoon Chung
