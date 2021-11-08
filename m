Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB89C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 23:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9946761152
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Nov 2021 23:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240834AbhKHXsu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:48:50 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:28184 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240337AbhKHXsu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2021 18:48:50 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211108234603epoutp0486c20195e005889f4f3aee80491f1239~1tuu4xSpL0251202512epoutp04U
        for <linux-mmc@vger.kernel.org>; Mon,  8 Nov 2021 23:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211108234603epoutp0486c20195e005889f4f3aee80491f1239~1tuu4xSpL0251202512epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636415163;
        bh=vsXyHaM60xBet/DDUPePxOVW6/iqlOZUcZgK/BKpyI4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=nacP915c30NnUvwcJMLeLgSWpWQH1Ch07EtdBUtXDDomRZm1l58SHv6fND9VrqMTM
         /3oQ/Abc4e3/odM2lCykrjHU0mIEGG+vHRPGsNssoEKPkMlduZvxYjmybTXW7FHs8m
         q/SEWX1r2SPozy+3mdJWqMbQ8xSo+PoWAhpHpULA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211108234602epcas1p3c19da61412b0b8714b550bd043d842fd~1tuurXSt10578705787epcas1p3w;
        Mon,  8 Nov 2021 23:46:02 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Hp7686g37z4x9QT; Mon,  8 Nov
        2021 23:45:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.56.21932.3A6B9816; Tue,  9 Nov 2021 08:45:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211108234539epcas1p3fb6c2984ea5268c8b78d4390a05c4e8f~1tuY90uRC0576005760epcas1p3N;
        Mon,  8 Nov 2021 23:45:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211108234539epsmtrp1844d48f9feea31f581bf71d0130dc975~1tuY8Mzgp0887408874epsmtrp1E;
        Mon,  8 Nov 2021 23:45:39 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-fb-6189b6a372d2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.D7.29871.3A6B9816; Tue,  9 Nov 2021 08:45:39 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211108234539epsmtip2055e443235fdcbe58acb78bbe5af7284~1tuYqAsus0563605636epsmtip2W;
        Mon,  8 Nov 2021 23:45:39 +0000 (GMT)
Subject: Re: [PATCH v2] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <9cbaceb0-e238-490f-477f-5d0615401a45@samsung.com>
Date:   Tue, 9 Nov 2021 08:46:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108113637.3699-1-marten.lindahl@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTT3fJts5Eg+XtzBYLtq9ksvjUompx
        5H8/o8WEq5MZLY6vDXdg9bi+LsBjwaZSjzvX9rB5fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZdu
        q+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RTSaEsMacUKBSQWFyspG9nU5RfWpKq
        kJFfXGKrlFqQklNgWqBXnJhbXJqXrpeXWmJlaGBgZApUmJCd8e/XW5aCVvGKbx9usjQwNgh1
        MXJySAiYSGx71cbYxcjFISSwg1Hi86stzCAJIYFPjBJt3cUQiW+MEmfnfmSE6Vh8cgc7RNFe
        RomfDQoQRe8ZJb5s3MYCkhAW8JRYseojK4gtIpAqMXn7diYQm1kgVOLI/hVgg9gEdCS2fzsO
        FOfg4BWwkzh60hgkzCKgInF91xqwclGBSIm/J3eBjeEVEJQ4OfMJ2HhOARuJi5/WM0KMFJe4
        9WQ+1Hh5ieats5lB7pEQ+Mgu8f74MjaIo10kOvqXs0LYwhKvjm9hh7ClJF72t0HZ1RK7ms9A
        NXcwStza1sQEkTCW2L90MtihzAKaEut36UOEFSV2/p4LdQSfxLuvPawgJRICvBIdbdDQVZG4
        9PolE8yqu0/+Q53gIbH+1SuWCYyKs5C8NgvJO7OQvDMLYfECRpZVjGKpBcW56anFhgUm8LhO
        zs/dxAhOjVoWOxjnvv2gd4iRiYPxEKMEB7OSCO+9ox2JQrwpiZVVqUX58UWlOanFhxhNgYE9
        kVlKNDkfmJzzSuINTSwNTMyMjE0sDM0MlcR5P8sVJgoJpCeWpGanphakFsH0MXFwSjUw8ZgY
        1O1X3JbsuzdK/Kr7t9uPg1bs11Kv3+Vv8NhUf8mZCz5HPyrc/7PP+cb28+86LN1lbE2+fPrS
        eva/V9bNf+eqazZNWjmvVCDR4n7xe4kPgu+2WvWJaOryus4vyNnx8PiO5ppNLz+qHilVCfgV
        p6FnVsZpU2RTL5qxc86nV9mbpu/7+d37HRvXUX6TKUtbd7XOF3pYtU34ypeyjENFE79vfFKl
        oMUlfld4uf8lVq+6fK4nmd/Efs9Y9jlP6dFm6fXppQe03fhyr5d1XPxRq3tmYRqPur/PythV
        v1X2VjX0nbHL2p768Vz1+WP8pyZ9qtrxTtLtYWHNtAePkzQmLlY6V1HUGHBPev0uUwfhGCWW
        4oxEQy3mouJEAMzq4SgWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO7ibZ2JBk+vSlss2L6SyeJTi6rF
        kf/9jBYTrk5mtDi+NtyB1eP6ugCPBZtKPe5c28Pm8XmTXABLFJdNSmpOZllqkb5dAlfGv19v
        WQpaxSu+fbjJ0sDYINTFyMkhIWAisfjkDvYuRi4OIYHdjBK9cz8zQiSkJD4/ncrWxcgBZAtL
        HD5cDFHzllHi67TZYDXCAp4SK1Z9ZAWxRQRSJe7t3cwOYjMLhEq8+vMGamg/o8THG41gCTYB
        HYnt344zgQzlFbCTOHrSGCTMIqAicX3XGiYQW1QgUqLpxFY2EJtXQFDi5MwnLCA2p4CNxMVP
        6xkh5qtL/Jl3iRnCFpe49WQ+E4QtL9G8dTbzBEahWUjaZyFpmYWkZRaSlgWMLKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYLjQUtzB+P2VR/0DjEycTAeYpTgYFYS4b13tCNRiDcl
        sbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqatMXce1JXftXrI
        t/6RPUfduedcHWw22yx50uV5jI4oBfOcin5j7pO7hXHak/WpvxQ2Lffm23tNnfFdlJX+ieAd
        Z5OUO250m38/8qGdle00j6N2lGhXutfuK5W2f0ufvBGxPrb5w9zziy/Wfe/atPfTUXvWzreh
        l1d8L/NlnqpV3pS8+JzxwdqEihr/62LVZ44q+s6Y6K+mVB0o907ET3wNV+2tL0sW7vnYeoCh
        mdlv7f+De3smGzz76ropr2WO5M9JXsZ6E+cvn1DGF9F42S+Kh8P4cVyyz439pv3vpY7xfHxz
        /bn9ZntjZkVfgaCGPg/OiPqH+4TPs6ldnrQmO8G4NV/znYVH1S1DIZZTbkosxRmJhlrMRcWJ
        AGej/JH2AgAA
X-CMS-MailID: 20211108234539epcas1p3fb6c2984ea5268c8b78d4390a05c4e8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211108113655epcas1p1b3621396703dffc16f0bca0d5f108c18
References: <CGME20211108113655epcas1p1b3621396703dffc16f0bca0d5f108c18@epcas1p1.samsung.com>
        <20211108113637.3699-1-marten.lindahl@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Marten,

On 11/8/21 8:36 PM, Mårten Lindahl wrote:
> The TMOUT register is always set with a full value for every transfer,
> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> Since the software dto_timer acts as a backup in cases when this timeout
> is not long enough, it is normally not a problem. But setting a full
> value makes it impossible to test shorter timeouts, when for example
> testing data read times on different SD cards.
> 
> Add a function to set any value smaller than the maximum of 0xFFFFFF.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> ---
> 
> v2:
>  - Calculate new value before checking boundaries
>  - Include CLKDIV register to get proper value
> 
>  drivers/mmc/host/dw_mmc.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..6edd7a231448 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1283,6 +1283,36 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  	mci_writel(host, CTYPE, (slot->ctype << slot->id));
>  }
>  
> +static void dw_mci_set_data_timeout(struct dw_mci *host,
> +				    unsigned int timeout_ns)
> +{
> +	unsigned int clk_div, tmp, tmout;
> +
> +	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> +	if (clk_div == 0)
> +		clk_div = 1;
> +
> +	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz,
> +			       NSEC_PER_SEC * clk_div);
> +
> +	if (!tmp || tmp > 0xFFFFFF) {
> +		/* Set maximum */

"Set maximum value about all Timeout"?

> +		tmout = 0xFFFFFFFF;
> +		goto tmout_done;
> +	}

It doesn't need to use "goto". Instead, if-else can be used.

> +
> +	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> +	tmout = 0xFF; /* Set maximum */

To prevent a confusion, how about add "Set a maximum response timeout"
And this line can be removed.

> +
> +	/* TMOUT[31:8] (DATA_TIMEOUT) */
> +	tmout |= (tmp & 0xFFFFFF) << 8;

tmout = (0xFF | ((tmp & 0xFFFFFF) << 8));

The entire code can be below

if (!tmp || ....)
	tmout = 0xFFFFFFFF;
else 
	tmout = (0xFF | ((tmp & 0xFFFFFF) << 8));

writel(TMOUT, ...)

How about this?

Best Regards,
Jaehoon Chung

> +
> +tmout_done:
> +	mci_writel(host, TMOUT, tmout);
> +	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
> +		timeout_ns, tmout >> 8);
> +}
> +
>  static void __dw_mci_start_request(struct dw_mci *host,
>  				   struct dw_mci_slot *slot,
>  				   struct mmc_command *cmd)
> @@ -1303,7 +1333,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  
>  	data = cmd->data;
>  	if (data) {
> -		mci_writel(host, TMOUT, 0xFFFFFFFF);
> +		dw_mci_set_data_timeout(host, data->timeout_ns);
>  		mci_writel(host, BYTCNT, data->blksz*data->blocks);
>  		mci_writel(host, BLKSIZ, data->blksz);
>  	}
> 

