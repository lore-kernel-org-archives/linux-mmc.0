From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC] MMC-4.5 Context ID
Date: Mon, 6 Feb 2012 11:04:10 +0530
Message-ID: <CAKLKtzcAqJVDTZFYpijicWStr7m76Quv2ic8hRZp+X_Wmd-bFQ@mail.gmail.com>
References: <1328110021-15199-1-git-send-email-saugata.das@stericsson.com>
	<m2mx8y6ls1.fsf@bob.laptop.org>
	<CAKLKtzeRHVeMemTytmaon0GsZ2GqXwz_M_CX6aTj+xDDgN7HVg@mail.gmail.com>
	<4F2F649E.2010106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37825 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab2BFFeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Feb 2012 00:34:11 -0500
Received: by wics10 with SMTP id s10so3908860wic.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Feb 2012 21:34:10 -0800 (PST)
In-Reply-To: <4F2F649E.2010106@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org

On 6 February 2012 10:56, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/06/2012 02:13 PM, Saugata Das wrote:
>
>> On 5 February 2012 08:15, Chris Ball <cjb@laptop.org> wrote:
>>> Hi,
>>>
>>> On Wed, Feb 01 2012, Saugata Das wrote:
>>>> From: Saugata Das <saugata.das@linaro.org>
>>>>
>>>> This patch groups the read or write transfers to eMMC in different=
 contexts
>>>> based on the block number. Transfers to consecutive blocks are gro=
uped to a
>>>> common context. So several small transfers combine to give perform=
ance like
>>>> a large multi block transfer.
>>>>
>>>> The patch creates a context of 1MB multiple in non-large unit mode=
=2E Reliable
>>>> mode is enabled in the context based on whether reliable write is =
enabled.
>>>
>>> Do you see any performance changes with this patchset? =A0If so, ca=
n you
>>> give details?
>>
>> I do not see any performance impact (positive or negative) on the
>> sample eMMC-4.5 device which I have. This could be due to the slow
>> bridge which I use (1-bit mode at 25MHz) to connect the eMMC-4.5
>> device on micro-SD slot of 8500 platform.
>
> I think that should be increased the performance by how we select the=
 context.
> I also didn't see any performance benefit..8-bit mode at 50Mhz.
> But i have interest for this feature
>

Thanks for the info. Perhaps the initial MMC-4.5 device samples do not
implement this command well. Yes, this feature is good to have in the
kernel. I shall wait for some more comments on the proposed
implementation before submitting the patch.


> Best Regards,
> Jaehoon Chung
>
>>
>>>
>>> Thanks,
>>>
>>> - Chris.
>>> --
>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>> One Laptop Per Child
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
