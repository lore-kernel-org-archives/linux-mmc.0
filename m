Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A7FCCA482
	for <linux-mmc@archiver.kernel.org>; Sat,  2 Jul 2022 16:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbiGBP77 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 2 Jul 2022 11:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiGBP76 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Jul 2022 11:59:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E75BCB2
        for <linux-mmc@vger.kernel.org>; Sat,  2 Jul 2022 08:59:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z13so8538901lfj.13
        for <linux-mmc@vger.kernel.org>; Sat, 02 Jul 2022 08:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:user-agent:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=Hz75Rx42oXHh7NmNLOTnnxJGcRdhgiXUHBkENH9MqHA=;
        b=t49DnnFkz+tH5eJrrVIDW1KUvaQG95jWIXLzQMKIvbpBvqNP3Roy+FMPGCu/PNyv2w
         p8pOjYWUSSBJ0Csnt61ODgx79ahGzcV7SPqLtzBoc60unYg+cbcKwQokXJNSqKXO66Uw
         AHciOKECs0eKerATKAPzaFm+6FKQkVmrjGYC5++MgFLUSWQHeTahilNBL634VEFgYFva
         LnAMjDrbcLNcYi45ctSY8kTB5rdraekMug3H4ePgfW6lWDBFVdJUmKSOSclc32TvVC7s
         ygN6y1TrlItsam5I6MBw8WUWLvdkpeFniEX9P/M9Vnc9GHq1IiXHj89dhChCv0jVrToL
         WxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:user-agent:in-reply-to
         :references:message-id:mime-version:content-transfer-encoding;
        bh=Hz75Rx42oXHh7NmNLOTnnxJGcRdhgiXUHBkENH9MqHA=;
        b=MrBqYKFBBbwyauq3PJnx64abyeSUSKWyLKkyNI+i4eplNO2g1NcHyjK0v0VIMCv7EA
         WU4ti1kkBbIsPPYsviEyrF1yxdGuN+mVNK9XhIai/7T5EyxLVmez0DcwzjGFNVIfGzDZ
         ZnwRaNikjrlCe9ceYlycgN3WxBCkAgg/RQJ1zxvPE9GU5uEiFMwVCkjdsh3gXqiYy7L2
         awHZ7ajZmpI9hC4Z7epYSMYFrXxPxnKsx/w6CkNqbOiqe4OPbw5q5Mz/K5SnbzDP5kfw
         6/bJiXJy5fDNjiD6BYglekqzzx0FUizskbBgRtSRPQdjyqemW7lPz99Ue4ZIIA8oDTJP
         Xn8Q==
X-Gm-Message-State: AJIora8KWM9x6k671XRq7mK4qiu2VCCg2d+NoJmLMaBRxtdw/gIOddsU
        uE/z0cOQGyElvELfDTqWBWNk6Q==
X-Google-Smtp-Source: AGRyM1tHO8HVvetVfAh0h/jVYaKiWK6Ez13CzIyaZGdFPjFEl84NdJBoTUuNYZcZFE0ahUNr+LAMpQ==
X-Received: by 2002:a05:6512:2216:b0:481:1ed5:5a72 with SMTP id h22-20020a056512221600b004811ed55a72mr12427813lfu.142.1656777595238;
        Sat, 02 Jul 2022 08:59:55 -0700 (PDT)
Received: from [127.0.0.1] ([94.25.229.203])
        by smtp.gmail.com with ESMTPSA id v6-20020a056512348600b00478f2f2f043sm4165446lfr.147.2022.07.02.08.59.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Jul 2022 08:59:54 -0700 (PDT)
Date:   Sat, 02 Jul 2022 18:59:48 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh@kernel.org>
CC:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.linux@gmail.com>,
        "Gross, Andy" <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/1=5D_dt-bindings=3A_mmc=3A_sd?= =?US-ASCII?Q?hci-msm=3A_Fix_issues_in_yaml_bindings?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL_Jsq++gOUymWFf6RwoRuqCFkd9XUNqyo-17QU-UQ-o+TXLtA@mail.gmail.com>
References: <20220514220116.1008254-1-bhupesh.sharma@linaro.org> <CAL_JsqLxXLFjre9h2dyoUJ=f0+pueUhSYezx_5bZ2SdpDt29xw@mail.gmail.com> <D42FBBDC-A6BA-4374-A726-061A4478D4C7@linaro.org> <CAL_Jsq++gOUymWFf6RwoRuqCFkd9XUNqyo-17QU-UQ-o+TXLtA@mail.gmail.com>
Message-ID: <36C2A924-3697-42FB-8C14-8E6E163558F2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 2 July 2022 18:22:19 GMT+03:00, Rob Herring <robh@kernel=2Eorg> wrote:
>On Sat, Jul 2, 2022 at 3:14 AM Dmitry Baryshkov
><dmitry=2Ebaryshkov@linaro=2Eorg> wrote:
>>
>>
>>
>> On 2 July 2022 01:06:48 GMT+03:00, Rob Herring <robh@kernel=2Eorg> wrot=
e:
>> >On Sat, May 14, 2022 at 4:01 PM Bhupesh Sharma
>> ><bhupesh=2Esharma@linaro=2Eorg> wrote:
>> >>
>> >> Rob pointed some remaining issues in the sdhci-msm yaml
>> >> bindings (via [1])=2E
>> >>
>> >> Fix the same by first using the 'mmc-controller=2Eyaml' as
>> >> 'ref' and thereafter also fix the issues reported by
>> >> 'make dtbs_check' check=2E
>> >>
>> >> [1]=2E https://lore=2Ekernel=2Eorg/linux-arm-msm/YnLmNCwNfoqZln12@ro=
bh=2Eat=2Ekernel=2Eorg/
>> >>
>> >> Fixes: a45537723f4b ("dt-bindings: mmc: sdhci-msm: Convert bindings =
to yaml")
>> >> Cc: Bjorn Andersson <bjorn=2Eandersson@linaro=2Eorg>
>> >> Cc: Rob Herring <robh@kernel=2Eorg>
>> >> Cc: Ulf Hansson <ulf=2Ehansson@linaro=2Eorg>
>> >> Signed-off-by: Bhupesh Sharma <bhupesh=2Esharma@linaro=2Eorg>
>> >> ---
>> >> -> This patch uses the dts changes sent (here: https://lore=2Ekernel=
=2Eorg/linux-arm-msm/20220514215424=2E1007718-1-bhupesh=2Esharma@linaro=2Eo=
rg/), for fixing the dtbs_check errors=2E
>> >> -> This patch is rebased on 'linux-next/master'
>> >>
>> >>  =2E=2E=2E/devicetree/bindings/mmc/sdhci-msm=2Eyaml    | 52 ++++++++=
++++++++---
>> >>  1 file changed, 44 insertions(+), 8 deletions(-)
>> >
>> >There's another issue with this applied:
>> >
>> >Documentation/devicetree/bindings/mmc/sdhci-msm=2Eexample=2Edtb:
>> >mmc@8804000: Unevaluated properties are not allowed
>> >('operating-points-v2' was unexpected)
>> >
>> >Should just need a 'operating-points-v2: true' line=2E
>> >
>> >This won't show up until a fix for 'unevaluatedProperties' handling is
>> >applied=2E But first I need all the issues fixed=2E
>>
>> Could you please add a dt-validate (?) argument so that we can validate=
 new schemas with unevaluatedProperties working as expected, while keeping =
default behaviour intact (while it gets sorted out)?
>>
>
>I think that wouldn't work well because the schemas have to be
>reprocessed when such an option changes=2E Though kbuild does look for
>command line changes=2E=2E=2E
>
>In any case, I'm going to commit this to the main branch in a few
>days=2E There aren't many warnings left=2E

Ack, thanks for the explanation=2E


--=20
With best wishes
Dmitry
