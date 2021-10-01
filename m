Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F272C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 00:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 781A061267
	for <linux-mmc@archiver.kernel.org>; Fri,  1 Oct 2021 00:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350993AbhJAAQO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 30 Sep 2021 20:16:14 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38003 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbhJAAQO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2021 20:16:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20211001001429epoutp02052a09838c1c3debad9ad6a164e5bf32~pv9bgoAcm0947609476epoutp02g
        for <linux-mmc@vger.kernel.org>; Fri,  1 Oct 2021 00:14:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20211001001429epoutp02052a09838c1c3debad9ad6a164e5bf32~pv9bgoAcm0947609476epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1633047269;
        bh=DzRE5t4Nqs/YomOh3gWgUJRZgn+Nx9wVWadBQc+COIk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=n129Urpioj+j+AD2cL3vq9u3N4NnT0OWh+2wAxVQ4z7uKAiVVfTuuOqLNwJqYlMY0
         Y0psiQ+64GNXvEkuXeO3hag+VwaiQEWlL8mSitJGxjh+ZzybV9YXg/+K0Nzp6Ublxt
         0mCwL/Bt6qhM6rT0cGhsHY7cwsrvbwO2k06sEHzY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211001001428epcas1p16d31c2c7b7bd1d66076015f3de2d6d97~pv9a8p_GH2162121621epcas1p1p;
        Fri,  1 Oct 2021 00:14:28 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HL9b149Hsz4x9QQ; Fri,  1 Oct
        2021 00:14:21 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.3B.13888.8D256516; Fri,  1 Oct 2021 09:14:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211001001415epcas1p40c13dc3fa74b72600b117e1180428f52~pv9Oc25cZ3227232272epcas1p4D;
        Fri,  1 Oct 2021 00:14:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211001001415epsmtrp25f2258c6a3ae37328e7cba86cf330372~pv9OcKBM00216202162epsmtrp2h;
        Fri,  1 Oct 2021 00:14:15 +0000 (GMT)
X-AuditID: b6c32a39-227ff70000003640-d7-615652d817eb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.10.08750.7D256516; Fri,  1 Oct 2021 09:14:15 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211001001415epsmtip2df8b22c81186bd401ad252101617a6be~pv9OPE-Sy0723307233epsmtip2O;
        Fri,  1 Oct 2021 00:14:15 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <2cd1ea80-9fde-ef0f-6ce6-b29ba0894994@samsung.com>
Date:   Fri, 1 Oct 2021 09:15:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cfe4476922584dff91bf0fdbec0c0843@hyperstone.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQPdGUFiiwevtohazb/tbXN41h83i
        yP9+RosJVyczWhxfG+7A6nF9XYDHmXUPGD3uXNvD5vF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZe
        uq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QUiWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgWmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsa7ozuZCuaJVTS++cDcwNgk
        1MXIySEhYCIx9+x7ZhBbSGAHo8S+A35djFxA9idGiY43z5ggEp8ZJT4fZYdpeL2xjR0ivotR
        YuLvYoiG94wSK78uYgRJCAt4SOx4O48VxBYR2MkocWm/WBcjBwezQI7EnG/5IGE2AR2J7d+O
        g83nFbCTuHbiIdhMFgEViflfToIdJCoQKfH35C5WiBpBiZMzn7CA2JxA9Y8mdoLZzALiEree
        zGeCsOUlmrfOZga5R0LgK7tE05tlzBBHu0hc3nyTDcIWlnh1fAvUM1ISn9/thYpXS+xqPgPV
        3MEocWtbExNEwlhi/9LJTBAPaEqs36UPEVaU2Pl7LiPEYj6Jd197WEFKJAR4JTraoIGrInHp
        9UsmmFV3n/xnhbA9JB5+us46gVFxFpLXZiF5ZxaSd2YhLF7AyLKKUSy1oDg3PbXYsMAUHtXJ
        +bmbGMGpUctyB+P0tx/0DjEycTAeYpTgYFYS4f0hHpwoxJuSWFmVWpQfX1Sak1p8iNEUGNgT
        maVEk/OByTmvJN7QxNLAxMzI2MTC0MxQSZz32GvLRCGB9MSS1OzU1ILUIpg+Jg5OqQamNVcN
        lz8XkjXwNTVwWhjpfnd36c6nW/jeb1zNe02zJmrujxMyrx58OKzsdDwvfmq1ra7kwcXT/tfP
        715z+c0nA7MTyuJqR1odT2m6TWpeXGDVcuoPo+ovgTV/LJynblsT81t5WXaitMj0l3w2pz76
        F1W27DpVLffqZCBTjPjpU1dnSG7fq29S3fMwIGfzms4pL9j6vaentJ8rFSm1WiNqk9vTKbjj
        ypKf92ZfEUi1nlEuYsgj8Vv/+m6uV3oP3on6br55vPiQKuu5mcbT7QT6XLOmVN5WN2c6dZIj
        W/DEwh0FIq2rFvKut21e4MBTf3R6XUltu/KRnKmftjDbBhSeDxY8qNS2Nsi0PpBVaMZ5JZbi
        jERDLeai4kQAo25RJxYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSvO71oLBEg19dMhazb/tbXN41h83i
        yP9+RosJVyczWhxfG+7A6nF9XYDHmXUPGD3uXNvD5vF5k1wASxSXTUpqTmZZapG+XQJXxruj
        O5kK5olVNL75wNzA2CTUxcjJISFgIvF6Yxt7FyMXh5DADkaJK5M/skIkpCQ+P53K1sXIAWQL
        Sxw+XAxR85ZR4uzyHhaQGmEBD4kdb+exgiREBHYySixePI8ZpIFZIEei43EsRMMvRonp2+4z
        gTSwCehIbP92HMzmFbCTuHbiITuIzSKgIjH/y0lmEFtUIFKi6cRWNogaQYmTM5+ALeMEqn80
        sRPMZhZQl/gz7xIzhC0ucevJfCYIW16ieets5gmMQrOQtM9C0jILScssJC0LGFlWMUqmFhTn
        pucWGxYY5aWW6xUn5haX5qXrJefnbmIEx4SW1g7GPas+6B1iZOJgPMQowcGsJML7Qzw4UYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamQxfvdJc4R2ru
        PMOUulC+Qdu5ZWHqrSar1mUXT3z81H+oRJ5B5bqof7DpkWVBDnOiFhZe6n50V69oyibvwm63
        GX3lk2Lqj8Wm7vpxaKZR600ezk1JdecXb93xMmKf0ozPZ7lif9/t3MdheMPyqO6BZTf+J07l
        0D8+4QajSalEg3bOy9hpewIamzIE3JbaepmcZwhgbMgtSFZT/6Lnms03xaBAndM86q2RbsNS
        1ljm7QIzpr5Q1X2xp1bF8/Mp51qBmU32umnNjOxKay32rur12OOps0vwxLFpxmbRB84rb9c6
        OtP0aN9VZe1pj+zu3kljvT+Dpfpe6yaLv/NNEtiD6z7r9TW6sbwtaH53cqUSS3FGoqEWc1Fx
        IgAQJfif+AIAAA==
X-CMS-MailID: 20211001001415epcas1p40c13dc3fa74b72600b117e1180428f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210917075050epcas1p1962cd1c7c388b20ad17cb841461dae1b
References: <CGME20210917075050epcas1p1962cd1c7c388b20ad17cb841461dae1b@epcas1p1.samsung.com>
        <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
        <a8031e66-77a0-ae9b-d78d-daebc1d7dc47@samsung.com>
        <cfe4476922584dff91bf0fdbec0c0843@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi

On 9/29/21 3:53 PM, Christian Löhle wrote:
> Hey,
> so more generally the timeout here can be 41954 up to 167783 ms.
> Is 42s too low to view it as invalid here?
> Would you prefer the patch exluding the specific timeout values instead of anything above
> 41954?
It's dependent with bus_hz value and div value.
So it's always not 167 or 42 seconds. Your comment is "TMOUT register is invalid".
But it's not invalid value. 
We can set to proper value at TMOUT register during probing or somewhere, according to each boards.

I understood what you want to avoid the long time timeout.
- I think your commit-msg, subject and comment need to describe in more detail. (Not register invalid)
- Not always 42 or 167secs when TMOUT is 0xFFFFFF. In some cases, it's under 100ms even though TMOUT is 0xFFFFFF.

If I misunderstood something, let me know, plz.

Anyway, Thanks for reporting this. 

Best Regards,
Jaehoon Chung

> 
> Regards,
> Christian
> 
> 
> 
> 
> From: Jaehoon Chung <jh80.chung@samsung.com>
> Sent: Friday, September 24, 2021 11:49 AM
> To: Christian Löhle; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org
> Cc: marten.lindahl@axis.com; ulf.hansson@linaro.org
> Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
>     
> Hi,
> 
> On 9/17/21 4:50 PM, Christian Löhle wrote:
>>
>> Set the limit to 1s if the register is at reset value.
>>
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>> ---
>>   drivers/mmc/host/dw_mmc.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 6578cc64ae9e..cd9a6e0a7449 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1983,6 +1983,14 @@ static void dw_mci_set_drto(struct dw_mci *host)
>>         /* add a bit spare time */
>>         drto_ms += 10;
>>   
>> +     /*
>> +      * If TMOUT register still holds the reset value the above calculation
>> +      * would yield a timeout of over 167 seconds, limit it to 1000ms.
>> +      * Normal reads/writes should not take anywhere close to 120s.
>> +      */
>> +     if (drto_ms > 120000)
>> +             drto_ms = 1000;
>> +
> 
> If dtrt_ms is 167sec, it means that bus_hz should be 0 or 1.
> What value is your host->bus_hz?
> 
> Best Regards,
> Jaehoon Chung
> 
>>         spin_lock_irqsave(&host->irq_lock, irqflags);
>>         if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>>                 mod_timer(&host->dto_timer,
>>
> 
>     =
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
> 
> 

