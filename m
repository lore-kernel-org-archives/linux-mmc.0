Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE00C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Nov 2021 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhKXJ4r (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Nov 2021 04:56:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:36195 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhKXJ4r (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 24 Nov 2021 04:56:47 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20211124095336epoutp036b8855698391e44f750bf52d3ce59fb3~6csen9-hU1215612156epoutp03i
        for <linux-mmc@vger.kernel.org>; Wed, 24 Nov 2021 09:53:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20211124095336epoutp036b8855698391e44f750bf52d3ce59fb3~6csen9-hU1215612156epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637747616;
        bh=rMJ62FTVUTwpOD+MOusMJuFK3wropF9QGI/mG1oW5no=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pPVBPL2HEWXcfLVBmZ2HxQMmZBYIOfpJCL8OwG8C2RdrNXMmWVVs3ff3akEjlJGRk
         GYApIX6B5UzvoYjI1HB6lI0Iam9/EtnoQ/mtC+QDsSWni8nvqzwg06Qzw2KTGbKixs
         XrgYDA4OMcO/iP9ikwq5ZvbkJMehxIb+/hrMgfQw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211124095335epcas1p35b93971e3fe8893037fa1d64b7cef408~6cseC8nTD2329423294epcas1p3z;
        Wed, 24 Nov 2021 09:53:35 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HzbtL251Tz4x9Pp; Wed, 24 Nov
        2021 09:53:30 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        01.9B.21932.D3B0E916; Wed, 24 Nov 2021 18:51:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211124095329epcas1p458550a7954cecc1ea111a3868c13fec4~6csYjBE5P2302823028epcas1p4L;
        Wed, 24 Nov 2021 09:53:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211124095329epsmtrp229bbdf5d030466a44dbf3bf3574d501f~6csYiW_1H1721117211epsmtrp2R;
        Wed, 24 Nov 2021 09:53:29 +0000 (GMT)
X-AuditID: b6c32a38-929ff700000255ac-6e-619e0b3d3639
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.7B.08738.99B0E916; Wed, 24 Nov 2021 18:53:29 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211124095329epsmtip298aa76bcd275118da98e76537e8b5687~6csYZu3Aw0785707857epsmtip2J;
        Wed, 24 Nov 2021 09:53:29 +0000 (GMT)
Subject: Re: [PATCH 2/2] mmc: dw_mmc: use standard "mmc" alias stem
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        John Keeping <john@metanate.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <315972c2-2253-ad10-b712-2d2c96b3da26@samsung.com>
Date:   Wed, 24 Nov 2021 18:54:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQNeWe16iwZ3P+hbvN01htbi8aw6b
        xZH//YwWx9eGO7B43Lm2h81j05RbrB6fN8kFMEdl22SkJqakFimk5iXnp2TmpdsqeQfHO8eb
        mhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYALVNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2Cql
        FqTkFJgW6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcv/uBsaBDrKJx8wb2BsZWwS5GTg4JAROJ
        Td0P2LoYuTiEBHYwSjz728EE4XxilHi5tZkVwvnMKPH66xF2mJZHF9qgWnYxSvzsegfV8p5R
        Yue6P6wgVcICzhIrHr9jBrFFBLwkpq6ZD2YzC1hL/PzRClbDJqAjsf3bcSYQm1fATqLj+Eyw
        GhYBVYn+bb/AbFGBSIn7P5azQ9QISpyc+YQFxOYUCJTYeeAE1ExxiVtP5jNB2PIS29/OYQY5
        SELgEbvEywfHoM52kXjwaAsThC0s8er4Fqi4lMTnd3vZIBqWMUrcuf0XylnPKHFg+xI2iCpj
        if1LJwN1cwCt0JRYv0sfIqwosfP3XEaIzXwS7772sIKUSAjwSnS0CUGUqEhcev2SCWbX3Sf/
        WSFsD4mlb3exTmBUnIXkt1lI/pmF5J9ZCIsXMLKsYhRLLSjOTU8tNiwwgcd3cn7uJkZwUtSy
        2ME49+0HvUOMTByMhxglOJiVRHivLZmdKMSbklhZlVqUH19UmpNafIjRFBjaE5mlRJPzgWk5
        ryTe0MTSwMTMyNjEwtDMUEmc97n/9EQhgfTEktTs1NSC1CKYPiYOTqkGpr5jR1uKXmvtPdgt
        6Wz3qbb23QnVA3Ut0j7fcqY87F25eO5qyecrxe5EZ3B0yk1kvBA032T3lcLUJXMlXhtPkQ2d
        tlvrqU83U3jF7nTJmnnLdKOSJu4SPHRh31ojxbXH71rUaP4M2x/Q8rlvZmBtt5D3frtLDxq7
        p8YnzPm+pe7/1y3V/Krtcn610mL3zCSf3dFYpObNt2Ynv3xV0acLDUZlM2bMuOBz3nsXu++5
        o5L8daxC2cfqcqtiHFW8r/E4ZG44e585507expgu3senN/oVr1Rea+X0cQlLNLeJwLvfJ85y
        bPinN+N1lPykApW6oPKHD4xOrbiQKjWLnUfN3/dXdexEh3ndn3Te/PKoVGIpzkg01GIuKk4E
        AHWlrusTBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSvO5M7nmJBvN36lm83zSF1eLyrjls
        Fkf+9zNaHF8b7sDicefaHjaPTVNusXp83iQXwBzFZZOSmpNZllqkb5fAlXH97gfGgg6xisbN
        G9gbGFsFuxg5OSQETCQeXWhjA7GFBHYwSvR9qYWIS0l8fjoVKM4BZAtLHD5c3MXIBVTyllGi
        5+81VpAaYQFniRWP3zGD2CICXhJT18wHs5kFrCV+/mhlhWhoYpJ4fPIvWAObgI7E9m/HmUBs
        XgE7iY7jM8EaWARUJfq3/QKzRQUiJdYdX8YOUSMocXLmExYQm1MgUGLngRNQC9Ql/sy7BGWL
        S9x6Mp8JwpaX2P52DvMERqFZSNpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OL
        S/PS9ZLzczcxgiNAS2sH455VH/QOMTJxMB5ilOBgVhLhvbZkdqIQb0piZVVqUX58UWlOavEh
        RmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTLO2yh848eWavnHMFA2Zo5tuhJ2qPX39
        7P6J3XJ+joL276bsOKo967su04m+ltM+aabrYwXOvDeM9DStEu7P5snYuT7pXMLEH/Gf9+vH
        iW5pPrpX/rjET4n13/aKlixPt1Ce+dPNiO2FseVluUkcn+RnbcvS2FR1YkqJzye+V+1NCc/a
        y971VagemGSUZbNmns2Jzu9G3NOuW/v0nrV6NLGyo/VUxvWTd1vKz25V850xRedM04me65Mj
        nn8SfhIpmqko/VXGzPLWDTWdD7JnDBXenGO51jpj4txs4ZrrrzfLyv8WMjtxuezd2sXb/U85
        q9hFX25a7VkoZPQ5XrXNxrG6+rqXW1n6C409KnvEzyuxFGckGmoxFxUnAgD8asrn7wIAAA==
X-CMS-MailID: 20211124095329epcas1p458550a7954cecc1ea111a3868c13fec4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211123193506epcas1p49d0d0a2d66c6e560ee26077da9c0202b
References: <20211116190244.1417591-1-john@metanate.com>
        <20211116190244.1417591-3-john@metanate.com>
        <CGME20211123193506epcas1p49d0d0a2d66c6e560ee26077da9c0202b@epcas1p4.samsung.com>
        <CAPDyKFp1zMBUfK7LteW0yEfTpqtU+P+EybLsJBFx_r54HwFdMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/24/21 4:34 AM, Ulf Hansson wrote:
> On Tue, 16 Nov 2021 at 20:02, John Keeping <john@metanate.com> wrote:
>>
>> The standard stem for MMC aliases is "mmc" and this is used by the MMC
>> core to set the slot index.
> 
> This isn't the correct description of the mmc aliases. The below text
> is copied from the DT doc:
> 
> "It is possible to assign a fixed index mmcN to an MMC host controller
> (and the corresponding mmcblkN devices) by defining an alias in the
> /aliases device tree node."
> 
>>
>> Use this in preference to the non-standard "mshc" stem when setting the
>> controller ID to avoid needing two aliases for each MMC device in order
>> to cover both the core and dw_mmc-specific functionality.
>>
>> The old "mshc" lookup is kept for backwards compatibility.
> 
> The mshc alias is really weird!
> 
> It looks like some leftover from when the dw_mmc controller supported
> multiple slots. This support was dropped a long time ago, simply
> because it never really worked - and it was not worth trying to. Only
> one slot per controller is supported.

As Ulf mentioned, dw_mmc controller can be supported multiple slot.
But I didn't see its case to use multiple slot. And I had been done to drop a long time ago.

mshc was used because of Mobile Storage Host Controller.

> 
> Rather than re-using the mmc alias in the same weird way as the mshc
> alias, I suggest we try to remove parsing of the mshc aliases
> completely. By looking at the corresponding code and in combination
> with the DTS files, it certainly looks doable to me. Do you want to
> have a look at it?

If possible to remove mshc, it's best.
I will check that removing mshc parsing in dw_mmc.c.

Best Regards,
Jaehoon Chung

> 
> Additionally, there is no need to deprecate the mshc alias binding, as
> it seems like it has never been documented. :-)
> 
> Kind regards
> Uffe
> 
>>
>> Signed-off-by: John Keeping <john@metanate.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 37af1245304b..6ffaa354410a 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -112,7 +112,11 @@ int dw_mci_of_alias_get_id(struct dw_mci *host)
>>         if (WARN_ON(!host->dev->of_node))
>>                 return 0;
>>
>> -       ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
>> +       ctrl_id = of_alias_get_id(host->dev->of_node, "mmc");
>> +
>> +       /* Compatibility fallback for old device trees. */
>> +       if (ctrl_id < 0)
>> +               ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");
>>
>>         if (ctrl_id < 0)
>>                 ctrl_id = 0;
>> --
>> 2.34.0
>>
> 

