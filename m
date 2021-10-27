Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C629C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8275660F56
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Oct 2021 23:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhJ0XFT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:05:19 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:12813 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhJ0XFS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Oct 2021 19:05:18 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211027230250epoutp012ff2fd8cc1971267cbcb35e780b4d9b1~yBZlJFzJj0426804268epoutp01e
        for <linux-mmc@vger.kernel.org>; Wed, 27 Oct 2021 23:02:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211027230250epoutp012ff2fd8cc1971267cbcb35e780b4d9b1~yBZlJFzJj0426804268epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635375770;
        bh=KpPEXdsGofjhfnJY49jneCV8VzuOPKp4L/ihVKiBFQo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=l/G5v90L6jwIH2j5C0Brj+G56F0EEDrHNaIwNQ4YjVFDPLX7/6iMOZRv4xFmXPN3j
         qI4IXjV+XKhORNYG0Jxaqxdwv2bjj5I2H9oKMJkQzD5TqwXI18KYmy0MgNWQ8Huwdc
         4hifqHDssmwhUaVeBpFrlzMnIEvzpGp9hH2mQe9M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20211027230250epcas1p491ac82f8258d91dd52763f4c25eaf4c1~yBZk5iMIq2214622146epcas1p4J;
        Wed, 27 Oct 2021 23:02:50 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.232]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Hfkjx1VQCz4x9Q2; Wed, 27 Oct
        2021 23:02:45 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.73.09592.E8AD9716; Thu, 28 Oct 2021 08:02:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20211027230237epcas1p47c478691a1133a4a1507152e79926ef3~yBZY8jgd11376313763epcas1p4y;
        Wed, 27 Oct 2021 23:02:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211027230237epsmtrp2a390f977ac4c8b9ec143d05940bc0ccf~yBZY77ixd2065120651epsmtrp22;
        Wed, 27 Oct 2021 23:02:37 +0000 (GMT)
X-AuditID: b6c32a37-28fff70000002578-35-6179da8ee460
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.E8.29871.D8AD9716; Thu, 28 Oct 2021 08:02:37 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20211027230237epsmtip1aee9c2e34e5744f5a309656c0f1aa4b4~yBZYqZTuL2994029940epsmtip1b;
        Wed, 27 Oct 2021 23:02:37 +0000 (GMT)
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: fix the finding clock sample
 value
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        krzysztof.kozlowski@canonical.com,
        Marian Mihailescu <mihailescu2m@gmail.com>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <84bffcf2-fa5c-bed5-08a0-4d0a9a1ce29b@samsung.com>
Date:   Thu, 28 Oct 2021 08:03:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BC6E985A-0F0B-4913-B829-6C2AE76978E1@gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEJsWRmVeSWpSXmKPExsWy7bCmnm7frcpEgxnLuSxe3ZrMbLHx7Q8m
        iyP/+xkt1h65y26xftpPVovja8Md2DxmNfSyeeycdZfd4861PWwefVtWMXp83iQXwBqVbZOR
        mpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdICSQlliTilQ
        KCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj7eNe
        9oLFIhWX2m4zNzDOEOhi5OSQEDCRWDeth7GLkYtDSGAHo8TPCavYIZxPjBJXpxxmB6kSEvjG
        KLFmqx5Mx5lF/1ghivYySqy83MYC4bxnlPgx4TczSJWwQKDEsmVTwLpFBBIkLj0+BbaDWWAa
        o8TWxY+ZQBJsAjoS278dB7N5BewkFr5eAWazCKhKvLq8GaxZVCBS4u/JXawQNYISJ2c+AdrG
        wcEpYCsx63ExSJhZQFzi1pP5TBC2vETz1tnMILskBDo5JF5OusQKcbaLxN2HB6BsYYlXx7ew
        Q9hSEp/f7WWDsKsldjWfgWruYJS4ta2JCSJhLLF/6WQmkMXMApoS63fpQ4QVJXb+nssIsZhP
        4t3XHlaQEgkBXomONiGIEhWJS69fMsGsuvvkP9QJHhJvpi9gmcCoOAvJZ7OQvDMLyTuzEBYv
        YGRZxSiWWlCcm55abFhgDI/t5PzcTYzgxKllvoNx2tsPeocYmTgYDzFKcDArifBenleeKMSb
        klhZlVqUH19UmpNafIjRFBjWE5mlRJPzgak7ryTe0MTSwMTMyNjEwtDMUEmc97NcYaKQQHpi
        SWp2ampBahFMHxMHp1QD07ZWheW8q2+xHFaOlUyzOSjV93azArNC6cMe/+CE81JXVkhLbSjM
        D50Xac158sL8ggVuW6fPv16TM/1Gztl0hgOfrP/+vyHm61PN7XX2wJMHfIVf+NKK3uqUhM96
        atkTE7HVuPJFHs96RjajQLPPPydtlpoqUasyS5/lgtqjs67Tj008eCTvl2TX6R+/bgY/eh8+
        7fP00/IGzaelPyY5eu5hSOFv0vq52bl66hNTm/9rNG+6+j61FUlq2D7vR/Jp9sSciOlCleVF
        f1z+X2I0mVp7zKZKcyrb2UVsm1epbeebte+O3xP5y+c1GP7LinlEmkrUvlhmYp/evUV4/y31
        vI97XiZteax2f8GlB9oZE5VYijMSDbWYi4oTAeq+2AIlBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSnG7vrcpEgyn/pC1e3ZrMbLHx7Q8m
        iyP/+xkt1h65y26xftpPVovja8Md2DxmNfSyeeycdZfd4861PWwefVtWMXp83iQXwBrFZZOS
        mpNZllqkb5fAlbH2cS97wWKRikttt5kbGGcIdDFyckgImEicWfSPFcQWEtjNKLF2QjZEXEri
        89OpbF2MHEC2sMThw8VdjFxAJW8ZJfZt/sQCUiMsECixbNkUdhBbRCBB4vSmyWwgRcwCUxgl
        ft89ywjRsZJJ4vPxNWwgVWwCOhLbvx1nArF5BewkFr5eAWazCKhKvLq8GWySqECkRNOJrWwQ
        NYISJ2c+YQG5glPAVmLW42KQMLOAusSfeZeYIWxxiVtP5jNB2PISzVtnM09gFJqFpHsWkpZZ
        SFpmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOFK0NHcwbl/1Qe8QIxMH
        4yFGCQ5mJRHey/PKE4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgST
        ZeLglGpgivt8rNn+S1Oyw7TYzDxHtobGm4/u66y1Srd1i9dSn3t8lsgm86aURUkuwbwSLdk8
        r4J0NRwjmROn3N6RJC6rw/GnU55/04fNMz6yOgW4N+n8npWZsdkqKH6ulfZvRmH2BT+X3bk2
        cVLXE4MyxogFOqdWOSsIJqhziT5n/VIS7XNxwdHOHNmILeKX+u5+DtpzrJh9uv3W+ZX/ra61
        NVs8bZDjrO28pLTs3+eSTZ1bP8t3l9r88Tm4I2bh+lCx+uxJJhw/NWetO9SW2VeTv+TAp1ez
        vcq5jdimvPNNvf6j7s+rN15/gj7xG0gV3eV9qcIbExJXbvd3c9qePzKJ+5o89E6X3juy+3vU
        DCO9S5OUWIozEg21mIuKEwEK1ZaLAwMAAA==
X-CMS-MailID: 20211027230237epcas1p47c478691a1133a4a1507152e79926ef3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910
References: <CGME20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910@epcas1p3.samsung.com>
        <20211022082106.1557-1-jh80.chung@samsung.com>
        <8DD814C1-8534-4762-BD41-DE941C16DC92@gmail.com>
        <9792ea4f-2696-484d-a5d7-04da270684cd@samsung.com>
        <BC6E985A-0F0B-4913-B829-6C2AE76978E1@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/22/21 8:42 PM, Christian Hewitt wrote:
> 
>> On 22 Oct 2021, at 3:35 pm, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> Hi,
>>
>> On 22.10.2021 12:53, Christian Hewitt wrote:
>>>> On 22 Oct 2021, at 12:21 pm, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>>>
>>>> Even though there are candiates value if can't find best value, it's
>>>> returned -EIO. It's not proper behavior.
>>>> If there is not best value, use a first candiate value to work eMMC.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>>>
>>> v2 patch working fine with the module that triggered the original report:
>>>
>>> [    2.902144] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
>>> [    2.912118] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
>>> [    3.142474] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
>>> [    3.239339] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
>>> [    3.241388] mmc_host mmc0: Bus speed (slot 0) = 266666666Hz (slot req 200000000Hz, actual 133333333HZ div = 1)
>>
>> I wonder why 266666666Hz bus speed is selected instead of the 
>> 400000000Hz one. Did you remove the workaround patch which changed the 
>> divider value from your kernel tree? I didn't analyze the code, so maybe 
>> this change is intentional result of this patch? On my XU4 I get 
>> 400000000Hz bus clock for the eMMC dw-mmc controller.
> 
> Yes, I removed the workaround patch before testing. It’s delivering
> the same result as the workaround so perhaps it’s normal for this
> module. All the emmc modules I have (all samples from HK sent at the
> same time) are identical so there’s nothing else I can test with.

As Marek was mentioned, I wonder why 266666666Hz is selected.
On my XU4, it's selected 400MHz as Marek's. 

Best Regards,
Jaehoon Chung

> 
> Christian
> 
>>> [    3.243310] mmc0: new HS400 MMC card at address 0001
>>> [    3.259191] mmcblk0: mmc0:0001 8GME4R 7.28 GiB
>>> [    3.302621]  mmcblk0: p1 p2
>>> [    3.311541] mmcblk0boot0: mmc0:0001 8GME4R 4.00 MiB
>>> [    3.327737] mmcblk0boot1: mmc0:0001 8GME4R 4.00 MiB
>>> [    3.340919] mmcblk0rpmb: mmc0:0001 8GME4R 512 KiB, chardev (246:0)
>>
>> Best regards
>> -- 
>> Marek Szyprowski, PhD
>> Samsung R&D Institute Poland
> 
> 

