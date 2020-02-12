Return-Path: <SRS0=ptsr=4A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D37C2BA83
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 12:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F202073C
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Feb 2020 12:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CWwuR3L1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgBLMAW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:00:22 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:14159 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728099AbgBLMAW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2020 07:00:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581508822; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=RLVnJC/Yp3dxGv33CP0wjpJhPdl/x7brvP9Cxn1hiIY=; b=CWwuR3L1t/UWQrVwFI3jYRUMXViwx+y1tAO0szD8ZFkwqQKR6LIwg3dTEaWjuYur8HGOezAl
 bvnnQMVXEPT9VWiePwrmiRyWXFu5iuasGBHxRMCdl/aeK0hSjSZmvowHbFHzIvJ8DYvDldv8
 Yg2AE+9Zxmt9DwLPfGp4qi94b+g=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e43e8c7.7fe49e644fb8-smtp-out-n03;
 Wed, 12 Feb 2020 12:00:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C3D9C447A3; Wed, 12 Feb 2020 12:00:07 +0000 (UTC)
Received: from [10.206.25.140] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8FAFEC433A2;
        Wed, 12 Feb 2020 12:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8FAFEC433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH V1] dt-bindings: mmc: sdhci-msm: Add CQE reg map
To:     Doug Anderson <dianders@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>, cang@codeaurora.org,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1581434955-11087-1-git-send-email-vbadigan@codeaurora.org>
 <CAD=FV=X6-aWM_fSfLE0ySuM04FvQCTKpM-A87k3xMXBMRzNXFQ@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <1e3f8fc3-dde9-5aaf-12a9-0eb0bc5ceb83@codeaurora.org>
Date:   Wed, 12 Feb 2020 17:30:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X6-aWM_fSfLE0ySuM04FvQCTKpM-A87k3xMXBMRzNXFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 2/11/2020 10:12 PM, Doug Anderson wrote:
> Hi,
>
> On Tue, Feb 11, 2020 at 7:29 AM Veerabhadrarao Badiganti
> <vbadigan@codeaurora.org> wrote:
>> CQE feature has been enabled on sdhci-msm. Add CQE reg map
>> that needs to be supplied for supporting CQE feature.
>>
>> Change-Id: I788c4bd5b7cbca16bc1030a410cc5550ed7204e1
>> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
>> ---
>>   Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> index 7ee639b..eaa0998 100644
>> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>> @@ -27,6 +27,11 @@ Required properties:
>>   - reg: Base address and length of the register in the following order:
>>          - Host controller register map (required)
>>          - SD Core register map (required for msm-v4 and below)
>> +       - CQE register map (Optional, needed only for eMMC and msm-v4.2 above)
> I did a quick search and it appears that SD cards implementing 6.0 of
> the spec can also use CQE.  Is that correct?  If so, maybe remove the
> part about "eMMC"?
On qcom platforms, only SDHC instance meant for eMMC has the CQE support.
So mentioned that its needed only for eMMC.
>
> Maybe also change "needed" to "useful" to make it clear that this
> entry isn't actually required for all msm-v4.2 controllers?
sure.
>
>> +- reg-names: When CQE register map is supplied, below reg-names are required
>> +       - "hc_mem" for Host controller register map
>> +       - "core_mem" for SD cpre regoster map
> s/regoster/register
>
>
>> +       - "cqhci_mem" for CQE register map
> I'm at least slightly confused.  You say that reg-names are there only
> if CQE register map is supplied.  ...and that requires 4.2 and above.
> ...but "core_mem" is only there on 4.0 and below.  So there should
> never be a "core_mem" entry?
core_mem is present till <v5.0
cqhci_mem is present on >=v4.2
Say, for version v4.2 both are present; .... and for v5.0 only cqhci_mem 
is present.

Both hc reg-map and core reg-map are being accessed through index.
So no need to list the reg names 'hc_mem' & 'core_mem' in general.

But coming to cqhci reg-map we can't access it with fixed index, since 
its index varies between 1/2
based on controller version.

So we are accessing it through reg-names. Since reg-names has to be 
associated with corresponding
reg maps, other two reg-names (hc_mem & core_mem) also need to br listed 
when cqhci_mem is listed.

That is the reason, I mentioned it like these are needed only cqe reg 
map is supplied.
If it is creating confusion, i will remove that statement.
> Trying to specify that sanely in free-form text seems like it's gonna
> be hard and not worth it.  You should probably transition to yaml
> first?
>
>
> I will also note that Rob isn't a huge fan of "reg-names".  In a
> different conversation I think you mentioned you had a reason for
> having it.  I guess just be prepared to defend yourself against Rob if
> you feel strongly about keeping reg-names.
Sure. Its the same reason mentioned in above comment.
>
> -Doug
