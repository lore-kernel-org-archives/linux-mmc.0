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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CEBC433B4
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B5A6128C
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Apr 2021 15:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbhDMPqi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Apr 2021 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhDMPqh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Apr 2021 11:46:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3DEC061574
        for <linux-mmc@vger.kernel.org>; Tue, 13 Apr 2021 08:46:17 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q10so12222380pgj.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Apr 2021 08:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=+epr+Md7e+4ldnLXtrOsqpImiIy0tcAwu9c9G5nl71Q=;
        b=FhNzs2ybhyu8wPNhs/IYduNdFxJDZM1Q8toPquWS/qwmq8pK3axGBA6Prc1qB1n8Oz
         enrrR/TjJIJJpkxYTahzrIzAo5GOeL9jYyf977uVieGy1uc5aKUgvxSZ+ZVSHLoDKQqS
         maogoUWR78gLpXTpWVhPP71gjrQmpanisgaFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=+epr+Md7e+4ldnLXtrOsqpImiIy0tcAwu9c9G5nl71Q=;
        b=dcAhgeLXhiTj8QXZl/0LbVCKy1x3wEOH6zlLmlwUssn3tq15Oj/lvC0wHT5KWqM50k
         tx8/dPlu0bERBgBTn+wBH1vFHVKr58quuT8nG4nr8rfSaDx8GsSIFW0D+niGtYbQLPKy
         +X+ehMjZiOcJh78ebEkqtnRhi3a8fWFxoVmruXqMrElZfvp6UpwNeIW9n1+zmVyCsNm0
         Rpyrt3g3XagHUKHT/NJcJ5Q+o/SQrAU4j+1ohDAIbQnEqLfON7bj1qQ9ShfxLshfDz1A
         DFvES0aTfsdrpQOphXzmt5ikY7pOXgJTFpeim+g/CPNbs/ASltaZyp9OKAaAaHfrzRsQ
         KqRA==
X-Gm-Message-State: AOAM531qh1IPBLHmg8unYOX0gMzhAnt7CdRsyem/4Fn8SlibNr7wME5C
        3oSph6fEjsb9MQWuzaTyK9kDzw==
X-Google-Smtp-Source: ABdhPJxiHjXNvTKsnCQeq4c9psrd9T56j7RbpcvssiLA/o++FZoK83eEMGRyT4AJNhvFB0J4PHGuiQ==
X-Received: by 2002:a63:510f:: with SMTP id f15mr32776528pgb.390.1618328777295;
        Tue, 13 Apr 2021 08:46:17 -0700 (PDT)
Received: from lbrmn-lnxub113.ric.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id k20sm12549212pfa.34.2021.04.13.08.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 08:46:16 -0700 (PDT)
Subject: Re: [PATCH] mmc: add quirk to disable eMMC cache for Micron eMMC v5.0
 cards
From:   Scott Branden <scott.branden@broadcom.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "Luca Porzio (lporzio)" <lporzio@micron.com>, tedirkes@micron.com
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
References: <20210408175951.22450-1-scott.branden@broadcom.com>
 <CAPDyKFrBMGjCFCwgaJ1D5f+VJSenp369MDP7KS_PY9JaPYA0Hg@mail.gmail.com>
 <90d986f4-bf72-64a6-62ce-cddcf6da43a9@broadcom.com>
Message-ID: <74343d16-9894-f203-1401-8fa44d19bac7@broadcom.com>
Date:   Tue, 13 Apr 2021 08:46:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <90d986f4-bf72-64a6-62ce-cddcf6da43a9@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ec7d8d05bfdc8771"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

--000000000000ec7d8d05bfdc8771
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

+Travis Dirkes (with corrected email),
 
 Could you provide more details on the Micron data error.
 
> On 2021-04-12 12:44 a.m., Ulf Hansson wrote:
>> + Bean Huo, Luca Porzio
>>
>> On Thu, 8 Apr 2021 at 19:59, Scott Branden <scott.branden@broadcom.com> wrote:
>>>
>>> From: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>>>
>>> In certain rare combination of operations, Micron eMMC v5.0 cards
>>> may experience data errors if internal cache is enabled.
>>> This may lead to eMMC related data errors.
>>> Introduce a quirk to disable cache on these eMMC cards.
>>
>> Can you please elaborate on this, what combinations of operations are
>> you referring to - and what kind of data errors?
>>
>> I have also looped in some of the Micron guys, to let them chim in.
>>
>>>
>>> Signed-off-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
>>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>>
>> Kind regards
>> Uffe
>>
>>> ---
>>>  drivers/mmc/core/card.h   | 5 +++++
>>>  drivers/mmc/core/mmc.c    | 4 ++--
>>>  drivers/mmc/core/quirks.h | 8 ++++++++
>>>  include/linux/mmc/card.h  | 1 +
>>>  4 files changed, 16 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
>>> index 7bd392d55cfa..22cea63ac359 100644
>>> --- a/drivers/mmc/core/card.h
>>> +++ b/drivers/mmc/core/card.h
>>> @@ -222,4 +222,9 @@ static inline int mmc_card_broken_hpi(const struct mmc_card *c)
>>>         return c->quirks & MMC_QUIRK_BROKEN_HPI;
>>>  }
>>>
>>> +static inline int mmc_card_broken_cache(const struct mmc_card *c)
>>> +{
>>> +       return c->quirks & MMC_QUIRK_BROKEN_CACHE;
>>> +}
>>> +
>>>  #endif
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 8741271d3971..cd83b7f0e59c 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1820,12 +1820,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>          * sudden power failure tests. Let's extend the timeout to a minimum of
>>>          * DEFAULT_CACHE_EN_TIMEOUT_MS and do it for all cards.
>>>          */
>>> -       if (card->ext_csd.cache_size > 0) {
>>> +       if (!mmc_card_broken_cache(card) && card->ext_csd.cache_size > 0) {
>>>                 unsigned int timeout_ms = MIN_CACHE_EN_TIMEOUT_MS;
>>>
>>>                 timeout_ms = max(card->ext_csd.generic_cmd6_time, timeout_ms);
>>>                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>> -                               EXT_CSD_CACHE_CTRL, 1, timeout_ms);
>>> +                                EXT_CSD_CACHE_CTRL, 1, timeout_ms);
>>>                 if (err && err != -EBADMSG)
>>>                         goto free_card;
>>>
>>> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
>>> index d68e6e513a4f..23972d87c82a 100644
>>> --- a/drivers/mmc/core/quirks.h
>>> +++ b/drivers/mmc/core/quirks.h
>>> @@ -116,6 +116,14 @@ static const struct mmc_fixup __maybe_unused mmc_ext_csd_fixups[] = {
>>>         MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_NUMONYX,
>>>                               0x014e, add_quirk, MMC_QUIRK_BROKEN_HPI, 6),
>>>
>>> +       /*
>>> +        * In certain rare combination of operations, Micron eMMC v5.0 cards
>>> +        * may experience data errors if internal cache is enabled.
>>> +        * Disabling cache for these cards eliminates the issue.
>>> +        */
>>> +       MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_MICRON,
>>> +                             0x014e, add_quirk, MMC_QUIRK_BROKEN_CACHE, 7),
>>> +
>>>         END_FIXUP
>>>  };
>>>
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index f9ad35dd6012..22f256a4e54e 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -270,6 +270,7 @@ struct mmc_card {
>>>  #define MMC_QUIRK_BROKEN_IRQ_POLLING   (1<<11) /* Polling SDIO_CCCR_INTx could create a fake interrupt */
>>>  #define MMC_QUIRK_TRIM_BROKEN  (1<<12)         /* Skip trim */
>>>  #define MMC_QUIRK_BROKEN_HPI   (1<<13)         /* Disable broken HPI support */
>>> +#define MMC_QUIRK_BROKEN_CACHE (1<<14)         /* Disable broken cache */
>>>
>>>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
>>>
>>> --
>>> 2.17.1
>>>
> 


--000000000000ec7d8d05bfdc8771
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
cRe0CRXA7ypOJSgxO/nOOyQoaJxT7CGg1npOeSpPjEuc3fE4xum3l0nvU85hj6MlKZu43hokdBh0
D0nLyyhEwlR3AC/msdff/UGbM/JR9vk812RP4m/aNWZFJwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRpzY290dC5icmFuZGVuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUOhjEpl04Sz9dh5MI82E1
V39lM/owDQYJKoZIhvcNAQELBQADggEBAA7Rlypx/esz/iq1yA4+KW7uwV/aBY344BWcXt6I+SNK
VwFBgFWfLj5vaEud9TVv2fPSiaHJo0umemOJk+43QD+bsoqmgcFXd21PrOt7Jjs+jjVED9VC5kJq
S4NNKUkS+BqijJwSegtVygrc/atrIlJbjI21q4qpemUo5fgwqCNm++BmBGTI8yA09vtGSNDRN42k
lLX9hl3iEj5SBgkQqCbbnoE+ZjjKfqt7ED166WhgyQWNrl39yLcvLj+JRUB3RuvXKZjH0NQEEBII
wZBDSkyneykLt3CBNIhSCTxKM6OWxVp936ALSa5K9FNy00TeWSpokR6NmzaW8VD/EjTgvqAxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgx9oXSJpKniO4dS
Gk8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHLDQJPxzEURitblVMuciMYfYVF2
LidFifR9K47RqRWSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDQxMzE1NDYxN1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA41G/V0RxS+ni4RlisoTHDc1JOy4eBJlchQyzYiaWMu7ru
6i8Xr/RpGpGxC55Az66owcJxAnOuUC46r1bG5+Qo3e+uDYO3WGcAvle2wzUWQfcLckDm28RPD+HV
W3i69z/zf8Pvof6epaYqIBtTn5Wz8fBabWZMrmT0xwhZqwXWgSWUfgziU4W3GbfzmoXvHKE6LwmQ
WYb2/7YvRQkHJWCi2FDOXcaN0H9xlCM1QYl+t7pww7nKmfcUbvD4fIs4gKLJnkLHwI7/SF7o5mNq
6J5EminHzdybdbQER8yk/pLMuvnDyr0pRdgld3KcQsIvzwYvfrHTUy2MV8sBcg/SH5et
--000000000000ec7d8d05bfdc8771--
