Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7884FC4320A
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 09:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFA0610FE
	for <linux-mmc@archiver.kernel.org>; Thu,  5 Aug 2021 09:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbhHEKAL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 5 Aug 2021 06:00:11 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:10613 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbhHEKAK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2021 06:00:10 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210805095955epoutp02a4532818614146bdb7783bec7f23cf4e~YYLTVdiyD0192601926epoutp02N
        for <linux-mmc@vger.kernel.org>; Thu,  5 Aug 2021 09:59:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210805095955epoutp02a4532818614146bdb7783bec7f23cf4e~YYLTVdiyD0192601926epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1628157595;
        bh=hKGUJHkTemhAFwZMYjeCAGwDbXQozBddYvbKPJvRpmY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Kl+pLvKkXqzGgTnLAXO+8nxftXiJx8BdZBJPkw09YzhKUfwd86ikHKcMnQ6pn0c3j
         UUq8jLIgGLe5tOJpL9RU/FiAau1200PbYA3N8ABFpvrE5if6IRSwCZsfW2GBwVWxdN
         CHYt6g8Kl40TVp33MATNOnVnXDU5CvumzdoELTpo=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210805095954epcas1p445a1edd2535c571ab02988e07ec57c81~YYLSygfRs2402224022epcas1p4W;
        Thu,  5 Aug 2021 09:59:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GgPGv2rdBz4x9Q7; Thu,  5 Aug
        2021 09:59:51 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.AA.13454.796BB016; Thu,  5 Aug 2021 18:59:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210805095950epcas1p3cbba5cc9cb6d24d4113669c8703dd56d~YYLOw5VE-2716227162epcas1p3K;
        Thu,  5 Aug 2021 09:59:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210805095950epsmtrp1cde357331decb9e3dd02d5e0f0b9e569~YYLOwNtSY0150601506epsmtrp1h;
        Thu,  5 Aug 2021 09:59:50 +0000 (GMT)
X-AuditID: b6c32a39-16fff7000002348e-b2-610bb6976d01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.B3.08289.696BB016; Thu,  5 Aug 2021 18:59:50 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210805095949epsmtip1951b53f51b72671ae67f0aab83615341~YYLOf61i-1897718977epsmtip1_;
        Thu,  5 Aug 2021 09:59:49 +0000 (GMT)
Subject: Re: [BUG] mmc_regulator_set_ocr can't cope with regulator-fixed
To:     Peter Geis <pgwipeout@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <a9aa636e-326f-a848-dd69-41df87c013af@samsung.com>
Date:   Thu, 5 Aug 2021 19:00:39 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmru70bdyJBst2ilhMffiEzWL+kXOs
        Ft+udDBZXN41h83iyP9+RotPD/4zW5x95m3RuvcIu8XxteEOnB47Z91l99i0qpPN4861PWwe
        m5fUe3zeJBfAGpVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIT
        oOuWmQN0jZJCWWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/X
        ytDAwMgUqDAhO2PF/6dsBVt5Kh7t3s/WwPiAs4uRg0NCwETi8FeeLkZODiGBHYwSnzbqdTFy
        AdmfGCUOTt3EBOF8ZpSYu/EyE0gVSMPrBctYIDp2MUo0zCyCKHrPKLHr5GJmkISwgIfEw+8L
        wYpEBLYxSmxtkAMpYhbYyyjx4P4UsElsAjoS278dB7N5Bewkuv6/YQc5iUVAReL9WTmQsKhA
        pMT53QtYIEoEJU7OfMICUsIpECixal4xSJhZQFzi1pP5TBC2vMT2t3OYQVZJCMzlkNi7bhcr
        xJcuEo/bBCHuF5Z4dXwLO4QtJfGyvw3KrpbY1XwGqreDUeLWtiaoh40l9i+dzAQyh1lAU2L9
        Ln2IsKLEzt9zGSH28km8+9oDtYpXoqNNCKJEReLS65dMMKvuPvnPCmF7SHxdPoVlAqPiLCSP
        zULyzSwk38xCWLyAkWUVo1hqQXFuemqxYYEpckxvYgSnUi3LHYzT337QO8TIxMF4iFGCg1lJ
        hDd5MVeiEG9KYmVValF+fFFpTmrxIUZTYEhPZJYSTc4HJvO8knhDUyNjY2MLE0MzU0NDJXHe
        b7FfE4QE0hNLUrNTUwtSi2D6mDg4pRqYigL7ux9PvJUh0nByYVXV0hPNMxYXLu6M7A1dpD2T
        YVbQtRT3TQt2e5w0L9ztaqeu2SH7sJ7TSEnu/J7ryavuTulWd18VPq/pt2U6T5jP+QtvdI87
        udy2s3BlaHQIj8xNmdt4o6m55O/h68liGvOSLasVtuft4fiuUfnglb38DZ2G5PdLWaPVH54u
        M9BY4LdbwO1M/e8f7ys29AoJP2N2qmvxLTX4JG8vybd6YeBBr8g9wT+uzNnoslPRu+H0+76r
        cx42CAUUvyrSOt0R+C+QpT/Cg+XGevk9QQGN0TOfbtN+vv5LYc2XbzciHM+ut/5Quk3S4VO8
        7EaFamCoHbVPcb5Y5HhvjbPsEp/QKUosxRmJhlrMRcWJAAWd7SQuBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnO60bdyJBk82s1hMffiEzWL+kXOs
        Ft+udDBZXN41h83iyP9+RotPD/4zW5x95m3RuvcIu8XxteEOnB47Z91l99i0qpPN4861PWwe
        m5fUe3zeJBfAGsVlk5Kak1mWWqRvl8CVseL/U7aCrTwVj3bvZ2tgfMDZxcjJISFgIvF6wTKW
        LkYuDiGBHYwSEz53s0IkpCQ+P53K1sXIAWQLSxw+XAxR85ZR4vCdGWA1wgIeEg+/LwRrFhHY
        xigxdcZ/MIdZYD+jxMe7/xkhWpYwSlxccBushU1AR2L7t+NMIDavgJ1E1/837CArWARUJN6f
        lQMJiwpESnxe8IoVokRQ4uTMJywgJZwCgRKr5hWDhJkF1CX+zLvEDGGLS9x6Mp8JwpaX2P52
        DvMERqFZSLpnIWmZhaRlFpKWBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OLS/PS9ZLzczcxgqNI
        S2sH455VH/QOMTJxMB5ilOBgVhLhTV7MlSjEm5JYWZValB9fVJqTWnyIUZqDRUmc90LXyXgh
        gfTEktTs1NSC1CKYLBMHp1QDk/OMU4tFGmPPzjxQcHb6tIWalmns3p+2i6Q/U1JO/Hoqp8RO
        5ey/dUmPzhevKv77dtKXW3zPVvz6aXDU7rX8xE/puoe7FD50MNgWOch/6ZMr/CXwN8lNoIDF
        RuqiwvrghSfm/1WdrpWf3rdeSmjnDcv3q/UOb7nK/fuLX8aRVpPWeu5/vx6t6TRbdzSTjSVo
        L/tLC4YHojs/1zatF7J/sGGf+emOchvJhOM5M8xS2r1XTqoPXvhC4dm+zK3yqxdNV5seP3tn
        kKNPWKXbyp3hEXFTf8SfvGYfHaqXnPacc22RotLJ/k27dtzufi+8lHtnTu6Sb2L3FkSX7p4x
        c9+pK3kJ9S3O1/IPhaZ3z44/mKrEUpyRaKjFXFScCADlIApgEQMAAA==
X-CMS-MailID: 20210805095950epcas1p3cbba5cc9cb6d24d4113669c8703dd56d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550
References: <CGME20210804143357epcas1p1c67eca591d8bb557c11b8175baaa8550@epcas1p1.samsung.com>
        <CAMdYzYrx8pgeyK7u=kcopZ+Wae+fQdr_uM4AuVjqWKfZYikgcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 8/4/21 11:32 PM, Peter Geis wrote:
> Good Morning,
> 
> I've encountered a fun issue with the dw-mmc driver while working on
> enabling support for the Quartz-64 Model A.
> The regulator-fixed driver supports enabling via a gpio, but does not
> have the ops to set voltage as it is fixed.
> The dw-mmc calls mmc_regulator_set_ocr for vmmc, which attempts to set
> the voltage first but fails due to the lack of the voltage ops. It
> then bails returning -EINVAL.
> This leads to the following message :
> dwmmc_rockchip fe2b0000.mmc: could not set regulator OCR (-22)

What is vdd value (ocr_avail value) on your target?
I didn't see its case until now. If there is a real bug, I will try to check again.

Best Regards,
Jaehoon Chung

> 
> This can be fixed by switching to regulator-gpio for the vmmc supply
> to the sdmmc controller, however the sdio controller vmmc is provided
> by a fixed regulator that is always on. Obviously the regulator-gpio
> isn't an option, as it has no gpio to enable.
> 
> Removing the vmmc phandle from the sdio node is an option, but then it
> doesn't fully describe the hardware (it's also a non-standard 4.4v).
> I had considered changing the check in dw-mmc.c [1] to continue in the
> case of -EINVAL, but there are other places in the regulator framework
> that can also return that and it doesn't address the underlying issue.
> 
> As such I'm reaching out to the experts to see what the best course of
> action is here.
> Please weigh in with what you think.
> 
> Very Respectfully,
> Peter Geis
> 

