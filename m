Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C179CC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Nov 2021 23:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKVXol (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Nov 2021 18:44:41 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30807 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhKVXol (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Nov 2021 18:44:41 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211122234132epoutp01ddfa5ac016b55972deb1e95b5c9f3f40~6AsysIozt0801508015epoutp01N
        for <linux-mmc@vger.kernel.org>; Mon, 22 Nov 2021 23:41:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211122234132epoutp01ddfa5ac016b55972deb1e95b5c9f3f40~6AsysIozt0801508015epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637624492;
        bh=tuKMT+kLOtoxE6UHM/nHKWNbO/BByGjp9p69ZJ0VNpI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OYUYeHJGvpDdKJSX2fW0ZCnSHkohSd9pSQFFP8I+t6SGHE3FYSCikHcvx+tf+uydt
         vKzPXlvXKSXgXEetYX11j+Iep1SgkFCoSdyRY6GGYwqKDolmPj9bWW9WSVAex/P7hl
         RKg6HUXHPgCGXTCdIcwL7Tr4w1bJkDeoF/mOGIKc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211122234132epcas1p163076180167ec0a17ec367a6d61c2810~6AsyefPnL1397113971epcas1p1h;
        Mon, 22 Nov 2021 23:41:32 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.233]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HykLY023Qz4x9Py; Mon, 22 Nov
        2021 23:41:25 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.96.28648.D9A2C916; Tue, 23 Nov 2021 08:41:17 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211122234117epcas1p24795795f7c4bb1628930d81ac6257b71~6AskugnOs2243922439epcas1p2U;
        Mon, 22 Nov 2021 23:41:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211122234117epsmtrp257dc4b1bda5c2cfe43f6fb9a85fd6893~6AsktyDMu0256802568epsmtrp20;
        Mon, 22 Nov 2021 23:41:17 +0000 (GMT)
X-AuditID: b6c32a39-003ff70000006fe8-78-619c2a9dd1bf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.2E.08738.D9A2C916; Tue, 23 Nov 2021 08:41:17 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211122234117epsmtip2be0cac6cfef54f4c10ee9d86d50b5d97~6Askjn1jl2918629186epsmtip2A;
        Mon, 22 Nov 2021 23:41:17 +0000 (GMT)
Subject: Re: [PATCH v6] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <62e60712-2bc0-fbbd-f6bc-786c020c1947@samsung.com>
Date:   Tue, 23 Nov 2021 08:41:59 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211119155337.14341-1-marten.lindahl@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTT3eu1pxEg3nvrC0WbF/JZPGpRdXi
        yP9+RosJVyczWhxfG+7A6nF9XYDHgk2lHneu7WHz+LxJLoAlKtsmIzUxJbVIITUvOT8lMy/d
        Vsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2inkkJZYk4pUCggsbhYSd/Opii/tCRV
        ISO/uMRWKbUgJafAtECvODG3uDQvXS8vtcTK0MDAyBSoMCE74/Knf4wFG8QqTq/7xNzAeFaw
        i5GTQ0LARGLR9s1sXYxcHEICOxgl1kw8wgKSEBL4xCixvk8Nwv7MKNG9PQKm4feVF0wQDbsY
        JY693Q3lvGeUeD33ARtIlbCAp8THVVMYQWwRgVSJydu3M4HYzAKhEkf2rwCLswnoSGz/dhws
        zitgJ7HjxwF2EJtFQFViavc9sBpRgUiJ+z+Ws0PUCEqcnPkE7DpOAVuJx883Qs0Ul7j1ZD6U
        LS/RvHU2M8hBEgIf2SX+fTjIAnG2i8SZV2ehbGGJV8e3sEPYUhKf3+1lg2hYxihx5/ZfKGc9
        o8SB7UvYIKqMJfYvnQy0ggNohabE+l36EGFFiZ2/5zJCbOaTePe1hxWkREKAV6KjTQiiREXi
        0uuXTDC77j75D1XiIfF0gsUERsVZSF6bheSdWUjemYWwdwEjyypGsdSC4tz01GLDAlN4ZCfn
        525iBCdHLcsdjNPfftA7xMjEwXiIUYKDWUmE99qS2YlCvCmJlVWpRfnxRaU5qcWHGE2BgT2R
        WUo0OR+YnvNK4g1NLA1MzIyMTSwMzQyVxHmf+09PFBJITyxJzU5NLUgtgulj4uCUamDqNvi/
        Iq0o7867rGO8TpuqHr2Qeek98Tpn6kyun8wevNd2Xjeu1btzMfTvnegj+/44KlW2pOgb75WZ
        tudlsW/F2eV1UmFrsit1NU96x1ZYPug1fvzRwdPbadvWo3UzzrPyu3PIHvRYuvPR9K2pztn/
        71Wpz8w/ZNHuyFErltP9Yk95wL/b202Zrtv/Xl984zZPweWJHz+/f/XeX7dIdtddxrO8HAs3
        THER52o81a3P+nza3znsdj1L7vWr3beudm7oLEyP+buDW2zHhfrWxncbBE0dGlSsP0fJs0hb
        zAtL2lHMz2rDwsLwOPqX2k1n4d3qDTemHT77fm0QU87BdeHOJ3z9lSbHLvn2lmF6+wwlluKM
        REMt5qLiRABxK5MaFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvO5crTmJBvMWyFss2L6SyeJTi6rF
        kf/9jBYTrk5mtDi+NtyB1eP6ugCPBZtKPe5c28Pm8XmTXABLFJdNSmpOZllqkb5dAlfG5U//
        GAs2iFWcXveJuYHxrGAXIyeHhICJxO8rL5i6GLk4hAR2MEr8OjufHSIhJfH56VS2LkYOIFtY
        4vDhYoiat4wSLxa9YwKpERbwlPi4agojiC0ikCpxb+9msF5mgVCJV3/esEM0TGCU2LpxJxtI
        gk1AR2L7t+NgzbwCdhI7fhwAa2ARUJWY2n0PbJCoQKTEuuPL2CFqBCVOznzCAmJzCthKPH6+
        kQligbrEn3mXmCFscYlbT+ZDxeUlmrfOZp7AKDQLSfssJC2zkLTMQtKygJFlFaNkakFxbnpu
        sWGBUV5quV5xYm5xaV66XnJ+7iZGcERoae1g3LPqg94hRiYOxkOMEhzMSiK815bMThTiTUms
        rEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBaeHXbVMiToh/M51t
        kPbDQCPLan9/zSsJvhmOQQdkTv01fyXKtDtwwTn1i91TQwJSz5hVBLxR/qns3JrHmq9x4EJs
        yQQn77WZqQvOHbc7zyHk3mX4S6CIrWfqkdTJteatO+M2Wyx7G5bbtnbK8a2+56b9XlX3MIbl
        8YppG8SK2Ca9ubdXyv3hemGRnJf1+plPnXUKU97PXNnxbtEpfaFVBRIzDvoaLs7sk0sROP+A
        +XtWzHmrn7fKYxa6ncsp+Cf12bTo16nl5YU7pqncXbps7Zn4Cf7Nt54efXD6W8C758r8V/Ju
        bJgp4niUR/n8xw2HejMNK6wSuTOnsdY91e714Xw5w+gb2zc2pxSRxPiwR0osxRmJhlrMRcWJ
        AOSEEvX3AgAA
X-CMS-MailID: 20211122234117epcas1p24795795f7c4bb1628930d81ac6257b71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211119155345epcas1p39cc745b0452320def8da7b2c484a9aa5
References: <CGME20211119155345epcas1p39cc745b0452320def8da7b2c484a9aa5@epcas1p3.samsung.com>
        <20211119155337.14341-1-marten.lindahl@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/20/21 12:53 AM, Mårten Lindahl wrote:
> The TMOUT register is always set with a full value for every transfer,
> which (with a 200MHz clock) will give a full DRTO of ~84 milliseconds.
> This is normally good enough to complete the request, but setting a full
> value makes it impossible to test shorter timeouts, when for example
> testing data read times on different SD cards.
> 
> Add a function to set any value smaller than the maximum of 0xFFFFFF.
> 
> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> 
> v2:
>  - Calculate new value before checking boundaries
>  - Include CLKDIV register to get proper value
> 
> v3:
>  - Use 'if-else' instead of 'goto'
>  - Don't touch response field when maximize data field
> 
> v4:
>  - Prevent 32bit divider overflow by splitting the operation
>  - Changed %06x to %#08x as suggested by Doug
>  - Rephrased commit msg as suggested by Doug
> 
> v5:
>  - Use u32 type for CPU reg access
>  - Make tmp 64bit to handle INT_MAX parameters
> 
> v6:
>  - Use u64 type for tmp
> 
>  drivers/mmc/host/dw_mmc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index d977f34f6b55..f310d9438dff 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1283,6 +1283,33 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  	mci_writel(host, CTYPE, (slot->ctype << slot->id));
>  }
>  
> +static void dw_mci_set_data_timeout(struct dw_mci *host,
> +				    unsigned int timeout_ns)
> +{
> +	u32 clk_div, tmout;
> +	u64 tmp;
> +
> +	clk_div = (mci_readl(host, CLKDIV) & 0xFF) * 2;
> +	if (clk_div == 0)
> +		clk_div = 1;
> +
> +	tmp = DIV_ROUND_UP_ULL((u64)timeout_ns * host->bus_hz, NSEC_PER_SEC);
> +	tmp = DIV_ROUND_UP_ULL(tmp, clk_div);
> +
> +	/* TMOUT[7:0] (RESPONSE_TIMEOUT) */
> +	tmout = 0xFF; /* Set maximum */
> +
> +	/* TMOUT[31:8] (DATA_TIMEOUT) */
> +	if (!tmp || tmp > 0xFFFFFF)
> +		tmout |= (0xFFFFFF << 8);
> +	else
> +		tmout |= (tmp & 0xFFFFFF) << 8;
> +
> +	mci_writel(host, TMOUT, tmout);
> +	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%#08x",
> +		timeout_ns, tmout >> 8);
> +}
> +
>  static void __dw_mci_start_request(struct dw_mci *host,
>  				   struct dw_mci_slot *slot,
>  				   struct mmc_command *cmd)
> @@ -1303,7 +1330,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  
>  	data = cmd->data;
>  	if (data) {
> -		mci_writel(host, TMOUT, 0xFFFFFFFF);
> +		dw_mci_set_data_timeout(host, data->timeout_ns);
>  		mci_writel(host, BYTCNT, data->blksz*data->blocks);
>  		mci_writel(host, BLKSIZ, data->blksz);
>  	}
> 

