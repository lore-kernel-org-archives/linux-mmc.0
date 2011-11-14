From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: support BKOPS feature for eMMC
Date: Mon, 14 Nov 2011 13:18:43 +0900
Message-ID: <4EC096A3.4070309@samsung.com>
References: <4EB11B6B.2010909@samsung.com>
 <CAFEEs1=yF3u-xL6OnEMTfqYx6HgOaePYkhC7iOJi-=z9TjPfmw@mail.gmail.com>
 <CAELcNGQEm073tFsmSgbKzBfx=oYjZDX=EdbgWQOMZEBscsobTw@mail.gmail.com>
 <CAFEEs1==cJ_dYDgesAZcs+E=-jj7-hwwssbAsE4a9AdmED8k3A@mail.gmail.com>
 <CAELcNGTddwX6HtR5vJ+wQChyN5a=mU3Wbd5Hg_EqY72xR7k8dA@mail.gmail.com>
 <CAFEEs1mKBUqi8HJK3unRh7KMraethMATTTf8Fn6WB2L+ZUqO9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:16967 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932Ab1KNESx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Nov 2011 23:18:53 -0500
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LUM00I6HUNEBZ10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Nov 2011 13:18:52 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LUM00M2ZUNFFS90@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Nov 2011 13:18:52 +0900 (KST)
In-reply-to: <CAFEEs1mKBUqi8HJK3unRh7KMraethMATTTf8Fn6WB2L+ZUqO9g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, svenkatr@ti.com, chuanxiao.dong@intel.com

Hi Per

>>>>>>
>>>>>>        if (card->ext_csd.rev >= 5) {
>>>>>> +               /* check whether the eMMC card support BKOPS */
>>>>>> +               if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>>>>>> +                       card->ext_csd.bkops = 1;
>>>>>> +                       card->ext_csd.bkops_en = 1;
>>>>> What if the card has not enabled bkops? This bit could be unset.
>>>>> card->ext_csd.bkops_en = ext_csd[EXT_CSD_BKOPS_EN];
>>>> When card is supported the bkops, bkops_en bit is set by default...
>>>>
>>> How do you know if the bkops_en is really enabled in th ext_csd?
>>> It could be unset in the ext_csd, right?
>>
>> In emmc4.5 spec, if card is supported the bkops, bkops_en is set by default.
> If bkops_en is set by default it should be in the the ext_csd too, right?
> It should be safer to trust the value of ext_csd[EXT_CSD_BKOPS_EN] in
> this case I think.

If we want to ensure whether bkops_en bit is set or not, your approach is right.

Best Regards,
Jaehoon Chung
