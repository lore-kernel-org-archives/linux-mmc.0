Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B176C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CAC610FC
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Oct 2021 11:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1LeV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Oct 2021 07:34:21 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:62937 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJ1LeV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Oct 2021 07:34:21 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211028113152epoutp0390e4562db0361ba7191579ff0af4aa13~yLnk1nUqP2810328103epoutp03a
        for <linux-mmc@vger.kernel.org>; Thu, 28 Oct 2021 11:31:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211028113152epoutp0390e4562db0361ba7191579ff0af4aa13~yLnk1nUqP2810328103epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635420712;
        bh=qPKVtQyQQkGyv4J6n3UjORyRBa1GV5fSYB+lDWdWH5k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OHl2IbSpuaXPHter8CS2u72OYkpK+GLmNsUR86+v2a88HoBFaKwLqC6j6dkI/Z9md
         U0ZymCN/HRiIKDnDVV10RDGV6rR0ZHb/SFYSckGrE+yEKtarqBo8Z8Ai75P8pp6gSw
         cBwPSxnOGL63mgQdljClabYIvpLxW43BO+m+gsxo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211028113152epcas1p2a3b506539472c1df47cdc2dc2dd1a5ac~yLnkyzaA71580015800epcas1p2q;
        Thu, 28 Oct 2021 11:31:52 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.233]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Hg3LB2Zhpz4x9Q3; Thu, 28 Oct
        2021 11:31:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.8E.09592.22A8A716; Thu, 28 Oct 2021 20:31:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211028113145epcas1p1fc19a8a2beee5ba347c9cffed3f5784f~yLneK7daj0595105951epcas1p16;
        Thu, 28 Oct 2021 11:31:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211028113145epsmtrp20d676e36bdf69bb168a220efb0592a20~yLneS7pud1039910399epsmtrp2Y;
        Thu, 28 Oct 2021 11:31:45 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-dd-617a8a220806
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.70.08738.12A8A716; Thu, 28 Oct 2021 20:31:45 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211028113145epsmtip1e067a91a5fb27c4c7988479d53a96720~yLnd8yVpt2523925239epsmtip1A;
        Thu, 28 Oct 2021 11:31:45 +0000 (GMT)
Subject: Re: [PATCH][next] mmc: dw_mmc: exynos: Fix spelling mistake
 "candiates" -> candidates
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Ian King <colin.i.king@googlemail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <e51c552a-0cab-10c0-1242-b69ea7707863@samsung.com>
Date:   Thu, 28 Oct 2021 20:32:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqXQwfJuU_PPrfeNwh51UkhtVFJzZ71_0R6kcVuSM3bWw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmrq5SV1WiwcIdihY7N/5gtdh6S9pi
        49sfTBabHl9jtbi8aw6bxZH//YwWM87vY7I4vjbcgcNjVkMvm8fTCZPZPe5c28PmsXlJvcfn
        TXIBrFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
        hygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwL9IoTc4tL89L18lJLrAwNDIxM
        gQoTsjMWPfvJUtAvV/Frc3oD40fhLkZODgkBE4mpbz6xdTFycQgJ7GCU2P3jDpTziVHi+I4N
        7BDOZ0aJ7/s2scG1nLzBApHYxSjRM3UPE4TznlHiyOQm1i5GDg5hgQSJ40e5QRpEBCIkPmxa
        zgpSwyzwhFFia/tsdpAEm4COxPZvx5lAbF4BO4nVE36xgNgsAqoSu/79BLNFBSIl/p7cxQpR
        IyhxcuYTsDinQKBE8+bpYL3MAuISt57Mh7LlJba/ncMMskxCoJdDoufrE3aIs10kvjxtZoKw
        hSVeHd8CFZeS+PxuL9Rr1RK7ms9ANXcwStza1gTVYCyxf+lkJpDPmAU0Jdbv0ocIK0rs/D2X
        EWIxn8S7rz1gz0sI8Ep0tAlBlKhIXHr9kglm1d0n/1khbA+Jo8dXME9gVJyF5LVZSN6ZheSd
        WQiLFzCyrGIUSy0ozk1PLTYsMIbHdnJ+7iZGcCLVMt/BOO3tB71DjEwcjIcYJTiYlUR4L88r
        TxTiTUmsrEotyo8vKs1JLT7EaAoM7InMUqLJ+cBUnlcSb2hiaWBiZmRsYmFoZqgkzvtZrjBR
        SCA9sSQ1OzW1ILUIpo+Jg1OqgSnKcOrfnU0LqnprBTS7jn+6cpjrosey+wZ3lxR/i6nbcbBi
        o7+rHrOhW5rojDcPHtvNP3pEzMknNMiu2tfj6oZ9+27vmfI17+kts1WeL38VJYkr+P9byKNY
        wzf71cxDT+/eNRAqMz3Nr7i8d+68qxsKOStmnOn4cenbv3iWOM9LgjfDZf/MOlQqIPZwy6Ut
        U68fmv1bqMh9rfQXo0WdW2+eWP/e51HiFx6Nh/Ktcysb1l27JXFILnvxgeIbQRlrXfNv6cY+
        7ZhwvuJG1nY9eya7mVJaswU+1RdY7pbpNpwkl71tQWV236oz06Yq+eyfKmh5rEVUQm1dDPOZ
        Dxe37AzPULO6l8odcFKOxTR62t0VSizFGYmGWsxFxYkAvm0FVC0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK5iV1Wiwfb94hY7N/5gtdh6S9pi
        49sfTBabHl9jtbi8aw6bxZH//YwWM87vY7I4vjbcgcNjVkMvm8fTCZPZPe5c28PmsXlJvcfn
        TXIBrFFcNimpOZllqUX6dglcGYue/WQp6Jer+LU5vYHxo3AXIyeHhICJxNSTN1i6GLk4hAR2
        MEos/7iDGSIhJfH56VS2LkYOIFtY4vDhYoiat4wSx5tb2UHiwgIJEsePcoOUiwhESLSdPMMK
        UsMs8IRR4v6jT8wQDdcZJY5M7WEBqWIT0JHY/u04E4jNK2AnsXrCL7A4i4CqxK5/P8FsUYFI
        iaYTW9kgagQlTs58AhbnFAiUaN48HayXWUBd4s+8S8wQtrjErSfzoeLyEtvfzmGewCg0C0n7
        LCQts5C0zELSsoCRZRWjZGpBcW56brFhgVFearlecWJucWleul5yfu4mRnDkaGntYNyz6oPe
        IUYmDsZDjBIczEoivJfnlScK8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1
        ILUIJsvEwSnVwKR/cu3ppC/32YsMcqWqRc7q/rnN1Wlz7deWvBVshWZdk/zSRa/nKT3U3nP0
        4qLNtswzBJf08i+bt7/k16HN15jv7uVa4rnna6R19wq3fO28fC85js1KVtOe1N2rq/+6p1xx
        YXTHoY93wlVfyTDeafkTLq+gsmkde35t3mWJLbnxSs2rLu/csWoCh4fiNbXvt/Zu93TObop5
        xFv/nrF2SkITMHqZK/i7diX+zVz8RqH1g17xQ6mA06t5Fvx6dsbyTtJO9SKfQon/MZwP6gpW
        VCp7vPuak5akpzAnp03s1XdGn6XiscIX5l5+oz5JgDduveiMFc91u5nmCi8U63jFF6K7corT
        AaeFAutX9q58qcRSnJFoqMVcVJwIAD4UfmYLAwAA
X-CMS-MailID: 20211028113145epcas1p1fc19a8a2beee5ba347c9cffed3f5784f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211028100054epcas1p2767c48b7e47f6147c590f8a3edfc6b85
References: <20211027130812.426373-1-colin.i.king@gmail.com>
        <CGME20211028100054epcas1p2767c48b7e47f6147c590f8a3edfc6b85@epcas1p2.samsung.com>
        <CAPDyKFqXQwfJuU_PPrfeNwh51UkhtVFJzZ71_0R6kcVuSM3bWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/28/21 7:00 PM, Ulf Hansson wrote:
> On Wed, 27 Oct 2021 at 15:08, Colin Ian King
> <colin.i.king@googlemail.com> wrote:
>>
>> There are several spelling mistakes in variable names and in a dev_warn
>> message. Fix these.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> 
> Applied for next, thanks!

Thanks for fixing them!

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> 
> 
>> ---
>>  drivers/mmc/host/dw_mmc-exynos.c | 20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 1f8a3c0ddfe1..c2dd29ef45c6 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -442,14 +442,14 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
>>         return sample;
>>  }
>>
>> -static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>> +static s8 dw_mci_exynos_get_best_clksmpl(u8 candidates)
>>  {
>>         const u8 iter = 8;
>>         u8 __c;
>>         s8 i, loc = -1;
>>
>>         for (i = 0; i < iter; i++) {
>> -               __c = ror8(candiates, i);
>> +               __c = ror8(candidates, i);
>>                 if ((__c & 0xc7) == 0xc7) {
>>                         loc = i;
>>                         goto out;
>> @@ -457,7 +457,7 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>>         }
>>
>>         for (i = 0; i < iter; i++) {
>> -               __c = ror8(candiates, i);
>> +               __c = ror8(candidates, i);
>>                 if ((__c & 0x83) == 0x83) {
>>                         loc = i;
>>                         goto out;
>> @@ -466,11 +466,11 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>>
>>         /*
>>          * If there is no cadiates value, then it needs to return -EIO.
>> -        * If there are candiates values and don't find bset clk sample value,
>> -        * then use a first candiates clock sample value.
>> +        * If there are candidates values and don't find bset clk sample value,
>> +        * then use a first candidates clock sample value.
>>          */
>>         for (i = 0; i < iter; i++) {
>> -               __c = ror8(candiates, i);
>> +               __c = ror8(candidates, i);
>>                 if ((__c & 0x1) == 0x1) {
>>                         loc = i;
>>                         goto out;
>> @@ -485,7 +485,7 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>>         struct dw_mci *host = slot->host;
>>         struct dw_mci_exynos_priv_data *priv = host->priv;
>>         struct mmc_host *mmc = slot->mmc;
>> -       u8 start_smpl, smpl, candiates = 0;
>> +       u8 start_smpl, smpl, candidates = 0;
>>         s8 found;
>>         int ret = 0;
>>
>> @@ -496,18 +496,18 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>>                 smpl = dw_mci_exynos_move_next_clksmpl(host);
>>
>>                 if (!mmc_send_tuning(mmc, opcode, NULL))
>> -                       candiates |= (1 << smpl);
>> +                       candidates |= (1 << smpl);
>>
>>         } while (start_smpl != smpl);
>>
>> -       found = dw_mci_exynos_get_best_clksmpl(candiates);
>> +       found = dw_mci_exynos_get_best_clksmpl(candidates);
>>         if (found >= 0) {
>>                 dw_mci_exynos_set_clksmpl(host, found);
>>                 priv->tuned_sample = found;
>>         } else {
>>                 ret = -EIO;
>>                 dev_warn(&mmc->class_dev,
>> -                       "There is no candiates value about clksmpl!\n");
>> +                       "There is no candidates value about clksmpl!\n");
>>         }
>>
>>         return ret;
>> --
>> 2.32.0
>>
> 

