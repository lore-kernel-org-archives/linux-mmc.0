Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6102AC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D596103E
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 06:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhJVGzm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 02:55:42 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46784 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhJVGzl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 02:55:41 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211022065322euoutp02a39f851bb55600f9d93a8a65fb4a5f04~wR8s4bRlj1844818448euoutp023
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 06:53:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211022065322euoutp02a39f851bb55600f9d93a8a65fb4a5f04~wR8s4bRlj1844818448euoutp023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634885602;
        bh=/WKuMZXmyN9g3NUoCm7JeLh9gsgC7GPgu9pjRaESrVs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=IXzqAY0/P9JdPo3iOVPdA8JTMz9ZO4qJgV+M0efjFQtsW7usZp3TISprKwfj5I+k2
         h7D5gzUPTBxcoIrwftkqwpW/g5+O1aiXnGJS99M8nrPQY/BFt1spL6SYxQgOMayIx7
         dw0hShiI9dccq0IaQ4KWD+4PZkaXe3+iJlB5Dd0I=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211022065322eucas1p2d1662fc50f2c475b77f812245d0a0081~wR8srIpOM0066500665eucas1p2C;
        Fri, 22 Oct 2021 06:53:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 28.E8.42068.2EF52716; Fri, 22
        Oct 2021 07:53:22 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211022065322eucas1p2f974ab996cb85da62b38f8509f4722d8~wR8sWRYrp0904009040eucas1p2s;
        Fri, 22 Oct 2021 06:53:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211022065322eusmtrp2d84e4c664b45faf173f9fc3e4f310589~wR8sVoBLC0774607746eusmtrp2j;
        Fri, 22 Oct 2021 06:53:22 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-b8-61725fe20243
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.EA.31287.2EF52716; Fri, 22
        Oct 2021 07:53:22 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211022065321eusmtip2654027f06bc38a2088114310e278d67c~wR8r22ofr3071930719eusmtip2w;
        Fri, 22 Oct 2021 06:53:21 +0000 (GMT)
Message-ID: <5d7d4a61-3652-85cc-6edb-e26ef8373c6e@samsung.com>
Date:   Fri, 22 Oct 2021 08:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH] mmc: dw_mmc: exynos: fix the finding clock sample value
Content-Language: en-US
To:     Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, krzysztof.kozlowski@canonical.com,
        christianshewitt@gmail.com, mihailescu2m@gmail.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211022040041.23156-1-jh80.chung@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRTut3t3dx3MblPzZGE0SSjSUhYsUlFImGCxklr0YF3zptKmtatp
        T5ZW1Cgfs7KWsVWQYk2nLHu5UvPRc4ZCmShZSYG0bBXlfGw5r5b/fd93vvP7zjn8SEx8mR9C
        ZmblMNosWi0hhHhDu7sz4qNKS6/63h8mG+otw2Q9o6f4sjrnCE/W6i1GstqLbr6sw6KMJ+RG
        3TlCft/YL5D3vWkk5EW2aiT/WR+q4G8TxqQx6swDjHZl3C5hhq7VINg3QuU/+X0C6dAJkR75
        kUBJ4VHNVVyPhKSYqkLwvtyOOPILwXjXDQFHfiJoNQ9jMy2GigcYV6hE8KW4aZq4ELi7PxM+
        l4iKgy8Nb3EfxqmlUFdlm9bnwbPLg1N6EJUKpisDAh8OoJKhpMnJ92GMCobeQRPPhwOpRCit
        NOOczoK5wTPlIago0Dv1U2/6UTEwYTs73bsY7jorpgYC6jUJZeebcW7sdVBlHRNwOACGOmzT
        eBF47/vCfA2FCD44LAKOnEXQXXAJca610OcYnYwjJyOWQe2DlZycAFdL//B8MlD+0OOcxw3h
        D4aGcoyTRXD6lJhzh4Oxo+ZfbPPrLqwESYyzzmKctb5x1jrG/7lmhFejYCaX1aQzbHQWkxfJ
        0ho2Nys9cne2ph5N/p4Xno5f91DlkCuyBfFI1IKAxCSBoof52bRYlEYfPMRos1XaXDXDtqCF
        JC4JFqXabqvEVDqdw+xlmH2MdqbKI/1CdDxr3EQe3zk/0bPisB8iLMvUtxSWoIinXnG3pjyD
        WHdn/JLhkzTa4C2wr3ENRUVvXf/1bmqs1HPM5NSEpXxLvvnxR08bjZId9YrEkJdoTTzhCTXv
        SDCaH+q1Y9fOtZmG2xyqrsJN1qS6J8kbvCl79bUt/uJoZTy7uV3U5yp/O1fy49348fZBV/P+
        kfDgpKiEW7ItpzWBNa1B+3+nSctUw6/ath44ae1U2nsddrI9PzGg6GCM2b3zQ1jOHV3Kc9mZ
        IF5nbFOs8EhzrEJ6XbF642b94/4ljtuNlhplUeDA2vjMbjZyR9mYVRWh7K91h14Y2ckrUm9f
        MGePfaCvMfSoBGcz6KjlmJal/wI3mrvyrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7qP4osSDR718li8ujWZ2eLGrzZW
        i41vfzBZHPnfz2ixftpPVovja8Md2DxmNfSyeeycdZfd4861PWwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl9FwZBJ7wQ+B
        isPfWhgbGFt4uxg5OSQETCQmzdnF3MXIxSEksJRRYur9z4wQCRmJk9MaWCFsYYk/17rYIIre
        M0qsXfcULMErYCfxfNt1FhCbRUBVYuOKLWwQcUGJkzOfgMVFBZIkPm6YwQxiCwv4SEw48Bas
        l1lAXOLWk/lMILaIgKvExOULWCDixRJd8+YxQSzrZ5Q4MGMP2EVsAoYSXW+7wBZwCthI/N3S
        AzXITKJraxcjhC0vsf3tHOYJjEKzkNwxC8m+WUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0
        L10vOT93EyMw1rYd+7l5B+O8Vx/1DjEycTAeYpTgYFYS4d1dkZ8oxJuSWFmVWpQfX1Sak1p8
        iNEUGBgTmaVEk/OB0Z5XEm9oZmBqaGJmaWBqaWasJM67de6aeCGB9MSS1OzU1ILUIpg+Jg5O
        qQYmv42NmfLVRy9bGuwOCl9V+9lC5bKS0iFvv88bPORN/2k53f8haJ3Rz/nk8/nXrH+64+8r
        XXzAHFK6XzXZ/PNEwQX5WjxSu499PpyzYWmfl5FRxl/PIwKu1t63ery/qLXXcUyy+F/l2/76
        8hSpzwd+B9zIixH/7fH5kwhX9adP1yqjD90LlAhgnLF3a07Kdr/6Nd2nKvdKNnrc5t137UT4
        HDmOnLOvJfYHXprRtc5tV7Rj1lrnXxmXT94ojnGZoXok7WSZU2LExBuGF9pSou87th/04NcN
        yP2iP0tRR0M3UUVc0mM6/xsjwwJuC0Wjr3t8lv+/lCwetXLhztv3hKe6rWDYLKS5gFV7u0X2
        CUslluKMREMt5qLiRAAWkyIKPgMAAA==
X-CMS-MailID: 20211022065322eucas1p2f974ab996cb85da62b38f8509f4722d8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834
References: <CGME20211022035959epcas1p40ccc67175d6a4a22943e5836609fb834@epcas1p4.samsung.com>
        <20211022040041.23156-1-jh80.chung@samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 22.10.2021 06:00, Jaehoon Chung wrote:
> Even though there are candiates value if can't find best value, it's
> returned -EIO. It's not proper behavior.
> If there is not best value, use a first candiate value to work eMMC.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine with all eMMC modules I have on my test systems.

> ---
>   drivers/mmc/host/dw_mmc-exynos.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 0c75810812a0..a475c249c430 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -431,6 +431,7 @@ static inline u8 dw_mci_exynos_move_next_clksmpl(struct dw_mci *host)
>   		clksel = mci_readl(host, CLKSEL);
>   
>   	sample = (clksel + 1) & 0x7;
> +
>   	clksel = SDMMC_CLKSEL_UP_SAMPLE(clksel, sample);
>   
>   	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS7 ||
> @@ -464,6 +465,14 @@ static s8 dw_mci_exynos_get_best_clksmpl(u8 candiates)
>   		}
>   	}
>   
> +	/* Return a first candiates value, if there is some candiates */
> +	for (i = 0; i < iter; i++) {
> +		__c = ror8(candiates, i);
> +		if ((__c & 0x1) == 0x1) {
> +			loc = i;
> +			goto out;
> +		}
> +	}
>   out:
>   	return loc;
>   }
> @@ -493,7 +502,18 @@ static int dw_mci_exynos_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
>   		dw_mci_exynos_set_clksmpl(host, found);
>   		priv->tuned_sample = found;
>   	} else {
> -		ret = -EIO;
> +		/*
> +		 * If there is no cadiates value, then it needs to return -EIO.
> +		 * If there are candiates values and don't find bset clk sample value,
> +		 * then use a first candiates clock sample value.
> +		 */
> +		if (candiates == 0) {
> +			ret = -EIO;
> +			dev_warn(&mmc->class_dev,
> +				"There is no candiates value about clksmpl!\n");
> +		} else {
> +			priv->tuned_sample = dw_mci_exynos_get_clksmpl(host);
> +		}
>   	}
>   
>   	return ret;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

