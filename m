Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC52C48BE6
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00B3B611BE
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Jun 2021 11:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236127AbhFNLmK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Jun 2021 07:42:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:45190 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236946AbhFNLkT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 14 Jun 2021 07:40:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623670697; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hzwIJOQ7OctpDsRQNZTjjMstVXO6J3lo7iM4zpxApOA=;
 b=D+zMwiBkc23Cp8AzCAGmCkdgmNotCBOVgzJUpcagB2Ny9utKDadl/DlpcQ5VeDukZTOIgf4l
 qHZg10vobyeYQ3QX9LHdxSGNTCJZyaQ5iHsN+3VF134bowT3/sAxim1y26E7dfvrqWuF9V7G
 VeOOo1IMoGrmf+eybEu+6EXuUl0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60c73f90e27c0cc77f961472 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 11:37:52
 GMT
Sender: sbhanu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6EA31C43217; Mon, 14 Jun 2021 11:37:50 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sbhanu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CD92C433D3;
        Mon, 14 Jun 2021 11:37:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jun 2021 17:07:47 +0530
From:   sbhanu@codeaurora.org
To:     Georgi Djakov <djakov@kernel.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        okukatla@codeaurora.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7180: bus votes for eMMC and SD
 card
In-Reply-To: <b1d108f1-75c1-87a7-a9de-3a004f56596e@kernel.org>
References: <1623309189-27943-1-git-send-email-sbhanu@codeaurora.org>
 <b1d108f1-75c1-87a7-a9de-3a004f56596e@kernel.org>
Message-ID: <c38a26ac268f5c12537955240885d5a3@codeaurora.org>
X-Sender: sbhanu@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2021-06-10 13:04, Georgi Djakov wrote:
> Hi Sajida,
> 
> Thank you for the patch!
> 
> On 10.06.21 10:13, Shaik Sajida Bhanu wrote:
>> Updated bus votes for eMMC and Sd card.
> 
> The commit text should also give answer to the question "Why is this
> patch necessary?". Do we need a Fixes: tag? The subject could be
> improved too. Please check:
> https://www.kernel.org/doc/Documentation/process/submitting-patches.rst
> 
> Thanks,
> Georgi
> 
Sure will update the commit message
>> 
>> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 20 ++++++++++----------
>>   1 file changed, 10 insertions(+), 10 deletions(-)
>> 
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi 
>> b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index 295844e..1fce39d 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -726,15 +726,15 @@
>>   				opp-100000000 {
>>   					opp-hz = /bits/ 64 <100000000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>> -					opp-peak-kBps = <100000 100000>;
>> -					opp-avg-kBps = <100000 50000>;
>> +					opp-peak-kBps = <1800000 600000>;
>> +					opp-avg-kBps = <100000 0>;
>>   				};
>>     				opp-384000000 {
>>   					opp-hz = /bits/ 64 <384000000>;
>> -					required-opps = <&rpmhpd_opp_svs_l1>;
>> -					opp-peak-kBps = <600000 900000>;
>> -					opp-avg-kBps = <261438 300000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <5400000 1600000>;
>> +					opp-avg-kBps = <390000 0>;
>>   				};
>>   			};
>>   		};
>> @@ -2685,15 +2685,15 @@
>>   				opp-100000000 {
>>   					opp-hz = /bits/ 64 <100000000>;
>>   					required-opps = <&rpmhpd_opp_low_svs>;
>> -					opp-peak-kBps = <160000 100000>;
>> -					opp-avg-kBps = <80000 50000>;
>> +					opp-peak-kBps = <1800000 600000>;
>> +					opp-avg-kBps = <100000 0>;
>>   				};
>>     				opp-202000000 {
>>   					opp-hz = /bits/ 64 <202000000>;
>> -					required-opps = <&rpmhpd_opp_svs_l1>;
>> -					opp-peak-kBps = <200000	120000>;
>> -					opp-avg-kBps = <100000 60000>;
>> +					required-opps = <&rpmhpd_opp_nom>;
>> +					opp-peak-kBps = <5400000 1600000>;
>> +					opp-avg-kBps = <200000 0>;
>>   				};
>>   			};
>>   		};
>> 
