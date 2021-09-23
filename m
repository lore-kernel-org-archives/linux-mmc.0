Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C240C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 04:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1476109E
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Sep 2021 04:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhIWEpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Sep 2021 00:45:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45626 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhIWEpo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2021 00:45:44 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210923044411epoutp016b11dd8dc66340ba89319f1affcb8615~nWeoG6HW11181411814epoutp01v
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2021 04:44:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210923044411epoutp016b11dd8dc66340ba89319f1affcb8615~nWeoG6HW11181411814epoutp01v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632372251;
        bh=AGrDBpsyXrosj3KNIKzP7yWVgAxWzdVkyTGz3tXdgjY=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=AMYbEZNTqSaM4QBN1q1pKmrgbPDIjlovTpPee06t6fegeuWIeTe6HrubZvtUotSl9
         bYeVvP4TD4hKz9FkkNwkE/IvTCCo5YVsJdFoem+XYLz2eXFwCL+9fjBuOiQY8Bn4WD
         gn58SlG3gm8CsDVyQBD54bkskf/sY7wsaNR2UqkA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210923044411epcas1p468b4653ee865f247e05cd33fccc902a4~nWen84qV30315403154epcas1p40;
        Thu, 23 Sep 2021 04:44:11 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.235]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HFMxv6jYvz4x9Q0; Thu, 23 Sep
        2021 04:44:03 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.F4.62447.F060C416; Thu, 23 Sep 2021 13:43:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210923044358epcas1p2fce36ec06ad52a79751233958e7aa47f~nWebsJXut1888718887epcas1p2W;
        Thu, 23 Sep 2021 04:43:58 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210923044358epsmtrp2eec3876076b9c41dbc18b337bde7fc22~nWebomzSb2224922249epsmtrp2a;
        Thu, 23 Sep 2021 04:43:58 +0000 (GMT)
X-AuditID: b6c32a36-3b5ff7000001f3ef-e6-614c060fccc2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.75.08750.E060C416; Thu, 23 Sep 2021 13:43:58 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210923044358epsmtip1da532866bfc8155e20384a207dc2d7bd~nWebdhBDL1492214922epsmtip1I;
        Thu, 23 Sep 2021 04:43:58 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Dont wait for DRTO on Write RSP error
From:   Jaehoon Chung <jh80.chung@samsung.com>
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <412adf8f-bbec-dabe-d80f-ef33da65a69d@samsung.com>
Date:   Thu, 23 Sep 2021 13:44:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <5212d8d7-7e77-b874-8f85-7948c03b5748@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLKsWRmVeSWpSXmKPExsWy7bCmri4/m0+iwcm1fBazb/tbXN41h83i
        yP9+Rovja8MdWDzOrHvA6HHn2h42j8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
        DAx1DS0tzJUU8hJzU22VXHwCdN0yc4B2KSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
        UnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMw6/38pYcJqv4tKMS4wNjDu4uxg5OSQETCT6
        N39l7mLk4hAS2MEosXLicSYI5xOjxLoL86Eynxklbh9+zwbTMnvSRqjELkaJk9O+M4IkhATe
        M0qs/68MYgsLuEvM6P7IBGKzCehIbP8GMVZE4B2jxOyrf9hBErwCdhJXl91i7WLk4GARUJVo
        msEJEhYViJT4e3IXK0SJoMTJmU9YQGxOAXuJLzsngrUyC4hL3HoynwnClpdo3jqbGeK4W+wS
        rRfiIGwXieNLl7JC2MISr45vYYewpSQ+v9sL9Uy1xK7mM2DPSAh0MErc2tbEBJEwlti/dDIT
        yG3MApoS63fpQ4QVJXb+nssIsZdP4t3XHrDzJQR4JTrahCBKVCQuvX7JBLPq7pP/UCd4SLxt
        u80KCbdjjBLnN6xjmcCoMAvJm7OQvDYLyWuzEK5YwMiyilEstaA4Nz212LDACB7byfm5mxjB
        6VDLbAfjpLcf9A4xMnEwHmKU4GBWEuH9fMMrUYg3JbGyKrUoP76oNCe1+BCjKTDcJzJLiSbn
        AxNyXkm8oYmlgYmZkbGJhaGZoZI477HXlolCAumJJanZqakFqUUwfUwcnFINTFExvmcF7O+k
        vGnX/LB6ZlzpTVnu1xrzXB5MSGveJOt7N3hyuvwJdc1zV9f3H+JiY33JU+P080XmvvNNScvk
        9sZKvjuyIdP7SeedLbp2TJwrxc3m8Jo6hExdqOGrLXKnz3XLL7Z/5iy3t02brC3k26imWbvi
        YavFb7ULYtZhHzU22eq+3Gt36cPuTpVozxoz+083N/sfcF96dcd6ma5w3nutQX9kGj8FP+/n
        vXnoxcm+Ztf7DK8Wi+e+UzB9cV/rQuG9LYbWqw++Om31drF4s6ZtQNbrvkWnNwRP2+IXlx4v
        qhly4rSgTJDM6ooUnWaH6SLFjw9mPhU571Vms/3kP+2OXBvGj4vef+qfFhZoosRSnJFoqMVc
        VJwIAGI6+4AQBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrALMWRmVeSWpSXmKPExsWy7bCSnC4fm0+iwfNpbBazb/tbXN41h83i
        yP9+Rovja8MdWDzOrHvA6HHn2h42j8+b5AKYo7hsUlJzMstSi/TtErgyDr/fylhwmq/i0oxL
        jA2MO7i7GDk5JARMJGZP2sjcxcjFISSwg1HieMMfFoiElMTnp1PZuhg5gGxhicOHiyFq3jJK
        /F19mRGkRljAXWJG90cmEJtNQEdi+7fjTCBFIgLvGCUOn3rHBNFxjFHiwKnJbCBVvAJ2EleX
        3WIFmcoioCrRNIMTJCwqECnRdGIrVImgxMmZT8CO4BSwl/iycyI7iM0soC7xZ94lZghbXOLW
        k/lMELa8RPPW2cwTGAVnIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L
        10vOz93ECA50La0djHtWfdA7xMjEwXiIUYKDWUmE9/MNr0Qh3pTEyqrUovz4otKc1OJDjNIc
        LErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamE65PhCzmS7EfVGSu15KMyw8ddPDAyfMlObr
        To3WVV6VPYld4cvPPbtm3rrko5B23YehQumolO8zkXrvtBJdi4vGt398UrjiwNTP5y58TO/V
        Q03vcxfXZc92XZiRfymNqYU3r+XdXC1F7fgZfhcKb7X9zLG4F3hnUvm0o2kfCip+3VQJlGyS
        CWzW5TztYDPP+tsLFadX9/lM/f5vcm1sV0kt1RQ++NvqZu0j3WW/z2ZtMxeJDK/vLHj0ocwg
        XK523exr8je+On1xfpJxeO1Z2x1/OwXYlFy9I2fNYtKW9Pu22Oqv0rdHklcEu8RL327U23w0
        2O7AVu9Dfa0ibu7RVbznT8SW2W1vuu3q9OekEktxRqKhFnNRcSIASKHJOuMCAAA=
X-CMS-MailID: 20210923044358epcas1p2fce36ec06ad52a79751233958e7aa47f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210916055929epcas1p2b5cc839886e68a2f2cec17200a2b6d83
References: <CGME20210916055929epcas1p2b5cc839886e68a2f2cec17200a2b6d83@epcas1p2.samsung.com>
        <af8f8b8674ba4fcc9a781019e4aeb72c@hyperstone.com>
        <5212d8d7-7e77-b874-8f85-7948c03b5748@samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/23/21 7:52 AM, Jaehoon Chung wrote:
> Hi Chritstian,
> 
> On 9/16/21 2:59 PM, Christian Löhle wrote:
>> Only wait for DRTO on reads, otherwise the driver hangs.
>>
>> The driver prevents sending CMD12 on response errors like CRCs.
>> According to the comment this is because some cards have problems
>> with this during the UHS tuning sequence.
>> Unfortunately this workaround currently also applies for any command
>> with data.
>> On reads this will set the drto timer which then triggers after a while.
>> On writes this will not set any timer and the tasklet will not be
>> scheduled again.
>> I cannot attest for the UHS workarounds need, but even if so, it should
>> at most apply to reads.
>> I have observed many hangs when CMD25 response contained a CRC error.
>> This patch fixes this without touching the actual UHS tuning workaround.
> 
> Sorry for reply too late. I'm checking your patch on my target. 
> I will share the result.
> 
> Best Regards,
> Jaehoon Chung
> 
>>
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

>> ---
>>  drivers/mmc/host/dw_mmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 6578cc64ae9e..22cf13dc799b 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2081,7 +2081,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>>  				 * delayed. Allowing the transfer to take place
>>  				 * avoids races and keeps things simple.
>>  				 */
>> -				if (err != -ETIMEDOUT) {
>> +				if (err != -ETIMEDOUT &&
>> +				    host->dir_status == DW_MCI_RECV_STATUS) {
>>  					state = STATE_SENDING_DATA;
>>  					continue;
>>  				}
>>
> 
> 

