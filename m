Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2693BC38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0216820CC7
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 07:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SViTcfZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgEHHcV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgEHHcV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 03:32:21 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B1C05BD43;
        Fri,  8 May 2020 00:32:20 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o198so449733ybg.10;
        Fri, 08 May 2020 00:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KRIM1BAPLhHwtjDMOtJ5xMBfKlQHh8XYJ7t4jw61XhY=;
        b=SViTcfZs1nHo2FcLH0DQTNeCOut51ca/UCY8xe0LJr0HSCQCfLsWavgNXf3uwwVEMn
         KdAghI2zP3E/+ew/A2ctJI84EEBk/I6xNYs+QUs0oUXIbL3qc6961GKwHAoU9ih6VbEy
         CF8GevfpKL/g7TlRRKa4zCF//+1U3rMYtKF8p03TvYCDl4R3Mvr+tynNFaGk4aWkfVU4
         T5FJkEUvhArruP8Q8FR0wDwm/BuA7gTpxZVd2FqM7+8tHNyUgBjdB+KYrcKxPRCo6unB
         eqlR3rjz/akaCupqSOfzrjn1arYpy43T+KaZ+NXoqOmWeJjz1U76Lh5PnHpa1BIKjmIj
         l79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KRIM1BAPLhHwtjDMOtJ5xMBfKlQHh8XYJ7t4jw61XhY=;
        b=cCt2l0ntMo+GrPGizYZAd5yxegHLZ0Z4Zk2cyzkX4a8Sn+R3c7fpmbdCpsUwaFr0/b
         JLeXVmiiptaPisTwRfaXHxK0B71G0J/EOmxIZMQempr9aJA0AZaCNQfa18Zpj1ORYVz+
         4Hx3Bc0Z17sumPFXFHJusmtTjZDnf+STvWiBWWscsISOsluERpGGfUqBDxgAzCnUfgZE
         XGdYKZ75OL0eks9so7BqFnDGmt9QMbt9sVI1B0hLvCGpoNfwcBYvx0J1IkPnCFdKbOdU
         fd2TybkSD31uTx4KiSVab+0rgmuVoMwYdcbWt7TG6KyAqiCvNdEtia3oamfA2C7M6L6A
         MW4w==
X-Gm-Message-State: AGi0PuZILwRzo+J3s/QSqntnlxJmJVNwq9tzJPAcTws1zI5JxyFkeKge
        QgephKoOIqMVAs8aYg6bQIWho6U/+70AW1Lm8BE=
X-Google-Smtp-Source: APiQypLws/tdRU6mXSLu/zxJHlfLJVgRYc5ZOI4uepSvcVw6LDtO8uzythQGN7x7MFrkO0M0Hg/9Wu1hIlR85XuwS7A=
X-Received: by 2002:a25:c402:: with SMTP id u2mr2605136ybf.82.1588923140074;
 Fri, 08 May 2020 00:32:20 -0700 (PDT)
MIME-Version: 1.0
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Fri, 8 May 2020 15:32:02 +0800
Message-ID: <CACT4zj_HHQxOO9cELfmRqrspuzCrMQXMWGRfdrRa14DW5_ZXKQ@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-pci-gli: Make sdhci_pci_gli_resume static
To:     Samuel Zou <zou_wei@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

>>On Thu, 7 May 2020 at 14:14, Samuel Zou <zou_wei@huawei.com> wrote:
>>
>> Fix the following sparse warning:
>>
>> drivers/mmc/host/sdhci-pci-gli.c:343:5: warning:
>> symbol 'sdhci_pci_gli_resume' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
>
>This actually fixes a commit that I on my fixes branch, which is also
>targeted for stable.
>
>Therefore, I decided to squash this into the offending commit and
>adding your sob tag, with a note about what you fixed.
>
>Kind regards
>Uffe
>

Thanks Samuel for fixed this issue.
Thanks Ulf for your help.

PS.
I use this email to reply because the company's email will have a
confidentiality clause in the letter.

Best regards,
Ben Chuang

>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index bdb6336..fd76aa6 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -340,7 +340,7 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>>  }
>>
>>  #ifdef CONFIG_PM_SLEEP
>>-int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>> +static int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
>>{
>>        struct sdhci_pci_slot *slot = chip->slots[0];
>>
>>--
>>2.6.2
>>
