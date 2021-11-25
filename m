Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662D8C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 23:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347146AbhKYXlq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 18:41:46 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53550 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhKYXjp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 18:39:45 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211125233632epoutp018f47bbc5c7ce61f7466f39dd2215147e~67kRlNQuh1644716447epoutp01k
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 23:36:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211125233632epoutp018f47bbc5c7ce61f7466f39dd2215147e~67kRlNQuh1644716447epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637883392;
        bh=wqQlhFmow9NJsLwo4Hs+yu4XE4eS1ibv8LCu/XI780s=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NyMdrsaAZ33U3c+Nhsf93sUpQ7w5HfgQrWJZGo8pubRNHysmFGk/EScBDCTs01roC
         EBdpLxFqsfyIUsgvjA1HxZ4V0l4nsxHPWcGFpjSgQSkoPeW7DPXsvec8lIhpuH7ZnO
         0IsEomnAtL7KXIXsLuevMmOKB9QBA3txftRUO694=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211125233631epcas1p4fe598af73a061d367f82fc54c49a7ffa~67kRN_yGy0653206532epcas1p4F;
        Thu, 25 Nov 2021 23:36:31 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.235]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4J0Z5S4cmPz4x9Pw; Thu, 25 Nov
        2021 23:36:28 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0F.F8.64085.22E10A16; Fri, 26 Nov 2021 08:37:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20211125233619epcas1p17cb72c8dea2b762ad0fc649d56907d09~67kGDQNs71069210692epcas1p1y;
        Thu, 25 Nov 2021 23:36:19 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211125233619epsmtrp28607e7b99ef69e0b364794737571bcb0~67kGCat2M2269222692epsmtrp2e;
        Thu, 25 Nov 2021 23:36:19 +0000 (GMT)
X-AuditID: b6c32a35-9c3ff7000000fa55-8d-61a01e22f211
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9B.4A.08738.3FD10A16; Fri, 26 Nov 2021 08:36:19 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211125233619epsmtip2def06e7e7c0fd3cc103deac0bb12657f~67kFznxZS1071110711epsmtip2Y;
        Thu, 25 Nov 2021 23:36:19 +0000 (GMT)
Subject: Re: [PATCH 1/4] mmc: dw_mmc: add common capabilities to replace
 caps
To:     John Keeping <john@metanate.com>, linux-mmc@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <ee596652-68f8-ddd4-4dcd-1bdb3a8a056b@samsung.com>
Date:   Fri, 26 Nov 2021 08:37:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124184603.3897245-2-john@metanate.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmvq6S3IJEg3v97Bb/H71mtXi/aQqr
        xca3P5gsNj2+xmpxedccNosj//sZLT49+M9sMeP8PiaL42vDHTg9ZjX0snncubaHzWPzknqP
        TVNusXpsvzaP2ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJucWl
        eel6eaklVoYGBkamQIUJ2RldR1eyFjwRqNjY/oW5gfEabxcjJ4eEgInE7x+b2LsYuTiEBHYw
        Sky6spIZwvnEKPHnYx8jSJWQwGdGiRuXk2A6jh1cxwJRtItR4tf+bjYI5z2jxP0ja1hBqoQF
        /CUm7v7OAmKLCNhLdL14zwZiMwtMYZLYsN8dxGYT0JHY/u04E4jNK2An8edPF1g9i4CqxP15
        z9hBbFGBSIn7P5azQ9QISpyc+QSshlPAUmLO/zUsEDPFJW49mc8EYctLbH87B+wFCYGlHBIf
        195ihzjbRWLy6zXMELawxKvjW6DiUhKf3+1lg2hYxihx5/ZfKGc9o8SB7UvYIKqMJfYvnQy0
        ggNohabE+l36EGFFiZ2/5zJCbOaTePe1hxWkREKAV6KjTQiiREXi0uuXTDC77j75zwphe0jM
        X9DCMoFRcRaS32Yh+WcWkn9mISxewMiyilEstaA4Nz212LDAEB7dyfm5mxjBCVbLdAfjxLcf
        9A4xMnEwHmKU4GBWEuF1DpyfKMSbklhZlVqUH19UmpNafIjRFBjaE5mlRJPzgSk+ryTe0MTS
        wMTMyNjEwtDMUEmc94X/9EQhgfTEktTs1NSC1CKYPiYOTqkGJq9/FlrBhnucrxZNtt1vbraY
        eZn/w5U87M0PNIp9LqaIiHs/7v0vOOV8QpbylplL4vdFXg+UuLpBKfZWTHXWxN0rp6+xXdcq
        97/5QtUL1zt+GbK/1ey0NK7Ux5vXCHkp3238cEWDa91DdouVv6J1nT3Nhe9YVfZlrl/95Fzj
        dMkFDudd+NYw5wkdSZE0KJb2Zl0XWvF1l8y+mvaW/vuPfLn+ar+9JvuFReX719QDE3ZOilba
        Hn61hzNrz+Rb2Wf2LdthavNJZvXJzwoHy606YrJ2f94xe2VndFz0fov93U6b+hb75crGes8V
        vL68IXD1wvjAfiGxGC25W09du8/5p/++PH9Ko8IdKZWVM8UnKbEUZyQaajEXFScCAMIDvyg5
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphkeLIzCtJLcpLzFFi42LZdlhJXvez7IJEg29LlCz+P3rNavF+0xRW
        i41vfzBZbHp8jdXi8q45bBZH/vczWnx68J/ZYsb5fUwWx9eGO3B6zGroZfO4c20Pm8fmJfUe
        m6bcYvXYfm0es8fnTXIBbFFcNimpOZllqUX6dglcGV1HV7IWPBGo2Nj+hbmB8RpvFyMnh4SA
        icSxg+tYuhi5OIQEdjBKLN3WxwyRkJL4/HQqWxcjB5AtLHH4cDFIWEjgLaPEvC8lILawgK/E
        7tu7mEBsEQF7ia4X79lA5jALTGOS+Lr2MRPE0N2MEhNPXmYBqWIT0JHY/u04WAevgJ3Enz9d
        YHEWAVWJ+/OesYPYogKREuuOL2OHqBGUODnzCVgNp4ClxJz/a8BsZgF1iT/zLjFD2OISt57M
        Z4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS9
        5PzcTYzgiNLS2sG4Z9UHvUOMTByMhxglOJiVRHidA+cnCvGmJFZWpRblxxeV5qQWH2KU5mBR
        Eue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cC0yi1X7370Q4Ez5oLmClX3vnJPrs7ts8vLnyHq
        sObEJLUFwSa9Ud8YeCrCD3dtq865eqeks4WvbvLMKyJmMa+CvFb//brSirdPTfY9/8s4bTYN
        V7c8Vpc3kR/2m8ml3DJNn6x33z37II9i28HnqhNnxsoteG3bsWzf+mnL9kRe13OerBVQNLHr
        vfeaW+t/yazjKs7bLDvfdGb5Wy2eyWZn1z1KE72mz9ufuk3BKS6e+/87hXsr5dm+XH8V4btr
        wasba6tt5ZLbffu/2e70vv64XW9C8PG8C8cd+Kwubpe8OyP7j6eilLmICkv3Annt6av2mQTc
        zkjLz/h9uzlrq6ISj6CS6fwTk1abnk8rrVBiKc5INNRiLipOBAA5C3u9FwMAAA==
X-CMS-MailID: 20211125233619epcas1p17cb72c8dea2b762ad0fc649d56907d09
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211124184620epcas1p4aab50870ced2308d40873bd8c7de32d3
References: <20211124184603.3897245-1-john@metanate.com>
        <CGME20211124184620epcas1p4aab50870ced2308d40873bd8c7de32d3@epcas1p4.samsung.com>
        <20211124184603.3897245-2-john@metanate.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/25/21 3:45 AM, John Keeping wrote:
> The caps field depends on the mshcN alias ID but for some devices this
> is unnecessary as the capabilities are the same for all instances
> sharing the same compatible.
> 
> Add a common_caps field for this case which updates the host's
> capabilities without needing the mshcN alias ID.
> 
> Signed-off-by: John Keeping <john@metanate.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 3 +++
>  drivers/mmc/host/dw_mmc.h | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 195f2b2434b0..f2a14a434bef 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2856,6 +2856,9 @@ static int dw_mci_init_slot_caps(struct dw_mci_slot *slot)
>  	if (host->pdata->pm_caps)
>  		mmc->pm_caps = host->pdata->pm_caps;
>  
> +	if (drv_data)
> +		mmc->caps |= drv_data->common_caps;
> +
>  	if (host->dev->of_node) {
>  		ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
>  		if (ctrl_id < 0)
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index ce05d81477d9..771d5afa3136 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -550,6 +550,8 @@ struct dw_mci_slot {
>   * dw_mci driver data - dw-mshc implementation specific driver data.
>   * @caps: mmc subsystem specified capabilities of the controller(s).
>   * @num_caps: number of capabilities specified by @caps.
> + * @common_caps: mmc subsystem specified capabilities applicable to all of
> + *	the controllers
>   * @init: early implementation specific initialization.
>   * @set_ios: handle bus specific extensions.
>   * @parse_dt: parse implementation specific device tree properties.
> @@ -562,6 +564,7 @@ struct dw_mci_slot {
>  struct dw_mci_drv_data {
>  	unsigned long	*caps;
>  	u32		num_caps;
> +	u32		common_caps;
>  	int		(*init)(struct dw_mci *host);
>  	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
>  	int		(*parse_dt)(struct dw_mci *host);
> 

