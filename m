Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E0C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 21:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F5A61207
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Nov 2021 21:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhKJV5F (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Nov 2021 16:57:05 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:19737 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhKJV5E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2021 16:57:04 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211110215414epoutp045d13f6ff4318c30e481eeb728f94968c~2TfrkYUlf0996709967epoutp04Q
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2021 21:54:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211110215414epoutp045d13f6ff4318c30e481eeb728f94968c~2TfrkYUlf0996709967epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636581254;
        bh=MKogoeBYAfnA7niT4r/dmDmsHyMtor8+uLI0V38w2HU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IatAg9DTm/XQPYIgh2SsNtcdXoV7lPrn8Lv0NDkWEhG1FR7+qJREY2/ABrX/+JRZq
         zGJeX1PlNJR+ryA2+2PCtp5dRwIyyJ+/jFfJAEhlurA3/zfJ3OsbYTff4sV1loWjtU
         /csT9wFaYV8zFRgJWscHTJwoqmDO960HgU/j1ql8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211110215414epcas1p1c9404f376a818f070fbce9a3a474a5b2~2TfrGvtef2214222142epcas1p1O;
        Wed, 10 Nov 2021 21:54:14 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.236]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4HqJXJ49wMz4x9Q0; Wed, 10 Nov
        2021 21:54:08 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.3D.09592.08F3C816; Thu, 11 Nov 2021 06:54:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211110215408epcas1p405f1782850905942891ec0699b979338~2TflfbDtK1517315173epcas1p4Y;
        Wed, 10 Nov 2021 21:54:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211110215408epsmtrp14adb68caf61d5edee02c237c4d8ae586~2Tfle1FGI3055130551epsmtrp1S;
        Wed, 10 Nov 2021 21:54:08 +0000 (GMT)
X-AuditID: b6c32a37-2a5ff70000002578-36-618c3f80887e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.85.08738.F7F3C816; Thu, 11 Nov 2021 06:54:07 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211110215407epsmtip187da0a3e8b068a89221612f8db5d4c2b~2TflRsk5Y0909409094epsmtip1k;
        Wed, 10 Nov 2021 21:54:07 +0000 (GMT)
Subject: Re: [PATCH v3] mmc: dw_mmc: Allow lower TMOUT value than maximum
To:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Doug Anderson <dianders@google.com>, kernel@axis.com,
        linux-mmc@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <bdd5aa18-1b3e-9fbf-f7a7-dc95e7ae23d8@samsung.com>
Date:   Thu, 11 Nov 2021 06:54:50 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110110500.4105-1-marten.lindahl@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTQLfBvifRYNJTeYsF21cyWXxqUbU4
        8r+f0WLC1cmMFsfXhjuwelxfF+CxYFOpx51re9g8Pm+SC2CJyrbJSE1MSS1SSM1Lzk/JzEu3
        VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqppFCWmFMKFApILC5W0rezKcovLUlV
        yMgvLrFVSi1IySkwLdArTswtLs1L18tLLbEyNDAwMgUqTMjOOLJvKmvBbpGKJ/dusTYwThbo
        YuTkkBAwkfi2fgcriC0ksINR4v7xgi5GLiD7E6PEylkL2SGcz4wS35tuMncxcoB1tD6KhIjv
        YpTYebORBcJ5zyixaMVbNpBRwgKeEtO2XmAGsUUEUiUmb9/OBGIzC4RKHNm/ghHEZhPQkdj+
        7ThYnFfATuJ29wqwXhYBVYnZDxaC2aICkRJ/T+5ihagRlDg58wkLiM0pYCMxfecxVoiZ4hK3
        nsyHmi8v0bx1NjPEax/ZJY60KkDYLhIPF71gg7CFJV4d38IOYUtJvOxvg7KrJXY1n2EGeUZC
        oINR4ta2JiaIhLHE/qWTmUC+ZxbQlFi/Sx8irCix8/dcRoi9fBLvvvawQgKIV6KjTQiiREXi
        0uuXTDCr7j75zwphe0jMuLWOeQKj4iwkn81C8s0sJN/MQli8gJFlFaNYakFxbnpqsWGBMTyu
        k/NzNzGCU6OW+Q7GaW8/6B1iZOJgPMQowcGsJMJryNKTKMSbklhZlVqUH19UmpNafIjRFBjW
        E5mlRJPzgck5ryTe0MTSwMTMyNjEwtDMUEmc97NcYaKQQHpiSWp2ampBahFMHxMHp1QDUxCf
        2H4vp8SjOQt5Lv5d/2z5n38Oa6ZMmCWysTmnt0Lg3SKzlvr7L9hvX09bI1nk/cPq5811zAJz
        Hj9exHxjyqHy75s6cxZXKt+5ukm9WHtPb27E75Z9fkZPmt8u6tX//Dr3e/e3rUx3bk58dOvH
        d6GD3ns6BVib7lbEntnwLFWHZZHDQWHXA++/nZy27f2zvQp54oKZm7mtHVfeTpP9M+GDzV+9
        8JArn4sOybXLHefdW1Jlc+LEa4meI0ed6kU5z3gr7mINW9hz9dS2kPvl3CtLM/1XnWc+epX/
        fJ7K0+M+nsKB3Cc/8rntCazwFbt2ciK37OqXpzOFrl5vkLrzdGvX/4rpLs9lFY5xLr/3pN1G
        iaU4I9FQi7moOBEADkpZ9RYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnG69fU+iwex9FhYLtq9ksvjUompx
        5H8/o8WEq5MZLY6vDXdg9bi+LsBjwaZSjzvX9rB5fN4kF8ASxWWTkpqTWZZapG+XwJVxZN9U
        1oLdIhVP7t1ibWCcLNDFyMEhIWAi0foosouRi0NIYAejxKpvX5m7GDmB4lISn59OZYOoEZY4
        fLgYouYto8TsK5cYQWqEBTwlpm29AFYvIpAqcW/vZnYQm1kgVOLVnzfsEA39jBKT35wHK2IT
        0JHY/u04E4jNK2Ancbt7BRuIzSKgKjH7wUIwW1QgUqLpxFY2iBpBiZMzn7CA2JwCNhLTdx5j
        hVigLvFn3iVmCFtc4taT+UwQtrxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKsYpRMLSjOTc8t
        Niwwykst1ytOzC0uzUvXS87P3cQIjgctrR2Me1Z90DvEyMTBeIhRgoNZSYTXkKUnUYg3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamta/7Tb943TG4l9s6
        c4+BbnxBcrJEcdzV9R6cE9ayWy/yZFo9c7buppZzl6ruSX1VUvNs/OLb21S/ziNj6hQz/ejM
        e7vj0hn/aVXFvNYTnrlp1vOX3ySit2fpJ0nNjhKLFVhXN8PpbPLn9tSp37sDljq6qr44f3pH
        zVfH0saTeX7fzvWbtmrteGe5oOL87yVLZz7LZv3mkLGZ9VLlzXnlk5S2ONaFOBVPu2pmH9kx
        +d7lKR13pnO9LipbJ+42cdIE/pi7UckvM2PD5B79sl9/pc3ROLDzypKZfEb35vNEztiRpOtm
        tKrvBd/rGe6uwnEzHDrWbdmxKVskdRFLUcPWJU4xC1fk6P0wucE0S6pLiaU4I9FQi7moOBEA
        jJnZcfYCAAA=
X-CMS-MailID: 20211110215408epcas1p405f1782850905942891ec0699b979338
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211110110553epcas1p27c5a3a2ff49282ae29895bcd30f922c3
References: <CGME20211110110553epcas1p27c5a3a2ff49282ae29895bcd30f922c3@epcas1p2.samsung.com>
        <20211110110500.4105-1-marten.lindahl@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Marten,

On 11/10/21 8:05 PM, Mårten Lindahl wrote:
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
>  drivers/mmc/host/dw_mmc.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..637ae2aea9fa 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1283,6 +1283,32 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
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
> +	dev_dbg(host->dev, "timeout_ns: %u => TMOUT[31:8]: 0x%06x",
> +		timeout_ns, tmout >> 8);
> +}
> +
>  static void __dw_mci_start_request(struct dw_mci *host,
>  				   struct dw_mci_slot *slot,
>  				   struct mmc_command *cmd)
> @@ -1303,7 +1329,7 @@ static void __dw_mci_start_request(struct dw_mci *host,
>  
>  	data = cmd->data;
>  	if (data) {
> -		mci_writel(host, TMOUT, 0xFFFFFFFF);
> +		dw_mci_set_data_timeout(host, data->timeout_ns);
>  		mci_writel(host, BYTCNT, data->blksz*data->blocks);
>  		mci_writel(host, BLKSIZ, data->blksz);
>  	}
> 

