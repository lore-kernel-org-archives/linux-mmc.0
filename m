Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E46C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 22:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714B46115A
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 22:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbhIVWxi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 18:53:38 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:50868 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhIVWxh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 18:53:37 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210922225205epoutp025fbc96e4d19a43b9a0291119faf49296~nRrM4g7L62578325783epoutp028
        for <linux-mmc@vger.kernel.org>; Wed, 22 Sep 2021 22:52:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210922225205epoutp025fbc96e4d19a43b9a0291119faf49296~nRrM4g7L62578325783epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632351125;
        bh=Gh9ArGRcDLBD5Vv+WKc6+2Sx2cljk/6qDR3Kz117EWk=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=aW7MbB22lbM1FmNpVTPw1WV4BQ23y9pzCbfsSB2S3FOyTvvHlh9ZU4ax0ovS0FGRI
         RdC2NEEhDNFYj6wPZuoN6rn6b4xNa0maezC/qx0q+iqj/6uOGtADbBp0zEpPqUeXLE
         O5JRPBJaHDTzQBD9CnCrylGeE0qyyAwFIN9cMOQ4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210922225205epcas1p15f1b542718c96e331f2294d902a31c99~nRrMrMvcG0031400314epcas1p1B;
        Wed, 22 Sep 2021 22:52:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.235]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HFD7j1bGpz4x9Pt; Wed, 22 Sep
        2021 22:52:01 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.52.13888.193BB416; Thu, 23 Sep 2021 07:52:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210922225159epcas1p196913877d1f451a7361bebe3fb56ea8d~nRrHqqg-p0834008340epcas1p1B;
        Wed, 22 Sep 2021 22:51:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210922225159epsmtrp25e46de7cfa63ea9cf3977728396be665~nRrHpB94T2945129451epsmtrp2o;
        Wed, 22 Sep 2021 22:51:59 +0000 (GMT)
X-AuditID: b6c32a39-227ff70000003640-90-614bb3917824
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.57.08750.F83BB416; Thu, 23 Sep 2021 07:51:59 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210922225159epsmtip20b8ce522240af5e4b87f6e868ad21986~nRrHcEIDy3130231302epsmtip2P;
        Wed, 22 Sep 2021 22:51:59 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Dont wait for DRTO on Write RSP error
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <5212d8d7-7e77-b874-8f85-7948c03b5748@samsung.com>
Date:   Thu, 23 Sep 2021 07:52:38 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmru7Ezd6JBke7OCxm3/a3uLxrDpvF
        kf/9jBbH14Y7sHicWfeA0ePOtT1sHp83yQUwR2XbZKQmpqQWKaTmJeenZOal2yp5B8c7x5ua
        GRjqGlpamCsp5CXmptoqufgE6Lpl5gDtUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
        pOQUmBboFSfmFpfmpevlpZZYGRoYGJkCFSZkZ/yckVfQy1uxZ9obxgbG+VxdjJwcEgImEg8O
        dzJ2MXJxCAnsYJTY2/KVBcL5xCjx4dMrJgjnM6PEpj07mGFaVnS8YwSxhQR2MUrs6+aAKHrP
        KLHs3j4mkISwgLvEjO6PYN0iAu8YJWZf/cMOkmAT0JHY/u04WBGvgJ3Em5PbwGwWAVWJKQcW
        g20QFYiU+HtyFytEjaDEyZlPWEBsTqD6Za1zwTYzC4hL3HoynwnClpdo3jqbGWSZhMA1dok9
        z6axQJzqIjG1p4EJwhaWeHV8CzuELSXx+d1eNgi7WmJX8xmo5g5GiVvbmqAajCX2L50MZHMA
        bdCUWL9LHyKsKLHzN8wRfBLvvvawgpRICPBKdLQJQZSoSFx6/ZIJZtXdJ/9ZIWwPibdtt1kh
        oTWRUeLT6u9MExgVZiH5cxaS32Yh+W0WwhULGFlWMYqlFhTnpqcWGxaYwqM7OT93EyM4IWpZ
        7mCc/vaD3iFGJg7GQ4wSHMxKIryfb3glCvGmJFZWpRblxxeV5qQWH2I0BYb8RGYp0eR8YErO
        K4k3NLE0MDEzMjaxMDQzVBLnPfbaMlFIID2xJDU7NbUgtQimj4mDU6qByfrZmuoMO3FtQ47W
        B09/SB79O3+KwalVITzhPcXfbibwfnXODZqfs9zjhP+vpMJNq7+JCXLoegbGPT7EoC9t3z/d
        c0mUukvpqmDXV/vmLvkTmyEc2lG262I12yH9U280mC+Kz323skFk47ZlrSvWr3CUzY1meLFd
        ZYv89aOvd3Fo8t+sUf1tIHfOXYC5dekRFv81v7WtvEM5f077een9TUUN4bsFsx5ZrM0pslGW
        Psw085+Nw9RLAYV8mUsS1PwXCC7zmDN5u8qP0sUMa1MmZk/YvtZtxxbv4kmuWi2SV8R3nlpf
        JRzOIJVqnLfWN8V6WbeaHE///NQpbCIW/z+nHClO3ijdyXVhue3p+av0lViKMxINtZiLihMB
        gWvT4hEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSvG7/Zu9Eg02bdSxm3/a3uLxrDpvF
        kf/9jBbH14Y7sHicWfeA0ePOtT1sHp83yQUwR3HZpKTmZJalFunbJXBl/JyRV9DLW7Fn2hvG
        Bsb5XF2MnBwSAiYSKzreMXYxcnEICexglHj3r4sZIiEl8fnpVLYuRg4gW1ji8OFiiJq3jBJf
        H35lB6kRFnCXmNH9kQkkISLwjlHi8Kl3TBBVExkl5nxaxAZSxSagI7H923EmEJtXwE7izclt
        YDaLgKrElAOLwbaJCkRKNJ3YygZRIyhxcuYTFhCbE6h+WetcRhCbWUBd4s+8S8wQtrjErSfz
        mSBseYnmrbOZJzAKzkLSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66X
        nJ+7iREc6FpaOxj3rPqgd4iRiYPxEKMEB7OSCO/nG16JQrwpiZVVqUX58UWlOanFhxilOViU
        xHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTBNfr2Y4RvbjibV55ZrYx8nPdDzyJRa/ipePXPh
        Jj3e8nTrunSPRzc9k26wm+syL+5acuSd5DmDo/LdWXJszvs8bPz3vHWQtJuckPgt2MZlc0sR
        2/vjy6vftb8+Zv0+U7n+eW7diYceGudfvWv/E/sy8J1cx5cKnlit4ynJT1rcre5/bsuvb1ic
        XarJVjt7god1DB+brOPBzL1WIUGGa2rL9391332v6e6f0MifZsWczLqWm8/PWBd4blGllFt7
        o/26kqlKKqxzKt9f3Gkipt1upcvW9Ppf0VXuOzOFH2a/snl4+F5qyKJ5cb9nM09deqNIb+Zk
        1pM72cL1OD6WbSur462trI8xfPT8Qk/UBSWW4oxEQy3mouJEAL2pqgLjAgAA
X-CMS-MailID: 20210922225159epcas1p196913877d1f451a7361bebe3fb56ea8d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210916055929epcas1p2b5cc839886e68a2f2cec17200a2b6d83
References: <CGME20210916055929epcas1p2b5cc839886e68a2f2cec17200a2b6d83@epcas1p2.samsung.com>
        <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Chritstian,

On 9/16/21 2:59 PM, Christian Löhle wrote:
> Only wait for DRTO on reads, otherwise the driver hangs.
> 
> The driver prevents sending CMD12 on response errors like CRCs.
> According to the comment this is because some cards have problems
> with this during the UHS tuning sequence.
> Unfortunately this workaround currently also applies for any command
> with data.
> On reads this will set the drto timer which then triggers after a while.
> On writes this will not set any timer and the tasklet will not be
> scheduled again.
> I cannot attest for the UHS workarounds need, but even if so, it should
> at most apply to reads.
> I have observed many hangs when CMD25 response contained a CRC error.
> This patch fixes this without touching the actual UHS tuning workaround.

Sorry for reply too late. I'm checking your patch on my target. 
I will share the result.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..22cf13dc799b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2081,7 +2081,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  				 * delayed. Allowing the transfer to take place
>  				 * avoids races and keeps things simple.
>  				 */
> -				if (err != -ETIMEDOUT) {
> +				if (err != -ETIMEDOUT &&
> +				    host->dir_status == DW_MCI_RECV_STATUS) {
>  					state = STATE_SENDING_DATA;
>  					continue;
>  				}
> 

