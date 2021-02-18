Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D77C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Feb 2021 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56B064DEC
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Feb 2021 00:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBRAYC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:24:02 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:15809 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhBRAYB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Feb 2021 19:24:01 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210218002317epoutp035d8c9c9d4d9e5026ff4f5491ea03fd37~kr74loJA30074300743epoutp03n
        for <linux-mmc@vger.kernel.org>; Thu, 18 Feb 2021 00:23:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210218002317epoutp035d8c9c9d4d9e5026ff4f5491ea03fd37~kr74loJA30074300743epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613607797;
        bh=dqEgETVi1DcI7sGovx4BLdE7g+x9hTwGOO7NVNJ0MP4=;
        h=Subject:To:From:Date:In-Reply-To:References:From;
        b=NBMYRcL/UB5gaM/Dm7wNd5+GSNjAfEsOrb9/tY/3RBJoq57vmAr7RKUX24P/hwasb
         JDacU1e6CAZ7daBQJKBkB9oQJls7romwe39y/uJbgPv4NtCgLDqx0xseex1qjdy38q
         eIGwqUi6QejgFQttF1I36v/dtmJshZJUyTJpEgpw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210218002317epcas1p2e40e439c5d0bc845e909afef61e24ed3~kr74XEJnQ1970419704epcas1p2-;
        Thu, 18 Feb 2021 00:23:17 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DgwR70FWnz4x9QC; Thu, 18 Feb
        2021 00:23:15 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7F.A9.02418.863BD206; Thu, 18 Feb 2021 09:23:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210218002304epcas1p43ff7b6749bb7b9e5bbdcd588e2843508~kr7sNQY2t2850228502epcas1p4K;
        Thu, 18 Feb 2021 00:23:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210218002304epsmtrp1999b169c2a449a51c68acf1a12c84add~kr7sMq2zP2257522575epsmtrp1m;
        Thu, 18 Feb 2021 00:23:04 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-28-602db368cec0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.85.08745.863BD206; Thu, 18 Feb 2021 09:23:04 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210218002304epsmtip250e72f80b88bfe47081fcd171fa08106~kr7r-Xs831480814808epsmtip2U;
        Thu, 18 Feb 2021 00:23:04 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Drop redundant call to ->card_event
 callback
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <be3b20dd-608b-48dc-7f4a-7bf300c0e0dd@samsung.com>
Date:   Thu, 18 Feb 2021 09:23:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210212132406.237270-1-ulf.hansson@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmrm7GZt0EgyU3DC2O/O9ntDi+NtyB
        yePOtT1sHp83yQUwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gBNV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUWBboFSfmFpfmpesl
        5+daGRoYGJkCFSZkZ7x5eZitYCN7xaeFr5kbGLvYuhg5OSQETCSu7G0Dsrk4hAR2MEps613K
        COF8YpR4u6uTFcL5zCix+8FyZpiWnXv3sUMkdjFKXFi1lQXCec8ocejDCiaQKmGBAIktd96w
        gtgiAs4STTvXs4PYbAI6Etu/HQer4RWwkzjVMRMsziKgKvG96S5YXFQgUmLn05fsEDWCEidn
        PmEBsTkFbCWOvDoIdjizgLjErSfzmSBseYntb+cwgxwhIXCIXWL28aVQp7pITF9zmQnCFpZ4
        dXwLO4QtJfGyvw3KrpbY1XwGqrmDUeLWtiaoBmOJ/UsnA9kcQBs0Jdbv0ocIK0rs/D2XEWIx
        n8S7rz2sICUSArwSHW1CECUqEpdev2SCWXX3yX9WCNtD4uHZX9CQm8Ao0floIeMERoVZSP6c
        heS3WUh+m4VwxQJGllWMYqkFxbnpqcWGBYbI8b2JEZz2tEx3ME58+0HvECMTB+MhRgkOZiUR
        XvbPWglCvCmJlVWpRfnxRaU5qcWHGE2BIT+RWUo0OR+YePNK4g1NjYyNjS1MDM1MDQ2VxHmT
        DB7ECwmkJ5akZqemFqQWwfQxcXBKNTBpRbz96LBk1jfenfz/gr98rT5lvitaTGqJmc5E7d9z
        7915k1A63+Dyn1tpMpbvmztlrAsiv/3Mi10i03Vxgmx1/9vCZNMusx6hzXPOexUzXOR4pHuO
        f03QHAXPlSfKOlx9aqdfkdlY8zRqxjfHub+uFPCZvji9oGR+ybUvDM9e2xzfyHXSj6G9XflP
        VVPh5fS0ddzba4ySZ/ll50/66P3Dqz9uTQBv2ovPx5VXXD97XiZvz6znHXMDyreonXzdI5Ep
        7puftsL/96Ffm3YeiAj+t7jKP/XM/Aq3rY9MmR4tWd/KX2Gj8Gbx5Q8/TqRu+rj4/Lxfh5+t
        0p13s/76x1WK/n11O46/ORiVzLj09bISUyWW4oxEQy3mouJEADSiDrAEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvG7GZt0Eg56LAhZH/vczWhxfG+7A
        5HHn2h42j8+b5AKYorhsUlJzMstSi/TtErgy3rw8zFawkb3i08LXzA2MXWxdjJwcEgImEjv3
        7mPvYuTiEBLYwShx7ssVVoiElMTnp1OBijiAbGGJw4eLIWreMkrcPbeaFSQuLOAn0b4nD6Rc
        RMBZomnneqg5ExglHk7aBDaHTUBHYvu340wgNq+AncSpjpnsIDaLgKrE96a7TCBzRAUiJXbu
        sIQoEZQ4OfMJC4jNKWArceTVQbA7mQXUJf7Mu8QMYYtL3HoynwnClpfY/nYO8wRGwVlI2mch
        aZmFpGUWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA1lLawfjnlUf9A4x
        MnEwHmKU4GBWEuFl/6yVIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU1ILU
        IpgsEwenVAPTrhXTfF7tM845Nkcg3VzqQ1NebPVlkefH9tyfkttV0qS+4to2raYJMt1Sz7c9
        e/z4o+WeVP/Nh7veTf3es/3gDYVz1cs27dOvDKnknbKY7VlW+Zrb/vsLv9Zn9XOsOMggeP99
        Gid3T8sGOzuf+v27+f7LXvr0zmwqb9a35xuCBW8q7NB7oOJiL///xSK5lMtdfA/YP278HHdQ
        R6ik6ZRyq8ATF5FZr/+6d6pNvyAzc0LDx9vcXKpdcfZlh9fK7w47kT7D6WL4Zc+LHP90DjR7
        /JjS+OrXlB2PzKvOpWXPnZKpn91/bFpy8U251z2qddklVvWN6gkFpS9eFC+v2xvbKJ2V8eN8
        rYfPjm8y5a/nKrEUZyQaajEXFScCAG2QEgXTAgAA
X-CMS-MailID: 20210218002304epcas1p43ff7b6749bb7b9e5bbdcd588e2843508
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210212132415epcas1p4811e5feb2da2d3c942ec0940d9d7688b
References: <CGME20210212132415epcas1p4811e5feb2da2d3c942ec0940d9d7688b@epcas1p4.samsung.com>
        <20210212132406.237270-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/12/21 10:24 PM, Ulf Hansson wrote:
> The ->card_event callback isn't being used by any of the dw_mmc variants.
> It's likely a leftover from an earlier change, hence let's just drop the
> redundant call to it.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a5244435556b..df327c89cec5 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2606,8 +2606,6 @@ static void dw_mci_handle_cd(struct dw_mci *host)
>  {
>  	struct dw_mci_slot *slot = host->slot;
>  
> -	if (slot->mmc->ops->card_event)
> -		slot->mmc->ops->card_event(slot->mmc);
>  	mmc_detect_change(slot->mmc,
>  		msecs_to_jiffies(host->pdata->detect_delay_ms));
>  }
> 

