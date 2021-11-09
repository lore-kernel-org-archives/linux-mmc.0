Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988EFC433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 23:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 739E3611F0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Nov 2021 23:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhKIXme (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Nov 2021 18:42:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:48686 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhKIXmd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2021 18:42:33 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211109233945epoutp015e8060550bc2c42c72bcd44f223bc063~2BShXkJWJ1152011520epoutp010
        for <linux-mmc@vger.kernel.org>; Tue,  9 Nov 2021 23:39:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211109233945epoutp015e8060550bc2c42c72bcd44f223bc063~2BShXkJWJ1152011520epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636501185;
        bh=Se3yZuz9T1bN6BYD+hYWSPJjIFkWNrRteV/U8AYdoSc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FF9KxePEbGrgtsrm9xjNo0F3/Bqna3njgThC7ObZpgnA25pkGzx1qz9eA+AU37r5K
         vZrYx6gGGkHzloKxC2vJHNSDwETKLLJ4MV3mIynuGBXO+sCtsI5EciycxxoCO6JP01
         CL8QS7dIRzdKy+RzWkDBC6F0UPVLIL5USxPHRyq0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211109233944epcas1p209ba28895035903622391cd38e21b790~2BSgqKFyn3239432394epcas1p2d;
        Tue,  9 Nov 2021 23:39:44 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HpkwN3HKrz4x9QG; Tue,  9 Nov
        2021 23:39:32 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.E0.09592.2B60B816; Wed, 10 Nov 2021 08:39:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211109233930epcas1p239bb72213c6a57ce3f1df0711352b5a3~2BSTH1x8D1634416344epcas1p2I;
        Tue,  9 Nov 2021 23:39:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211109233930epsmtrp294bf31cca122e8837a3be5449337eeb8~2BSTHBkDZ1051510515epsmtrp2B;
        Tue,  9 Nov 2021 23:39:30 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-8d-618b06b26672
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.4C.29871.1B60B816; Wed, 10 Nov 2021 08:39:29 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211109233929epsmtip19d4c8e3a08678a0c81f56eb1037318b0~2BSS4llnh0345303453epsmtip15;
        Tue,  9 Nov 2021 23:39:29 +0000 (GMT)
Subject: Re: [PATCH v2] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     Marten Lindahl <martenli@axis.com>
Cc:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <Marten.Lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Doug Anderson <dianders@google.com>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <721d4e03-c8ba-16fb-3224-2a8d4e926920@samsung.com>
Date:   Wed, 10 Nov 2021 08:40:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211109132757.GA8103@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42LZdljTQHcTW3eiQftnRYsF21cyWXxqUbU4
        8r+f0WLC1cmMFltbv7FbHF8b7sDmcX1dgMeCTaUed67tYfP4vEkugCUq2yYjNTEltUghNS85
        PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaLGSQlliTilQKCCxuFhJ386m
        KL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtjYdtHtoKVShW3tz9g
        bmD8JNXFyMkhIWAi8X/vdfYuRi4OIYEdjBKnDy6Hcj4xSpzYe5MZwvnGKNH8ZyILTMvHZ82s
        EIm9jBLtcw4wQjjvGSVarz5hB6kSFvCUWLHqIyuILSKgJnGm7wYTSBGzwH1GiZsv+8CK2AR0
        JLZ/O84EYvMK2EkcvNXJBmKzCKhK3D/TDrZOVCBS4u/JXawQNYISJ2c+AYtzCuhKXH99B6ye
        WUBc4taT+UwQtrxE89bZYHdLCPxll/j2djkrxN0uEvuv7GWEsIUlXh3fwg5hS0l8freXDcKu
        ltjVfAaquYNR4ta2JiaIhLHE/qWTgWwOoA2aEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6J
        jjYhiBIViUuvXzLBrLr75D/UOR4S61+9YpnAqDgLyWuzkLwzC8k7sxAWL2BkWcUollpQnJue
        WmxYYAyP7+T83E2M4GSpZb6DcdrbD3qHGJk4GA8xSnAwK4nw3jvakSjEm5JYWZValB9fVJqT
        WnyI0RQY2BOZpUST84HpOq8k3tDE0sDEzMjYxMLQzFBJnPezXGGikEB6YklqdmpqQWoRTB8T
        B6dUA1O6d+aKsKsC17V7Gy5LNuQ8XpYVfvLB7DPRi2q9rJ4dSDOs4k7KuGsuFWgXN8XTV0mr
        zF70f92yzX/m+Ot0RH3QU5zJIOwrddrgSe3V+RuUuh105/6bN+Pw9fgbNpND3esWHGXVniSu
        LF9/8uC272sfK+1SeDfxsZzRrO//lPaGePG0K58rCJ38jWft8fkFE80m1c66wNTezT2l+KLi
        jIcvHb4F8Hy6tGJR8a+aIM8NDemxl9p2Hp5xSr3rnM5MVcbM6X4sQmq2oTu/WvY5cT5oCu6q
        PXJNiqGRxcK9NznnYWRs0YstogIypy36D0j4/Jr81HW7kX3Nopr7xxOY/B7Nbj38QuGlavTs
        pywNXUosxRmJhlrMRcWJAJmi1mQfBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSnO5Gtu5Eg7U7bSwWbF/JZPGpRdXi
        yP9+RosJVyczWmxt/cZucXxtuAObx/V1AR4LNpV63Lm2h83j8ya5AJYoLpuU1JzMstQifbsE
        royFbR/ZClYqVdze/oC5gfGTVBcjJ4eEgInEx2fNrF2MXBxCArsZJT7e2MwOkZCS+Px0KlsX
        IweQLSxx+HAxRM1bRoltZ8+ygdQIC3hKrFj1kRXEFhFQkzjTd4MJpIhZ4CGjxO/7y9khOp4z
        Stzb/5IRpIpNQEdi+7fjTCA2r4CdxMFbnWCTWARUJe6faWcBsUUFIiWaTmxlg6gRlDg58wlY
        nFNAV+L66ztgcWYBdYk/8y4xQ9jiEreezGeCsOUlmrfOZp7AKDQLSfssJC2zkLTMQtKygJFl
        FaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcHRoae5g3L7qg94hRiYOxkOMEhzMSiK8
        9452JArxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7NbUgtQgmy8TBKdXAJFNk
        2pce/830VJB+zIUky6cnzu1k07v45exB0bdztLyeszdET3zbV+h9SHx9uZ75iWk+OYp7oixV
        pMNtLx/9EnaxNzT7SRNjqI/9Pfb+vy2zPHJuPzfJXZ9nJs508dKOpTbWq5XkErLn9t578t0m
        u2T70olRFw5ukJ21VudH1ozEqIs7U9fm1+dNXF0h8MHRZen7jP1Ht+qlfvFjEOUIvqkdF36f
        J+GGskJB5JHpu0XEY2uPcgUc8dJqcy2/e/bJV4kLgX6T5p1iK0lJOff2zPoAjtBEwV1ny0Pu
        vr8UZL9utfaqp1xPpoXw1OYFauvt8+CWbF7iuGwfu40w42sWQ5+IU26va9PsLQ28IuyVWIoz
        Eg21mIuKEwFT46a9/QIAAA==
X-CMS-MailID: 20211109233930epcas1p239bb72213c6a57ce3f1df0711352b5a3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211108113655epcas1p1b3621396703dffc16f0bca0d5f108c18
References: <CGME20211108113655epcas1p1b3621396703dffc16f0bca0d5f108c18@epcas1p1.samsung.com>
        <20211108113637.3699-1-marten.lindahl@axis.com>
        <9cbaceb0-e238-490f-477f-5d0615401a45@samsung.com>
        <20211109132757.GA8103@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/9/21 10:27 PM, Marten Lindahl wrote:
> On Tue, Nov 09, 2021 at 12:46:17AM +0100, Jaehoon Chung wrote:
>> Hi Marten,
> 
> Hi Jaehoon!
> 
>>
>> On 11/8/21 8:36 PM, Mårten Lindahl wrote:
>>> The TMOUT register is always set with a full value for every transfer,
>>> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
>>> Since the software dto_timer acts as a backup in cases when this timeout
>>> is not long enough, it is normally not a problem. But setting a full
>>> value makes it impossible to test shorter timeouts, when for example
>>> testing data read times on different SD cards.
>>>
>>> Add a function to set any value smaller than the maximum of 0xFFFFFF.
>>>
>>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>>> ---
>>>
>>> v2:
>>>  - Calculate new value before checking boundaries
>>>  - Include CLKDIV register to get proper value
>>>
>>>  drivers/mmc/host/dw_mmc.c | 32 +++++++++++++++++++++++++++++++-
>>>  1 file changed, 31 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 6578cc64ae9e..6edd7a231448 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1283,6 +1283,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>>>  	mci_writel(host, CTYPE, (slot->ctype << slot->id));
>>>  }
>>>  
>>> +static void dw_mci_set_data_timeout(struct dw_mci *host,
>>> +				    unsigned int timeout_ns)
>>> +{
>>> +	unsigned int clk_div, tmp, tmout;
>>> +
>>> +	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
>>> +	if (clk_div == 0)
>>> +		clk_div = 1;
>>> +
>>> +	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
>>> +			       NSEC_PER_SEC * clk_div);
>>> +
>>> +	if (!tmp || tmp > 0xFFFFFF) {
>>> +		/* Set maximum */
>>
>> "Set maximum value about all Timeout"?
> 
> Do you mean just changing the comment here? Or do you wonder about the
> 0xFFFFFF check? 0xFFFFFF is the upper limit for this HW timer. If we
> want to support a longer timer than this, a software timer should be
> used, but in a separate patch.

My mean is how about changing the comment to clarify than now.
At below, tmout is set to maximum value about data/response timeout.

> 
>>
>>> +		tmout = 0xFFFFFFFF;
>>> +		goto tmout_done;
>>> +	}
>>
>> It doesn't need to use "goto". Instead, if-else can be used.
> 
> If you prefer it I can change goto to if-else

Well, it's just my  preference. If you're ok, I hope that so.

> 
>>
>>> +
>>> +	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
>>> +	tmout = 0xFF; /* Set maximum */
>>
>> To prevent a confusion, how about add "Set a maximum response timeout"
>> And this line can be removed.
> 
> But if removing the lines above, the comment will also be removed. I see
> your point, but couldn't there be more confusion by merging both fields
> into one line? My intention was to specify the TMOUT register fields
> separately to make it more clear.

Agreed. It's more clear than my opinion.

Best Regards,
Jaehoon Chung

> 
>>
>>> +
>>> +	/* TMOUT[31:8] (DATA_TIMEOUT) */
>>> +	tmout |= (tmp & 0xFFFFFF) << 8;
>>
>> tmout = (0xFF | ((tmp & 0xFFFFFF) << 8));
>>
>> The entire code can be below
>>
>> if (!tmp || ....)
>> 	tmout = 0xFFFFFFFF;
>> else 
>> 	tmout = (0xFF | ((tmp & 0xFFFFFF) << 8));
>>
>> writel(TMOUT, ...)
>>
>> How about this?
> 
> I agree that this is smaller code, but as I said above it may not be
> clear that there are more than one field in the TMOUT register. Wouldn't
> it raise questions about the 0xFF?
> 
> Kind regards
> Mårten
> 
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>> +
>>> +tmout_done:
>>> +	mci_writel(host, TMOUT, tmout);
>>> +	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
>>> +		timeout_ns, tmout >> 8);
>>> +}
>>> +
>>>  static void __dw_mci_start_request(struct dw_mci *host,
>>>  				   struct dw_mci_slot *slot,
>>>  				   struct mmc_command *cmd)
>>> @@ -1303,7 +1333,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>>>  
>>>  	data = cmd->data;
>>>  	if (data) {
>>> -		mci_writel(host, TMOUT, 0xFFFFFFFF);
>>> +		dw_mci_set_data_timeout(host, data->timeout_ns);
>>>  		mci_writel(host, BYTCNT, data->blksz*data->blocks);
>>>  		mci_writel(host, BLKSIZ, data->blksz);
>>>  	}
>>>
>>
> 

